import Debug "mo:base/Debug";
import Int "mo:base/Int";

func quicksort(left : Nat, right : Nat, arry : [var Int]) {
    if( left >= right) return;

    var i = left;
    var j = right;
    var tmp = 0:Int;

    let base = arry[left];

    while(i < j) {
        while(arry[j] >= base and i < j)
            j -= 1;
        while(arry[i] <= base and i < j)
            i += 1;

        if(i < j) {
            tmp := arry[i];
            arry[i] := arry[j];
            arry[j] := tmp;
        };
    };

    arry[left] := arry[i];
    arry[i] := base;

    quicksort(left, i - 1, arry);
    quicksort(i + 1, right, arry);

};

let a_arry :[var Int] = [var 5, 6, 8, 2, 1, 9, 0, 23, 12];

quicksort(0 : Nat,8 : Nat, a_arry);

for(ele in a_arry.vals()) {
    Debug.print(Int.toText(ele));
};