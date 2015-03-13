(setq load-path
	  (append
	   (list
		(expand-file-name "~/.mylisp")
		(expand-file-name "~/.mylisp/apel")
		(expand-file-name "~/.mylisp/navi2ch")
		)load-path))

;;; 日本語環境
;;; utf にするなら以下をコメント
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; キーバインド
;(global-set-key [f3]  'ibuffer)
;(global-set-key [f5]  'folding-mode)
;(global-set-key [f7]  'enlarge-window-horizontally)
;(global-set-key [f8]  'enlarge-window)
(global-set-key [delete] 'delete-backward-char)
(global-set-key [kp-delete] 'delete-backward-char)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-p" 'scroll-down)
(global-set-key "\M-n" 'scroll-up)
(global-set-key "\C-x\C-n" 'goto-line)
(global-set-key "\C-_" 'undo)
(global-set-key "\C-u" 'undo)
(global-set-key "\C-x\C-u" 'universal-argument)
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)  ;; ミニバッファで単語削除
(global-set-key "\C-x\C-r" 'point-to-register)
(global-set-key "\C-x\C-j" 'jump-to-register)
(global-unset-key "\C-z")

;;;; 基本情報
;; メニューバーを表示しない
(menu-bar-mode 0)
;; 時間を表示する
(display-time)
;; shift + 矢印で分割ウィンドウ間を移動
(windmove-default-keybindings)
;; バックアップはしない
(setq make-backup-files nil)
;; スタートアップメッセージを表示しない
(setq inhibit-startup-message t)
;; 行数表示
(column-number-mode t)
;; 圧縮ファイルの閲覧可能にする
(auto-compression-mode 1)
;; 文字の折り返し
(setq truncate-lines t)
(setq truncate-partial-width-windows t)
;; 補完時に大文字/小文字を区別しない
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
;; インデント設定
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(defun indent-and-next-line ()
  (interactive)
  (indent-according-to-mode)
  (next-line 1))
;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")
;; カラー設定
(require 'color-theme)
(color-theme-initialize)
(global-font-lock-mode t)
(color-theme-sp1rytus)
;;;;
(setq transient-mark-mode t)
;; folding mode
(autoload 'folding-mode "folding" nil t)
;; ibuffer mode
(require 'ibuffer)
;; smarty-mode
;(require 'smarty-mode)
;(add-to-list 'auto-mode-alist (cons "\\.tpl\\'" 'smarty-mode))
;(autoload 'smarty-mode "smarty-mode" "Smarty Mode" t)

;; php-mode
(require 'php-mode)
;(require 'yasnippet)
;(yas/load-directory "/usr/local/share/emacs23/site-lisp/snippets")
;(add-to-list 'yas/extra-mode-hooks
;             'php-mode-hook)
;(setq-default tab-width 4)
(setq auto-mode-alist
      (cons (cons "\\.\\(phtml\\|ctp\\|thtml\\|inc\\|php[s345]?\\)$" 'php-mode) auto-mode-alist))
      (autoload 'php-mode "php-mode" "PHP mode" t)
;(yas/initialize)

;; ruby-mode
(require 'ruby-mode)
(setq auto-mode-alist
      (cons (cons "\\.\\(erb\\|thor\\|rake\\|rb\\)$" 'ruby-mode) auto-mode-alist))
      (autoload 'ruby-mode "ruby-mode" "Ruby mode" t)

;; hook 用の関数の定義
(defun my-c-mode-common-hook ()
  ;; my-c-stye を有効にする
  (c-set-style "my-c-style")

  ;;   ;; 次のスタイルがデフォルトで用意されているので選択してもよい
  ;; (c-set-style "k&r")
  ;;   (c-set-style "gnu")
  ;;   (c-set-style "cc-mode")
  ;;   (c-set-style "stroustrup")
  ;;   (c-set-style "ellemtel")
  ;;   ;; 既存のスタイルを変更する場合は次のようにする
  ;;   (c-set-offset 'member-init-intro '++)

  ;; タブ長の設定
  (setq tab-width 4)

  ;; タブの代わりにスペースを使う
  ;;(setq indent-tabs-mode t)

  ;; 自動改行(auto-newline)を有効にする (C-c C-a)
  (c-toggle-auto-state t)

  ;; 連続する空白の一括削除(hungry-delete)を有効にする (C-c C-d)
  (c-toggle-hungry-state t)

  ;; セミコロンで自動改行しない
  (setq c-hanging-semi&comma-criteria nil)

  ;; カッコ前後の自動改行処理の設定
   (setq c-hanging-braces-alist
  	'(
  	  (class-open)          ; クラス宣言の'{'
  	  (class-close)         ; クラス宣言の'}'
  	  (defun-open)          ; 関数宣言の'{'
  	  (defun-close)         ; 関数宣言の'}'
  	  (inline-open)         ; クラス内のインライン関数宣言の'{'
  	  (inline-close)        ; クラス内のインライン関数宣言の'}'
  	  (brace-list-open)     ; 列挙型、配列宣言の'{'
  	  (brace-list-close)    ; 列挙型、配列宣言の'}'
  	  (block-open)          ; ステートメントの'{'
  	  (block-close)         ; ステートメントの'}'
  	  (substatement-open)   ; サブステートメント(if 文等)の'{'
  	  (statement-case-open) ; case 文の'{'
  	  (extern-lang-open)    ; 他言語へのリンケージ宣言の '{'
  	  (extern-lang-close)   ; 他言語へのリンケージ宣言の '}'
  	  (inexpr-class-open)
  	  (inexpr-class-close)))

  ;; キーバインドの追加
  ;; ------------------
  ;; C-m	改行＋インデント
  ;; C-c c	コンパイルコマンドの起動
  ;; C-h	空白の一括削除
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-base-map "\C-cc" 'compile)
  (define-key c-mode-base-map "\C-h" 'c-electric-backspace)

  ;;   ;; コンパイルコマンドの設定
  ;;   (setq compile-command "make -k" )   ; GNU make
  ;;   (setq compile-command "nmake /NOLOGO /S") ; VC++ の nmake

  ) ;; my-c-mode-common-hook

;; モードに入るときに呼び出す hook の設定
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook #'(lambda ()
                             (setq indent-tabs-mode t)
                             (c-toggle-hungry-state t)
                             ))

;;######################################
;; MarkDown-mode
;;######################################
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons (cons "\\.\\(text\\|markdown\\|md\\)$" 'markdown-mode) auto-mode-alist))

;;######################################
;; Redo
;;######################################
(require 'redo)
(global-set-key "\M-_" 'redo)

;;######################################
;; kill-summary
;;######################################
(autoload 'kill-summary "kill-summary" nil t)
(global-set-key "\M-y" 'kill-summary)

;;######################################
;; navi2ch
;;######################################
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)

;;######################################
;; Elscreen
;;######################################
(when (locate-library "elscreen")
  (setq elscreen-prefix-key "\C-z")
  (require 'elscreen))
(global-set-key "\M-}" 'elscreen-next)
(global-set-key "\M-{" 'elscreen-previous)
(define-key elscreen-map "\C-k" 'elscreen-kill-screen-and-buffers)

;;######################################
;; tabbar
;;######################################
; (setq tabber-prefix-key "\C-z")
; (require 'tabbar)
; (tabbar-mode 1)
; ;; グループ化しない
; (setq tabbar-buffer-groups-function nil)
; ;; 左に表示されるボタンを無効化
; (dolist (btn '(tabbar-buffer-home-button
;                tabbar-scroll-left-button
;                tabbar-scroll-right-button))
;   (set btn (cons (cons "" nil)
;                  (cons "" nil))))
; ;;; タブの長さ
; (setq tabbar-separator '(1.0))
; ;; 外観変更
; (set-face-attribute
;  'tabbar-default nil
;  :background "white")
; (set-face-attribute
;  'tabbar-unselected nil
;  :foreground "black"
;  :box nil)
; (set-face-attribute ;アクティブなタブ
;  'tabbar-selected nil
;  :background "blue"
;  :foreground "white"
;  :box nil)
; ;; タブに表示させるバッファの設定
; (defun my-tabbar-buffer-list ()
;   (delq nil
;         (mapcar #'(lambda (b)
;                     (cond
;                      ((eq (current-buffer) b) b)
;                      ((buffer-file-name b) b)
;                      ((char-equal ?\  (aref (buffer-name b) 0)) nil)
;                           ((equal "*scratch*" (buffer-name b)) b)
;                                ((char-equal ?* (aref (buffer-name b) 0)) nil)
;                      ((buffer-live-p b) b)))
;                 (buffer-list))))
; (setq tabbar-buffer-list-function 'my-tabbar-buffer-list)
; (global-set-key (kbd "C-z n") 'tabbar-forward-tab)
; (global-set-key (kbd "C-z p") 'tabbar-backward-tab)
; (global-set-key (kbd "C-z C-n") 'tabbar-forward-tab)
; (global-set-key (kbd "C-z C-p") 'tabbar-backward-tab)
; (global-set-key "\C-z\C-f" 'find-file)
; (global-set-key (kbd "C-z k") 'kill-buffer-and-window)
; (global-set-key (kbd "C-z C-k") 'kill-buffer-and-window)
