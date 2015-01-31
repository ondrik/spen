
; Extending QF_S:
; constant emptybag, 
; the function singleton, 
; the multiset comparison operator bag-lt, bag-le, bag-gt, bag-ge
; bag-union, bag-diff, bag-sub

(set-logic QF_S)

;; declare sorts
(declare-sort Bst_t 0)

;; declare fields
(declare-fun left () (Field Bst_t Bst_t))
(declare-fun right () (Field Bst_t Bst_t))
(declare-fun data () (Field Bst_t Int))

;; declare predicates

;; bst(E,M)::= E = nil & emp & M = emptybag | 
;; exists X,Y,M1,M2. E |-> ((left,X), (right,Y)) * bst(X,M1) * bst(Y,M2) & M = {E.data} cup M1 cup M2 & M1 < E.data < M2


(define-fun bst ((?E Bst_t) (?M BagInt)) Space (tospace 
	(or 
	(and (= ?E nil) 
		(tobool emp
		)
		(= ?M emptybag)
	)
 
	(exists ( (?X Bst_t) (?Y Bst_t) (?M1 BagInt) (?M2 BagInt) (?d Int) ) 
	(and (distinct ?E nil) 
		(tobool (ssep 
		(pto ?E (sref (ref left ?X) (ref right ?Y) (ref data ?d)) ) 
		(bst ?X ?M1)
		(bst ?Y ?M2)
		)
		)
		(= ?M (bag-union (singleton ?d) (bag-union ?M1 ?M2) ) )
		(bag-lt ?M1 (singleton ?d))
		(bag-lt (singleton ?d) ?M2)
	)
	)
	)
))

;; bsthole(E,F,M1,M2)::= E = F & emp & M1 = M2 | 
;; exists X,Y,M3,M4. E |-> ((left,X), (right,Y)) * bst(X,M3) * bsthole(Y,F,M4,M2) & M1={E.data} cup M3 cup M4 & M3 < E.data < M4 |
;; exists X,Y,M3,M4. E |-> ((left,X), (right,Y)) * bsthole(X,F,M3,M2) * bst(Y,M4) & M1={E.data} cup M3 cup M4 & M3 < E.data < M4

(define-fun bsthole ((?E Bst_t) (?F Bst_t) (?M1 BagInt) (?M2 BagInt)) Space (tospace 
	(or 
	(and (= ?E ?F) 
		(tobool emp
		)
		(= ?M1 ?M2)
	)
 
	(exists ((?X Bst_t) (?Y Bst_t) (?M3 BagInt) (?M4 BagInt) (?d Int)) 
	(and (distinct ?E ?F) 
		(tobool (ssep 
		(pto ?E (sref (ref left ?X) (ref right ?Y) (ref data ?d)) ) 
		(bst ?X ?M3)
		(bsthole ?Y ?F ?M4 ?M2)
		)
		)
		(= ?M1  (bag-union (singleton ?d) (bag-union ?M3 ?M4) ) )
		(bag-lt ?M3 (singleton ?d) )
		(bag-lt (singleton ?d) ?M4 )
	) 
	)

	(exists ((?X Bst_t) (?Y Bst_t) (?M3 BagInt) (?M4 BagInt) (?d Int)) 
	(and (distinct ?E ?F) 
		(tobool (ssep 
		(pto ?E (sref (ref left ?X) (ref right ?Y) (ref data ?d)) ) 
		(bsthole ?X ?F ?M3 ?M2)
		(bst ?Y ?M4)
		)
		)
		(= ?M1 (bag-union (singleton ?d) (bag-union ?M3 ?M4) ) )
		(bag-lt ?M3 (singleton ?d) )
		(bag-lt (singleton ?d) ?M4 )
	) 
	)
	)
))

;; declare variables
(declare-fun root () Bst_t)
(declare-fun cur1 () Bst_t)
(declare-fun cur2 () Bst_t)
(declare-fun parent () Bst_t)
(declare-fun Y () Bst_t)
(declare-fun M0 () BagInt)
(declare-fun M1 () BagInt)
(declare-fun M2 () BagInt)
(declare-fun M3 () BagInt)
(declare-fun M4 () BagInt)
;;(declare-fun M5 () BagInt)
;;(declare-fun M6 () BagInt)
(declare-fun key () Int)
(declare-fun d () Int)

;; declare set of locations

(declare-fun alpha1 () SetLoc)
(declare-fun alpha2 () SetLoc)
(declare-fun alpha3 () SetLoc)
(declare-fun alpha4 () SetLoc)
(declare-fun alpha5 () SetLoc)

;; VC: root |-> ((left, cur2), (right,Y)) * bst(cur2,M1) * bst(Y,M2) & M0 = {root.data} cup M1 cup M2 & M1 < root.data < M2
;;  & cur1 = root & cur1.data > key & parent = cur1 & M3 = M0 \ {key} & M4 = ({parent.data} cup M1 cup M2) \ {key} |- 
;; bsthole(root, parent, M3, M4) * parent |-> ((left,cur2), (right,Y)) * bst(cur2, M1) * bst(Y,M2) & M3 = M0 \ {key} & 
;; M4 = ({parent.data} cup M1 cup M2) \ {key} & M1 < parent.data < M2 & parent.data > key & 
;; (key in M0 <=> key in M1)

(assert 
	(and
	(tobool 
	(ssep 
		(pto root (sref (ref left cur2) (ref right Y) (data d) ) ) 
		(index alpha1 (bst cur2 M1) )
		(index alpha2 (bst Y M2) )
	))
	(= M0 (bag-union (singleton d) (bag-union M1 M2)) )
	(bag-lt M1 (singleton d) )
	(bag-lt (singleton d) M2)
	(= cur1 root)
	(> d key)
	(= parent cur1)
	(= M3 (bag-diff M0 (singleton key)))
	(= M4 (bag-diff (bag-union (singleton d) (bag-union M1 M2)) (singleton key)))
	)
)

;; bsthole(root, parent, M3, M4) * parent |-> ((left,cur2), (right,Y)) * bst(cur2, M1) * bst(Y,M2) & M3 = M0 \ {key} & 
;; M4 = ({parent.data} cup M1 cup M2) \ {key} & M1 < parent.data < M2 &  parent.data > key & 
;; (key in M0 <=> key in M1)

(assert (not 
	(and
	(tobool 
	(ssep 
		(index alpha3 (bsthole root parent M3 M4) )
		(pto parent (sref (ref left cur2) (ref right Y) (data d) ) ) 
		(index alpha4 (bst cur2 M1) )
		(index alpha5 (bst Y M2) )
	))
	(= M3 (bag-diff M0 (singleton key)) )
	(= M4 (bag-diff (bag-union (singleton d) (bag-union M1 M2)) (singleton key)) )
	(bag-lt M1 (singleton d) )
	(bag-lt (singleton d) M2)
	(> d key)
	(or (not (bag-sub (singleton key) M0)) (bag-sub (singleton key) M1))
	(or (not (bag-sub (singleton key) M1)) (bag-sub (singleton key) M0))
	)
))

(check-sat)