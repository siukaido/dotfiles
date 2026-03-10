;;; 20-php.el --- PHP開発環境設定 -*- lexical-binding: t; -*-

;;; Commentary:
;; PHP開発環境の設定
;; PSR-2コーディング規約に準拠

;;; Code:
(use-package php-mode
  :mode "\\.php\\'"
  :custom
  (php-mode-coding-style 'psr2)
  (php-mode-template-compatibility nil)
  (php-imenu-generic-expression 'php-imenu-generic-expression-simple)
  :config
  (add-hook 'php-mode-hook
            (lambda ()
              (subword-mode 1)
              (setq-local show-trailing-whitespace t))))

;;; 20-php.el ends here
