(require 'elscreen)

(elscreen-start)
(setq elscreen-prefix-key "\C-z")
(define-key elscreen-map "\C-k" 'elscreen-kill-screen-and-buffers)
