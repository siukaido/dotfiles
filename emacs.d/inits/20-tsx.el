;;; 20-tsx.el --- JavaScript/TypeScript開発環境設定 -*- lexical-binding: t; -*-

;;; Commentary:
;; tree-sitter ベースの JavaScript/TypeScript 統合開発環境
;; eglot (LSP) + corfu による構成
;; フォーマットは npm scripts で手動実行
;;
;; 手動対応:
;;   1. tree-sitter grammar のインストール（初回のみ）
;;      M-x treesit-install-language-grammar RET javascript
;;      M-x treesit-install-language-grammar RET typescript
;;      M-x treesit-install-language-grammar RET tsx
;;   2. npm パッケージのインストール（初回のみ）
;;      npm install -g typescript typescript-language-server eslint prettier
;;   3. 補完は corfu を使用（company-mode は削除済み）

;;; Code:

;;;; tree-sitter language sources
(setq treesit-language-source-alist
      '((javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx        "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")))

;;;; ファイル関連付け
(add-to-list 'auto-mode-alist '("\\.ts\\'"  . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'"  . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . tsx-ts-mode))

;;;; インデント設定
(setq typescript-ts-mode-indent-offset 2)
(setq tsx-ts-mode-indent-offset 2)

;;;; eglot (LSP)
;; 診断は eglot → flycheck-eglot 経由で flycheck に表示
(use-package eglot
  :hook ((typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode        . eglot-ensure)
         (js-ts-mode         . eglot-ensure))
  :custom
  (eglot-stay-out-of '(flymake))
  :config
  (add-to-list 'eglot-server-programs
               '((typescript-ts-mode tsx-ts-mode js-ts-mode)
                 "typescript-language-server" "--stdio"))
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (flymake-mode -1)
              (eglot-inlay-hints-mode -1))))

;;;; eglot の診断を flycheck に流す
(use-package flycheck-eglot
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))

;;;; 補完UI（ターミナル Emacs 対応）
(use-package corfu
  :demand t
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 1)
  (corfu-auto-delay 0.2)
  (corfu-cycle t)
  (corfu-preview-current nil)
  :config
  (global-corfu-mode))

;; ターミナルで corfu のポップアップを表示するためのパッケージ
(use-package corfu-terminal
  :straight (:type git :host codeberg :repo "akib/emacs-corfu-terminal")
  :unless (display-graphic-p)
  :demand t
  :after corfu
  :config
  (corfu-terminal-mode 1))

;;;; 保存時の自動フォーマットは無効（npm scripts で手動実行する）

;;; 20-tsx.el ends here
