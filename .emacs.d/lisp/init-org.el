;;; init-org.el --- Set up Org Mode

;; Basic Org Mode configuration, assuming presence of Evil Mode.

(use-package org
    :ensure t
    :defer t  ;; lazy loading
    :commands (org-capure)  ;; autoload commands
    :bind (("C-c a" .   org-agenda)  ;; key bindings
           ("C-c c" .   org-capture)
           ("C-c j" .   org-journal-new-entry)
           ("C-c l" .   org-store-link))
    :config

    (setq org-todo-keywords
        '((sequence "TODO(t)" "IN-PROGRESS(p)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)")))

    (defvar org-journal--date-location-scheduled-time nil)

    (setq org-capture-templates
          '(
            ("j" "Journal Entry" entry
             (file+olp+datetree "jowo_journal.org")
             "* %?\n%U"
             :empty-lines 1)
            ("t" "Todo [inbox]" entry
             (file+headline "gtd/inbox.org" "Tasks")
             "* TODO %i%?")
            ("T" "Tickler" entry
             (file+headline "gtd/tickler.org" "Tickler")
             "* %i%? \n %U")))

    (setq org-directory "~/Nextcloud/org")

    ;; Agenda configuration
    (setq org-agenda-files (list (expand-file-name "gtd/inbox.org" org-directory)
                                 (expand-file-name "gtd/gtd.org" org-directory)
                                 (expand-file-name "gtd/tickler.org" org-directory)
                                 (expand-file-name "jowo_journal.org" org-directory)))
    (setq org-refile-targets `((,(expand-file-name "gtd/gtd.org" org-directory) :maxlevel . 3)
                               (,(expand-file-name "gtd/someday.org" org-directory) :level . 1)
                               (,(expand-file-name "gtd/tickler.org" org-directory) :maxlevel . 2)))
    (setq org-refile-use-outline-path 'file)
    (setq org-refile-allow-creating-parent-nodes 'confirm)

    (setq org-agenda-custom-commands
          '(("w" "At work" tags-todo "@work"
             ((org-agenda-overriding-header "JoWo")
              (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first))))))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))

(defun org-current-is-todo ()
  (member (org-get-todo-state) '("TODO" "IN-PROGRESS")))

; Enable languages for evaluation
(org-babel-do-load-languages
  'org-babel-load-languages
  '((shell . t)))

(provide 'init-org)
