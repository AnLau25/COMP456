(defvar *seed* 1)  ; Initial seed value

(defun random-number (max)
  (let* ((a 1103515245)  ; Multiplier
         (c 12345)       ; Increment
         (m (expt 2 31)) ; Modulus
         (new-seed (mod (+ (* a *seed*) c) m)))
    (setf *seed* new-seed)
    (mod new-seed max)))

(defun set-seed (seed)
  (setf *seed* seed))

(set-seed 42)  
(format t "RandN: ~a~%" (random-number 10))
(format t "RandN: ~a~%" (random-number 10))
(format t "RandN: ~a~%" (random-number 10))