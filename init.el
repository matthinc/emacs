(require 'package)

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (eval-when-compile (require 'use-package)))

;; ########## ivy / counsel / swiper ##########
(package-install 'counsel)
(package-install 'ivy)
(package-install 'swiper)
(package-install 'ivy-rich)
(package-install 'all-the-icons-ivy-rich)

(all-the-icons-ivy-rich-mode 1)
(counsel-mode)
(ivy-rich-mode 1)

(setq all-the-icons-ivy-rich-icon t)
(setq all-the-icons-ivy-rich-color-icon t)

(setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)

(global-set-key (kbd "C-s") 'swiper)
(global-set-key "\C-x\ b" 'counsel-switch-buffer)

;; ########## smartparens ##########
(package-install 'smartparens)
(add-hook 'prog-mode-hook #'smartparens-mode)
(require 'smartparens-config)

;; ########## company ##########
(package-install 'company)
(add-hook 'after-init-hook 'global-company-mode)

(global-set-key "\C-c\ \C-a" 'company-complete)


;; ########## ag ##########
(use-package ag :ensure t)

;; ########## expand-region ##########
(package-install 'expand-region)
(global-set-key (kbd "C-h") 'er/expand-region)

;; ########## sml ##########
(use-package smart-mode-line :ensure t)
(setq sml/no-confirm-load-theme t)
(smart-mode-line-enable t)

;; ########## auctex ##########
(package-install 'auctex)

;; ########## magit ##########
(use-package magit :ensure t)
(global-set-key (kbd "C-x g") 'magit-status)

;; ########## org-bullets ##########
(use-package org-bullets :ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; ########## which key ##########
(use-package which-key :ensure t)
(which-key-mode)

;; ########## yas ##########
(use-package yasnippet :ensure t)
(yas-global-mode 1)
(global-set-key "\C-c\ a\ i" 'yas-insert-snippet)

;; ########## flycheck ##########
(package-install 'flycheck)
(global-flycheck-mode)

;; ########## rainbow-delimiters ##########
(package-install 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; ########## hl-todo ##########
(package-install 'hl-todo)
(add-hook 'prog-mode-hook #'hl-todo-mode)

;; ########## centaur-tabs ##########
(package-install 'centaur-tabs)
(setq centaur-tabs-height 48)
(centaur-tabs-mode t)
(centaur-tabs-headline-match)
(global-set-key (kbd "C-<left>") 'centaur-tabs-backward)
(global-set-key (kbd "C-<right>") 'centaur-tabs-forward)

(defun centaur-tabs-buffer-groups () (list "GROUP"))

;; ########## buffers config ##########
(setq-default message-log-max nil)
(setq inhibit-startup-screen t)

;; ########## lorem-impsum ##########
(package-install 'lorem-ipsum)

;; ########## avy ##########
(package-install 'avy)
(global-set-key "\C-l" 'avy-goto-char)

;; ########## aggressive-indent ##########
(package-install 'aggressive-indent)
(global-aggressive-indent-mode 1)

;; ########## popup-killring ##########
(package-install 'popup-kill-ring)
(global-set-key "\M-y" 'popup-kill-ring)

;; ########## highlight-indentation ##########
(package-install 'highlight-indentation)
(add-hook 'prog-mode-hook #'highlight-indentation-mode)

;; ########## language support ##########
(package-install 'haskell-mode)
(package-install 'go-mode)
(package-install 'markdown-mode)
(package-install 'gitignore-mode)
(package-install 'web-mode)
(package-install 'cc-mode)

;; ########## UI Config ##########
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(when window-system
  (set-frame-size (selected-frame) 200 50))

;; ########## Terminal ##########
(defun mterm ()
  "Create new 'ansi-term' if not exists, else switche to this buffer."
  (interactive)
  (select-window (split-window-below))
  (if (eq nil (get-buffer "*ansi-term*"))
      (ansi-term "/bin/bash")
    (switch-to-buffer "*ansi-term*")))
  
(global-set-key "\C-t" 'mterm)

;; ########## Testfile ##########
(defun testfile ()
  "Create empty buffer in /tmp."
  (interactive)
  (find-file "/tmp/emacs_testfile.txt")
  (save-buffer))

;; ########## line numbers ##########
(global-display-line-numbers-mode)

;; ########## (un)comment shortcuts ##########
(global-set-key "\C-c\ \C-c" 'comment-line)

;; ########## recent files ##########
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; ########## tabs numbers ##########
(setq-default indent-tabs-mode nil tab-width 3)

;; ########## don't ask before quit ##########
(setq confirm-kill-emacs nil)
(setq confirm-kill-processes nil)

;; ########## yes or no ##########
(fset 'yes-or-no-p 'y-or-n-p)

;; ########## kill current buffer ##########
(global-set-key "\C-x\ \C-k" 'kill-current-buffer)

;; ########## cursor ##########
(setq-default cursor-type 'bar)

;; ########## disable autosave ##########
(setq auto-save-default nil)

;; ########## colors ##########
(set-face-attribute 'region nil :background "#b5d5ff")
(set-face-background 'mode-line "#003")
(set-face-foreground 'mode-line "#fff")

;; ########## variables ##########

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(company-quickhelp-color-background "#e8e8e8")
 '(company-quickhelp-color-foreground "#444444")
 '(custom-enabled-themes (quote (wheatgrass)))
 '(custom-safe-themes
   (quote
    ("c2e1201bb538b68c0c1fdcf31771de3360263bd0e497d9ca8b7a32d5019f2fae" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "76b4632612953d1a8976d983c4fdf5c3af92d216e2f87ce2b0726a1f37606158" default)))
 '(fci-rule-color "#eeeeee")
 '(nrepl-message-colors
   (quote
    ("#8f4e8b" "#8f684e" "#c3a043" "#397460" "#54ab8e" "#20a6ab" "#3573b1" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (ccls lsp-mode doneburn-theme cc-mode popup-kill-ring popup-killring load-theme-buffer-local pdf-tools auctex centaur-tabs expand-region smart-mode-line swiper smartparens web-mode company company-mode all-the-icons-ivy-rich counsel ivy-rich highlight-indentation aggressive-indent org-caldav go-mode haskell-mode lorem-ipsum gitignore-mode hl-todo rainbow-delimiters markdown-mode avy el-search flycheck ivy use-package)))
 '(pdf-view-midnight-colors (quote ("#444444" . "#eeeeee")))
 '(vc-annotate-background "#f9f9f9")
 '(vc-annotate-color-map
   (quote
    ((20 . "#844880")
     (40 . "#8f4e8b")
     (60 . "#8f684e")
     (80 . "#cfb56e")
     (100 . "#c3a043")
     (120 . "#c3a043")
     (140 . "#2a5547")
     (160 . "#397460")
     (180 . "#3b7863")
     (200 . "#438972")
     (220 . "#4c9a80")
     (240 . "#54ab8e")
     (260 . "#20a6ab")
     (280 . "#234d76")
     (300 . "#295989")
     (320 . "#2e659c")
     (340 . "#3573b1")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
