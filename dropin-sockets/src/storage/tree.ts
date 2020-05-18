export class Tree {
    public  t: any = {};


    public  build() {
        for (let i = 0; i < localStorage.length; i++) {
            // @ts-ignore
            this.add(localStorage.key(i), localStorage.getItem(<string>localStorage.key(i)))
        }
    }

    public add(key: string, val: string) {
        const keys = key.split('.');
        this.t[keys[0]] = {[keys[1]]: val};
    }


}
