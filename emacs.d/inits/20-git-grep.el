(use-package git-grep
  :commands (git-grep git-grep-repo)
  :bind (;("C-x g g" . git-grep)
         ("C-x C-g" . git-grep-repo)))
