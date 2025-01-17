(defun my_member (x list)
  (loop for elm in list
        when (equal x elm) do (return (loop for rest in (member x list) do (format t "~a " rest)))
        finally (return nil)))


(my_member 7 '(5 2 7 8 6))
