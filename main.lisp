(ql:quickload 'cffi)

(cffi:load-foreign-library "./libcint.so")
(cffi:defcfun ("add1" c-add1) :int32 (x :int32))
(c-add1 233)

(defun add1 (x)
  (declare (type (signed-byte 32) x))
  (+ x 1))

(defparameter *test-scale* 100000000)

(declaim (optimize (speed 3) (safety 0)))

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

(time (test-c))
(time (test))

(if (not (find-package 'swank))
    (sb-ext:exit))
