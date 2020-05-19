import {from, Observable, of, Subject} from "rxjs";
import {DEFAULT_EVENTS, IDataPacket, IEventsOptions, TProtocols} from "./SocketsInterfaces";
import {concatMap, filter} from "rxjs/operators";


export class SocketDriver {

    private webSocket: WebSocket;
    private incomingDataSubject$: Subject<IDataPacket>;

    // Data not sent due to error
    private unsentData: string[] = [];
    private eventsOptions: IEventsOptions;
    private static formatDataPacket(lane: string, command: string, dataValue: any): string {
        const dataPacket: IDataPacket = {'l': lane, 'e': command, 'v': dataValue};
        return JSON.stringify(dataPacket);
    }

    constructor(url: string, protocols: TProtocols, eventsOptions: IEventsOptions = DEFAULT_EVENTS) {
        this.eventsOptions = eventsOptions;
        if (protocols === undefined) {
            this.webSocket = new WebSocket(url);
        } else {
            this.webSocket = new WebSocket(url, protocols);
        }
        this.incomingDataSubject$ = new Subject<IDataPacket>();
        this.listeners();
    }

    public getLaneObs$(lane: string): Observable<any> {
        return this.incomingDataSubject$.pipe(
            filter((dPacket => dPacket['l'] === lane)),
            concatMap(dPacket => {
                if (dPacket.e === this.eventsOptions.incomingArr) {
                    return from<any>(dPacket.v);
                }
                else {
                    return of(dPacket.v);
                }
            })
        );
    }


    private listeners() {
        this.webSocket.onmessage = (event) => {
            console.log({'onMessage': event});
            this.incomingDataSubject$.next(JSON.parse(event.data));
        };

        this.webSocket.onopen = (event) => {
            console.log({'onopen': event});
        };

        this.webSocket.onclose = (event) => {
            console.log({'onclose': event});
        };
        this.webSocket.onerror = (event) => {
            console.log({'onError': event});
        };
    }

    public sendMessage(lane: string, event: string, dataValue: any) {
        try {
            this.webSocket.send(SocketDriver.formatDataPacket(lane, event, dataValue))
        } catch (e) {
            this.unsentData.push(SocketDriver.formatDataPacket(lane, event, dataValue))
        }
    }



}