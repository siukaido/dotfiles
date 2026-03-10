;;; 10-git-grep.el --- Gitリポジトリ内検索機能 -*- lexical-binding: t; -*-

;;; Commentary:
;; git-grepを使用したリポジトリ内高速検索
;; C-x g g でリポジトリ全体を検索

;;; Code:
(use-package git-grep
  :commands (git-grep git-grep-repo)
  :bind (;("C-x g g" . git-grep)
         ("C-x g g" . git-grep-repo)))

;;; 10-git-grep.el ends here