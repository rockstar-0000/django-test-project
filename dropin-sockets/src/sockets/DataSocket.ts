import {Observable} from "rxjs";
import {DataController} from "./DataController";

export class DataSocket {


    private lane: string;
    private DataController: DataController;

    constructor(lane: string, DataController: DataController) {
        this.lane = lane;
        this.DataController = DataController;

        DataController.registerLane(lane);
    }

    public newDataListener(func: Function, event?: string)  {
        this.DataController.getReceiverObs$(this.lane).subscribe({
            next(val) {func(val)},
            error(err) { console.error('something wrong occurred: ' + err); },
            complete() { console.log('done'); }
        })
    }

    // TODO block new messages until old data has loaded
    /**
     *
     * @param {number} start - (ordered by latest) which item to start at.
     * @param {number} limit - (ordered by latest) max amount of items
     *  @description Sends a message to the websocket server requesting data
     */
    public requestData(start: number, limit: number) {
        this.DataController.send(this.lane, 'gr', {'start': start, 'limit': limit})
    }


    /**
     *
     * @param dataValue - The object to send to server
     * @param event - the event name to send to server
     *  @description Sends message to the server as a IDataPacket
     */
    public sendData(dataValue: any, event: string = '') {
        this.DataController.send(this.lane, event, dataValue);
    }
}