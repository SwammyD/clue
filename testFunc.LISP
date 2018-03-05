;;(load "C:\\Users\Anne\Documents\EECS\EECS 371\\testFunc.LISP")

(defun test-ask (fact)
  (fire::ask-it fact
                :context 'EverythingPSC :response :bindings))