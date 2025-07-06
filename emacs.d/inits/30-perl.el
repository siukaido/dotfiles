;;; perl.el -*- lexical-binding: t; -*- --- Perl言語サポート

;;; Commentary:
;; Perl開発環境の設定（遅延読み込み）
;; cperl-modeを使用

;;; Code:
(use-package cperl-mode
  :defer t  ; 遅延読み込み
  :mode (("\\.pl\\'" . cperl-mode)
         ("\\.pm\\'" . cperl-mode)
         ("\\.t\\'" . cperl-mode)
         ("\\.psgi\\'" . cperl-mode))
  :custom
  (cperl-indent-level 4)
  (cperl-close-paren-offset -4)
  (cperl-continued-statement-offset 4)
  (cperl-indent-parens-as-block t)
  (cperl-tab-always-indent t)
  :config
  ;; perl-modeのエイリアスとして設定
  (defalias 'perl-mode 'cperl-mode))
;;; 30-perl.el ends here
