;;; 30-terraform.el -*- lexical-binding: t; -*- --- Terraform設定ファイル編集サポート

;;; Commentary:
;; Terraformインフラ定義ファイルの編集環境
;; 保存時の自動フォーマット機能付き

;;; Code:
(use-package terraform-mode
  :mode "\\.tf\\'"
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))

;;; 30-terraform.el ends here