(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t
             '("org" . "https://orgmode.org/elpa/") t
             '("gnu" . "https://elpa.gnu.org/packages/") t
             )
(package-initialize)
