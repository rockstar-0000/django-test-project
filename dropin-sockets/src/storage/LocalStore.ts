import {BaseStorage} from "./BaseStorage";
import {IDataPacket} from "../sockets/interfaces";
import {throwError} from "rxjs";
import {Tree} from "./tree";
import {Algorithms} from "./Algorithms";

export class LocalStore extends BaseStorage {

    constructor() {
        super("lastUpdate", 5000000);
    }

    _getAll(limit: number, lessThan: number, greaterThan: number): any[] {
        return [];
    }

    _formatKey(dPacket: IDataPacket): string {
        if (!dPacket.v.hasOwnProperty('id')) {
            throwError('dPacket does not have property: id. Cannot format key for storage')
        }
        return dPacket.l + '.' + dPacket.v['id'];

    }

    _metaFormatKey(lane: string): string {
        return 'm' +  lane;
    }

    _metaUpdate(dPacket: IDataPacket): undefined {
            const key = this._metaFormatKey(dPacket.l);
            const val = this._getByKey(key);
            let arr: any[] = [[], []]; // first arr id second is last_update
            if (val !== null) {
                arr = JSON.parse(val)
            }

            const id = Algorithms.binaryInsert(arr[0], dPacket.v['id']);
            arr[1][id] = dPacket.v[this.timeStampPropName];

            const arrString = JSON.stringify(arr);

            this._setByKeyVal(key, arrString);

            return;
    }
    _metaGetAll(lane: string): [Array<Number>, Array<Number>] {
        const val = this._getByKey(this._metaFormatKey(lane));
        if (val === null) {
            return [[], []]
        }
        return JSON.parse(val);
    }
    _getLatestTime(lane: string): number {
        const arr = Algorithms.quickSort(this._metaGetAll(lane)[1]);
        if(arr.length > 0) {
            return arr[0]
        }
        return 0;

    }

    _get(dPacket: IDataPacket): object | null {
        const key = this._formatKey(dPacket);
        const dataStr = localStorage.getItem(key);
        if(dataStr) {
            return JSON.parse(dataStr);
        }
        return null;
    }

    _getByKey(key: string): string | null {
        return localStorage.getItem(key);
    }

    _set(dPacket: IDataPacket): number {
        const key = this._formatKey(dPacket);
        const val = JSON.stringify(dPacket.v);
        localStorage.setItem(key, val);
        return (key+val).length;
    }

    _setByKeyVal(key: string, val: string | number): undefined {
        localStorage.setItem(key, String(val));
        return;
    }

    _del(dPacket: IDataPacket): number {
        const key = this._formatKey(dPacket);
        const val = this.get(dPacket);
        localStorage.removeItem(key);
        return (key+val).length;

    }

    _has(dPacket: IDataPacket): boolean {
        return this._get(dPacket) != null;
    }



}