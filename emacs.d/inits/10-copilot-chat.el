(leaf copilot-chat
  :config
  (straight-use-package
   '(copilot-chat :host github :repo "chep/copilot-chat.el" :files
                  ("*.el")))
  (with-eval-after-load 'markdown-mode
    (eval-after-load 'org
      '(eval-after-load 'request
         '(require 'copilot-chat nil nil)))))
