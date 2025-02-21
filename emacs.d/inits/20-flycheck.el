;;--------------------------------------------------------------------
;; syntax checkするパッケージ
;;--------------------------------------------------------------------
(use-package flycheck
  :config
  ;; 利用するモード
  ;;;; 30
  (add-hook 'dart-mode-hook 'flycheck-mode)
  (add-hook 'go-mode-hook    'flycheck-mode)
  (add-hook 'perl-mode-hook  'flycheck-mode)
  (add-hook 'php-mode-hook   'flycheck-mode)
  (add-hook 'prog-mode-hook 'flycheck-mode)
  (add-hook 'solidity-mode-hook 'flycheck-mode)
  ;;;; 40
  (add-hook 'js2-mode-hook   'flycheck-mode)
  (add-hook 'rjsx-mode       'flycheck-mode)
  (add-hook 'scss-mode-hook  'flycheck-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-mode 'typescript-tslint 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'vue-mode)
  ;;;; 50
  (add-hook 'json-mode-hook  'flycheck-mode)
  (add-hook 'yaml-mode-hook  'flycheck-mode)
  )

;;--------------------------------------------------------------------
;; https://github.com/flycheck/flycheck-pos-tip
;; エラー内容をその場にツールチップで表示するためのパッケージ
;;--------------------------------------------------------------------
(use-package flycheck-pos-tip
  :config
  (with-eval-after-load 'flycheck
    (flycheck-pos-tip-mode)))
