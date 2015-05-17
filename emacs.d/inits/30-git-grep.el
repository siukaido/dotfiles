(defun git-grep ()
  (interactive)
  (let ((root (locate-dominating-file default-directory ".git")))
    (cond (root (let* ((ggrep (format "cd %s && git --no-pager grep -i -n --no-color" root))
                       (command
                        (read-from-minibuffer
                         "COMMAND: "
                         `(,(format "%s '%s'"  ggrep (or (current-word) "")) . ,(+ 3 (length ggrep))))))
                  (grep-find command)))
          (t (message "%s is not in a git working tree" default-directory)))))

(provide 'git-grep)
