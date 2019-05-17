;; ~/.emacs.d/site-lisp 以下全部読み込み
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

;; パッケージのインストーラーの設定
(require 'package)
(add-to-list 'package-archives '("gnu". "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa". "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org". "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
;;;; パッケージ情報の更新
;(package-refresh-contents)

;; common-lisp 系の関数設定
(require 'cl)

;; 必要パッケージのリスト
(defvar installing-package-list
  '(
    ;; 00：基本設定
    init-loader
    exec-path-from-shell
    use-package
    ;; 10：見た目
    auto-highlight-symbol
    color-theme
    atom-dark-theme
    ;; 20：utinitly
    company
    eglot
    elscreen
    flycheck
    flycheck-pos-tip
    ;; 30：サーバサイドmode
    apache-mode
    go-mode
    php-mode
    ruby-mode
    slim-mode
    smarty-mode
    ;; 40：フロントエンドmode
    jade-mode
    rainbow-mode
    rjsx-mode
    scss-mode
    typescript-mode
    web-mode
    ;; 50：その他mode
    google-c-style
    markdown-mode
    ssh-config-mode
    yaml-mode
    ))
;; 自動インストール設定
(dolist (package installing-package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; 各々の設定ファイルのロード
(use-package init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(line-number-mode t)
 '(markdown-command "mdown")
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (yaml-mode ssh-config-mode markdown-mode google-c-style web-mode typescript-mode scss-mode rjsx-mode rainbow-mode jade-mode smarty-mode slim-mode php-mode go-mode eglot apache-mode flycheck-pos-tip flycheck elscreen company atom-dark-theme color-theme auto-highlight-symbol use-package exec-path-from-shell init-loader)))
 '(toggle-scroll-bar nil)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
