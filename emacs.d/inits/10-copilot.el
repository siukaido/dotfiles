;;; cooilot.el --- copilot for emacs -*- lexical-binding: t; -*-

;;; Commentary:
;; copilotの設定
;; SEE: https://qiita.com/nobuyuki86/items/f3a98428220b101878e0

;;; Code:
(straight-use-package
 '(copilot :type git :host github :repo "zerolfx/copilot.el" :files ("dist" "*.el")))

;; 使用するnode.jsを指定
(setq copilot-node-executable "~/.anyenv/envs/nodenv/versions/22.13.1/bin/node")

;; プログラムモードの場合、copilot-modeを実行
(add-hook 'prog-mode-hook 'copilot-mode)

(defun my-tab ()
  (interactive)
  (or (copilot-accept-completion)
      (company-indent-or-complete-common nil)))

(global-set-key (kbd "TAB") #'my-tab)
(global-set-key (kbd "<tab>") #'my-tab)
(setq copilot-max-char-warning-disabled t)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "TAB") #'my-tab)
  (define-key company-active-map (kbd "<tab>") #'my-tab)
  (define-key company-mode-map (kbd "TAB") #'my-tab)
  (define-key company-mode-map (kbd "<tab>") #'my-tab))
