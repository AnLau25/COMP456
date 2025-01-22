(defparameter stack nil)

(defun init ()
  (setf stack '())
  (format t "~a~%" stack))

(defun push_x (elm)
    (setf stack (cons elm stack));setf creates a new stack based on the cons, that joins the elms
    (format t "~a~%" elm))

(defun top_x ()
    (format t "~a~%" (car stack)))

(defun list_stack ()
    (format t "~a~%" stack))

(defun pop_x ()
    (format t "~a~%" (car stack))
    (setf stack (cdr stack)))

(init)
(push_x 'foo)
(push_x 'bar)
(top_x)
(list_stack)
(pop_x)
(top_x)
(list_stack)