;; -*- lexical-binding: t; -*-

;;; Straight package manager 

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;; Package initialization

;; set straight.el to use 'use-package
(straight-use-package 'use-package)

(setq package-enable-at-startup nil)
(setq straight-use-package-by-default t)

;;; --------------------------------------------------
;;; Miscellaneous configurations
;;; --------------------------------------------------

;; Add svg to image type list
(add-to-list 'image-types 'svg)

;; remove warning for large files threshold
(setq large-file-warning-threshold nil)

;; remove startup message
(setq inhibit-startup-message t)

;; disable several ui elements
(scroll-bar-mode -1)  ; Disable visible scrollbar
(tool-bar-mode -1)    ; Disable the toolbar
(tooltip-mode -1)     ; Disable tooltips
(set-fringe-mode 10)  ; Give some breathing room
(menu-bar-mode -1)    ; Disable the menu bar

;; make titlebar the same as buffer
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon nil)
(setq frame-title-format nil)

;; enable vertical scrolling
(setq scroll-step 1)
(setq scroll-margin 1)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq auto-window-vscroll nil)
(setq fast-but-imprecise-scrolling nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq scroll-preserve-screen-position t)

;; enable horizontal scrolling
(setq hscroll-step 1)
(setq hscroll-margin 1)

;; keybindings for horizontal scrolling
(defun joemacs/scroll-right() (interactive) (scroll-right 2))
(defun joemacs/scroll-left() (interactive) (scroll-left 2))
(global-set-key (kbd "<left-margin> <triple-wheel-left>")  'joemacs/scroll-left)
(global-set-key (kbd "<left-margin> <triple-wheel-right>")  'joemacs/scroll-right)

(global-set-key (kbd "<right-margin> <triple-wheel-right>") 'joemacs/scroll-left)
(global-set-key (kbd "<right-margin> <triple-wheel-left>") 'joemacs/scroll-right)


(global-set-key (kbd "<wheel-left>") 'joemacs/scroll-right)
(global-set-key (kbd "<double-wheel-left>") 'joemacs/scroll-right)
(global-set-key (kbd "<triple-wheel-left>") 'joemacs/scroll-right)
(global-set-key (kbd "<wheel-right>") 'joemacs/scroll-left)
(global-set-key (kbd "<double-wheel-right>") 'joemacs/scroll-left)
(global-set-key (kbd "<triple-wheel-right>") 'joemacs/scroll-left)

;; set up the visible bell
(setq visible-bell t)

;; mac specific settings
(setq mac-option-modifier nil
     mac-control-modifier 'control
     mac-command-modifier 'meta
     select-enable-clipboard t)
;; one line at a time 
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
;; don't accelerate scrolling
(setq mouse-wheel-progressive-speed nil) 
;; Disable dialog boxes since they weren't working in Mac OSX
(setq use-dialog-box nil) 

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; transparency on emacs frame
(set-frame-parameter (selected-frame) 'alpha '(98 . 98))
(add-to-list 'default-frame-alist '(alpha . (98 . 98)))

;; ido-mode configuration
(ido-mode 1)
(setq ido-separator "\n")

;; Doom modeline and themes
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)
           (doom-modeline-lsp t)
           (doom-modeline-github t)))

(use-package doom-themes
  :init (load-theme 'doom-gruvbox t))

;; Rainbow delimiters
(use-package rainbow-delimiters
	     :hook (prog-mode . rainbow-delimiters-mode))

;; Enable line numbers in general
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                vterm-mode-hook
                shell-mode-hook
                eshell-mode-hook
                markdown-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0)))
  ;; Remove indentation
  (electric-indent-local-mode -1))

;;; --------------------------------------------------
;;; Formatting configuration
;;; --------------------------------------------------

;; Favor spaces over tabs. Pls dun h8, but I think spaces (and 4 of them) is a
;; more consistent default than 8-space tabs. It can be changed on a per-mode
;; basis anyway (and is, where tabs are the canonical style, like go-mode).
(setq-default indent-tabs-mode nil
              tab-width 4)

;; Only indent the line when at BOL or in a line's indentation. Anywhere else,
;; insert literal indentation.
(setq-default tab-always-indent nil)

;; Make `tabify' and `untabify' only affect indentation. Not tabs/spaces in the
;; middle of a line.
(setq tabify-regexp "^\t* [ \t]+")

;; An archaic default in the age of widescreen 4k displays? I disagree. We still
;; frequently split our terminals and editor frames, or have them side-by-side,
;; using up more of that newly available horizontal real-estate.
(setq-default fill-column 100)

;; Continue wrapped words at whitespace, rather than in the middle of a word.
(setq-default word-wrap t)

;; ...but don't do any wrapping by default. It's expensive. Enable
;; `visual-line-mode' if you want soft line-wrapping. `auto-fill-mode' for hard
;; line-wrapping.
(setq-default truncate-lines t)
;; If enabled (and `truncate-lines' was disabled), soft wrapping no longer
;; occurs when that window is less than `truncate-partial-width-windows'
;; characters wide. We don't need this, and it's extra work for Emacs otherwise,
;; so off it goes.
(setq truncate-partial-width-windows nil)

;; This was a widespread practice in the days of typewriters. I actually prefer
;; it when writing prose with monospace fonts, but it is obsolete otherwise.
(setq sentence-end-double-space nil)

;; The POSIX standard defines a line is "a sequence of zero or more non-newline
;; characters followed by a terminating newline", so files should end in a
;; newline. Windows doesn't respect this (because it's Windows), but we should,
;; since programmers' tools tend to be POSIX compliant (and no big deal if not).
(setq require-final-newline t)

;; Prevent images from showing actual width
;; (setq org-image-actual-width nil)
(setq org-image-actual-width (/ (display-pixel-width) 5))

;; Default to soft line-wrapping in text modes. It is more sensibile for text
;; modes, even if hard wrapping is more performant.
(add-hook 'text-mode-hook
          #'visual-line-mode
          #'(lambda ()
             (setq indent-tabs-mode nil)
             (setq tab-width 4)))

;;; --------------------------------------------------
;;; Clipboard / kill-ring configuration
;;; --------------------------------------------------

;; Cull duplicates in the kill ring to reduce bloat and make the kill ring
;; easier to peruse (with `counsel-yank-pop' or `helm-show-kill-ring'.
(setq kill-do-not-save-duplicates t)

;; You will most likely need to adjust this font size for your system!
(defvar joemacs/default-font-size 140)
(defvar joemacs/default-variable-font-size 160)

;; Font configuration

;; set the default face
(set-face-attribute 'default nil
                    :font "JetBrains Mono"
                    :height joemacs/default-font-size)

;; set the fixed pitch face
(set-face-attribute 'fixed-pitch nil
                    :font "JetBrains Mono"
                    :height joemacs/default-variable-font-size)

;; set the variable pitch face
(set-face-attribute 'variable-pitch nil
                    :font "JetBrains Mono"
                    :height joemacs/default-variable-font-size
                    :weight 'normal)

;; NOTE: The first time you load your configuration on a new machine, you'll
;; need to run the following command interactively so that mode line icons
;; display correctly:
;;
;; M-x all-the-icons-install-fonts
;; M-x nerd-icons-install-fonts

(use-package all-the-icons)

;;; --------------------------------------------------
;; Evil mode configuration 
;;; --------------------------------------------------

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)

  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(defun joemacs/dont-arrow-me-bro ()
  (interactive)
  (message "Stop using arrow keys!"))

;; Disable arrow keys in normal and visual modes
(define-key evil-normal-state-map (kbd "<left>") 'joemacs/dont-arrow-me-bro)
(define-key evil-normal-state-map (kbd "<right>") 'joemacs/dont-arrow-me-bro)
(define-key evil-normal-state-map (kbd "<down>") 'joemacs/dont-arrow-me-bro)
(define-key evil-normal-state-map (kbd "<up>") 'joemacs/dont-arrow-me-bro)
(evil-global-set-key 'motion (kbd "<left>") 'joemacs/dont-arrow-me-bro)
(evil-global-set-key 'motion (kbd "<right>") 'joemacs/dont-arrow-me-bro)
(evil-global-set-key 'motion (kbd "<down>") 'joemacs/dont-arrow-me-bro)
(evil-global-set-key 'motion (kbd "<up>") 'joemacs/dont-arrow-me-bro)

;; (add-hook 'evil-local-mode-hook 'turn-on-undo-tree-mode)

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-commentary
  :after evil
  :straight t
  :diminish
  :config
  (evil-commentary-mode 1))

;; Auto-enable and disable electric pair mode based on major mode
(add-hook 'prog-mode-hook
	  (lambda () (electric-pair-mode 1)))
(add-hook 'emacs-lisp-mode-hook
	  (lambda () (electric-pair-mode 0)))

;;; --------------------------------------------------
;;; Which-key configuration
;;; --------------------------------------------------

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0))

;;; --------------------------------------------------
;;; General mode configuration 
;;; --------------------------------------------------

(use-package general
 :config
 (general-create-definer joemacs/leader-keys
   :keymaps '(normal insert visual emacs)
   :prefix "SPC"
   :global-prefix "C-SPC")

 (joemacs/leader-keys
   "SPC" '(counsel-M-x :which-key "M-x")
   "b b" '(counsel-ibuffer :which-key "list active buffers")
   "b f" '(counsel-find-file :which-key "find/new buffer")
   "w v" '(split-window-horizontally :which-key "window split horizontally")
   "w h" '(split-window-vertically :which-key "window split vertically")
   "t"   '(term :which-key "open terminal")
   "o t" '(org-todo :which-key "org-todo toggle")
   "o s" '(org-sort-entries nil ?a :which-key "org-sort-entries header")
   "p o" '(org-present :which-key "open presentation")
   "p n" '(org-present-next :which-key "next slide")
   "p N" '(org-present-prev :which-key "previous slide")
   "p q" '(org-present-quit :which-key "close presentation")
))

;;; --------------------------------------------------
;;; Counsel configuration
;;; --------------------------------------------------

(use-package counsel)

;; ignore certain files
(setq counsel-find-file-ignore-regexp ".*~\\|.#")

;;; --------------------------------------------------
;;; Ivy configuration
;;; --------------------------------------------------

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

(defun joemacs/find-file-no-ivy ()
  (interactive)
  (let ((ivy-state ivy-mode))
    (ivy-mode -1)
    (call-interactively 'find-file)
    (ivy-mode ivy-state)))

(global-set-key (kbd "C-x F") 'joemacs/find-file-no-ivy) ; steals key from set-fill-column
(setq ivy-extra-directories nil)

(use-package ivy-rich
 :init
 (ivy-rich-mode 1))

;;; --------------------------------------------------
;;; Undo-tree configuration
;;; --------------------------------------------------

(use-package undo-tree
  :init
  (setq undo-tree-auto-save-history nil)
  (global-undo-tree-mode 1))

;;; --------------------------------------------------
;;; Org mode configuration
;;; --------------------------------------------------

(defun joemacs/org-mode-setup ()
 (variable-pitch-mode 1)
 (auto-fill-mode 0)
 (visual-line-mode 1)
 (setq evil-auto-indent nil))

(defun joemacs/org-font-setup ()
 ;; Replace list hyphen with dot
 (font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "-"))))))

 ;; Set faces for heading levels
 (dolist (face '((org-level-1 . 1.4)
                 (org-level-2 . 1.05)
                 (org-level-3 . 1.0)
                 (org-level-4 . 1.0)
                 (org-level-5 . 1.0)
                 (org-level-6 . 1.0)
                 (org-level-7 . 1.0)
                 (org-level-8 . 1.0)))
   (set-face-attribute (car face) nil :font "Cantarell" :weight 'bold :height (cdr face)))

 ;; Ensure that anything that should be fixed-pitch in Org files appears that way
 (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
 (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
 (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
 (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
 (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
 (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
 (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org
 :hook (org-mode . joemacs/org-mode-setup)
 :config
 (setq org-ellipsis " ▼"
       org-hide-emphasis-markers t
       org-src-fontify-natively t
       org-fontify-quote-and-verse-blocks t
       org-src-tab-acts-natively t
       org-edit-src-content-indentation 2
       org-hide-block-startup nil
       org-src-preserve-indentation t
       org-cycle-separator-lines 2
       org-capture-bookmark nil)
 (joemacs/org-font-setup))

(use-package org-download)

(defun joemacs/org-present-prepare-slide (buffer-name heading)
  ;; Show only top-level headlines
  (org-overview)

  ;; Unfold the current entry
  (org-show-entry)

  ;; Show only direct subheadings of the slide but don't expand them
  (org-show-children))

(defun joemacs/org-present-start ()
  ;; Tweak font sizes
  (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
                                     (header-line (:height 4.0) variable-pitch)
                                     (org-document-title (:height 1.75) org-document-title)
                                     (org-code (:height 1.55) org-code)
                                     (org-verbatim (:height 1.55) org-verbatim)
                                     (org-block (:height 1.25) org-block)
                                     (org-block-begin-line (:height 0.7) org-block)))

  ;; Set a blank header line string to create blank space at the top
  (setq header-line-format " ")

  ;; Display inline images automatically
  (org-display-inline-images)

  ;; Center the presentation and wrap lines
  (visual-fill-column-mode 1)
  (visual-line-mode 1))

(defun joemacs/org-present-end ()
  ;; Reset font customizations
  (setq-local face-remapping-alist '((default variable-pitch default)))

  ;; Clear the header line string so that it isn't displayed
  (setq header-line-format nil)

  ;; Stop displaying inline images
  (org-remove-inline-images)

  ;; Stop centering the document
  (visual-fill-column-mode 0)
  (visual-line-mode 0)
  (org-mode-restart))

;; Register hooks with org-present
(add-hook 'org-present-mode-hook 'joemacs/org-present-start)
(add-hook 'org-present-mode-quit-hook 'joemacs/org-present-end)
(add-hook 'org-present-after-navigate-functions 'joemacs/org-present-prepare-slide)

(defun joemacs/visual-fill ()
 (setq visual-fill-column-width 100
       visual-fill-column-center-text t)
 (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . joemacs/visual-fill)
  :hook (org-present . joemacs/visual-fill)
  :hook (markdown-mode . joemacs/visual-fill))

(add-to-list 'org-structure-template-alist '("sh"  . "src shell"))
(add-to-list 'org-structure-template-alist '("el"  . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py"  . "src python"))
(add-to-list 'org-structure-template-alist '("jv"  . "src java"))
(add-to-list 'org-structure-template-alist '("ru"  . "src rust"))
(add-to-list 'org-structure-template-alist '("go"  . "src go"))
(add-to-list 'org-structure-template-alist '("hs"  . "src haskell"))
(add-to-list 'org-structure-template-alist '("kt"  . "src kotlin"))
(add-to-list 'org-structure-template-alist '("md"  . "src markdown"))
(add-to-list 'org-structure-template-alist '("sql" . "src sql"))
(add-to-list 'org-structure-template-alist '("xml" . "src xml"))
(add-to-list 'org-structure-template-alist '("yml" . "src yml"))

;; src block indentation / editing / syntax highlighting
(setq org-src-fontify-natively t
   org-src-window-setup 'current-window ;; edit in current window
   org-src-strip-leading-and-trailing-blank-lines t
   org-src-preserve-indentation t ;; do not put two spaces on the left
   org-src-tab-acts-natively t)

(org-babel-do-load-languages
'org-babel-load-languages
'((emacs-lisp . t)))

(defun joemacs/org-update-all-statistics-cookies ()
  (org-update-statistics-cookies t))

(defun joemacs/org-move-to-state-heading ()
  (let ((state (org-get-todo-state)))
    (cond
     ((string= state "ADMIN")
      (org-cut-subtree)
      (goto-char (point-min))
      (search-forward "* admin todo")
      (outline-next-visible-heading 1)
      (org-paste-subtree 2))
     ((string= state "DEVEL")
      (org-cut-subtree)
      (goto-char (point-min))
      (search-forward "* dev todo")
      (outline-next-visible-heading 1)
      (org-paste-subtree 2))
     ((string= state "SETUP")
      (org-cut-subtree)
      (goto-char (point-min))
      (search-forward "* setup todo")
      (outline-next-visible-heading 1)
     ((string= state "STATUS")
      (org-cut-subtree)
      (goto-char (point-min))
      (search-forward "* status")
      (outline-next-visible-heading 1)
      (org-paste-subtree 2))
      (org-paste-subtree 2))
     ((string= state "REVIEW")
      (org-cut-subtree)
      (goto-char (point-min))
      (search-forward "* review")
      (outline-next-visible-heading 1)
      (org-paste-subtree 2))
     ((string= state "TEST")
      (org-cut-subtree)
      (goto-char (point-min))
      (search-forward "* test")
      (outline-next-visible-heading 1)
      (org-paste-subtree 2))
     ((string= state "PROD")
      (org-cut-subtree)
      (goto-char (point-min))
      (search-forward "* production")
      (outline-next-visible-heading 1)
      (org-paste-subtree 2))
     ((string= state "DONE")
      (org-cut-subtree)
      (goto-char (point-min))
      (search-forward "* done")
      (outline-next-visible-heading 1)
      (org-paste-subtree 2))
     ((string= state "BACKLOG")
      (org-cut-subtree)
      (goto-char (point-min))
      (search-forward "* backlog")
      (outline-next-visible-heading 1)
      (org-paste-subtree 2)))))

(add-hook 'org-after-todo-state-change-hook #'joemacs/org-move-to-state-heading)

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'joemacs/org-update-all-statistics-cookies nil 'local)))

(setq org-fontify-whole-heading-line nil)

;; Setup keywords
(setq org-todo-keywords
  '((sequence "BACKLOG(b)" "ADMIN(a)" "DEVEL(d)" "SETUP(s)" "STATUS(u)" "TEST(t)" "PROD(p)" "TODO(o)" "REVIEW(r)" "DONE(D)")))

;; Setup faces
(setq org-todo-keyword-faces
      '(("BACKLOG" . (:foreground "#f5f1f2" :weight bold))
        ("ADMIN"   . (:foreground "#fe8018" :weight bold))
        ("DEVEL"   . (:foreground "#fe8018" :weight bold))
        ("SETUP"   . (:foreground "#fe8018" :weight bold))
        ("STATUS"  . (:foreground "#fe8018" :weight bold))
        ("TEST"    . (:foreground "#fe8018" :weight bold))
        ("PROD"    . (:foreground "#fe8018" :weight bold))
        ("TODO"    . (:foreground "#fe8018" :weight bold))
        ("REVIEW"  . (:foreground "#fe8018" :weight bold))
        ("DONE"    . (:foreground "#776d79" :weight bold))))

;; default directory for pasting images from clipboard
(setq-default org-download-image-dir "./img")
(setq-default org-download-heading-lvl nil)


;;; --------------------------------------------------
;;; Projectile configuration
;;; --------------------------------------------------

 (use-package projectile
   :diminish projectile-mode
   :config (projectile-mode)
   :custom ((projectile-completion-system 'ivy))
   :bind-keymap
   ("C-c p" . projectile-command-map)
   :init
   ;; NOTE: Set this to the folder where you keep your Git repos!
   (when (file-directory-p "~/workspace")
 	(setq projectile-project-search-path '("~/workspace")))
   (setq projectile-switch-project-action #'projectile-dired))

;;; --------------------------------------------------
;;; Programming configurations
;;; --------------------------------------------------

;; lsp mode || lsp ui || lsp treemacs
(use-package lsp-mode
 :commands (lsp lsp-deferred)
 :init
 (setq lsp-keymap-prefix "C-c l") ;; Or 'C-l', 's-l'
 :bind (:map lsp-mode-map
             ("<tab>" . company-indent-or-complete-common))
 :config
 (lsp-enable-which-key-integration t)
 (add-hook 'c-mode-hook      #'(lambda () (when (eq major-mode 'c-mode) (lsp-deferred))))
 (add-hook 'go-mode-hook     #'(lambda () (when (eq major-mode 'go-mode) (lsp-deferred))))
 (add-hook 'c++-mode-hook    #'(lambda () (when (eq major-mode 'c++-mode) (lsp-deferred))))
 (add-hook 'java-mode-hook   #'(lambda () (when (eq major-mode 'java-mode) (lsp-deferred))))
 (add-hook 'yaml-mode-hook   #'(lambda () (when (eq major-mode 'yaml-mode) (lsp-deferred))))
 (add-hook 'objc-mode-hook   #'(lambda () (when (eq major-mode 'objc-mode) (lsp-deferred))))
 (add-hook 'python-mode-hook #'(lambda () (when (eq major-mode 'python-mode) (lsp-deferred))))
 (add-hook 'kotlin-mode-hook #'(lambda () (when (eq major-mode 'kotlin-mode) (lsp-deferred))))
 )

(use-package lsp-ui
 :hook (lsp-mode . lsp-ui-mode)
 :custom
 (lsp-ui-sideline-show-code-actions t)
 (lsp-ui-doc-position 'at-point))

(use-package lsp-treemacs
 :after lsp)

;; lua mode
(use-package lua-mode
 :mode "\\.lua\\'"
 :hook (lua-mode . lsp-deferred))

;; yaml mode
(use-package yaml-mode)
(add-hook 'yaml-mode-hook
    #'(lambda ()
       (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; java mode || lsp java || dap-mode || dap java
(use-package lsp-java
 :after lsp)

(use-package java
 :straight nil
 :after lsp-java
 :bind (:map java-mode-map ("C-c i" . lsp-java-add-import)))

(use-package dap-mode
 :after lsp-mode
 :config (dap-auto-configure-mode))

(use-package dap-java
 :straight nil)

;; kotlin mode
(use-package kotlin-mode
  :after (lsp-mode dap-mode)
  :config
  (require 'dap-kotlin)
  ;; should probably have been in dap-kotlin instead of lsp-kotlin
  (setq lsp-kotlin-debug-adapter-path (or (executable-find "kotlin-debug-adapter") ""))
  :hook
  (kotlin-mode . lsp))

;; python mode || python black || pyvenv
(use-package python-mode
  :straight t
  :hook (python-mode . lsp-deferred)
  :custom
  ;; NOTE: Set these if Python 3 is called "python3" on your system!
  (python-shell-interpreter "python3")
  (dap-python-executable "python3")
  (dap-python-debugger 'debugpy)
  :config
  (require 'dap-python))

(use-package python-black
  :demand t
  :after python
  :hook (python-mode . python-black-on-save-mode-enable-dwim))

(use-package pyvenv
  :after python-mode
  :config
  (pyvenv-mode 1))

;; c mode || c++ mode || objc mode || cuda mode
(use-package ccls
 :hook ((c-mode c++-mode objc-mode cuda-mode) .
        (lambda () (require 'ccls) (lsp))))

;; rust mode || rustic
(use-package rustic
 :straight t
 :bind (("<f6>" . rustic-format-buffer))
 :config
 (require 'lsp-rust)
 (setq lsp-rust-analyzer-completion-add-call-parenthesis nil))

;; golang mode || go projectile
(use-package go-mode
  :straight t
  :hook (go-mode . lsp-deferred))

(use-package go-projectile)
(go-projectile-tools-add-path)
(setq go-projectile-tools
  '((gocode    . "github.com/mdempsky/gocode")
    (golint    . "golang.org/x/lint/golint")
    (godef     . "github.com/rogpeppe/godef")
    (errcheck  . "github.com/kisielk/errcheck")
    (godoc     . "golang.org/x/tools/cmd/godoc")
    (gogetdoc  . "github.com/zmb3/gogetdoc")
    (goimports . "golang.org/x/tools/cmd/goimports")
    (gorename  . "golang.org/x/tools/cmd/gorename")
    (gomvpkg   . "golang.org/x/tools/cmd/gomvpkg")
    (guru      . "golang.org/x/tools/cmd/guru")))

;; flycheck
(use-package flycheck
 :hook (lsp-mode))

;; setup cmake-mode for autoloading
(autoload 'cmake-mode "cmake-mode" "Major mode for editing CMake listfiles." t)
(setq auto-mode-alist
          (append
           '(("CMakeLists\\.txt\\'" . cmake-mode))
           '(("\\.cmake\\'" . cmake-mode))
           auto-mode-alist))

;;; --------------------------------------------------
;;; Magit configuration
;;; --------------------------------------------------

(use-package magit
 :custom
 (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;;; --------------------------------------------------
;;; Term configuration
;;; --------------------------------------------------

(use-package term
	:commands term
	:config 
	(setq explicit-shell-file-name "zsh")
    ;; Set this to match your custom shell prompt
    (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))  

;;; --------------------------------------------------
;;; Testing stuff
;;; --------------------------------------------------

(use-package org-excalidraw
  :straight (:type git :host github :repo "wdavew/org-excalidraw"))
