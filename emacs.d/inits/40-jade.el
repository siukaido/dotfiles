;;; 40-jade.el -*- lexical-binding: t; -*- --- Jadeテンプレートエンジンサポート

;;; Commentary:
;; Jade（現Pug）テンプレートファイルの編集モード
;; .jadeファイルの編集環境を提供

;;; Code:
(use-package jade-mode
  :defer t  ; 遅延読み込み
  :mode "\\.jade\\'")

;;; 40-jade.el ends here