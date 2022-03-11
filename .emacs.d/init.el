;; Load custom variables and faces
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; *****************************
;; Package Manager Configuration -----------------------------------------------
;; *****************************

;; Load built-in package manager 'package.el'
(require 'package)
;; Define and initialize package repositories
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)  ; initialize package.el
 
;; Install use-package if not installed
(unless (package-installed-p 'use-package)
  (package-refresh-contentes)
  (package-install 'use-package))
;; initialize use-package
(require 'use-package)
;; Set a variable to ensure that any missing packages are automatically installed
(setq use-package-always-ensure t)


;; **********************
;; Basic UI Configuration ------------------------------------------------------
;; **********************

(setq inhibit-startup-message t ; Don't show the splash screen
      visible-bell t)           ; Enable the visible bell (no sound)

(menu-bar-mode -1)   ; Disable the menu bar, but reachable with F10
(scroll-bar-mode -1) ; Disable visible scrollbar
(tool-bar-mode -1)   ; Disable the toolbar
(tooltip-mode -1)    ; Disable tooltips

(global-hl-line-mode -1)             ; Highlight current line toggle
(blink-cursor-mode 1)                ; cursor blinking toggle
(column-number-mode)                 ; Display column numbers
(global-display-line-numbers-mode 1) ; Display line numbers in every buffer

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Set all yes / no confirmations to a one-letter abbreviation
(defalias 'yes-or-no-p 'y-or-n-p)

;; Theme megapack
;; find more at https://github.com/doomemacs/themes or https://emacsthemes.com/
(use-package doom-themes
  :init (load-theme 'deeper-blue t))

;; NOTE: The first time you load your configuration on a new machine, you'll
;; need to run the following command interactively so that mode line icons
;; display correctly:
;;
;; M-x all-the-icons-install-fonts

;; Library for inserting developer icons
(use-package all-the-icons)

;; Fancy, fast and minimalistic mode-line
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; Highlights delimters according to their depth
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


;; ******************************
;; Input Completion Configuration ----------------------------------------------
;; ******************************

;; Interactive interface for completion
;; TODO Match and map Helm config
;; https://lucidmanager.org/productivity/emacs-completion-system/#outline-container-headline-2
;; with mapping table here: https://sam217pa.github.io/2016/09/13/from-helm-to-ivy/
;; TODO Go through custom keybindings
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; Collection of Ivy-enhanced versions of common Emacs commands
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

;; Enhances ivy and counsel with additional information.
(use-package ivy-rich
  :after counsel
  :init
  (ivy-rich-mode 1))

;; Displays available key bindings following a currently incomplete command
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; Alternative to the built-in Emacs help
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


;; ******************
;; Font Configuration -----------------------------------------------------------
;; ******************

;; Set default, fixed and variabel pitch fonts
;; Use M-x menu-set-font to view available fonts
(use-package mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode)
  :config
  (set-face-attribute 'default nil :font "Fira Code" :height 130)
  (set-face-attribute 'fixed-pitch nil :font "Fira Code")  ; or DejaVu Sans Mono
  (set-face-attribute 'variable-pitch nil :font "Cantarell"))  ; DejaVu Sans

;; *************************
;; Key Binding Configuration ---------------------------------------------------
;; *************************

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package general
  :config
  (general-create-definer nrbrt/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (nrbrt/leader-keys
  "t"  '(:ignore t :which-key "toggles")
  "tt" '(counsel-load-theme :which-key "choose theme")))

;; Projectile Configuration ----------------------------------------------------

;; (use-package projectile
;;   :diminish projectile-mode
;;   :config (projectile-mode)
;;   :custom ((projectile-completion-system 'ivy))
;;   :bind-keymap
;;   ("C-c p" . projectile-command-map)
;;   :init
;;   ;; NOTE: Set this to the folder where you keep your Git repos!
;;   (when (file-directory-p "~/Projects/Code")
;;     (setq projectile-project-search-path '("~/Projects/Code")))
;;   (setq projectile-switch-project-action #'projectile-dired))

;; (use-package counsel-projectile
;;   :config (counsel-projectile-mode))

;; Magit Configuration ---------------------------------------------------------

;; (use-package magit
;;   :custom
;;   (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; (use-package evil-magit
;;   :after magit)

;; ;; NOTE: Make sure to configure a GitHub token before using this package!
;; ;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; ;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
;; (use-package forge)

;; (defun efs/org-mode-setup ()
;;   (org-indent-mode)
;;   (variable-pitch-mode 1)
;;   (visual-line-mode 1))

;; ***********************************
;; Load additional configuration files -----------------------------------------
;; ***********************************

;; add "lisp" directory to load-path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; Large package-specific configurations
(require 'init-evil)
(require 'init-org)
(require 'init-roam)
; (require 'init-journal)
