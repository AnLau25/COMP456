(defparameter vowels '(#\a #\e #\i #\o #\u))
(defparameter cnsnts '(#\b #\c #\d #\f #\g #\h #\j #\k #\l #\m #\n #\p #\q #\r #\s #\t #\v #\w #\x #\y #\z))

(defun split (word)
    (let ((i 0)
        (syllables '())
        (letters '()))
        (loop for j across word 
            for pos from 0 do
            (push j letters)
            (when (member j vowels :test #'char-equal)
                (incf i)
                (when (= i 2)
                    (setq i 0)
                    (push (coerce (reverse letters) 'string) syllables)
                    (setq letters nil)
                )
            )
            (when (and (member j cnsnts :test #'char-equal)
                         (< (1+ pos) (length word))
                         (member (char word (1+ pos)) cnsnts :test #'char-equal))
                (push (coerce (reverse letters) 'string) syllables)
                (setq letters nil)
                (setq i 0)
            )
        )
        (when letters
        (push (coerce (reverse letters) 'string) syllables))
        (format t "Syllables: ~a~%" (reverse syllables))    
    )
)

(split "bumper"); 
(split "analog"); 
