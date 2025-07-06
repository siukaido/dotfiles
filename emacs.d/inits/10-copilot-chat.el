;;; copilot-chat.el -*- lexical-binding: t; -*- --- GitHub Copilot Chat設定

;;; Commentary:
;; GitHub Copilot Chatの設定
;; Copilotとのチャットインターフェースを提供

;;; Code:
(use-package copilot-chat
  :straight (:host github :repo "chep/copilot-chat.el" :files ("*.el"))
  :custom
  (copilot-chat-create-directories nil)
  (copilot-chat-frontend 'shell-maker)  ; shell風のインターフェースを有効にする
  :config
  ;; 依存関係の設定
  (with-eval-after-load 'markdown-mode
    (eval-after-load 'org
      '(eval-after-load 'request
         '(require 'copilot-chat nil nil))))

  ;; 日本語のプロンプトを設定
  (with-eval-after-load 'copilot-chat-prompts
    (setq my/copilot-chat-org-prompt-original copilot-chat-org-prompt)
    (setopt copilot-chat-org-prompt
            (concat my/copilot-chat-org-prompt-original "\n出力には日本語を用います"))

    (setq my/copilot-chat-markdown-prompt-original copilot-chat-markdown-prompt)
    (setopt copilot-chat-markdown-prompt
            (concat my/copilot-chat-markdown-prompt-original "\n出力には日本語を用います"))

    (setq my/copilot-chat-commit-prompt-original copilot-chat-commit-prompt)
    (setopt copilot-chat-commit-prompt
            (concat "description には英語 body には日本語を用いる。また1行は66文字以内に収めること。ただし日本語は1文字を2文字換算とする\n" 
                    my/copilot-chat-commit-prompt-original))))

;;; 10-copilot-chat.el ends here
