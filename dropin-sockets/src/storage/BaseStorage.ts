
// M = meta, O = object
import {from, Observable} from "rxjs";

export abstract class BaseStorage<M, O> {

    public idPropName: string;
    public lastUpdatePropName: string;

    constructor(idPropName: string, lastUpdatePropName: string) {
        this.idPropName = idPropName;
        this.lastUpdatePropName = lastUpdatePropName;
    }

    abstract _get(metaItem: M): Promise<O>
    abstract _set(item: O): never
    abstract _getAll(metaItems: M[]): Promise<O[]>

    public get(metaItem: M) {
        this._get(metaItem).then((item)=>{

        })
    }

    // set last update to -1 if we need to get from db
    public getAll(metaItems: M[]): Observable<O[]> {
         return from(this._getAll(metaItems));
    }

}