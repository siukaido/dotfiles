;;; flycheck.el -*- lexical-binding: t; -*- --- シンタックスチェックの設定

;;; Commentary:
;; flycheckによるリアルタイムシンタックスチェックの設定
;; 各言語のLSPサーバーやリンターと連携します

;;; Code:
(use-package flycheck
  :init
  ;; グローバルにflycheckを有効化
  (global-flycheck-mode 1)
  :custom
  ;; チェックのタイミング設定
  (flycheck-check-syntax-automatically '(save mode-enabled))
  (flycheck-idle-change-delay 0.5)
  (flycheck-display-errors-delay 0.5)
  ;; エラー表示の改善
  (flycheck-indication-mode 'left-fringe)
  (flycheck-highlighting-mode 'symbols)
  :config
  ;; 特定のモードでの追加設定
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-mode 'typescript-tslint 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'vue-mode)

  ;; 不要なチェッカーを無効化
  (setq-default flycheck-disabled-checkers
                '(emacs-lisp-checkdoc  ; ドキュメントチェックは冗長
                  json-jsonlint        ; json-jqの方が高速
                  javascript-jshint))) ; ESLintを優先

;;--------------------------------------------------------------------
;; エラー内容をツールチップ表示
;;--------------------------------------------------------------------
(use-package flycheck-pos-tip
  :after flycheck
  :hook (flycheck-mode . flycheck-pos-tip-mode)
  :custom
  (flycheck-pos-tip-timeout 10))

;;--------------------------------------------------------------------
;; インラインエラー表示（Emacs 26以降）
;;--------------------------------------------------------------------
(use-package flycheck-inline
  :after flycheck
  :hook (flycheck-mode . flycheck-inline-mode)
  :custom
  (flycheck-inline-display-function
   (lambda (msg pos)
     (let ((ov (quick-peek-overlay-ensure-at pos)))
       (setf (overlay-get ov 'quick-peek--contents) msg)
       (quick-peek-update ov))))
  :config
  ;; 条件によってpos-tipかinlineを選択
  (when (version< emacs-version "26.0")
    (flycheck-inline-mode -1)))

;;; 20-flycheck.el ends here
