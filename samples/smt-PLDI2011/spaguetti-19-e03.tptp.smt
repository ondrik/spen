(set-logic QF_SLRD)

(declare-sort Sll_t 0)

(declare-fun f () (Field Sll_t Sll_t))

(define-fun ls ((?in Sll_t) (?out Sll_t)) Space
(tospace (or (= ?in ?out)
(exists ((?u Sll_t))
(tobool
(ssep (pto ?in (ref f ?u)) (ls ?u ?out)
))))))

(declare-fun nil () Sll_t)

(declare-fun x_emp () Sll_t)
(declare-fun y_emp () Sll_t)
(declare-fun z_emp () Sll_t)
(declare-fun t_emp () Sll_t)
(declare-fun x0 () Sll_t)
(declare-fun x1 () Sll_t)
(declare-fun x2 () Sll_t)
(declare-fun x3 () Sll_t)
(declare-fun x4 () Sll_t)
(declare-fun x5 () Sll_t)
(declare-fun x6 () Sll_t)
(declare-fun x7 () Sll_t)
(declare-fun x8 () Sll_t)
(declare-fun x9 () Sll_t)
(declare-fun x10 () Sll_t)
(declare-fun x11 () Sll_t)
(declare-fun x12 () Sll_t)
(declare-fun x13 () Sll_t)
(declare-fun x14 () Sll_t)
(declare-fun x15 () Sll_t)
(declare-fun x16 () Sll_t)
(declare-fun x17 () Sll_t)
(declare-fun x18 () Sll_t)
(declare-fun x19 () Sll_t)
(declare-fun x20 () Sll_t)
(declare-fun x21 () Sll_t)
(declare-fun x22 () Sll_t)
(declare-fun x23 () Sll_t)
(declare-fun alpha0 () SetLoc)
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
(assert
  (and 
    (= nil nil)
(distinct x11 x13 )
(distinct x11 x15 )
(distinct x3 x6 )
(distinct x7 x9 )
(distinct x9 x18 )
(distinct x9 x19 )
(distinct x12 x18 )
(distinct x12 x19 )
(distinct x2 x16 )
(distinct x2 x13 )
(distinct x8 x18 )
(distinct x8 x10 )
(distinct x1 x6 )
(distinct x1 x7 )
(distinct x1 x10 )
(distinct x1 x16 )
(distinct x1 x17 )
(distinct x5 x16 )
(distinct x5 x13 )
    (tobool  (ssep  (index alpha0 (ls x8 x1 )) (ssep  (index alpha1 (ls x12 x19 )) (ssep  (index alpha2 (ls x17 x19 )) (ssep  (index alpha3 (ls x7 x17 )) (ssep  (index alpha4 (ls x7 x12 )) (ssep  (index alpha5 (ls x3 x2 ))(ssep (pto x_emp (ref f y_emp)) (pto z_emp (ref f t_emp))))))))))
  )
)
(assert
  (not
    (and (distinct x1 x1 )    (tobool (ssep (pto x_emp (ref f y_emp)) (pto z_emp (ref f t_emp))))
)  ))

(check-sat)
