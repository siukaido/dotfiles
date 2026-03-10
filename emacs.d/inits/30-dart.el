;;; 30-dart.el --- Dart言語サポート -*- lexical-binding: t; -*-

;;; Commentary:
;; Dart/Flutter開発環境の設定（遅延読み込み）

;;; Code:
(use-package dart-mode
  :defer t  ; 遅延読み込み
  :mode "\\.dart\\'"
  :custom
  (dart-enable-analysis-server t)
  (dart-format-on-save t))
;;; 30-dart.el ends here
