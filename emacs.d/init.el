;; ~/.emacs.d/site-lisp 以下全部読み込み
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

;; パッケージのインストーラーの設定
(require 'package)
(add-to-list 'package-archives '("melpa" .     "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; common-lisp 系の関数設定
(require 'cl)

;; 必要パッケージのリスト
(defvar installing-package-list
  '(
    init-loader
    ;; 10
    auto-complete
    auto-highlight-symbol
    color-theme
    foreign-regexp
    ;; 20
    apache-mode
    google-c-style
    jade-mode
    js2-mode
    json-mode
    markdown-mode
    php-mode
    popwin
    rainbow-mode
    scala-mode2
    scss-mode
    smarty-mode
    ssh-config-mode
    yaml-mode
    web-mode
    ;; 30
    flyspell
    flycheck
    flycheck-pos-tip
    google-translate
    ;; 40
    ensime
    sbt-mode
    ;; others
    magit
    web-beautify
    ))

;; 自動インストール設定
(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))

;; 各々の設定ファイルのロード
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")
