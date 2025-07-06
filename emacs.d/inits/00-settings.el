;;; 00-settings.el -*- lexical-binding: t; -*- --- Emacs基本設定

;;; Commentary:
;; Emacsの基本的な動作設定
;; エンコーディング、表示、編集、キーバインドなど

;;; Code:

;;--------------------------------------------------------------------
;; 基本設定
;;--------------------------------------------------------------------
(use-package emacs
  :straight nil  ; 組み込みパッケージ
  :custom
  ;; 起動・バックアップ設定
  (inhibit-startup-message t)              ; スタートアップメッセージを表示しない
  (make-backup-files nil)                  ; バックアップファイルを作成しない
  (create-lockfiles nil)                   ; ロックファイルを作成しない
  (auto-save-default nil)                  ; 自動保存しない

  ;; 表示設定
  (scroll-step 1)                          ; スクロール時の移動量を1に
  (column-number-mode t)                   ; カラム番号を表示
  (line-number-mode t)                     ; 行番号を表示
  (transient-mark-mode t)                  ; 選択領域をハイライト
  (show-paren-delay 0)                     ; 対応する括弧のハイライトに対するdelay
  (truncate-lines t)                       ; 通常のウィンドウで行を折り返さない
  (truncate-partial-width-windows t)       ; ウィンドウを左右に分割したときに行を折り返さない

  ;; 編集設定
  (read-file-name-completion-ignore-case t); ファイル名補完時に大文字小文字を区別しない
  (indent-tabs-mode nil)                   ; ハードタブではなくソフトタブ
  (tab-width 4)                            ; タブ幅を4に設定
  (comment-style 'multi-line)              ; コメントアウトの形式変更

  ;; その他の設定
  (vc-follow-symlinks t)                   ; シンボリックリンクを開くときの質問省略
  (ring-bell-function 'ignore)             ; ビープ音を無効化
  (use-short-answers t)                    ; yes/noの代わりにy/nを使用（Emacs 28以降）

  :init
  ;; エンコーディング設定
  (set-language-environment "Japanese")
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (setq-default buffer-file-coding-system 'utf-8)

  ;; GUIモードの設定
  (when (display-graphic-p)
    (tool-bar-mode -1)                     ; ツールバーを非表示
    (menu-bar-mode -1)                     ; メニューバーを非表示
    (scroll-bar-mode -1))                  ; スクロールバーを非表示

  ;; 行番号表示を無効化
  ;; (when (version<= "26.0.50" emacs-version)
  ;;   (global-display-line-numbers-mode 1)
  ;;   (setq display-line-numbers-type 'relative)  ; 相対行番号も選択可能
  ;;   (set-face-attribute 'line-number nil
  ;;                       :foreground "DarkOliveGreen"
  ;;                       :background "#131521")
  ;;   (set-face-attribute 'line-number-current-line nil
  ;;                       :foreground "gold"))

  :config
  ;; ウィンドウ移動の設定
  (windmove-default-keybindings)           ; shift + 矢印で分割ウィンドウ間を移動

  ;; その他の設定
  (auto-compression-mode 1)                ; 圧縮ファイルの閲覧可能にする
  (show-paren-mode t)                      ; 対応する括弧をハイライト
  (global-auto-revert-mode 1)              ; ファイルが変更されたら自動的に再読み込み

  ;; インデント時に次の行へ移動する関数
  (defun indent-and-next-line ()
    (interactive)
    (indent-according-to-mode)
    (forward-line 1))

  ;; キーバインド設定
  :bind
  (([delete] . delete-backward-char)
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
   ("C-<return>" . newline-and-indent)
   :map minibuffer-local-completion-map
   ("C-w" . backward-kill-word)))

;;--------------------------------------------------------------------
;; タブバーモードの設定
;;--------------------------------------------------------------------
(use-package tab-bar
  :straight nil  ; 組み込みパッケージ
  :init
  (global-unset-key "\C-z")  ; C-zを無効化してタブ操作に使用
  :bind
  (("C-z C-c" . tab-bar-new-tab)
   ("C-z c" . tab-bar-new-tab)
   ("C-z C-f" . find-file-other-tab)
   ("C-z f" . find-file-other-tab)
   ("C-z C-k" . tab-bar-close-tab)
   ("C-z k" . tab-bar-close-tab)
   ("C-z C-p" . tab-previous)
   ("C-z p" . tab-previous)
   ("C-z C-n" . tab-next)
   ("C-z n" . tab-next))
  :custom
  (tab-bar-show t)
  (tab-bar-close-button nil)
  (tab-bar-new-tab-choice "*scratch*")
  (tab-bar-tab-hints t)  ; タブに番号を表示
  :custom-face
  (tab-bar ((t (:background "Gray50"))))
  (tab-bar-tab ((t (:background "white" :foreground "black" :underline t))))
  (tab-bar-tab-inactive ((t (:background "Gray50")))))

;;; 00-settings.el ends here
