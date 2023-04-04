;;; go-autocomplete.el --- auto-complete-mode backend for go-mode

;;; Commentary:
;; This package provides auto-complete-mode backend for go-mode.

;;; Code:
(use-package go-autocomplete
  :ensure t
  :config
  (require 'auto-complete-config)
  (ac-config-default))
