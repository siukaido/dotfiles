;;; go-autocomplete.el --- auto-complete-mode backend for go-mode

;;; Commentary:
;; This package provides auto-complete-mode backend for go-mode.
;; copilot や go-eldoc と併用すると、補完候補が出なくなるので注意。

;;; Code:
;; (use-package go-autocomplete
;;   :ensure t
;;   :config
;;   (require 'auto-complete-config)
;;   (ac-config-default))
