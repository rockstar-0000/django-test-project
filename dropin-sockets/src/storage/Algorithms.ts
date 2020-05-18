

 export class Algorithms {

    public static binarySearch(arr: any[], target: any, comparator?: any): number {
        let l = 0,
            h = arr.length - 1,
            m, comparison;
        comparator = comparator || function (a: any, b: any) {
            return (a < b ? -1 : (a > b ? 1 : 0)); /* default comparison method if one was not provided */
        };
        while (l <= h) {
            m = (l + h) >>> 1; /* equivalent to Math.floor((l + h) / 2) but faster */
            comparison = comparator(arr[m], target);
            if (comparison < 0) {
                l = m + 1;
            } else if (comparison > 0) {
                h = m - 1;
            } else {
                return m;
            }
        }
        return~l;
    }

     /*
         target: the object to insert into the array
         duplicate: (optional) whether to insert the object into the array even if a matching object already exists in the array (false by default)
         comparator: (optional) a method for comparing the target object type
         return value: the index where the object was inserted into the array, or the index of a matching object in the array if a match was found and the duplicate parameter was false
     */
    public static binaryInsert(array: any[], target: any, duplicate: Boolean = false): number {
        let i = Algorithms.binarySearch(array, target);
        if (i >= 0) {
            if (!duplicate) {
                return i;
            }
        } else {
            i = ~i;
        }
        array.splice(i, 0, target);
        return i;
    }


     public static quickSort(items: any[], left?: any, right?: any): any[] {
        var index;
        if (items.length > 1) {
            index = partition(items, left, right); //index returned from partition
            if (left < index - 1) { //more elements on the left side of the pivot
                Algorithms.quickSort(items, left, index - 1);
            }
            if (index < right) { //more elements on the right side of the pivot
                Algorithms.quickSort(items, index, right);
            }
        }
        return items;
    }
}

 function swap(items: any[], leftIndex: number, rightIndex: number){
     var temp = items[leftIndex];
     items[leftIndex] = items[rightIndex];
     items[rightIndex] = temp;
 }
 function partition(items: any[], left: number, right: number) {
     var pivot   = items[Math.floor((right + left) / 2)], //middle element
         i       = left, //left pointer
         j       = right; //right pointer
     while (i <= j) {
         while (items[i] < pivot) {
             i++;
         }
         while (items[j] > pivot) {
             j--;
         }
         if (i <= j) {
             swap(items, i, j); //sawpping two elements
             i++;
             j--;
         }
     }
     return i;
 }
