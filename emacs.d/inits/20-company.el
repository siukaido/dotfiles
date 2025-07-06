;;; company.el -*- lexical-binding: t; -*- --- 補完システムの設定

;;; Commentary:
;; company-modeによる補完システムの設定
;; 各言語に対応した補完機能を提供

;;; Code:
(use-package company
  :hook (after-init . global-company-mode)
  :custom
  ;; 基本設定
  (company-auto-expand t)
  (company-transformers '(company-sort-by-backend-importance))
  (company-idle-delay 0.2)                  ; 0.2秒後に補完開始（0は重い）
  (company-minimum-prefix-length 2)         ; 2文字から補完開始
  (company-selection-wrap-around t)         ; 補完候補の循環
  (company-tooltip-align-annotations t)     ; アノテーションを揃える
  (company-show-quick-access t)             ; 番号でクイックアクセス

  ;; 大文字小文字の扱い
  (completion-ignore-case t)
  (company-dabbrev-downcase nil)

  ;; バックエンド別設定
  (company-go-insert-arguments nil)         ; Go言語で引数を自動挿入しない

  :bind
  (:map company-active-map
        ("M-n" . nil)
        ("M-p" . nil)
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ("C-h" . nil)
        ("C-m" . company-complete-selection)
        ("C-g" . company-abort))

  :config
  ;; バックエンドの設定
  (setq company-backends
        '((company-files          ; ファイル名
           company-keywords       ; 言語のキーワード
           company-capf          ; completion-at-point-functions
           company-yasnippet     ; スニペット
           company-abbrev        ; 略語
           company-dabbrev))))   ; 動的略語

;; 言語別の追加設定（必要に応じて）
(use-package company-go
  :after (company go-mode)
  :config
  (add-to-list 'company-backends 'company-go))

;;; 20-company.el ends here
