(set-logic QF_NOLL)

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
(declare-fun alpha13 () SetLoc)
(declare-fun alpha14 () SetLoc)
(declare-fun alpha15 () SetLoc)
(declare-fun alpha16 () SetLoc)
(declare-fun alpha17 () SetLoc)
(declare-fun alpha18 () SetLoc)
(assert
  (and 
    (= nil nil)
(distinct x6 x12 )
(distinct x6 x14 )
(distinct x7 x11 )
(distinct x7 x15 )
(distinct x9 x11 )
(distinct x9 x15 )
(distinct x2 x10 )
(distinct x2 x12 )
(distinct x8 x11 )
(distinct x8 x13 )
(distinct x4 x8 )
(distinct x4 x6 )
(distinct x1 x3 )
(distinct x1 x7 )
(distinct x1 x9 )
(distinct x13 x14 )
(distinct x10 x12 )
(distinct x10 x14 )
(distinct x5 x8 )
    (tobool  (ssep  (index alpha0 (ls x10 x5 )) (ssep  (index alpha1 (ls x10 x14 )) (ssep  (index alpha2 (ls x10 x8 )) (ssep  (index alpha3 (ls x13 x9 )) (ssep  (index alpha4 (ls x1 x5 )) (ssep  (index alpha5 (ls x1 x2 )) (ssep  (index alpha6 (ls x4 x11 )) (ssep  (index alpha7 (ls x4 x6 )) (ssep  (index alpha8 (ls x15 x3 )) (ssep  (index alpha9 (ls x7 x10 )) (ssep  (index alpha10 (ls x3 x2 )) (ssep  (index alpha11 (ls x3 x11 )) (ssep  (index alpha12 (ls x11 x5 )) (ssep  (index alpha13 (ls x11 x10 ))(ssep (pto x_emp (ref f y_emp)) (pto z_emp (ref f t_emp))))))))))))))))))
  )
)
(assert
  (not
    (and (distinct x1 x1 )    (tobool (ssep (pto x_emp (ref f y_emp)) (pto z_emp (ref f t_emp))))
)  ))

(check-sat)
