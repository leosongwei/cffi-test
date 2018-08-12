(declaim (optimize (speed 3) (safety 0)))

(ql:quickload 'cffi)

(cffi:load-foreign-library "./libcint.so")
(cffi:defcfun ("add1" c-add1) :int32 (x :int32))
(c-add1 233)

(defun add1 (x)
  (declare (type (signed-byte 32) x))
  (+ x 1))
(declaim (inline add1-inline))
(defun add1-inline (x)
  (declare (type (signed-byte 32) x))
  (+ x 1))

(defparameter *test-scale* 100000000)

(defun test-c ()
  (let ((n (floor (/ (- *test-scale*) 2))))
    (dotimes (i *test-scale*)
      (setf n (c-add1 n)))
    n))
(defun test ()
  (let ((n (floor (/ (- *test-scale*) 2))))
    (dotimes (i *test-scale*)
      (setf n (add1 n)))
    n))
(defun test-inline ()
  (let ((n (floor (/ (- *test-scale*) 2))))
    (dotimes (i *test-scale*)
      (setf n (add1-inline n)))
    n))


(format t "cffi~%")
(time (test-c))

(format t "funcall~%")
(time (test))

(format t "inline~%")
(time (test-inline))

(format t "C program, so, -O2 -ldl:~%~A"
        (with-output-to-string (s)
          (sb-ext:run-program "./cso" nil :output s)))

(format t "~%")

(format t "C program, func, -O2:~%~A"
        (with-output-to-string (s)
          (sb-ext:run-program "./cfn" nil :output s)))

(if (not (find-package 'swank))
    (sb-ext:exit))
