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
        this.DataController.getReceiverObs$(this.lane, event).subscribe({
            next(val) {func(val)},
            error(err) { console.error('something wrong occurred: ' + err); },
            complete() { console.log('done'); }
        })
    }


    public sendData(dataValue: any, event: string = '') {
        this.DataController.send(this.lane, event, dataValue);
    }
}