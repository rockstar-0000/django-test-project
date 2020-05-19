import { openDB, deleteDB, wrap, unwrap } from 'idb';

export class IndexedDbStorage {
    
    constructor(dbName: string, lanes: string[]) {
        console.log('making a new object store');



    }


    private initTables(db: IDBDatabase, lanes: string[]) {
        const tree: any = {};
        for (const storeName of Array.from(db.objectStoreNames)) {
            tree[storeName] = '';
    }
        for(const lane of lanes) {
            if (!tree.hasOwnProperty(lane)) {
                const os = db.createObjectStore(lane);
                os.createIndex('id', 'id', {unique: true});
                os.createIndex('last_update', 'last_update', {unique: false});
            }
        }
    }
}