;;; 30-shell-model.el --- シェルスクリプト関連ファイルの設定 -*- lexical-binding: t; -*-

;;; Commentary:
;; bashrc、bash_profile、bash_aliasesなどの
;; 拡張子なしシェル設定ファイルをshell-script-modeで開く

;;; Code:
(add-to-list 'auto-mode-alist '("bashrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("bash_profile$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("bash_aliases$" . shell-script-mode))

;;; 30-shell-model.el ends here