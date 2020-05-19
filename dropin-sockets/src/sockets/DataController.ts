import {Observable, of} from "rxjs";
import {SocketDriver} from "./SocketDriver";
import {IDataPacket, IEventMap, ILaneObj} from "./SocketsInterfaces";
import {concatMap, filter, flatMap, map, tap} from "rxjs/operators";
import {BaseStorage} from "../storage/BaseStorage";
import {Handshake} from "./Handshake";

export class DataController {

    private lanes: ILaneObj = {};
    private SocketDriver: SocketDriver;
    private eventMap: IEventMap;

    constructor(SocketDriver: SocketDriver) {
        this.SocketDriver = SocketDriver;
        this.eventMap = this.SocketDriver.getHandshake().getEventMap();
    }


/*
    private metaHandler(lane: string) {
        const metaObs = this.lanes[lane].pipe(filter(dPacket => dPacket.e === this.eventMap.meta));

        metaObs.pipe(
            concatMap(dPacket => {
            // @ts-ignore
            return this.storage.getAll(dPacket.v)
            }),
            concatMap(metaObjArr => {
                return of(metaObjArr);
            }),
            concatMap<any, any>(metaObj => {
                if (metaObj['last_update'] === -1) {
                    return of(metaObj);
                } else {
                    return of(metaObj);
                }
            })

        )

    }
*/

    public registerLane(lane: string)  {
        // @ts-ignore
        this.lanes[lane] = this.SocketDriver.getLaneObs$(lane);
    }




    /** TODO: integrate cache system.
     * 1. get any data in backend
     * 2. get latest last update from sever
     * 3. determine with lastUpdate property if new data exists.
     * 4. if backend data is needed push into Subject SocketDriver
     * 5. When new data comes in to  SocketDriver push into Subject
     * @param lane
     * @param eventFilter
     */
    public getReceiverObs$(lane: string, ): Observable<object> {
        if(!this.lanes.hasOwnProperty(lane)) {
            throw Error("lane does not exist in lanes object")
        }

        return this.lanes[lane].pipe();

    }

    public send(lane: string, event: string, dataValue: any) {
        if(!this.lanes.hasOwnProperty(lane)) {
            throw Error("lane does not exist in lanes object")
        }
        this.SocketDriver.sendMessage(lane, event, dataValue)
    }
}
