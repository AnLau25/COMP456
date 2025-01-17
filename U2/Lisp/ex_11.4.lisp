(defun my_member (x lst)
  (loop for elm in lst
        when (equal x elm) do (return (loop for rest in (member x lst) do (format t "~a " rest)))
        finally (return nil)))


(my_member 7 '(5 2 7 8 6))
