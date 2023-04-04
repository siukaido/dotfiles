;;; init.el --- Emacs configuration

;;; Commentary:
;; Emacsの設定ファイル

;;; Code:

;;; straight.el自身のインストールと初期設定を行ってくれる
;; このコードを実行すると、~/.emacs.d/straight/ 以下にstraight.elがインストールされる
(setq straight-repository-branch "develop") ;; use the develop branch of straight.el

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-vc-git-default-clone-depth 1) ;; shallow clone

;; use-packageをインストールする
(straight-use-package 'use-package)

;; オプションなしで自動的にuse-packageをstraight.elにフォールバックする
;; 本来は (use-package hoge :straight t) のように書く必要がある
(setq straight-use-package-by-default t)

;; ~/.emacs.d/init/ 以下のファイルを全部読み込む
(use-package init-loader
  :config
  (init-loader-load "~/.emacs.d/inits"))

;;; init.el ends here
