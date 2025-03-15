;;Supervicesd learning of binary clasifiers


(defun threshold_function, (x) ;;The binary clasifiers??
  (if (>= x 0.0) 1 -1))

(defun dot-product (a b);;Dot product function.
  (let ((a-list (coerce a 'list))
        (b-list (coerce b 'list)))
    (cond ((and (null a-list) (null b-list)) 0);; handles lists and vectors cause yeh
          ((or (null a-list) (null b-list)) (error "Vectors must be of equal length"))
          (t (+ (* (first a-list) (first b-list))
                (dot-product (rest a-list) (rest b-list)))))))

(defclass perceptron ();;Sets the perceptron class
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
    :initform #'threshold_function,
    :documentation "Set the step function.")))

(defmethod fit ((p perceptron) X y) ;;learning
  (let* ((n-samples (length X));;list of testing samples
         (n-features (length (car X)));; number of fatures, ie number of inputs
         (weights (make-array n-features :initial-element 0.0));;init weights at 0
         (bias 0);; init bias at 0
         (y_ (mapcar (lambda (yi) (if (> yi 0) 1 -1)) y)));; forces y to 1 or -1, in case of 

    (setf (slot-value p 'weights) weights);;weights as weights
    (setf (slot-value p 'bias) bias);;bias as bias

    (loop for _ from 1 to (slot-value p 'n-iters) do
      (loop for idx from 0 below n-samples
            for x_i in X
            for y_i in y_ do
        (let* ((linear-output (+ (dot-product x_i weights) bias))
               (y-predicted (funcall (slot-value p 'activation-funct) linear-output))
               (update (* (slot-value p 'learning-rate) (- y_i y-predicted))))
          (loop for j from 0 below n-features do
            (setf (aref weights j) (+ (aref weights j) (* update (nth j x_i)))))
          (setf bias (+ bias update)))))

    (setf (slot-value p 'weights) weights)
    (setf (slot-value p 'bias) bias)))

(defmethod predict ((p perceptron) X);;predicting 
  (let* ((weights (slot-value p 'weights))
         (bias (slot-value p 'bias))
         (linear-output (+ (dot-product X weights) bias))
         (y-predicted (funcall (slot-value p 'activation-funct) linear-output)))
    y-predicted))

(let* ((X '((1.0 1.0) (9.4 6.4) (2.5 2.1) (8.0 7.7) (0.5 2.2) 
            (7.9 8.4) (7.0 7.0) (2.8 0.8) (1.2 3.0) (7.8 6.1)))
       (y '(1 -1 1 -1 1 -1 -1 1 1 -1))
       (p (make-instance 'perceptron :learning-rate 0.1 :n-iters 10)))
  (fit p X y)
  (mapcar (lambda (x) (predict p (coerce x 'list))) X))  
;; Convierte x en lista antes de usar predict
;;Ask TA if this is it, test it with self velues ig?
;;Print predictions???


;;Inputs multiply by the weights to return activation function
;;Diference between output and activation???
;;You give examples to regulate he values the weights should have (it learns)
;;Bassed on the examples and the calculated weights, it should be hable to predict activation for future imputs?