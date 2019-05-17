;;;; 基本情報

(custom-set-variables
 '(display-time-mode t)       ;; 時間を表示
 '(tool-bar-mode nil)         ;; ツールバーを非表示
 '(menu-bar-mode nil)         ;; メニューバーを非表示
 '(toggle-scroll-bar nil)     ;; スクロールバーを非表示
 '(transient-mark-mode t)     ;; 選択領域をハイライト
 '(column-number-mode t)      ;; 行数表示
 '(line-number-mode t);; カーソルの位置が何行目かを表示する
 '(inhibit-startup-message t) ;; スタートアップメッセージを表示しない
 )

;; shift + 矢印で分割ウィンドウ間を移動
(windmove-default-keybindings)
;; バックアップはしない
(setq make-backup-files nil)
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

;; ミニバッファ:単語単位での削除操作
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)

;; 通常のウィンドウで行を折り返さない
(setq truncate-lines t)

;; ウィンドウを左右に分割したときに行を折り返さない
(setq truncate-partial-width-windows t)

;; スクロール時の移動量を1に
(setq scroll-step 1)

;; 対応する括弧をハイライト
(setq show-paren-delay 0)
(show-paren-mode t)

;; 編集時 buffer 再読み込み
(global-auto-revert-mode 1)

;; Emacs の質問を y/n に
(fset 'yes-or-no-p 'y-or-n-p)

;; シンボリックリンクを開くときの質問省略
(setq vc-follow-symlinks t)

;; linum-mode をいじって Emacs を高速化
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;; シェルに設定されている環境変数を引き継ぐ
(exec-path-from-shell-initialize)
