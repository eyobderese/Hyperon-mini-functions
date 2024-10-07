! (import! &self  partition)
! (register-module! ./)

(= (add-to-subsets $element $subsets)
    (if (== $subsets ())
        () ; If the subsets list is empty, return an empty list

        (let* (
                ($head-sub (car-atom $subsets))
                ($tail-sub (cdr-atom $subsets))
                ($current (cons-atom $element $head-sub))
                ($rest (add-to-subsets $element $tail-sub))

            )
        (cons-atom $current $rest)
    )

)
)

(= (concat-atom $list1 $list2)
    (if (== $list1 ())
        $list2 ; If the first list is empty, return the second list
        (let* (
                ($head (car-atom $list1))
                ($tail (concat-atom (cdr-atom $list1) $list2))
            )
        (cons-atom $head $tail)
    ) ; Recursively attach elements of list1 to list2
)
)

 ; powerset is generet a subset of the orginal pattern
 ;;  for example
 ;;;;;;  input: ('A' 'B' 'C')
 ;;;;;;  output: (('A') ('B') ('C') ('A' 'B') ('A' 'C')  ('B' 'C') ('A' 'B' 'C'))

(= (powerset $lst)
    (if (== $lst ())
        (cons-atom () ()) ; Base case: the powerset of an empty list is a list with one empty set
        (let* (
                ($rest (powerset (cdr-atom $lst))) ; Recursive call to get powerset of the rest of the list
                ($with-current (add-to-subsets (car-atom $lst) $rest)) ; Add the first element to each subset in the powerset of the rest
            )
        (concat-atom $rest $with-current)) ; Combine the subsets with and without the current element
)
)

 ;;; generet-partition-without-pattern is genrete aa partition using python implmentation of gen-partion

 ;;  input
 ;; (('A') ('B') ('C') ('A' 'B') ('A' 'C')  ('B' 'C') ('A' 'B' 'C'))  subset
 ;; ('A' 'B' 'C')  the orginal pattern
 ;; output
 ;; ((('A') ('B') ('C'))   ('A' 'B') ('C'))     (('A' 'C')  ('B'))    the partition

(= (generet-partition-without-pattern $pattern)
    (let $subsets (powerset $pattern)
        (gen-partition $subset $pattern)) ; gen-partition is registered
)

 ;;;;;  this is checker function which help wether it check the python function is registered or not

! (get-type gen-partion)
! ( gen-partition ( () ('C') ('B') ('B' 'C') ('A') ('A' 'C') ('A' 'B') ('A' 'B' 'C'))  ('A' 'B' 'C') )
