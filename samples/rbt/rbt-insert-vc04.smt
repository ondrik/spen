
; Extending QF_S:
; constant emptybag, 
; the function bag, 
; the multiset comparison operator bag-lt, bag-le, bag-gt, bag-ge
; bagunion, bag-diff, bag-sub

(set-logic QF_SLRDI)

;; declare sorts
(declare-sort Rbt_t 0)

;; declare fields
(declare-fun left () (Field Rbt_t Rbt_t))
(declare-fun right () (Field Rbt_t Rbt_t))
(declare-fun data () (Field Rbt_t Int))
(declare-fun color () (Field Rbt_t Int))

;; declare predicates

;; Each node has two data fields: data, color (0: red, 1: black). 
;; the rbt predicate defined here does not require the root to be black

;; rbt(E, M, N, C)::= E = nil & emp & M = emptyset & N = 1 & C = 1 | 
;; exists X,Y,M1,M2,N1,N2,C1,C2. E |-> ((left,X), (right,Y)) * rbt(X,M1,N1,C1) * rbt(Y,M2,N2,C2) & M = {E.data} cup M1 cup M2 & 
;; M1 < E.data < M2 & N1 = N2 & C = E.color  & 0 <= C <= 1 & ite(C=0, N = N1, N=N1+1) & C = 0 => (C1 = 1 & C2 = 1)


(define-fun rbt ((?E Rbt_t) (?M BagInt) (?N Int) (?C Int)) Space (tospace 
	(or 
	(and (= ?E nil) 
		(tobool emp
		)
		(= ?M emptybag)
		(= ?N 1)
		(= ?C 1)
	)
 
	(exists ( (?X Rbt_t) (?Y Rbt_t) (?M1 BagInt) (?M2 BagInt) (?N1 Int) (?N2 Int) (?C1 Int) (?C2 Int) (?d Int) (?c Int) ) 
	(and (distinct ?E nil) 
		(tobool 
		(ssep 
			(pto ?E (sref (ref left ?X) (ref right ?Y) (ref data ?d) (ref color ?c) ) ) 
			(rbt ?X ?M1 ?N1 ?C1)
			(rbt ?Y ?M2 ?N2 ?C2)
		)
		)
		(= ?M (bagunion ?M1 (bag ?d) ?M2) )
		(< ?M1 (bag ?d))
		(< (bag ?d) ?M2)
		(= ?N (ite (= ?C 0) ?N1 (+ ?N1 1) ) )
		(= ?N1 ?N2)
		(= ?c ?C)	
		(= ?C 0) (= ?C1 1) (= ?C2 1)
	)
	)

	(exists ( (?X Rbt_t) (?Y Rbt_t) (?M1 BagInt) (?M2 BagInt) (?N1 Int) (?N2 Int) (?C1 Int) (?C2 Int) (?d Int) (?c Int) ) 
	(and (distinct ?E nil) 
		(tobool 
		(ssep 
			(pto ?E (sref (ref left ?X) (ref right ?Y) (ref data ?d) (ref color ?c) ) ) 
			(rbt ?X ?M1 ?N1 ?C1)
			(rbt ?Y ?M2 ?N2 ?C2)
		)
		)
		(= ?M (bagunion ?M1 (bag ?d) ?M2) )
		(< ?M1 (bag ?d))
		(< (bag ?d) ?M2)
		(= ?N (ite (= ?C 0) ?N1 (+ ?N1 1) ) )
		(= ?N1 ?N2)
		(= ?c ?C)	
		(= ?C 1) (<= 0 ?C1) (<= ?C1 1) (<= 0 ?C2) (<= ?C2 1)
	)
	)
	)
))

