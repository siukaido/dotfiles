;;; 50-ssh-config.el -*- lexical-binding: t; -*- --- SSH設定ファイル編集サポート

;;; Commentary:
;; SSH/SSHDの設定ファイル編集モード
;; ~/.ssh/configやsshd_configファイルのシンタックスハイライト機能

;;; Code:
(use-package ssh-config-mode
  :defer t  ; 遅延読み込み
  :mode ((".ssh/config\\'" . ssh-config-mode)
         ("sshd?_config\\'" . ssh-config-mode)
         ("sshd?-config" . ssh-config-mode))
  :hook (ssh-config-mode . turn-on-font-lock))

;;; 50-ssh-config.el ends here