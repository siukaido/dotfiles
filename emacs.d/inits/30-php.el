;;; 30-php.el -*- lexical-binding: t; -*- --- PHP開発環境設定

;;; Commentary:
;; PHP開発環境の設定
;; PSR-2コーディング規約に準拠
;; php-modeとphp-ideの統合設定

;;; Code:
(defun my-php-mode-init ()
  (subword-mode 1)
  (setq-local show-trailing-whitespace t)
  (setq-local ac-disable-faces '(font-lock-comment-face font-lock-string-face))
  (add-hook 'hack-local-variables-hook 'php-ide-turn-on nil t))

(with-eval-after-load 'php-mode
  (add-hook 'php-mode-hook #'my-php-mode-init)
  (custom-set-variables
   '(php-mode-coding-style 'psr2)
   '(php-mode-template-compatibility nil)
   '(php-imenu-generic-expression 'php-imenu-generic-expression-simple))

  ;; If you find phpcs to be bothersome, you can disable it.
  (when (require 'flycheck nil)
    (add-to-list 'flycheck-disabled-checkers 'php-phpmd)
    (add-to-list 'flycheck-disabled-checkers 'php-phpcs)))

;;; 30-php.el ends here