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
    auto-complete
    company
    elscreen
    flycheck
    flycheck-pos-tip
    ;; 30：サーバサイドmode
    apache-mode
    eglot
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
