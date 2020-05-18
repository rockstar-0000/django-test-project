import {IDataPacket} from "../sockets/interfaces";
import {throwError} from "rxjs";


export abstract class BaseStorage {

    private static STORE_KEY = 'su';
    public curSpaceUsageChars: number = 10;
    public maxSpaceUsageChars: number;
    public timeStampPropName: string;

    constructor(timeStampPropName: string, maxSpaceUsageChars: number) {
        this.maxSpaceUsageChars = maxSpaceUsageChars;
        this.timeStampPropName = timeStampPropName;

        const curSU = this._getByKey(BaseStorage.STORE_KEY);
        if (curSU !== null) {
            this.curSpaceUsageChars += Number(curSU);
        } else {
            this._setByKeyVal(BaseStorage.STORE_KEY, '10');
        }

    }


    abstract  _formatKey(dPacket: IDataPacket): string
    abstract _set(dPacket: IDataPacket): number
    abstract _setByKeyVal(key: string, val: string | number): undefined
    abstract _getByKey(key: string): string | null;
    abstract _get(dPacket: IDataPacket): object | null
    abstract _del(dPacket: IDataPacket): number
    abstract _has(dPacket: IDataPacket): boolean

    abstract _metaFormatKey(lane: string): string
    abstract _metaGetAll(lane: string): [Array<Number>,Array<Number>]
    abstract _metaUpdate(dPacket: IDataPacket): undefined

    abstract _getLatestTime(lane: string): number
    abstract _getAll(limit: number, lessThan: number, greaterThan: number): any[]


    public getLatestTime(lane: string) {

    }



    public getAll(limit: number = Number.MAX_VALUE, lessThan: number = Number.MAX_VALUE, greaterThan: number = 0): any[] {
        return this._getAll(limit, lessThan, greaterThan);
    }





    private setLatestTime(dPacket: IDataPacket): undefined {
        const val = this._getByKey(dPacket.l);
        if (val === null) {
            this._setByKeyVal(dPacket.l, dPacket.v[this.timeStampPropName])
        } else {
            if (dPacket.v[this.timeStampPropName] > val) {
                this._setByKeyVal(dPacket.l, dPacket.v[this.timeStampPropName])
            }
        }
        return
    }

    private getSpaceUsage(): number {
        return Number(this._getByKey(BaseStorage.STORE_KEY));
    }

    private addSpaceUsage(keyVal: string, numChar = 0) {
        const curSU = this.getSpaceUsage() + keyVal.length + numChar;
        this._setByKeyVal(BaseStorage.STORE_KEY, String(curSU));

        this.curSpaceUsageChars = curSU;
    }

    private removeSpaceUsage(keyVal: string, numChar = 0 ) {
        const curSU = this.getSpaceUsage() - keyVal.length + numChar;
        this._setByKeyVal(BaseStorage.STORE_KEY, String(curSU));
        this.curSpaceUsageChars = curSU;
    }




    public has(dPacket: IDataPacket): Boolean {
        return this._has(dPacket);
    }
    public del(dPacket: IDataPacket) {
        if (this.has(dPacket)) {
            const chars = this._del(dPacket);
            this.removeSpaceUsage('', chars);
        }
    }

    public set(dPacket: IDataPacket) {
        const chars = this._set(dPacket);
        this.setLatestTime(dPacket);
        this.addSpaceUsage('', chars)

    }

    public get(dPacket: IDataPacket) {
        return this._get(dPacket)
    }




}