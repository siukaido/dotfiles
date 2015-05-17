(if (file-executable-p "/usr/bin/aspell")
    (setq-default ispell-program-name "aspell")
    (setq-default ispell-program-name "ispell"))

(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
