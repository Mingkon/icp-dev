import Array "mo:base/Array";

actor {
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

    public func qsort(arr: [Int]): async [Int] {
        let var_arry : [var Int] = Array.thaw(arr);
        let left : Nat = 0;
        let right : Nat = arr.size() - 1 : Nat;
        quicksort(left, right, var_arry);

        Array.freeze(var_arry)
    };
};
