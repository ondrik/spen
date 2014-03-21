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
(declare-fun alpha11 () SetLoc)
(declare-fun alpha12 () SetLoc)
(assert
  (and 
    (= nil nil)
(distinct x6 x7 )
(distinct x6 x9 )
(distinct x11 x16 )
(distinct x3 x11 )
(distinct x3 x4 )
(distinct x7 x16 )
(distinct x7 x15 )
(distinct x2 x6 )
(distinct x2 x16 )
(distinct x14 x16 )
(distinct x15 x16 )
(distinct x8 x9 )
(distinct x1 x11 )
(distinct x1 x3 )
(distinct x4 x8 )
(distinct x4 x6 )
(distinct x4 x15 )
(distinct x10 x15 )
(distinct x13 x16 )
(distinct x5 x16 )
    (tobool  (ssep  (index alpha0 (ls x5 x2 )) (ssep  (index alpha1 (ls x13 x16 )) (ssep  (index alpha2 (ls x8 x4 )) (ssep  (index alpha3 (ls x15 x7 )) (ssep  (index alpha4 (ls x9 x16 )) (ssep  (index alpha5 (ls x7 x15 )) (ssep  (index alpha6 (ls x11 x15 )) (ssep  (index alpha7 (ls x6 x10 ))(ssep (pto x_emp (ref f y_emp)) (pto z_emp (ref f t_emp))))))))))))
  )
)
(assert
  (not
    (and (distinct x1 x1 )    (tobool (ssep (pto x_emp (ref f y_emp)) (pto z_emp (ref f t_emp))))
)  ))

(check-sat)
