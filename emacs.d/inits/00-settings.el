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

;; create backup file in ~/.emacs.d/backup
(setq make-backup-files t)
(setq backup-directory-alist
  (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
    backup-directory-alist))

;; create auto-save file in ~/.emacs.d/backup
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backup/") t)))

;; コメントアウトの形式変更
(setq comment-style 'multi-line)

;; 改行コードを表示
(setq eol-mnemonic-dos  "(CRLF)")
(setq eol-mnemonic-mac  "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; ミニバッファ:単語単位での削除操作
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)

;; 通常のウィンドウで行を折り返さない
(setq truncate-lines t)

;; ウィンドウを左右に分割したときに行を折り返さない
(setq truncate-partial-width-windows t)

;; スクロール時の移動量を1に
(setq scroll-step 1)

;; モードラインに列番号表示
(column-number-mode t)

;; カーソルの位置が何文字目かを表示する
(column-number-mode t)

;; カーソルの位置が何行目かを表示する
(line-number-mode t)

;; 対応する括弧をハイライト
(setq show-paren-delay 0)
(show-paren-mode t)

;; 編集時 buffer 再読み込み
(global-auto-revert-mode 1)

;; Emacs の質問を y/n に
(fset 'yes-or-no-p 'y-or-n-p)

;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; シンボリックリンクを開くときの質問省略
(setq vc-follow-symlinks t)

;; linum-mode をいじって Emacs を高速化
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))
