import {Observable} from "rxjs";

export type TProtocols = string | string[] | undefined
interface DataValue {
    [key: string]: any
}
export interface IDataPacket {
    'l': string // data lane
    'e': string  // event
    'v': DataValue // value

}

export interface ILaneObj {
        [key: string]: Observable<IDataPacket>
}
