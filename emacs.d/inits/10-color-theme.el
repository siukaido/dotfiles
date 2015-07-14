;; カラー設定
(require 'color-theme)
(defun color-theme-default ()
  (interactive)
  (color-theme-install
   '(color-theme-default
     ((foreground-color . "white")
      (background-color . "black")
      (background-mode . dark)
      (border-color . "black")
      (cursor-color . "yellow")
      (foreground-color . "white")
     )
     (default ((t (nil))))
     (bold ((t (:bold))))
     (region ((t (:background "blue"))))
     (underline ((t (:underline t))))
     (italic ((t (:italic t))))
     (bold-italic ((t (:italic t :bold t))))
     (modeline ((t (:background "white" :foreground "black"))))
     (modeline-buffer-id ((t (:background "white" :foreground "black"))))
     (modeline-mousable ((t (:background "white" :foreground "black"))))
     (modeline-mousable-minor-mode ((t (:background "white" :foreground "black"))))
     (minibuffer-prompt ((t (:foreground "brightblue"))))

     (font-lock-builtin-face ((t (:foreground "LightSteelBlue"))))
     (font-lock-constant-face ((t (:foreground "Aquamarine"))))
     (font-lock-doc-string-face ((t (:foreground "LightSalmon"))))
     (font-lock-function-name-face ((t (:foreground "LightSkyBlue"))))
     (font-lock-keyword-face ((t (:foreground "Cyan"))))
     (font-lock-preprocessor-face ((t (:foreground "Aquamarine"))))
     (font-lock-reference-face ((t (:foreground "LightSteelBlue"))))
     (font-lock-string-face ((t (:foreground "LightSalmon"))))
     (font-lock-type-face ((t (:foreground "PaleGreen"))))
     (font-lock-variable-name-face ((t (:foreground "LightGoldenrod"))))
     (font-lock-warning-face ((t (:bold t :foreground "Pink"))))
     (font-lock-comment-face ((t (:foreground "OrangeRed")))))))

(color-theme-initialize)
(global-font-lock-mode t)
(color-theme-default)