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
(declare-fun x20 () Sll_t)
(declare-fun x21 () Sll_t)
(declare-fun x22 () Sll_t)
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
(declare-fun alpha19 () SetLoc)
(declare-fun alpha20 () SetLoc)
(declare-fun alpha21 () SetLoc)
(declare-fun alpha22 () SetLoc)
(assert
  (and 
    (= nil nil)
(distinct x6 x13 )
(distinct x6 x16 )
(distinct x11 x18 )
(distinct x11 x17 )
(distinct x3 x16 )
(distinct x3 x12 )
(distinct x3 x17 )
(distinct x7 x13 )
(distinct x7 x14 )
(distinct x7 x15 )
(distinct x9 x13 )
(distinct x9 x17 )
(distinct x2 x8 )
(distinct x2 x6 )
(distinct x2 x11 )
(distinct x2 x17 )
(distinct x12 x14 )
(distinct x8 x14 )
(distinct x1 x10 )
(distinct x1 x15 )
(distinct x4 x11 )
(distinct x4 x9 )
(distinct x4 x13 )
(distinct x13 x18 )
(distinct x10 x11 )
(distinct x10 x12 )
(distinct x5 x6 )
(distinct x5 x16 )
    (tobool  (ssep  (index alpha0 (ls x5 x14 )) (ssep  (index alpha1 (ls x13 x15 )) (ssep  (index alpha2 (ls x13 x12 )) (ssep  (index alpha3 (ls x13 x2 )) (ssep  (index alpha4 (ls x10 x11 )) (ssep  (index alpha5 (ls x18 x10 )) (ssep  (index alpha6 (ls x18 x11 )) (ssep  (index alpha7 (ls x1 x5 )) (ssep  (index alpha8 (ls x4 x15 )) (ssep  (index alpha9 (ls x4 x11 )) (ssep  (index alpha10 (ls x15 x16 )) (ssep  (index alpha11 (ls x17 x10 )) (ssep  (index alpha12 (ls x2 x16 )) (ssep  (index alpha13 (ls x2 x6 )) (ssep  (index alpha14 (ls x9 x15 )) (ssep  (index alpha15 (ls x7 x12 )) (ssep  (index alpha16 (ls x7 x13 )) (ssep  (index alpha17 (ls x11 x9 ))(ssep (pto x_emp (ref f y_emp)) (pto z_emp (ref f t_emp))))))))))))))))))))))
  )
)
(assert
  (not
    (and (distinct x1 x1 )    (tobool (ssep (pto x_emp (ref f y_emp)) (pto z_emp (ref f t_emp))))
)  ))

(check-sat)
