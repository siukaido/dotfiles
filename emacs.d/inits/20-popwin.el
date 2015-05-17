(require 'popwin)

(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-position 'bottom)
(setq popwin:close-popup-window-timer-interval 0.5)

;; キーマップの変更
(global-set-key (kbd "C-x p") popwin:keymap)

;; ポップアップ表示設定
(push '("*Occur*") popwin:special-display-config)
(push '(dired-mode :position top) popwin:special-display-config)
