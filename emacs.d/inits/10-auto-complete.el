(require 'auto-complete)
(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

(ac-config-default)
(setq ac-use-menu-map t)

(setq ac-auto-start 2)         ;; n文字以上の単語の時に補完を開始
(setq ac-delay 0.05)           ;; n秒後に補完開始
(setq ac-use-fuzzy t)          ;; 曖昧マッチ有効
(setq ac-use-comphist t)       ;; 補完推測機能有効
(setq ac-auto-show-menu 0.05)  ;; n秒後に補完メニューを表示
(setq ac-quick-help-delay 0.5) ;; n秒後にクイックヘルプを表示

(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))

;; メニュー表示崩れ対策
(setq popup-use-optimized-column-computation nil)

;; flyspell-mode対策
(ac-flyspell-workaround)

;; 日本語対策
(defadvice ac-word-candidates (after remove-word-contain-japanese activate)
  (let ((contain-japanese (lambda (s) (string-match (rx (category japanese)) s))))
    (setq ad-return-value
          (remove-if contain-japanese ad-return-value))))

;; 指定のモードで動くように
(add-to-list 'ac-modes 'json-mode)
(add-to-list 'ac-modes 'perl-mode)
(add-to-list 'ac-modes 'php-mode)
(add-to-list 'ac-modes 'scala-mode)
(add-to-list 'ac-modes 'scss-mode)
(add-to-list 'ac-modes 'typescript-mode)
(add-to-list 'ac-modes 'yaml-mode)
