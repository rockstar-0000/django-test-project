import {BaseStorage} from "./BaseStorage";
import {IDataPacket} from "../sockets/interfaces";
import {throwError} from "rxjs";
import {Tree} from "./tree";

export class LocalStore extends BaseStorage {

    public tree: Tree = new Tree();
    constructor() {
        super("lastUpdate", 5000000);
        this.tree.build();
    }

    _getAll(limit: number, lessThan: number, greaterThan: number): any[] {
        return [];
    }
    _getLatest(lane: string): number {
        return 0;
    }

    _formatKey(dPacket: IDataPacket): string {
        if (!dPacket.v.hasOwnProperty('id')) {
            throwError('dPacket does not have property: id. Cannot format key for storage')
        }
        return dPacket.l + '.' + dPacket.v['id'];

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

    _setByKeyVal(key: string, val: string): undefined {
        localStorage.setItem(key, val);
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