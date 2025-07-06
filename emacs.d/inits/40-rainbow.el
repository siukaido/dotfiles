;;; rainbow.el -*- lexical-binding: t; -*- --- カラーコードの可視化

;;; Commentary:
;; CSSやSCSS、HTMLファイルでカラーコードを実際の色で表示

;;; Code:
(use-package rainbow-mode
  :hook ((css-mode scss-mode html-mode web-mode) . rainbow-mode)
  :config
  ;; 自動的に有効化するモードを追加
  (setq rainbow-html-colors t)
  (setq rainbow-x-colors t))
;;; 40-rainbow.el ends here
