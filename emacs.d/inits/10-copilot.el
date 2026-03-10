;;; 10-copilot.el --- GitHub Copilot設定 -*- lexical-binding: t; -*-

;;; Commentary:
;; copilotの設定
;;
;; 手動対応:
;;   1. M-x copilot-login でGitHubアカウントと連携

;;; Code:
(use-package copilot
  :straight (:type git :host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :custom
  (copilot-max-char-warning-disabled t)
  :hook (prog-mode . copilot-mode)
  :config
  ;; TABキーでCopilotの補完を優先し、なければインデントを行う関数
  (defun my-copilot-tab ()
    "Copilotの補完を優先的に受け入れ、なければインデントを行う"
    (interactive)
    (or (copilot-accept-completion)
        (indent-for-tab-command)))

  ;; prog-mode-mapでのみTABキーを設定
  (with-eval-after-load 'prog-mode
    (define-key prog-mode-map (kbd "TAB") #'my-copilot-tab)
    (define-key prog-mode-map (kbd "<tab>") #'my-copilot-tab)))

;;; 10-copilot.el ends here
