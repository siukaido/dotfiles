;;
;; 各種基本設定を記述する
;;

(use-package leaf)
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
    ;; 行番号を表示させる
    (progn
      (global-display-line-numbers-mode)
      (set-face-attribute 'line-number nil
                          :foreground "DarkOliveGreen"
                          :background "#131521")
      (set-face-attribute 'line-number-current-line nil
                                                    :foreground "gold")
      )
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
             ("C-<return>" . newline-and-indent)
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
             ("C-z p" . tab-previous)
             ("C-z C-n" . tab-next)
             ("C-z n" . tab-next)
             )
      :custom ((tab-bar-show . t)
               (tab-bar-close-button . nil)
               )
      :custom-face
      (tab-bar . '((t (:background "Gray50"))))
      (tab-bar-tab . '((t (:background "white" :foreground "black" :underline t))))
      (tab-bar-tab-inactive . '((t (:background "Gray50"))))
      )))
