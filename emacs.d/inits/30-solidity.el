;;; 30-solidity.el --- Solidityスマートコントラクト開発サポート -*- lexical-binding: t; -*-

;;; Commentary:
;; Ethereum/Solidityスマートコントラクト開発環境（遅延読み込み）

;;; Code:
(use-package solidity-mode
  :defer t  ; 遅延読み込み
  :mode "\\.sol\\'")
;;; 30-solidity.el ends here