;; rbthole(E,F, M1, N1, C1, M2, N2, C2)::= E = F & emp & M1 = M2 & N1 = N2 & C1 = C2 | 
;; exists X,Y,M3,M4,N3,N4, C3, C4. E |-> ((left,X), (right,Y)) * rbt(X,M3,N3,C3) * rbthole(Y,F,M4,N4,C4, M2, N2, C2) & 
;; M1 = {E.data} cup M3 cup M4 & M3 < E.data < M4 & N3 = N4 & C1 = E.color & 0 <= C1,C3,C4 <= 1 & ite(C1=0, N1=N3, N1=N3+1) & 
;; C1 = 0 => (C3 = 1 & C4 = 1) |
;; exists X,Y,M3,M4,N3,N4, C3, C4. E |-> ((left,X), (right,Y)) * rbthole(X,F,M3,N3,C3, M2, N2, C2) * rbt(Y,M4,N4,C4) & 
;; M1 = {E.data} cup M3 cup M4 & M3 < E.data < M4 & N3 = N4 & C1 = E.color & 0 <= C1,C3,C4 <= 1 & ite(C1=0, N1=N3, N2=N3+1) & 
;; C1 = 0 => (C3 = 1 & C4 = 1)

(define-fun rbthole ((?E Rbt_t) (?F Rbt_t) (?M1 BagInt) (?N1 Int) (?C1 Int) (?M2 BagInt) (?N2 Int) (?C2 Int)) Space (tospace 
	(or 
	(and (= ?E ?F) 
		(tobool emp
		)
		(= ?M1 ?M2)
		(= ?N1 ?N2)
		(= ?C1 ?C2)
	)
 
	(exists ( (?X Rbt_t) (?Y Rbt_t) (?M3 BagInt) (?N3 Int) (?C3 Int) (?M4 BagInt) (?N4 Int) (?C4 Int) (?d Int) (?c Int) ) 
	(and (distinct ?E ?F) 
		(tobool 
		(ssep 
			(pto ?E (sref (ref left ?X) (ref right ?Y) (ref data ?d) (ref color ?c)) ) 
			(rbthole ?X ?F ?M3 ?N3 ?C3 ?M2 ?N2 ?C2)
			(rbt ?Y ?M4 ?N4 ?C4)
		)
		)
		(= ?M1 (bagunion ?M3 (bag ?d) ?M4) )
		(< ?M3 (bag ?d))
		(< (bag ?d) ?M4)
		(= ?N1 (ite (= ?C1 0) ?N3 (+ ?N3 1) ) )
		(= ?N3 ?N4)
		(= ?c ?C1)	
		(= ?C1 0) (= ?C3 1) (= ?C4 1)
	)
	)

	(exists ( (?X Rbt_t) (?Y Rbt_t) (?M3 BagInt) (?N3 Int) (?C3 Int) (?M4 BagInt) (?N4 Int) (?C4 Int) (?d Int) (?c Int) ) 
	(and (distinct ?E ?F) 
		(tobool 
		(ssep 
			(pto ?E (sref (ref left ?X) (ref right ?Y) (ref data ?d) (ref color ?c)) ) 
			(rbthole ?X ?F ?M3 ?N3 ?C3 ?M2 ?N2 ?C2)
			(rbt ?Y ?M4 ?N4 ?C4)
		)
		)
		(= ?M1 (bagunion ?M3 (bag ?d) ?M4) )
		(< ?M3 (bag ?d))
		(< (bag ?d) ?M4)
		(= ?N1 (ite (= ?C1 0) ?N3 (+ ?N3 1) ) )
		(= ?N3 ?N4)
		(= ?c ?C1)	
		(= ?C1 1) (<= 0 ?C3) (<= ?C3 1) (<= 0 ?C4) (<= ?C4 1)
	)
	)

	(exists ( (?X Rbt_t) (?Y Rbt_t) (?M3 BagInt) (?N3 Int) (?C3 Int) (?M4 BagInt) (?N4 Int) (?C4 Int) (?d Int) (?c Int) ) 
	(and (distinct ?E ?F) 
		(tobool 
		(ssep 
			(pto ?E (sref (ref left ?X) (ref right ?Y) (ref data ?d) (ref color ?c)) ) 
			(rbt ?X ?M3 ?N3 ?C3)
			(rbthole ?Y ?F ?M4 ?N4 ?C4 ?M2 ?N2 ?C2)
		)
		)
		(= ?M1 (bagunion ?M3 (bag ?d) ?M4) )
		(< ?M3 (bag ?d))
		(< (bag ?d) ?M4)
		(= ?N1 (ite (= ?C1 0) ?N3 (+ ?N3 1) ) )
		(= ?N3 ?N4)
		(= ?c ?C1)	
		(= ?C1 0) (= ?C3 1)(= ?C4 1)
	)
	)

	(exists ( (?X Rbt_t) (?Y Rbt_t) (?M3 BagInt) (?N3 Int) (?C3 Int) (?M4 BagInt) (?N4 Int) (?C4 Int) (?d Int) (?c Int) ) 
	(and (distinct ?E ?F) 
		(tobool 
		(ssep 
			(pto ?E (sref (ref left ?X) (ref right ?Y) (ref data ?d) (ref color ?c)) ) 
			(rbt ?X ?M3 ?N3 ?C3)
			(rbthole ?Y ?F ?M4 ?N4 ?C4 ?M2 ?N2 ?C2)
		)
		)
		(= ?M1 (bagunion ?M3 (bag ?d) ?M4) )
		(< ?M3 (bag ?d))
		(< (bag ?d) ?M4)
		(= ?N1 (ite (= ?C1 0) ?N3 (+ ?N3 1) ) )
		(= ?N3 ?N4)
		(= ?c ?C1)	
		(= ?C1 1) (<= 0 ?C3) (<= ?C3 1) (<= 0 ?C4) (<= ?C4 1)
	)
	)
	)
))



