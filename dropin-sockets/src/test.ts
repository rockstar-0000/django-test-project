import {concatMap, filter, tap} from "rxjs/operators";
import {of} from "rxjs";

export class Test {

    public testStorage(d: any) {
        return of([{'trevor': 'test'}, {'tucker': 'test1'}, {'dad': 'test2'}])
    }
    public metaHandler(lane: string) {
        const metaObs = of({'v': [{'1': '2'}, {'1': '3'}, {'1': '4'}]});

        metaObs.pipe(
            concatMap(dPacket => {
                // @ts-ignore
                return this.testStorage(dPacket.v)
            }),

            concatMap((metaArr) => {
                return of(metaArr)
            }),
            tap((data) => {
                console.log(data);
            })
        ).subscribe();

    }
}