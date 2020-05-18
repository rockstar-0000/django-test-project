import {Observable} from "rxjs";
import {SocketDriver} from "./SocketDriver";
import {IDataPacket, ILaneObj} from "./interfaces";
import {filter} from "rxjs/operators";
import {LocalStore} from "../storage/LocalStore";

export class DataController {

    private lanes: ILaneObj = {};
    private SocketDriver: SocketDriver;

    // change to private later

    public localStore: LocalStore = new LocalStore();

    constructor(SocketDriver: SocketDriver) {
        this.SocketDriver = SocketDriver;
    }

    public registerLane(lane: string)  {
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
    public getReceiverObs$(lane: string, eventFilter?: string): Observable<IDataPacket> {
        if(!this.lanes.hasOwnProperty(lane)) {
            throw Error("lane does not exist in lanes object")
        }
        if (eventFilter === undefined) {
            return this.lanes[lane].pipe();
        } else {
            return this.lanes[lane].pipe(filter(dPacket => dPacket.e === eventFilter));
        }
    }

    public send(lane: string, event: string, dataValue: any) {
        if(!this.lanes.hasOwnProperty(lane)) {
            throw Error("lane does not exist in lanes object")
        }
        this.SocketDriver.sendMessage(lane, event, dataValue)
    }
}
