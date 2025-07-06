;;; 50-json.el -*- lexical-binding: t; -*- --- json mode

;;; Commentary:
;; JSONファイルの編集環境
;; .jsonおよび.jsonc（コメント付きJSON）ファイルをサポート

;;; Code:
(use-package json-mode)
(add-to-list 'auto-mode-alist '("\\.jsonc$" . jsonc-mode))
;;; 50-json.el ends here