;; declare variables
(declare-fun root () Rbt_t)
(declare-fun root0 () Rbt_t)
(declare-fun cur () Rbt_t)
(declare-fun cur1 () Rbt_t)
(declare-fun cur2 () Rbt_t)
(declare-fun parent () Rbt_t)
(declare-fun parent0 () Rbt_t)
(declare-fun parent1 () Rbt_t)
(declare-fun parent2 () Rbt_t)
(declare-fun grandpa () Rbt_t)
(declare-fun grandpa1 () Rbt_t)
(declare-fun grandpa2 () Rbt_t)
(declare-fun ggrandpa () Rbt_t)
(declare-fun ggrandpa1 () Rbt_t)
(declare-fun ggrandpa2 () Rbt_t)
(declare-fun cusparent () Rbt_t)
(declare-fun cusparent1 () Rbt_t)
(declare-fun cusparent2 () Rbt_t)
(declare-fun cusnode () Rbt_t)
(declare-fun cusnode1 () Rbt_t)
(declare-fun cusnode2 () Rbt_t)
(declare-fun cu () Rbt_t)
(declare-fun cu1 () Rbt_t)
(declare-fun cu2 () Rbt_t)
(declare-fun pa () Rbt_t)
(declare-fun gra () Rbt_t)
(declare-fun uncle () Rbt_t)
(declare-fun uncle1 () Rbt_t)
(declare-fun uncle2 () Rbt_t)

(declare-fun x () Rbt_t)
(declare-fun X () Rbt_t)
(declare-fun Y () Rbt_t)
(declare-fun Z () Rbt_t)
(declare-fun U () Rbt_t)
(declare-fun V () Rbt_t)
(declare-fun W () Rbt_t)
(declare-fun U1 () Rbt_t)
(declare-fun V1 () Rbt_t)
(declare-fun U2 () Rbt_t)
(declare-fun V2 () Rbt_t)

(declare-fun M0 () BagInt)
(declare-fun M1 () BagInt)
(declare-fun M2 () BagInt)
(declare-fun M3 () BagInt)
(declare-fun M4 () BagInt)
(declare-fun M5 () BagInt)
(declare-fun M6 () BagInt)
(declare-fun M7 () BagInt)
(declare-fun M8 () BagInt)
(declare-fun M9 () BagInt)
(declare-fun M10 () BagInt)
(declare-fun M11 () BagInt)
(declare-fun M12 () BagInt)
(declare-fun M13 () BagInt)
(declare-fun M14 () BagInt)
(declare-fun M15 () BagInt)

