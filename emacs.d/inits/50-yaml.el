;;; yaml.el -*- lexical-binding: t; -*- --- YAML設定

;;; Commentary:
;; YAMLファイルの編集環境設定

;;; Code:
(use-package yaml-mode
  :mode (("\\.ya?ml\\'" . yaml-mode)
         ("\\.ya?ml\\.liquid\\'" . yaml-mode))
  :bind (:map yaml-mode-map
              ("RET" . newline-and-indent)
              ("C-m" . newline-and-indent))
  :custom
  ;; YAMLのインデント幅
  (yaml-indent-offset 2))

;;; 50-yaml.el ends here
