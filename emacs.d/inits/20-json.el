;;; 20-json.el --- JSON編集環境 -*- lexical-binding: t; -*-

;;; Commentary:
;; JSONファイルの編集環境
;; .json および .jsonc（コメント付きJSON）ファイルをサポート

;;; Code:
(use-package json-mode
  :mode (("\\.json\\'" . json-mode)
         ("\\.jsonc\\'" . jsonc-mode)))

;;; 20-json.el ends here
