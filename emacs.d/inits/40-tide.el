;;; 40-tide.el -*- lexical-binding: t; -*- --- TypeScript IDE機能設定

;;; Commentary:
;; TypeScript Interactive Development Environment (tide)の設定
;; TypeScript/JavaScript向けの高度なIDE機能を提供
;; 自動補完、型情報表示、リファクタリング機能など

;;; Code:
(use-package tide)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;;; 40-tide.el ends here