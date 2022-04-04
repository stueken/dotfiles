;; Move to init.el

(add-hook 'text-mode-hook 'visual-line-mode)  ; line breaks at end of text area

(setq-default line-spacing 1)  ; Increase line spacing


;; **********************
;; Org Mode Configuration ------------------------------------------------------
;; **********************
;;  assuming presence of Evil Mode

; capture directly to inbox
(defun org-capture-inbox ()
     (interactive)
     (call-interactively 'org-store-link)
     (org-capture nil "i"))


(use-package org
  :bind  ; key bindings
  (("C-c a" . org-agenda)           ; view the agenda
   ("C-c c" . org-capture)          ; capture note
   ("C-c l" . org-store-link)       ; create link
   ("C-c i" . 'org-capture-inbox))  ; capture to inbox
  :config
  (setq org-directory "~/Documents/org/")
  (setq org-hide-emphasis-markers t         ; hide rich text/emphasis markers
	org-image-actual-width '(300)       ; restrict width of preview images
	org-pretty-entities t               ; display special characters like x² and x_1
	org-startup-indented t              ; indent text according to outline structure
	org-startup-with-inline-images t)   ; preview all images in the buffer

  (setq org-agenda-files '("inbox.org" "agenda.org"))

  (setq org-capture-templates
	;; Append to inbox file with inactive timestamp that does not cause an agenda entry
        `(("i" "Inbox" entry  (file "inbox.org")
          ,(concat "* TODO  %?\n"
                   "/Entered on/ %U"))))

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "|" "DONE(d)" "CANCELLED(c)"))))


;; **********
;; Appearance -------------------------------------------------------------------
;; **********

;; Show hidden emphasis markers
(use-package org-appear  ; https://github.com/awth13/org-appear
  :hook (org-mode . org-appear-mode))

;; Nice bullets
(use-package org-superstar  ; https://github.com/integral-dw/org-superstar-mode
  :config
  (add-hook 'org-mode-hook (lambda ()
			     (org-superstar-mode 1))))

;; Distraction-free screen
(use-package olivetti  ; https://github.com/rnkn/olivetti
  :init
  (setq olivetti-body-width .67)  ; only use 67% of frame width
  :config
  (defun distraction-free ()
    "Distraction-free writing environment"
    (interactive)
    (if (equal olivetti-mode nil)
         (progn
           (window-configuration-to-register 1)  ; store window config
           (delete-other-windows)                ; show only actual buffer
           (text-scale-increase 2)               ; increase text size
           (olivetti-mode t))                    ; activate olivetti mode
       (progn
         (jump-to-register 1)        ; restore window config
         (olivetti-mode 0)           ; switch of olivetti-mode
         (text-scale-decrease 2))))  ; decrease text size
   :bind
   (("<f9>" . distraction-free)))  ; activate with F9

(provide 'init-org)
