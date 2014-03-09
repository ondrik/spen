(set-logic QF_NOLL)

(declare-sort Dll_t 0)

(declare-fun next () (Field Dll_t Dll_t))
(declare-fun prev () (Field Dll_t Dll_t))

; singly-linked list
(define-fun dll ((?in Dll_t) (?ex Dll_t) (?pr Dll_t) (?hd Dll_t))
  Space (tospace (or (and (= ?in ?pr) (= ?hd ?ex)) 
    (exists ((?u Dll_t)) (tobool (ssep
      (pto ?in (sref (ref next ?u) (ref prev ?pr)))
      (dll ?u ?ex ?in ?hd))
)))))

(declare-fun x_emp () Dll_t)
(declare-fun w_emp () Dll_t)
(declare-fun y_emp () Dll_t)
(declare-fun z_emp () Dll_t)
(declare-fun alpha1 () SetLoc)
(declare-fun alpha2 () SetLoc)
(assert
    (tobool (ssep (pto x_emp (sref (ref next w_emp) (ref prev nil))) 
                  (dll w_emp y_emp x_emp z_emp)
                  (pto y_emp (sref (ref next z_emp) (ref prev w_emp)))
            )
    )
)
(assert
  (not
    (tobool (index alpha1 (dll x_emp y_emp nil z_emp)))
))

(check-sat)
