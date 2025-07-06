;;; copilot.el --- copilot for emacs -*- lexical-binding: t; -*-

;;; Commentary:
;; copilotの設定
;; SEE: https://qiita.com/nobuyuki86/items/f3a98428220b101878e0

;;; Code:
(use-package copilot
  :straight (:type git :host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :custom
  (copilot-node-executable "~/.anyenv/envs/nodenv/versions/22.13.1/bin/node")
  (copilot-max-char-warning-disabled t)
  :hook (prog-mode . copilot-mode)
  :config
  ;; TABキーでCopilotの補完を受け入れる関数
  (defun my-copilot-tab ()
    "Copilotの補完を優先的に受け入れ、なければcompanyの補完を行う"
    (interactive)
    (or (copilot-accept-completion)
        (company-indent-or-complete-common nil)))

  ;; prog-mode-mapでのみTABキーを設定
  (with-eval-after-load 'prog-mode
    (define-key prog-mode-map (kbd "TAB") #'my-copilot-tab)
    (define-key prog-mode-map (kbd "<tab>") #'my-copilot-tab))

  ;; company-modeとの統合
  (with-eval-after-load 'company
    ;; prog-modeでのみ有効になるようにフックで設定
    (add-hook 'prog-mode-hook
              (lambda ()
                (define-key company-active-map (kbd "TAB") #'my-copilot-tab)
                (define-key company-active-map (kbd "<tab>") #'my-copilot-tab)
                (define-key company-mode-map (kbd "TAB") #'my-copilot-tab)
                (define-key company-mode-map (kbd "<tab>") #'my-copilot-tab)))))

;;; 10-copilot.el ends here
