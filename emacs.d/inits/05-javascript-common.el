;;; javascript-common.el -*- lexical-binding: t; -*- --- JavaScript/TypeScript共通設定

;;; Commentary:
;; JavaScript、TypeScript、JSON等の共通インデント設定
;; 各言語固有の設定ファイルより先に読み込まれる

;;; Code:
(use-package emacs
  :straight nil
  :custom
  ;; JavaScript/TypeScript共通のインデント設定
  (js-indent-level 2)              ; 標準のJavaScriptモード
  (js2-indent-level 2)             ; js2-mode
  (js2-basic-offset 2)             ; js2-modeの基本オフセット
  (typescript-indent-level 2)      ; TypeScriptモード
  (json-reformat:indent-width 2)   ; JSONフォーマット
  (web-mode-code-indent-offset 2)  ; web-modeのJavaScript部分
  (web-mode-css-indent-offset 2)   ; web-modeのCSS部分
  (web-mode-markup-indent-offset 2); web-modeのHTML部分

  ;; 構文チェック設定（js2-mode用）
  (js2-strict-missing-semi-warning nil)      ; セミコロン省略の警告を無効化
  (js2-missing-semi-one-line-override nil)   ; 1行のセミコロン省略を許可
  (js2-strict-trailing-comma-warning nil)    ; 末尾カンマの警告を無効化

  ;; その他の共通設定
  (js2-highlight-level 3)          ; 構文ハイライトレベル

  :config
  ;; グローバルなインデント設定の確認用関数
  (defun my/show-js-indent-settings ()
    "JavaScript関連のインデント設定を表示"
    (interactive)
    (message "js-indent-level: %s, js2-indent-level: %s, typescript-indent-level: %s"
             js-indent-level js2-indent-level typescript-indent-level)))
;;; 05-javascript-common.el ends here
