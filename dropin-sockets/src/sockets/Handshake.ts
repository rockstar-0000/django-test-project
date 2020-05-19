import {IEventMap} from "./SocketsInterfaces";

export class Handshake {

    private handShakeLaneName: string;
    private version: string;
    private eventMap: IEventMap;

    constructor(handShakeLaneName: string, version: string, eventMap: IEventMap) {
        this.handShakeLaneName = handShakeLaneName;
        this.version = version;
        this.eventMap = eventMap;
    }

    public setHandshake(handShakeLaneName: string, version: string, eventMap: IEventMap) {
        if(version !== this.version) {
            this.handShakeLaneName = handShakeLaneName;
            this.version = version;
            this.eventMap = eventMap;
        } else {
            console.log('Unable to update Handshake the versions are the same')
        }
    }

    public getEventMap() {
        return this.eventMap;
    }

}