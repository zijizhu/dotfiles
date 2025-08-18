;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up use-package ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; Package archives
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
 
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
 
;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
 
;; Set up use-package
(require 'use-package)
(setq use-package-always-ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General customizations ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(exec-path-from-shell-initialize)
;; (when (memq window-system '(mac ns x))
;;   (exec-path-from-shell-initialize))

(use-package emacs
  :init

  ;; Enable indentation+completion using the TAB key.
  (setq tab-always-indent 'complete)
  (setq read-extended-command-predicate #'command-completion-default-include-p)

  ;; Turn off the ring bell
  (setq ring-bell-function 'ignore)

  ;; Maximize frame on startup
  (add-to-list 'default-frame-alist '(fullscreen . maximized))
 
  ;; Tweak backup settings
  (if (not (file-directory-p "~/.backups"))
      (make-directory "~/.backups"))
  (if (not (file-directory-p "~/.auto-saves"))
      (make-directory "~/.auto-saves"))

  (setq
   backup-by-copying t       ; don't clobber symlinks
   backup-directory-alist
   '(("." . "~/.backups/"))  ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2)      ; use versioned backups
  (setq auto-save-file-name-transforms `((".*" "~/.auto-saves/" t)))
 
  ;; Minibuffer and command settings from vertico.el
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
		  (replace-regexp-in-string
		   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
		   crm-separator)
		  (car args))
	  (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)
 
  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
	'(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
 
  ;; Support opening new minibuffers from inside existing minibuffers.
  (setq enable-recursive-minibuffers t)
 
  ;; Emacs 28 and newer: Hide commands in M-x which do not work in the current
  ;; mode.  Vertico commands are hidden in normal buffers. This setting is
  ;; useful beyond Vertico.
  (setq read-extended-command-predicate #'command-completion-default-include-p)

  :config
 
  ;; Tweak interface
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (set-fringe-mode 0)
  (menu-bar-mode -1)
  (global-display-line-numbers-mode)
 
  ;; Auto-close brackets
  (electric-pair-mode)
  (add-function :before-until
		electric-pair-inhibit-predicate
		(lambda
		  (c) (eq c ?<)))

  ;; Dired Configuration
  (setq dired-kill-when-opening-new-dired-buffer 1)

  ;; Set font face
  (set-face-attribute 'default nil :font "PragmataPro" :height 130)
  (set-face-attribute 'variable-pitch nil :family "PragmataPro" :height 130)
  (set-face-attribute 'fixed-pitch nil :font "PragmataPro" :height 130)

  ;; Configure languages
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
 
  ;; Config built-in tree-sitter
  ;; blog: https://www.masteringemacs.org/article/how-to-get-started-tree-sitter
  ;; starter guide: https://github.com/emacs-mirror/emacs/blob/master/admin/notes/tree-sitter/starter-guide
  ;; NOTE tree-sitter grammers currently do have have a versioning system, so sometimes latest releases might not work
  ;; For example, we need specify versions that work for C and C++: https://github.com/tree-sitter/tree-sitter-cpp/issues/271
  (setq treesit-language-source-alist
	'((bash "https://github.com/tree-sitter/tree-sitter-bash")
	  (elisp "https://github.com/Wilfred/tree-sitter-elisp")
	  (json "https://github.com/tree-sitter/tree-sitter-json")
	  (make "https://github.com/alemuller/tree-sitter-make")
	  (c "https://github.com/tree-sitter/tree-sitter-c" "v0.20.7")
	  (cpp "https://github.com/tree-sitter/tree-sitter-cpp" "v0.22.0")
	  (python "https://github.com/tree-sitter/tree-sitter-python")
	  (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
	  (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
	  (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
	  (toml "https://github.com/tree-sitter/tree-sitter-toml")
	  (yaml "https://github.com/ikatyang/tree-sitter-yaml")))
 
  ;; Enable tree-sitter for various languages
  ;; AucTex package utilizes variable major-mode-remap-alist
  ;; So we must use add-to-list instead of setq to not break AucTex
  ;; (add-to-list 'major-mode-remap-alist '(elisp-mode . elisp-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
  (add-to-list 'major-mode-remap-alist '(cpp-mode . cpp-ts-mode))
  (add-to-list 'major-mode-remap-alist '(yaml-mode . yaml-ts-mode))
  (add-to-list 'major-mode-remap-alist '(bash-mode . bash-ts-mode))
  (add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))
  (add-to-list 'major-mode-remap-alist '(json-mode . json-ts-mode))
  (setq treesit-font-lock-level 4))

(use-package which-key)
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load themes, icon packs and modeline theme ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package hl-todo
  :ensure t
  :config
  (global-hl-todo-mode))

(use-package modus-themes
  :custom
  (modus-themes-mixed-fonts t)
  :config
  (load-theme 'modus-vivendi :no-confirm))
 
(use-package nerd-icons
  :custom
  (nerd-icons-font-family "Symbols Nerd Font Mono")
  :config
  (setq nerd-icons-scale-factor 1.1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Language integration with eglot ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package eglot)
 ;; :config
 ;; (add-to-list 'eglot-server-programs '((c-ts-mode :language-id "c") . ("clangd" "--stdio"))))

;; Note: we can use the following packages to enhance eglot:
;; -- eglot-booster
;; -- emacs-lsp-booster
;; But these might not be needed as the latest Emacs versions come with native JSON parsing
;; Discussion: https://www.reddit.com/r/emacs/comments/1b25904/is_there_anything_i_can_do_to_make_eglots/


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Command completion with vertico and consult ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
(use-package vertico
  :init
  (vertico-mode)
  :config
  ;; Turn off case sensitivity of Emacs default completion system
  (setq read-file-name-completion-ignore-case t
	read-buffer-completion-ignore-case t
	completion-ignore-case t))
 
;; Configure directory extension.
(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))
 
(use-package consult)

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  ;; The :init section is always executed.
  :init
  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (orderless-matching-styles '(orderless-regexp orderless-flex))
  (completion-category-overrides '((file (styles basic partial-completion)))))

 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup code completion with corfu, cape and magit ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-preselect 'prompt)

  :bind
  (:map corfu-map
	("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))

  :init
  (global-corfu-mode))

(use-package kind-icon
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package cape
  :bind ("C-c p" . cape-prefix-map) ;; Alternative keys: M-p, M-+, ...
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file))
 
(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.config/emacs/snippets"))
  (yas-global-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; git management with magit ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
(use-package magit)


;;;;;;;;;;;;;;;;;;;;;;;;
;; Configure org-mode ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(use-package olivetti
  :custom
  (olivetti-body-width 0.75)
  :config
  (add-hook 'org-mode-hook
	    (lambda ()
	      (variable-pitch-mode)
	      (olivetti-mode 1)
	      (flyspell-mode 1)
	      (visual-line-mode)
	      (display-line-numbers-mode -1)))
	      ;; LaTeX formatting in Org Mode
	      ;; (setq org-format-latex-options (plist-put org-format-latex-options :background "Transparent"))
	      ;; (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))))
  (setq org-startup-indented t)
  (setq org-preview-latex-default-process 'dvisvgm))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configure env variables ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Emacs Plus has a feature that injects $PATH variable
;; So this is not needed for $PATH on macOS, but still useful on other devices or for other env vars
(use-package exec-path-from-shell)

(use-package envrc
  :hook (after-init . envrc-global-mode))
 
(setq custom-file "~/.config/emacs/custom.el")
(load custom-file)
