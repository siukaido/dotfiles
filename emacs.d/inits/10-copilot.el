(straight-use-package
 '(copilot :type git :host github :repo "zerolfx/copilot.el" :files ("dist" "*.el")))

;; 使用するnode.jsを指定
(setq copilot-node-executable "~/.anyenv/envs/nodenv/versions/17.9.1/bin/node")

;; プログラムモードの場合、copilot-modeを実行
(add-hook 'prog-mode-hook 'copilot-mode)

;; copilot用にキーバインドを設定
(defun my-tab ()
  (interactive)
  (or (copilot-accept-completion)
      (company-indent-or-complete-common nil)))

(global-set-key (kbd "TAB") #'my-tab)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "TAB") #'my-tab)
  (define-key company-mode-map (kbd "TAB") #'my-tab))
