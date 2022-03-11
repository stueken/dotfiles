;; ---------------
;; Org Roam Config -------------------------------------------------------------
;; ---------------

;; Keep Org-roam notes separate to GTD directory
(setq org-roam-directory (concat (getenv "HOME") "/nextcloud/org/notes/"))

(use-package org-roam
  :after org
  :init (setq org-roam-v2-ack t)  ; Acknowledge V2 upgrade
  :custom
  (org-roam-directory (file-truename org-roam-directory))
  :config
  (org-roam-setup)  ; initiate the database
  :bind (("C-c n f" . org-roam-node-find)    ; Open a new or existing note
         ("C-c n r" . org-roam-node-random)  ; Open a random note		    
         (:map org-mode-map
               (("C-c n i" . org-roam-node-insert)        ; Add link to existing node
                ("C-c n o" . org-id-get-create)           ; Promote heading to a node
                ("C-c n t" . org-roam-tag-add)            ; Add tags
                ("C-c n a" . org-roam-alias-add)          ; Add alias
                ("C-c n l" . org-roam-buffer-toggle)))))  ; Toggle show of backlinks

(setq org-roam-capture-templates '(("d" "default" plain "%?"
                                    :if-new
                                    (file+head "${slug}.org"
                                               "#+title: ${title}\n#+date: %u\n#+lastmod: \n\n")
                                    :immediate-finish t))  ; bypass capture system
      time-stamp-start "#\\+lastmod: [\t]*")  ; set variable to store last modified

;; Search inside written notes
(use-package deft
  :config
  ;; TODO Should this only search roam or also other org directories?
  (setq deft-directory org-roam-directory
        deft-recursive t  ; include subfolders
	;; Strip properties drawer for file summaries   
        deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n"
        deft-use-filename-as-title t)
  :bind
  ("C-c n d" . deft))

(provide 'init-roam)
