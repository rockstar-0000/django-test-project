export class Tree {
    private static t: any = {};


    public static build() {
        for(let i =0; i < localStorage.length; i++){
            Tree.add(localStorage.key(i), localStorage.getItem(<string>localStorage.key(i)))
        }
    }

    public static add(key: string | null, val: string | null) {
        if (key !== null && val != null) {
            Tree.t[key] = val;
        }
    }

}
