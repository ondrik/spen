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
(distinct nil x1 )
(distinct nil x2 )
(distinct nil x3 )
(distinct x1 x2 )
(distinct x2 x3 )
(distinct nil x5 )
(distinct nil x6 )
(distinct nil x7 )
(distinct x5 x6 )
(distinct x6 x7 )
(distinct nil x9 )
(distinct nil x10 )
(distinct nil x11 )
(distinct x9 x10 )
(distinct x10 x11 )
(distinct nil x13 )
(distinct nil x14 )
(distinct nil x15 )
(distinct x13 x14 )
(distinct x14 x15 )
    (tobool  (ssep  (index alpha0 (ls x15 x13 )) (ssep  (pto x13  (ref f x15 ) ) (ssep  (index alpha1 (ls x11 x9 )) (ssep  (pto x9  (ref f x11 ) ) (ssep  (index alpha2 (ls x7 x5 )) (ssep  (pto x5  (ref f x7 ) ) (ssep  (index alpha3 (ls x3 x1 )) (ssep  (pto x1  (ref f x3 ) )(ssep (pto x_emp (ref f y_emp)) (pto z_emp (ref f t_emp))))))))))))
  )
)
(assert
  (not
        (tobool  (ssep  (index alpha4 (ls x16 x13 )) (ssep  (pto x13  (ref f x16 ) ) (ssep  (index alpha5 (ls x12 x9 )) (ssep  (pto x9  (ref f x12 ) ) (ssep  (index alpha6 (ls x8 x5 )) (ssep  (pto x5  (ref f x8 ) ) (ssep  (index alpha7 (ls x4 x1 )) (ssep  (pto x1  (ref f x4 ) )(ssep (pto x_emp (ref f y_emp)) (pto z_emp (ref f t_emp))))))))))))
  ))

(check-sat)
