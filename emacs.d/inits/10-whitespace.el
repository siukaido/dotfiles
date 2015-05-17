;; 末尾に改行が必ずあるように
(setq require-final-newline t)

;; 行末の空白を表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "brightwhite")

;; インデントをスペースに(タブ幅4)
(defun my-c-mode-hook ()
  (c-set-style "linux")
  (setq c-basic-offset tab-width))
(add-hook 'c-mode-hook 'my-c-mode-hook)
(setq-default tab-width 4 indent-tabs-mode nil)

;; インデントして次の行に移動する
(defun indent-and-next-line ()
  (interactive)
  (indent-according-to-mode)
  (next-line 1))

;; タブと全角スペースに色を付けて目立たせる
(defface my-face-b-1 '((t (:background "brightwhite"))) nil)
(defface my-face-b-2 '((t (:background "brightblack"))) nil)
(defvar  my-face-b-1 'my-face-b-1)
(defvar  my-face-b-2 'my-face-b-2)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("　" 0 my-face-b-1 append)
     ("\t" 0 my-face-b-2 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
