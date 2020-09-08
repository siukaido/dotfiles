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
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)
    :config
    (leaf-keywords-init)))

(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

;; common-lisp 系の関数設定
(require 'cl)

;;--------------------------------------------------------------------
;; settings
;;--------------------------------------------------------------------
(leaf settings
  :config
  ;;--------------------------------------------------------------------
  ;; locale
  ;;--------------------------------------------------------------------
  (leaf locale
    :setq-default ((buffer-file-coding-system quote utf-8))
    :config
    (set-language-environment "Japanese")
    (prefer-coding-system 'utf-8)
    (set-default-coding-systems 'utf-8)
    (set-terminal-coding-system 'utf-8)
    (set-keyboard-coding-system 'utf-8))
  ;;--------------------------------------------------------------------
  ;; basic-setting
  ;;--------------------------------------------------------------------
  (leaf basic-setting
    :custom ((inhibit-startup-message . t)        ;; スタートアップメッセージを表示しない
             (make-backup-files . nil)            ;; バックアップはしない
             (tool-bar-mode . nil)                ;; ツールバーを非表示
             (menu-bar-mode . nil)                ;; メニューバーを非表示
             (toggle-scroll-bar . nil)            ;; スクロールバーを非表示
             (scroll-step . 1)                    ;; スクロール時の移動量を1に
             (column-number-mode . t)             ;; 行数表示
             (line-number-mode . t)               ;; カーソルの位置が何行目かを表示する
             (transient-mark-mode . t)            ;; 選択領域をハイライト
             (show-paren-delay . 0)               ;; 対応する括弧のハイライトに対するdelay
           ; (completion-ignore-case . t t)       ;; 補完時に大文字/小文字を区別しない
             (read-file-name-completion-ignore-case . t)
             (indent-tabs-mode . nil)             ;; ハードタブではなくソフトタブ
             (default-tab-width . 4)              ;; インデント設定
             (comment-style . 'multi-line)        ;; コメントアウトの形式変更
             (truncate-lines . t)                 ;; 通常のウィンドウで行を折り返さない
             (truncate-partial-width-windows . t) ;; ウィンドウを左右に分割したときに行を折り返さない
             (vc-follow-symlinks . t)             ;; シンボリックリンクを開くときの質問省略
             (linum-delay . t)
             )
    :preface
    (defun indent-and-next-line ()
      (interactive)
      (indent-according-to-mode)
      (next-line 1))
    :config
    (windmove-default-keybindings) ;; shift + 矢印で分割ウィンドウ間を移動
    (auto-compression-mode 1)      ;; 圧縮ファイルの閲覧可能にする
    (show-paren-mode t)            ;; 対応する括弧をハイライト
    (global-auto-revert-mode 1)    ;; 編集時 buffer 再読み込み
    (fset 'yes-or-no-p 'y-or-n-p)  ;; Emacs の質問を y/n に
    ;; linum-mode をいじって Emacs を高速化
    (defadvice linum-schedule (around my-linum-schedule () activate)
      (run-with-idle-timer 0.2 nil #'linum-update-current))
    )
  ;;--------------------------------------------------------------------
  ;; keybind
  ;;--------------------------------------------------------------------
  (leaf keybind
    :config
    (leaf kill-keybind
      :config (global-unset-key "\C-z"))
    (leaf global
      :bind (([delete] . delete-backward-char)
             ([kp-delete] . delete-backward-char)
             ("C-h" . delete-backward-char)
             ("M-p" . scroll-down)
             ("M-n" . scroll-up)
             ("C-x C-n" . goto-line)
             ("C-_" . undo)
             ("C-u" . undo)
             ("C-x C-u" . universal-argument)
             ("C-x C-r" . point-to-register)
             ("C-x C-j" . jump-to-register)
             ))
    (leaf minibuffer
      :config
      ;; ミニバッファで単語削除
      (define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word))
    (leaf tab-bar-mode
      :bind (("C-z C-c" . tab-bar-new-tab)
             ("C-z c" . tab-bar-new-tab)
             ("C-z C-f" . find-file-other-tab)
             ("C-z f" . find-file-other-tab)
             ("C-z C-k" . tab-bar-close-tab)
             ("C-z k" . tab-bar-close-tab)
             ("C-z C-p" . tab-previous)
             ("C-z C-n" . tab-next)
             )
      :custom ((tab-bar-show . t)
               (tab-bar-close-button . nil)
               )
      :custom-face
      (tab-bar . '((t (:background "gray85"))))
      (tab-bar-tab . '((t (:background "black" :weight bold))))
      (tab-bar-tab-inactive . '((t (:foreground "gray40"))))
      )))

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
    ;go-mode
    ruby-mode
    ;; 40：フロントエンドmode
    jade-mode
    rainbow-mode
    rjsx-mode
    scss-mode
    typescript-mode
    web-mode
    tide
    ;; 50：その他mode
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
(init-loader-load "~/.emacs.d/inits")

;;--------------------------------------------------------------------
;; 以降は自動で追加されてしまう
;;--------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(comment-style 'multi-line)
 '(company-auto-expand t)
 '(company-dabbrev-downcase nil)
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 2)
 '(company-selection-wrap-around t)
 '(company-transformers '(company-sort-by-backend-importance))
 '(completion-ignore-case t t)
 '(default-tab-width 4 t)
 '(imenu-list-position 'left)
 '(imenu-list-size 30)
 '(indent-tabs-mode nil)
 '(inhibit-startup-message t)
 '(line-number-mode t)
 '(linum-delay t t)
 '(make-backup-files nil)
 '(markdown-command "mdown")
 '(menu-bar-mode nil)
 '(package-archives
   '(("org" . "https://orgmode.org/elpa/")
     ("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(go-mode json-mode terraform-mode yaml-mode ssh-config-mode markdown-mode tide web-mode typescript-mode scss-mode rjsx-mode rainbow-mode jade-mode apache-mode flycheck-pos-tip flycheck eglot company atom-dark-theme color-theme auto-highlight-symbol use-package exec-path-from-shell init-loader macrostep leaf-tree leaf-convert blackout el-get hydra leaf-keywords leaf))
 '(read-file-name-completion-ignore-case t)
 '(scroll-step 1)
 '(show-paren-delay 0)
 '(toggle-scroll-bar nil t)
 '(tool-bar-mode nil)
 '(transient-mark-mode t)
 '(truncate-lines t)
 '(truncate-partial-width-windows t)
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