(declare-fun N1 () Int)
(declare-fun N2 () Int)
(declare-fun N3 () Int)
(declare-fun N4 () Int)
(declare-fun N5 () Int)
(declare-fun N6 () Int)
(declare-fun N7 () Int)
(declare-fun N8 () Int)
(declare-fun N9 () Int)
(declare-fun N10 () Int)
(declare-fun N11 () Int)
(declare-fun N12 () Int)
(declare-fun N13 () Int)
(declare-fun N14 () Int)
(declare-fun N15 () Int)

(declare-fun n1 () Int)
(declare-fun n2 () Int)
(declare-fun n3 () Int)
(declare-fun n4 () Int)
(declare-fun n5 () Int)
(declare-fun n6 () Int)
(declare-fun n7 () Int)
(declare-fun n8 () Int)
(declare-fun n9 () Int)
(declare-fun n10 () Int)
(declare-fun iseven () Int)

(declare-fun C1 () Int)
(declare-fun C2 () Int)
(declare-fun C3 () Int)
(declare-fun C4 () Int)
(declare-fun C5 () Int)
(declare-fun C6 () Int)
(declare-fun C7 () Int)
(declare-fun C8 () Int)
(declare-fun C9 () Int)
(declare-fun C10 () Int)
(declare-fun C11 () Int)
(declare-fun C12 () Int)
(declare-fun C13 () Int)
(declare-fun C14 () Int)
(declare-fun C15 () Int)

(declare-fun d1 () Int)
(declare-fun d2 () Int)
(declare-fun d3 () Int)
(declare-fun d4 () Int)
(declare-fun d5 () Int)
(declare-fun d6 () Int)
(declare-fun d7 () Int)
(declare-fun d8 () Int)
(declare-fun c1 () Int)
(declare-fun c2 () Int)
(declare-fun c3 () Int)
(declare-fun c4 () Int)
(declare-fun c5 () Int)
(declare-fun c6 () Int)
(declare-fun c7 () Int)
(declare-fun c8 () Int)

(declare-fun key () Int)

;; declare set of locations

(declare-fun alpha1 () SetLoc)
(declare-fun alpha2 () SetLoc)
(declare-fun alpha3 () SetLoc)
(declare-fun alpha4 () SetLoc)
(declare-fun alpha5 () SetLoc)
(declare-fun alpha6 () SetLoc)
(declare-fun alpha7 () SetLoc)
(declare-fun alpha8 () SetLoc)
(declare-fun alpha9 () SetLoc)
(declare-fun alpha10 () SetLoc)
(declare-fun alpha11 () SetLoc)
(declare-fun alpha12 () SetLoc)
(declare-fun alpha13 () SetLoc)
(declare-fun alpha14 () SetLoc)


