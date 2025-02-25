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
  (if (or (and (equal (wolf state) (goat state))
               (not (equal (farmer state) (wolf state))))
          (and (equal (goat state) (choux state))
               (not (equal (farmer state) (goat state)))))
      nil
      state))

        

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

(defun path (state goal has_been has_found)
  (cond ((null state) has_found) 
        ((equal state goal) (cons (reverse (cons state has_been)) has_found)) 
        ((member state has_been :test #'equal) has_found)
        (t (append (path (takes_self state) goal (cons state has_been) has_found)
                   (path (takes_wolf state) goal (cons state has_been) has_found)
                   (path (takes_goat state) goal (cons state has_been) has_found)
                   (path (takes_choux state) goal (cons state has_been) has_found)))))


(defun print_found (found)
  (loop for path in found
        for i from 1
        do (format t "~A: ~A~%" i path)))

(defun fwgc (state goal)
    (let ((found (path state goal nil nil)))
    (print_found found)))

(fwgc (define_state 'e 'e 'e 'e) (define_state 'w 'w 'w 'w))

