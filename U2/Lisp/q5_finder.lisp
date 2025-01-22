(defun finding_x (x lst)
  (let ((i 1)
        (pos '()))
    (loop for elm in lst
          do (if (equal x elm)
                 (setq pos (append pos (list i))))
          (setq i (1+ i)))
    (prnt pos)))

(defun prnt (lst)
  (cond
    ((null lst) (format t "No position found~%"))
    (t
     (format t "Positions: ~a~%" lst))))

(finding_x 3 '(7 2 7 8 6 1 9 7 4))
(finding_x 7 '(7 2 7 8 6 1 9 7 4))
