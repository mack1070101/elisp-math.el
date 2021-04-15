;;; elisp-math.el --- An Elisp based DSL for simple math -*- lexical-binding: t; coding: utf-8 -*-

;; Author: Mackenzie Bligh <mackenziebligh@gmail.com>

;; Keywords: tools math
;; Homepage:
;; Version: 0.0.1

;; elisp-math requires at least GNU Emacs 25.1 and fotingo 1.9.2

;; elisp-math is free software; you can redistribute it and/or modify it
;; under the terms of the gnu general public license as published by
;; the free software foundation; either version 3, or (at your option)
;; any later version.
;;
;; elisp-math is distributed in the hope that it will be useful, but without
;; any warranty; without even the implied warranty of merchantability
;; or fitness for a particular purpose. See the gnu general public
;; license for more details.
;;
;; You should have received a copy of the gnu general public license
;; along with elisp-math.  if not, see http://www.gnu.org/licenses.

;;; Commentary:
;; Inspired by
;; https://github.com/divs1210/maya/blob/master/src/maya/core.clj

;;; Code:
(require 'dash)

;; https://www.emacswiki.org/emacs/ThreadMacroFromClojure
(defmacro -> (x form &rest more)
  "Rip off of Clojure's threading operation. See https://github.com/sroccaserra/emacs/blob/master/tools.el"
  (cond ((not (null more)) `(-> (-> ,x ,form) ,@more))
        (t (if (sequencep form)
               `(if (null ,x) nil
                  (,(first form) ,x ,@(rest form)))
             `(if (null ,x) nil
                ,(list form x))))))

(defmacro |-> (exp &rest f-x-pairs)
  "Threading but for simple math"
  (princ "\n")
  (princ exp)
  (princ "\n")
  (princ f-x-pairs)
  (princ "\n")
  (if (= 0 (% (length f-x-pairs) 2))
      ;; TODO need to apply order of operations here
      `(-> ,exp
           ,@(seq-partition f-x-pairs 2))
    (error "Needs an even number of args")))


(defmacro |> (&rest exprs)
  (message "Exprs: %s" exprs)
  (message "Type of %s" (type-of (car exprs)))
  (while exprs
    (progn
      (-let [(exp rest) (--split-with (not (eq :as it)) (car exprs))]
        (setq exprs (cdr exprs))
        (message "Exp %s" exp)
        (message "rest %s" rest)
        (-let [(ignored var-name next-exprs) rest]
          (message "Next exprs %s" next-exprs)
          (if (not next-exprs)
              (cons `|-> exp)
            `(let* ((,var-name (|-> ,@exp)))
               (|> ,@next-exprs))))))))


;; TODO it's because it's quoted
(|> '(4 + 0 :as four) '(2 + 3 :as five))

(--split-with (not (eq :as it)) (nth 0 '((4 + 0 :as four) '(2 + 3 :as five))))
(--split-with (not (eq :as it)) '(4 + 0 :as four))

(type-of '(4 + 0 :as four))

;;; elisp-math.el ends here
