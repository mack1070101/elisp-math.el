;; elisp-math-tests.el -*- lexical-binding: t; -*-
;; Copyright (C) 2021 Mackenzie Bligb

;; Author: Mackenzie Bligh <mackenziebligh@gmail.com>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Tests for elisp-math

;;; Code:
(ert-deftest test-2-variable-equation-threading ()
  (should (= (|-> -1 + -2) -3))
  (should (= (|-> 1 + 2) 3))
  (should (= (|-> 2 - 1) 1))
  (should (= (|-> 1 - 2) -1))
  (should (= (|-> 3 * 2) 6))
  (should (= (|-> -3 * 2) -6))
  (should (= (|-> -3 * -2) 6))
  (should (= (|-> 6 / 2) 3))
  (should (= (|-> 6 / -2) -3))
  (should (= (|-> -6 / -2) 3))
  (should (= (|-> 6 / 4) 1.5)))

(ert-deftest test-n-variable-equation-threading ()
  ;; Doesn't test for order of operations
  (should (= (|-> 1 + 2 + 3 + 4) 10)))


;; elisp-math-tests.el ends here
