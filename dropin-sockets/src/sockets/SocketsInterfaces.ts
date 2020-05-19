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


export interface IEventsOptions {
    'meta': string
    'getAll': string
    'get': string
    'getRecent': string

    'incomingItem': string
    'incomingArr': string
}

export const DEFAULT_EVENTS: IEventsOptions = {
    'meta': 'm',
    'getAll': 'ga',
    'getRecent': 'gr',
    'get': 'g',

    'incomingItem': 'ii',
    'incomingArr': 'ia',
};
