;;; 30-jade.el --- Pug/Jadeテンプレートエンジンサポート -*- lexical-binding: t; -*-

;;; Commentary:
;; Pugテンプレートファイルの編集モード
;; .pug と .jade の両方に対応

;;; Code:
(use-package pug-mode
  :defer t  ; 遅延読み込み
  :mode ("\\.pug\\'" "\\.jade\\'"))

;;; 30-jade.el ends here
