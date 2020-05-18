import {Observable, Subject} from "rxjs";
import {IDataPacket, TProtocols} from "./interfaces";
import {filter} from "rxjs/operators";


export class SocketDriver {

    private webSocket: WebSocket;
    private incomingDataSubject$: Subject<IDataPacket>;

    // Data not sent due to error
    private unsentData: string[] = [];

    private static formatDataPacket(lane: string, command: string, dataValue: any): string {
        const dataPacket: IDataPacket = {'l': lane, 'e': command, 'v': dataValue};
        return JSON.stringify(dataPacket);
    }

    constructor(url: string, protocols: TProtocols) {
        if (protocols === undefined) {
            this.webSocket = new WebSocket(url);
        } else {
            this.webSocket = new WebSocket(url, protocols);
        }
        this.incomingDataSubject$ = new Subject<IDataPacket>();
        this.listeners();
    }

    public getLaneObs$(lane: string): Observable<IDataPacket> {
        return this.incomingDataSubject$.pipe(
            filter((dPacket => dPacket['l'] === lane))
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