;;; 20-tsx.el --- JavaScript/TypeScript開発環境設定 -*- lexical-binding: t; -*-

;;; Commentary:
;; tree-sitter ベースの JavaScript/TypeScript 統合開発環境
;; eglot (LSP) + prettier + corfu による構成
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
(use-package eglot
  :hook ((typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode        . eglot-ensure)
         (js-ts-mode         . eglot-ensure))
  :custom
  ;; flycheck を使用するため flymake は無効化
  (eglot-stay-out-of '(flymake))
  :config
  ;; eglot-stay-out-of だけでは flymake が残る場合があるため明示的に無効化
  (add-hook 'eglot-managed-mode-hook (lambda () (flymake-mode -1)))
  (add-to-list 'eglot-server-programs
               '((typescript-ts-mode tsx-ts-mode js-ts-mode)
                 "typescript-language-server" "--stdio")))

;;;; 補完UI
(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-preview-current nil))

;;;; prettier による自動フォーマット
(use-package prettier-js
  :hook ((typescript-ts-mode . prettier-js-mode)
         (tsx-ts-mode        . prettier-js-mode)
         (js-ts-mode         . prettier-js-mode)))

;;; 20-tsx.el ends here