;; VC04: cusparent1 |-> ((left,cusnode1),(right,X),(data,d1),(color,c1)) * rbt(X,M3,N3,C3) * cusnode1 |-> ((left, parent1),
;; (right, uncle1),(data,d2),(color,c2)) * rbt(uncle1,M4,N4,C4) * parent1 |-> ((left,cur1),(right,V),(data,d3),(color,c3)) *
;; rbt(V,M5,N5,C5) * cur1 |-> ((left,U1),(right,U),(data,d5),(color,c5)) * rbt(U,M10,N10,C10) * rbthole(U1,parent0,M9,N9,C9,
;; M7,N7,C7) * parent0 |-> ((left,x),(right,Z),(data,d4),(color,c4)) * x |-> ((left,nil),(right,nil),(data,key),(color,0)) *
;; rbt(Z,M8,N8,C8) 
;; & M9 < d5 < M10 & N9 = N10 & 0 <=c5 <=1 & (c5=0 => C9=1 & C10 = 1) & M6= {d5} cup M9 cup M10 & N6 = ite(c5=0,N10,N10+1) &
;; C6 = c5 & key < d4 < M8 & N8=1 & 0<=c4 <= 1 & c4=0 => C8 = 1 & M7 = {d4} cup {key} cup M8 & N7=ite(c4=0,N8,N8+1) & 
;; C7=c4 & M7 < d3 < M5 & N6 = N5 & 0<=c3 <= 1 & (c3 =0 => C6 =1 & C5 = 1) & {d3} cup M6 cup M5 < d2 < M4 & 
;; n3=ite(c3=0, N5,N5+1) & n3 = N4 & 0<=c2 <= 1 & (c2 =0 => c3 =1 & C4 = 1) & {d3} cup M6 cup M5 cup {d2} cup M4 < d1 < M3 &
;; n2=ite(c2=0,N4,N4+1) & n2=N3 & 0 <=c1 <= 1 & (c1 = 0 => c2 =1 & C3 = 1) & M0 cup {key} = {d3} cup M6 cup M5 cup {d2} cup
;; M4 cup {d1} cup M3 & ! key in M0 & ! parent0 = nil & ! parent0 = root & cusparent1 = root & cusparent1 = ggrandpa1 &
;; cusnode1 = grandpa1 & is_even = 1 & (c3 = 1 | C4 = 1) & parent2 = cur1 & cur2 = U1 & (= cusparent2 cusparent1) 
;; (= cusnode2 cusnode1)(= grandpa2 parent1) (= ggrandpa2 cusnode1) (= uncle2 V)
;; |-
;; cusparent2 |-> ((left,cusnode2),(right,X),(data,d1),(color,c1)) * rbt(X,M3,N3,C3) * cusnode2 |-> ((left, grandpa2),
;; (right, uncle1),(data,d2),(color,c2)) * rbt(uncle1,M4,N4,C4) * grandpa2 |-> ((left,parent2),(right,uncle2),(data,d3),
;; (color,c3)) * rbt(uncle2,M5,N5,C5) * parent2 |-> ((left,cur2),(right,U),(data,d5),(color,c5)) * rbthole(cur2,parent0,M9,
;; N9,C9,M7,N7,C7) * rbt(U,M10,N10,C10) * parent0 |-> ((left,x),(right,Z),(data,d4),(color,c4)) * x |-> ((left,nil),
;; (right,nil),(data,key),(color,0)) * rbt(Z,M8,N8,C8)
;; & M9 < d5 < M10 & N9 = N10 & 0 <=c5 <=1 & (c5=0 => C9=1 & C10 = 1) & key < d4 < M8 & N8=1 & 0<=c4 <= 1 & c4=0 => C8 = 1 &
;; M7 = {d4} cup {key} cup M8 & N7=ite(c4=0,N8,N8+1) & C7=c4 & M9 cup {d5} cup M10 < d3 < M5 & n5=ite(c5=0, N10, N10+1) & 
;; n5 = N5 & 0<=c3 <= 1 & (c3 =0 => c5 =1 & C5 = 1) & M9 cup {d5} cup M10 cup {d3} cup M5 < d2 < M4 & n3=ite(c3=0, N5,N5+1)
;; & n3 = N4 & 0<=c2 <= 1 & (c2 =0 => c3 =1 & C4 = 1) & M9 cup {d5} cup M10 cup {d3} cup M5 cup {d2} cup M4 < d1 < M3 &
;; n2=ite(c2=0,N4,N4+1) & n2=N3 & 0 <=c1 <= 1 & (c1 = 0 => c2 =1 & C3 = 1) & M0 cup {key} = M9 cup {d5} cup M10 cup {d3} cup
;; M5 cup {d2} cup M4 cup {d1} cup M3 & ! key in M0 & ! parent0 = nil & ! parent0 = root & cusparent2 = root & 
;; cusnode2 = ggrandpa2 & is_even = 1


