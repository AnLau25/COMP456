(defun rever (lst)
  (cond ((null lst) nil)
        ((atom lst) (list lst))
        (t (append (rever (cdr lst)) (list (car lst))))))

(defun iter-rever (lst)
  (let ((result nil))
    (dolist (element lst result)
      (setq result (cons element result)))))

 
 ;In Common Lisp, the list function creates a list from its arguments. 
 ;Each argument becomes an element of the list

(defun prnt (lst)
  (when lst
    (format t "~a " (car lst))
    (prnt (cdr lst))))

(defun full_rev (lst)
    (prnt (rever lst))
)

(full_rev '(1 2 3 4 5 6))
