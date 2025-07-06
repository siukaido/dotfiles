;;; apache.el -*- lexical-binding: t; -*- --- Apache設定ファイル編集サポート

;;; Commentary:
;; Apache設定ファイルの編集モード（遅延読み込み）

;;; Code:
(use-package apache-mode
  :defer t  ; 遅延読み込み
  :mode (("\\.htaccess\\'" . apache-mode)
         ("httpd\\.conf\\'" . apache-mode)
         ("srm\\.conf\\'" . apache-mode)
         ("access\\.conf\\'" . apache-mode)
         ("sites-\\(available\\|enabled\\)/" . apache-mode)))
;;; 30-apache.el ends here
