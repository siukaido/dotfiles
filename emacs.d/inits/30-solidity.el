;;; solidity.el -*- lexical-binding: t; -*- --- Solidityスマートコントラクト開発サポート

;;; Commentary:
;; Ethereum/Solidityスマートコントラクト開発環境（遅延読み込み）

;;; Code:
(use-package solidity-mode
  :defer t  ; 遅延読み込み
  :mode "\\.sol\\'")
;;; 30-solidity.el ends here
