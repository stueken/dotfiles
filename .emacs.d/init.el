;; workaround for bug in 26.1
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; load built-in package manager 'package.el'
(require 'package)
;; add repositories
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
;; initialize package.el
(package-initialize)
;; install 'use-package' (alternative to package.el) if its not installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;; initialize use-package
(eval-when-compile
  (require 'use-package))

;; load custom variables and faces
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; add "lisp" directory to load-path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; Large package-specific configurations
(require 'init-evil)
(require 'init-org)
; (require 'init-journal)
