;; backup in one place. flat, no tree structure
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;; auto-save in one place
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-save/" t)))

;; don't create lockfiles
(setq create-lockfiles nil)

;; fix emacs gnu mirror issue
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; package manager
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dockerfile-mode org-link-minor-mode auctex company-auctex git-gutter flycheck-irony flycheck iedit multiple-cursors google-c-style projectile company-c-headers company-irony use-package ac-c-headers clang-format format-all yaml-mode rust-mode markdown-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; -------- GENERAL CONFIGURATION --------

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

;; enable file history
(require 'recentf)
(recentf-mode 1)

(global-set-key "\C-xf" 'recentf-open-files)

;; moving lines up and down
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(control shift p)]  'move-line-up)
(global-set-key [(control shift n)]  'move-line-down)

;; duplicate current line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (forward-line 1)
  (yank)
)
(global-set-key (kbd "C-S-d") 'duplicate-line)

;; compile shortcut
(global-set-key (kbd "C-c m") 'recompile)

;; format all shortcut
;; Dependencies: format-all
(global-set-key (kbd "C-c f") 'format-all-buffer)

;; slower mouse wheel scrolling
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; ---------- WINDOW MANAGEMENT -----------

;; Move around in the windows by pressing shift + arrow
(windmove-default-keybindings)

(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.33)))

;; ---------- THIRD PARTY PLUGINS -----------
;; Dependencies: use-package

;; -------- Languages --------
;; ---- LaTeX ----
;; Dependencies: auctex

;; -------- Minibuffer --------
(use-package ido
  :config
  (setq ido-enable-flex-matching t)
  (ido-everywhere t)
  (ido-mode 1))

;; -------- Editing --------
;; ---- Multiple Cursors ----
;; Dependencies: multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; ---- Easy Renaming ----
;; Dependencies: iedit
(require 'iedit)


;; -------- Project Management --------
;; Dependencies: projectile
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))
(setq projectile-project-search-path '("~/projects/"))

;; ---- Shortcut Project grep ----
(global-set-key (kbd "C-S-f") 'projectile-grep)


;; ---- Git ----
;; Dependencies: git-gutter
(global-git-gutter-mode +1)


;; -------- Linting --------
;; Dependencies: flycheck
(global-flycheck-mode)

;; ---- C / C++ ----
;; Dependencies: flycheck-irony
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))


;; -------- Autocompletion --------
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0)

;; ---- C / C++ ----
;; Dependencies: company-irony, company-c-headers
;; System Dependencies: llvm
;; Installation: irony-install-server

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(defvar company-backends)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-c-headers))

;; ---- LaTeX ----
;; Dependencies: company-auctex
(require 'company-auctex)
(company-auctex-init)

;; ---- Docker ----
;; Dependencies: dockerfile-mode
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; -------- Code Style --------
;; ---- C / C++ ----
;; Dependencies: google-c-style
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
