(use-package evil
  :init  ; execute code before package is loaded
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  ; (setq evil-want-C-i-jump nil) TODO I do use C-i!
  :config  ; execute code after package is loaded
  (evil-mode 1)  ; globally turn on evil-mode all the time
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

;; bindings for the parts of Emacs that Evil does not cover properly by default
;; https://github.com/emacs-evil/evil-collection
(use-package evil-collection
  :after evil  ; load package after evil
  :config
  (evil-collection-init))

;; TODO why in evil config?
;; Tie related commands into a family of short bindings with a common prefix
;; https://github.com/abo-abo/hydra
(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(nrbrt/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(provide 'init-evil)
