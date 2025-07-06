;;; whitespace.el -*- lexical-binding: t; -*- --- 空白文字の表示設定

;;; Commentary:
;; タブ、全角スペース、行末の空白などを可視化

;;; Code:
(use-package whitespace
  :straight nil  ; 組み込みパッケージ
  :hook (after-init . global-whitespace-mode)
  :custom
  ;; 末尾に改行が必ずあるように
  (require-final-newline t)

  ;; 表示する空白の種類
  (whitespace-style '(face           ; faceで可視化
                      trailing       ; 行末の空白
                      tabs           ; タブ
                      tab-mark))     ; タブの記号

  ;; 空白文字の表示マッピング
  (whitespace-display-mappings
   '((tab-mark   ?\t     [?\u00BB ?\t]) ; タブ → »
     ))

  ;; タブ幅とインデント設定（グローバル）
  (tab-width 4)
  (indent-tabs-mode nil)

  ;; 改行コードの表示
  (eol-mnemonic-dos "(CRLF)")
  (eol-mnemonic-mac "(CR)")
  (eol-mnemonic-unix "(LF)")

  :config
  ;; 全角スペースだけは別途ハイライト（font-lockを使用）
  (defface my-face-zenkaku-space
    '((t (:background "gray20")))
    "全角スペース用のフェイス")

  (defun my-highlight-zenkaku-space ()
    "全角スペースをハイライト"
    (font-lock-add-keywords nil
                            '(("　" 0 'my-face-zenkaku-space append))))

  (add-hook 'prog-mode-hook #'my-highlight-zenkaku-space)
  (add-hook 'text-mode-hook #'my-highlight-zenkaku-space)

  ;; 色の設定
  (set-face-attribute 'whitespace-trailing nil
                      :background "red"
                      :foreground "yellow"
                      :weight 'bold)
  (set-face-attribute 'whitespace-tab nil
                      :background "brightblack"
                      :foreground "gray40")

  ;; C言語モードの設定
  (defun my-c-mode-hook ()
    "C言語モード用の設定"
    (c-set-style "linux")
    (setq c-basic-offset tab-width))
  (add-hook 'c-mode-hook #'my-c-mode-hook)

  ;; インデントして次の行に移動する関数
  ;; (00-settings.elで定義済みなのでコメントアウト)
  ;; (defun indent-and-next-line ()
  ;;   (interactive)
  ;;   (indent-according-to-mode)
  ;;   (forward-line 1))
  )

;;; 10-whitespace.el ends here
