(defun define_state (f w g c) (list f w g c))
(defun farmer (state)
    (nth 0 state))
(defun wolf (state)
    (nth 1 state))
(defun goat (state)
    (nth 2 state))
(defun choux (state);french word for cabbage
    (nth 3 state))

(defun opp (side)
    (cond ((equal side 'e) 'w) 
          ((equal side 'w) 'e)))

(defun is_safe (state)
    (cond ((and (equal (wolf state) (goat state))
           (not (equal (farmer state) (wolf state))))
           nil)
          ((and (equal (goat state) (choux state))
           (not (equal (farmer state) (goat state))))
           nil)
          (t state)))
        

(defun takes_self (state)
    (define_state (opp (farmer state))
                (wolf state)
                (goat state)
                (choux state)))

(defun takes_wolf (state)
    (cond ((equal (farmer state) (wolf state))
        (is_safe (define_state (opp (farmer state))
                               (opp (wolf state))
                               (goat state)
                               (choux state))))
        (t nil)))

(defun takes_goat (state)
    (cond ((equal (farmer state) (goat state))
        (is_safe (define_state (opp (farmer state))
                               (wolf state)
                               (opp (goat state))
                               (choux state))))
        (t nil)))

(defun takes_choux (state)
    (cond ((equal (farmer state) (choux state))
        (is_safe (define_state (opp (farmer state))
                               (wolf state)
                               (goat state)
                               (opp (choux state)))))
    (t nil)))