(assert 
	(and
	(tobool 
	(ssep 
		(pto cusparent1 (sref (ref left cusnode1) (ref right X) (ref data d1) (ref color c1)) )
		(index alpha1 (rbt X M3 N3 C3) )
		(pto cusnode1 (sref (ref left parent1) (ref right uncle1) (ref data d2) (ref color c2)) )
		(index alpha2 (rbt uncle1 M4 N4 C4) )
		(pto parent1 (sref (ref left cur1) (ref right V) (ref data d3) (ref color c3)) )
		(index alpha3 (rbt V M5 N5 C5) ) 
		(pto cur1 (sref (ref left U1) (ref right U) (ref data d5) (ref color c5)) )
		(index alpha4 (rbt U M10 N10 C10) ) 
		(index alpha5 (rbthole U1 parent0 M9 N9 C9 M7 N7 C7) )
		(pto parent0 (sref (ref left x) (ref right Z) (ref data d4) (ref color c4)) )
		(pto x (sref (ref left nil) (ref right nil) (ref data key) (ref color c6)) )
		(index alpha6 (rbt Z M8 N8 C8)) 
	))
	(< M9 (bag d5)) (< (bag d5) M10)(= N9 N10) (<= 0 c5) (<= c5 1)
	(=> (= c5 0) (= C9 1) ) (=> (= c5 0) (= C10 1) ) (= M6 (bagunion (bag d5) M9 M10) ) 
	(= N6 (ite (= c5 0) N10 (+ N10 1)) ) (= C6 c5)
	(< key d4) (< (bag d4) M8) (= N8 1) (<= 0 c4) (<= c4 1)
	(=> (= c4 0) (= C8 1) ) (= M7 (bagunion (bag d4) (bag key) M8) ) 
	(= N7 (ite (= c4 0) N8 (+ N8 1)) ) (= C7 c4) (< M7 (bag d3)) (< (bag d3) M5)
	(= N6 N5) (<= 0 c3) (<= c3 1) (=> (= c3 0) (= C6 1) ) (=> (= c3 0) (= C5 1) )
	(< (bagunion (bag d3) M6 M5) (bag d2) ) (< (bag d2) M4)
	(= N4 (ite (= c3 0) N5 (+ N5 1)) ) 
	(<= 0 c2) (<= c2 1) (=> (= c2 0) (= c3 1) )( => (= c2 0) (= C4 1) ) (< (bagunion (bag d3) M6 M5 (bag d2) M4) (bag d1) ) 
	(< (bag d1) M3) (= N3  (ite (= c2 0) N4 (+ N4 1)) ) (<= 0 c1) (<= c1 1)
	(=> (= c1 0) (= c2 1) ) ( => (= c2 1) (= C3 1) ) 
	(= (bagunion M0 (bag key)) (bagunion (bag d3) M6 M5 (bag d2) M4 (bag d1) M3) )
	(= M0 (bagminus M0 (bag key)) ) (distinct parent0 nil) (distinct parent0 root) (= cusparent1 root)
	(= cusparent1 ggrandpa1) (= cusnode1 grandpa1) (= iseven 1) (>= (+ c3 C4) 1) (= parent2 cur1) (= cur2 U1) 
	(= cusparent2 cusparent1) (= cusnode2 cusnode1)(= grandpa2 parent1) (= ggrandpa2 cusnode1) (= uncle2 V)
	(= c6 0)
	)
)

;; cusparent2 |-> ((left,cusnode2),(right,X),(data,d1),(color,c1)) * rbt(X,M3,N3,C3) * cusnode2 |-> ((left, grandpa2),
;; (right, uncle1),(data,d2),(color,c2)) * rbt(uncle1,M4,N4,C4) * grandpa2 |-> ((left,parent2),(right,uncle2),(data,d3),
;; (color,c3)) * rbt(uncle2,M5,N5,C5) * parent2 |-> ((left,cur2),(right,U),(data,d5),(color,c5)) * rbthole(cur2,parent0,M9,
;; N9,C9,M7,N7,C7) * rbt(U,M10,N10,C10) * parent0 |-> ((left,x),(right,Z),(data,d4),(color,c4)) * x |-> ((left,nil),
;; (right,nil),(data,key),(color,0)) * rbt(Z,M8,N8,C8)
;; & M9 < d5 < M10 & N9 = N10 & 0 <=c5 <=1 & (c5=0 => C9=1 & C10 = 1) & key < d4 < M8 & N8=1 & 0<=c4 <= 1 & c4=0 => C8 = 1 &
;; M7 = {d4} cup {key} cup M8 & N7=ite(c4=0,N8,N8+1) & C7=c4 & M9 cup {d5} cup M10 < d3 < M5 & n5=ite(c5=0, N10, N10+1) & 
;; n5 = N5 & 0<=c3 <= 1 & (c3 =0 => c5 =1 & C5 = 1) & M9 cup {d5} cup M10 cup {d3} cup M5 < d2 < M4 & n3=ite(c3=0, N5,N5+1)
;; & n3 = N4 & 0<=c2 <= 1 & (c2 =0 => c3 =1 & C4 = 1) & M9 cup {d5} cup M10 cup {d3} cup M5 cup {d2} cup M4 < d1 < M3 &
;; n2=ite(c2=0,N4,N4+1) & n2=N3 & 0 <=c1 <= 1 & (c1 = 0 => c2 =1 & C3 = 1) & M0 cup {key} = M9 cup {d5} cup M10 cup {d3} cup
;; M5 cup {d2} cup M4 cup {d1} cup M3 & ! key in M0 & ! parent0 = nil & ! parent0 = root & cusparent2 = root & 
;; cusnode2 = ggrandpa2 & is_even = 1

