;; this enables this running method
;;   emacs -q -l ~/.debug.emacs.d/{{pkg}}/init.el
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org"   . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu"   . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (package-refresh-contents)

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
      tide
      ;; 50：その他mode
      google-c-style
      markdown-mode
      ssh-config-mode
      yaml-mode
      terraform-mode
      json-mode
      ))
  ;; 自動インストール設定
  (dolist (package installing-package-list)
    (unless (package-installed-p package)
      (package-install package)))

  ;; 各々の設定ファイルのロード
  (use-package init-loader)
  (setq init-loader-show-log-after-init nil)
  (init-loader-load "~/.emacs.d/inits"))

;;--------------------------------------------------------------------
;; 以降は自動で追記される
;;--------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(company-auto-expand t)
 '(company-dabbrev-downcase nil)
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 2)
 '(company-selection-wrap-around t)
 '(company-transformers '(company-sort-by-backend-importance))
 '(completion-ignore-case t t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(line-number-mode t)
 '(markdown-command "mdown")
 '(menu-bar-mode nil)
 '(package-archives
   '(("org" . "https://orgmode.org/elpa/")
     ("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(json-mode terraform-mode yaml-mode ssh-config-mode markdown-mode google-c-style tide web-mode typescript-mode scss-mode rjsx-mode rainbow-mode jade-mode smarty-mode slim-mode php-mode go-mode apache-mode flycheck-pos-tip flycheck eglot company atom-dark-theme color-theme auto-highlight-symbol use-package exec-path-from-shell init-loader))
 '(read-file-name-completion-ignore-case t)
 '(toggle-scroll-bar nil)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
