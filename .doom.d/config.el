;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Norbert Stüken"
      user-mail-address "norbert.stueken@nrbrt.com")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'wombat)

(setq deft-directory "~/Documents"
      deft-extensions '("org", "txt")
      deft-recursive t)

(setq projectile-project-search-path '("~/Nextcloud/coding/"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")

(after! org (setq org-insert-heading-respect-content nil))

(defun org-export-output-file-name-modified (orig-fun extension &optional subtreep pub-dir)
  (unless pub-dir
    (setq pub-dir (concat (file-name-as-directory org-directory) "export"))
    (unless (file-directory-p pub-dir)
      (make-directory pub-dir)))
  (apply orig-fun extension subtreep pub-dir nil))
(advice-add 'org-export-output-file-name :around #'org-export-output-file-name-modified)

(add-hook! org-mode :append
           #'visual-line-mode)
           ;; #'variable-pitch-mode)

(after! org (setq org-hide-emphasis-markers t))

(after! org
  (use-package! org-appear
    :hook (org-mode . org-appear-mode)))

(setq ob-mermaid-cli-path "/usr/local/bin/mmdc")

(setq org-roam-directory (concat org-directory "notes/"))

(org-roam-db-autosync-mode)

(setq org-capture-templates nil)

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
  ("p" "personal" plain "%?"
   :if-new (file+head "personal/${slug}.org"
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

(cl-defmethod org-roam-node-type ((node org-roam-node))
  "Return the TYPE of NODE."
  (condition-case nil
    (file-name-nondirectory
     (directory-file-name
      (file-name-directory
       (file-relative-name (org-roam-node-file node) org-roam-directory))))
    (error "")))

(setq org-roam-node-display-template
      (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

(defun nrbrt/org-roam-toggle-personal-subdirectory ()
  (interactive)
  (if (listp org-roam-file-exclude-regexp)
      (if (member "personal" org-roam-file-exclude-regexp)
          (setq org-roam-file-exclude-regexp (delete "personal" org-roam-file-exclude-regexp))
        (add-to-list 'org-roam-file-exclude-regexp "personal"))
    (setq org-roam-file-exclude-regexp
          (if (string-match-p "personal" org-roam-file-exclude-regexp)
              (replace-regexp-in-string "\\|personal" "" org-roam-file-exclude-regexp)
            (concat org-roam-file-exclude-regexp "\\|personal"))))
  (org-roam-db-sync))

(defun rename-org-files ()
  "Rename .org files in `org-roam-directory` according to the '${slug}.org' template."
  (interactive)
  (let ((dir org-roam-directory))
    (dolist (file (directory-files-recursively dir "\\.org$"))
      (let* ((old-file (file-truename file))
             (slug (generate-slug-from-file-title file))
             (new-file (expand-file-name (format "%s.org" slug) (file-name-directory old-file))))
        (unless (string= old-file new-file)
          (rename-file old-file new-file t)
          (update-links-in-file new-file slug))))))

(defun generate-slug-from-file-title (file)
  "Generate a slug from the 'title' property in the FILE."
  (with-temp-buffer
    (insert-file-contents file)
    (let ((case-fold-search t))
      (if (re-search-forward "^#\\+title: \\(.+\\)$" nil t)
          (let ((title (match-string 1)))
            (replace-regexp-in-string "[^[:alnum:]]+" "-" (downcase title)))
        "untitled"))))

(defun update-links ()
  "Update links in all .org files in `org-roam-directory`."
  (interactive)
  (let ((dir org-roam-directory))
    (dolist (file (directory-files-recursively dir "\\.org$"))
      (let* ((slug (generate-slug-from-file-title file)))
        (update-links-in-file file slug)))))

(defun update-links-in-file (file slug)
  "Update links in FILE to the new SLUG."
  (find-file file)
  (goto-char (point-min))
  (while (re-search-forward (format "\\[\\[.*?%s\\]\\[.*?\\]\\]" slug) nil t)
    (replace-match (format "[[%s][%s]]" slug (match-string 0))))
  (save-buffer)
  (kill-buffer))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(setq org-cite-csl-styles-dir "~/Zotero/styles")

(setq! citar-bibliography (list (concat org-directory "ref/references.bib"))
       citar-library-paths (list (concat org-directory "ref/library_files/"))
       citar-notes-paths (concat org-directory "ref/notes/"))

(after! org
  (setq org-todo-keywords
        '((sequence
           "TODO(t)"
           "NEXT(n)"
           "STRT(s)"
           "WAIT(w)"
           "|"
           "DONE(d)"
           "KILL(k)"))))

(defvar nrbrt/org-gtd-directory
  (expand-file-name "gtd/" org-directory)
  "Base directory for GTD files.")

(defvar nrbrt/org-gtd-personal-directory
  (expand-file-name "personal/" nrbrt/org-gtd-directory)
  "Directory for personal GTD files.")

(defvar nrbrt/org-gtd-jowo-directory
  (expand-file-name "jowo/" nrbrt/org-gtd-directory)
  "Directory for Jowo GTD files.")

(defvar nrbrt/org-gtd-personal-inbox-file
  (expand-file-name "inbox.org" nrbrt/org-gtd-personal-directory)
  "Personal GTD inbox file.")

(defvar nrbrt/org-gtd-personal-tasks-file
  (expand-file-name "tasks.org" nrbrt/org-gtd-personal-directory)
  "Personal GTD tasks file.")

(defvar nrbrt/org-gtd-personal-projects-file
  (expand-file-name "projects.org" nrbrt/org-gtd-personal-directory)
  "Personal GTD projects file.")

(defvar nrbrt/org-gtd-personal-someday-file
  (expand-file-name "someday.org" nrbrt/org-gtd-personal-directory)
  "Personal GTD someday file.")

(defvar nrbrt/org-gtd-jowo-inbox-file
  (expand-file-name "inbox.org" nrbrt/org-gtd-jowo-directory)
  "Jowo GTD inbox file.")

(defvar nrbrt/org-gtd-jowo-tasks-file
  (expand-file-name "tasks.org" nrbrt/org-gtd-jowo-directory)
  "Jowo GTD tasks file.")

(defvar nrbrt/org-gtd-jowo-projects-file
  (expand-file-name "projects.org" nrbrt/org-gtd-jowo-directory)
  "Jowo GTD projects file.")

(defvar nrbrt/org-gtd-jowo-someday-file
  (expand-file-name "someday.org" nrbrt/org-gtd-jowo-directory)
  "Jowo GTD someday file.")

(after! org
  (setq org-log-done 'time
        org-log-into-drawer t))

(defun nrbrt/org-set-created-property ()
  "Set a CREATED property on the current Org heading if it does not exist."
  (when (org-at-heading-p)
    (unless (org-entry-get nil "CREATED")
      (org-set-property "CREATED"
                        (format-time-string
                         (org-time-stamp-format t t))))))

(defun nrbrt/org-capture-set-created-property ()
  "Set CREATED property on a newly captured Org entry."
  (when (derived-mode-p 'org-mode)
    (save-excursion
      (org-back-to-heading t)
      (nrbrt/org-set-created-property))))

(add-hook 'org-capture-after-finalize-hook
          #'nrbrt/org-capture-set-created-property)

(defun nrbrt/set-org-agenda-files-personal ()
  "Use personal GTD files for `org-agenda-files`."
  (interactive)
  (setq org-agenda-files
        (directory-files-recursively
         nrbrt/org-gtd-personal-directory "\\.org$"))
  (message "Using personal agenda files"))

(defun nrbrt/set-org-agenda-files-jowo ()
  "Use Jowo GTD files for `org-agenda-files`."
  (interactive)
  (setq org-agenda-files
        (directory-files-recursively
         nrbrt/org-gtd-jowo-directory "\\.org$"))
  (message "Using Jowo agenda files"))

(after! org
  (nrbrt/set-org-agenda-files-personal))

(after! org
  (setq org-refile-targets
        `((,nrbrt/org-gtd-personal-tasks-file :maxlevel . 3)
          (,nrbrt/org-gtd-personal-projects-file :maxlevel . 3)
          (,nrbrt/org-gtd-personal-someday-file :maxlevel . 3)

          (,nrbrt/org-gtd-jowo-tasks-file :maxlevel . 3)
          (,nrbrt/org-gtd-jowo-projects-file :maxlevel . 3)
          (,nrbrt/org-gtd-jowo-someday-file :maxlevel . 3)))

  (setq org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes 'confirm
        org-refile-use-cache nil))

(after! org
  (setq org-default-notes-file nrbrt/org-gtd-personal-inbox-file)

  (setq org-capture-templates
        `(("p" "Personal inbox"
           entry
           (file ,nrbrt/org-gtd-personal-inbox-file)
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n%i"
           :empty-lines 1)

          ("P" "Personal inbox with context"
           entry
           (file ,nrbrt/org-gtd-personal-inbox-file)
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n%i\n%a"
           :empty-lines 1)

          ("j" "Jowo inbox"
           entry
           (file ,nrbrt/org-gtd-jowo-inbox-file)
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n%i"
           :empty-lines 1)

          ("J" "Jowo inbox with context"
           entry
           (file ,nrbrt/org-gtd-jowo-inbox-file)
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n%i\n%a"
           :empty-lines 1))))

(after! org
  (setq org-agenda-custom-commands
        '(("n" "Next tasks"
           todo "NEXT")

          ("s" "Started tasks"
           todo "STRT")

          ("w" "Waiting tasks"
           todo "WAIT")

          ("d" "Dashboard"
           ((agenda "")
            (todo "STRT")
            (todo "NEXT")
            (todo "WAIT"))))))

(map! :leader
      (:prefix ("o" . "open")
       (:prefix ("a" . "agenda")
        :desc "Use personal agenda files" "p"
        #'nrbrt/set-org-agenda-files-personal
        :desc "Use Jowo agenda files" "j"
        #'nrbrt/set-org-agenda-files-jowo
        :desc "Open agenda" "a"
        #'org-agenda)))

(map! :after org
      :map org-mode-map
      :localleader
      "N" #'org-add-note)

(after! org-clock
  (setq org-clock-persist t)
  (org-clock-persistence-insinuate))

(use-package! ox-jira
  :after org)

;; Ensure ox-rst is loaded when org-mode starts.
(after! org
  (require 'ox-rst))

(setq org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-file-format "%Y-%m-%d.org")

(defun switch-to-personal-journal ()
  (interactive)
  ; file-name-as-directory ensures that org-directory ends with a slash
  (setq org-journal-dir (concat (file-name-as-directory org-directory) "journals/personal/")))

(defun switch-to-jowo-journal ()
  (interactive)
  (setq org-journal-dir (concat (file-name-as-directory org-directory) "journals/jowo/")))

(map! :leader
     (:prefix ("n" . "notes")
      (:prefix ("j" . "journal")
       :desc "New personal journal entry" "j" (lambda () (interactive) (switch-to-personal-journal) (org-journal-new-entry nil))
       :desc "New work (jowo) journal entry" "w" (lambda () (interactive) (switch-to-jowo-journal) (org-journal-new-entry nil)))))
