;; ---------------
;; Org Roam Config -------------------------------------------------------------
;; ---------------

;; Keep Org-roam notes separate to GTD directory
;; (setq org-roam-directory (concat (getenv "HOME") "/nextcloud/org/notes/"))
(setq org-roam-directory (concat org-directory "notes/"))

(use-package org-roam
  :after org
  :init (setq org-roam-v2-ack t)  ; Acknowledge V2 upgrade
  :custom
  (org-roam-directory (file-truename org-roam-directory))
  :config
  (org-roam-setup)  ; initiate the database
  (org-roam-db-autosync-mode)  ; ensure Org-roam is available on startup

  ;; Creating the property "type" on my nodes (must be after org-roam-setup)
  (cl-defmethod org-roam-node-type ((node org-roam-node))
    "Return the TYPE of NODE."
    (condition-case nil
      (file-name-nondirectory
       (directory-file-name
        (file-name-directory
	 (file-relative-name (org-roam-node-file node) org-roam-directory))))
      (error "")))

  :bind (("C-c n f" . org-roam-node-find)    ; Open a new or existing note
         ("C-c n r" . org-roam-node-random)  ; Open a random note		    
         (:map org-mode-map
               (("C-c n i" . org-roam-node-insert)        ; Add link to existing node
                ("C-c n o" . org-id-get-create)           ; Promote heading to a node
                ("C-c n t" . org-roam-tag-add)            ; Add tags
                ("C-c n a" . org-roam-alias-add)          ; Add alias
                ("C-c n l" . org-roam-buffer-toggle)))))  ; Toggle show of backlinks

(setq org-roam-capture-templates
      '(("m" "main" plain "%?"
         :if-new (file+head "main/${slug}.org"
			    "#+title: ${title}\n")
         :immediate-finish t  ; bypass capture system
	 :unnarrowed t)
        ("j" "jowo" plain "%?"
         :if-new (file+head "jowo/${slug}.org"
			    "#+title: ${title}\n")
         :immediate-finish t
	 :unnarrowed t)
	("r" "reference" plain "%?"
	 :if-new (file+head "reference/${title}.org"
			    "#+title: ${title}\n")
	 :immediate-finish t
	 :unnarrowed t)
	("a" "article" plain "%?"
	 :if-new (file+head "articles/${title}.org"
		  "#+title: ${title}\n#filetags: :article:\n")
	 :immediate-finish t
	 :unnarrowed t)))

;; Modifying the display template to show the node "type"
(setq org-roam-node-display-template
      (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

;; --------
;; Packages --------------------------------------------------------------------
;; --------

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
