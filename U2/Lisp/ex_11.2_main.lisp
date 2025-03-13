(defun unit_step_funct (x)
    (cond ((x > 0) 1) (t 0)))


(defclass perceptron ()
  ((learning-rate
    :initarg :learning-rate
    :initform 0.01
    :documentation "Learning rate of the perceptron.")
   (n-iters
    :initarg :n-iters
    :initform 1000
    :documentation "Number of iterations for training.")
    (weights
    :initarg :weights
    :initform nil
    :documentation "Set path weights.")
    (bias
    :initarg :bias
    :initform nil
    :documentation "Set bias.")
    (activation-funct
    :initarg :activation-funct
    :initform #'unit_step_funct
    :documentation "Set the step function.")))

(defmethod fit ((p perceptron) x1 x2 y)
    form*)

(defmethod predict ((p perceptron) x1 x2)
    form*)