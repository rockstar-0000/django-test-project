import {SocketDriver} from "./sockets/SocketDriver";
import {DataController} from "./sockets/DataController";
import {DEFAULT_EVENTS, TProtocols} from "./sockets/SocketsInterfaces";
import {DataSocket} from "./sockets/DataSocket";

export class DropInSockets
{
    private url: string;
    private protocol: TProtocols;
    public SocketDriver: SocketDriver;
    public DataController: DataController;
    // TODO make events more seamless
    constructor(url: string, protocol: TProtocols, events = {'meta': 'm'}){
        this.url = url;
        this.protocol = protocol;

        this.SocketDriver = new SocketDriver(url, protocol);
        this.DataController = new DataController(this.SocketDriver,  DEFAULT_EVENTS);
    }

    public createDataSocket(lane: string): DataSocket{
        return new DataSocket(lane, this.DataController);
    }

}