(assert (not 
	(and 
	(tobool 
	(ssep 
		(pto cusparent2 (sref (ref left cusnode2) (ref right X) (ref data d1) (ref color c1)) )
		(index alpha1 (rbt X M3 N3 C3) ) 
		(pto cusnode2 (sref (ref left grandpa2) (ref right uncle1) (ref data d2) (ref color c2)) )
		(index alpha2 (rbt uncle1 M4 N4 C4) )
		(pto grandpa2 (sref (ref left parent2) (ref right uncle2) (ref data d3) (ref color c3)) )
		(index alpha3 (rbt uncle2 M5 N5 C5) ) 
		(pto parent2 (sref (ref left cur2) (ref right U) (ref data d5) (ref color c5)) )
		(index alpha4 (rbthole cur2 parent0 M9 N9 C9 M7 N7 C7) )
		(index alpha5 (rbt U M10 N10 C10) )
		(pto parent0 (sref (ref left x) (ref right Z) (ref data d4) (ref color c4)) )
		(pto x (sref (ref left nil) (ref right nil) (ref data key) (ref color c6)) )
		(index alpha6 (rbt Z M8 N8 C8) )
	))
	(< M9 (bag d5)) (< (bag d5) M10) (= N9 N10) (<= 0 c5) (<= c5 1)
	(=> (= c5 0) (= C9 1) ) (=> (= c5 0) (= C10 1) ) (< key d4) (< (bag d4) M8) (= N8 1)
	(<= 0 c4) (<= c4 1) (=> (= c4 0) (= C8 1))
	(= M7 (bagunion (bag d4) (bag key) M8) ) 
	(= N7 (ite (= c4 0) N8 (+ N8 1)) ) (= C7 c4) (< (bagunion M9 (bag d5) M10) (bag d3) ) (< (bag d3) M5)
	(= n5 (ite (= c5 0) N10 (+ N10 1)) )
	(= n5 N5) (<= 0 c3) (<= c3 1) (=> (= c3 0) (= c5 1) ) (=> (= c3 0) (= C5 1)) 
	(< (bagunion M9 (bag d5) M10  (bag d3) M5) (bag d2) ) (< (bag d2) M4)
	(= N4 (ite (= c3 0) N5 (+ N5 1)) ) (<= 0 c2) (<= c2 1)
	(=> (= c2 0) (= c3 1) ) (=> (= c2 0) (= C4 1) ) (< (bagunion M9 (bag d5) M10 (bag d3) M5 (bag d2) M4) (bag d1) )
	(< (bag d1) M3) (= N3 (ite (= c2 0) N4 (+ N4 1)) ) (<= 0 c1) (<= c1 1)
	(=> (= c1 0) (= c2 1) ) (=> (= c1 0) (= C3 1) ) 
	(= (bagunion M0 (bag key)) (bagunion M9 (bag d5) M10 (bag d3) M5 (bag d2) M4 (bag d1) M3) ) 
	(= M0 (bagminus M0 (bag key)) ) (distinct parent0 nil) (distinct parent0 root) (= cusparent2 root)
	(= cusnode2 ggrandpa2) (= iseven 1) (= c6 0)
	)
))

(check-sat)
