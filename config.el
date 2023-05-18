;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Morland Meng"
      user-mail-address "mmeng@atlassian.com"
      which-key-idle-delay 0.5
      which-key-idle-secondary-delay 0)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; (setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "MesloLGS NF" :size 14)
;;       doom-unicode-font (font-spec :family "MesloLGS NF" :size 14))

;; (setq doom-font (font-spec :family "Hack" :size 14)
;;       doom-variable-pitch-font (font-spec :family "MesloLGS NF" :size 14)
;;       doom-unicode-font (font-spec :family "MesloLGS NF" :size 14))

;; (setq doom-font (font-spec :family "Menlo" :size 14)
;;       doom-variable-pitch-font (font-spec :family "MesloLGS NF" :size 14)
;;       doom-unicode-font (font-spec :family "MesloLGS NF" :size 14))

(setq doom-font (font-spec :family "JetBrains Mono" :size 14 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "MesloLGS NF" :size 14)
      doom-unicode-font (font-spec :family "MesloLGS NF" :size 14))

;;(setq-default line-spacing 0.25)
;;(setq default-text-properties '(line-height 1.4))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Set initial frame size and position

;; -- UI --
(setq default-frame-alist '((fullscreen . maximized)))
(setq vertico-multiform-commands
      '((consult-line
         posframe
         (vertico-posframe-poshandler . posframe-poshandler-frame-top-center)
         (vertico-posframe-border-width . 10)
         ;; NOTE: This is useful when emacs is used in both in X and
         ;; terminal, for posframe do not work well in terminal, so
         ;; vertico-buffer-mode will be used as fallback at the
         ;; moment.
         (vertico-posframe-fallback-mode . vertico-buffer-mode))
        (t posframe)))
(vertico-multiform-mode 1)
(setq vertico-multiform-commands
      '((consult-lsp-symbols (:not posframe))
        (consult-lsp-diagnostics (:not posframe))
        (t posframe)))
;;(helm-posframe-enable)

(with-eval-after-load 'doom-themes
  (doom-themes-treemacs-config))
(setq doom-themes-treemacs-theme "doom-colors")

;; -- TABS --
(after! centaur-tabs
  (setq centaur-tabs-set-bar 'over
        centaur-tabs-height 32
        )
  (centaur-tabs-headline-match)
                                        ; (setq centaur-tabs-style "bar"
                                        ; centaur-tabs-height 48
                                        ; centaur-tabs-set-bar 'under)
  (centaur-tabs-change-fonts "Lucidia Grade" 148)
  (+popup-window-p)
  (centaur-tabs-group-by-projectile-project))
(defun centaur-tabs-hide-tab (x)
  "Do no to show buffer X in tabs."
  (let ((name (format "%s" x)))
    (or
     ;; Current window is not dedicated window.
     (window-dedicated-p (selected-window))

     ;; Buffer name not match below blacklist.
     (string-prefix-p "*epc" name)
     (string-prefix-p "*helm" name)
     (string-prefix-p "*Helm" name)
     (string-prefix-p "*Compile-Log*" name)
     (string-prefix-p "*lsp" name)
     (string-prefix-p "*company" name)
     (string-prefix-p "*Flycheck" name)
     (string-prefix-p "*tramp" name)
     (string-prefix-p " *Mini" name)
     (string-prefix-p "*help" name)
     (string-prefix-p "*straight" name)
     (string-prefix-p " *temp" name)
     (string-prefix-p "*vterm" name)
     (string-prefix-p "*Help" name)
     (string-prefix-p "*mybuf" name)

     ;; Is not magit buffer.
     (and (string-prefix-p "magit" name)
          (not (file-name-extension name)))
     )))

;; -- Projects --
(after! projectile
  (treemacs-project-follow-mode)
  (setq projectile-project-root-files-bottom-up '("package.json" ".projectile" ".project" ".git")
        projectile-ignored-projects '("~/.emacs.d/")
        projectile-project-search-path '("~/projects" "~/playground")))

;; -- Tree Sitter --
(evil-define-key 'normal 'tree-sitter-mode "[a" (+tree-sitter-goto-textobj "parameter.inner" t))
(evil-define-key 'normal 'tree-sitter-mode "]a" (+tree-sitter-goto-textobj "parameter.inner"))
(evil-define-key 'normal 'tree-sitter-mode "[f" (+tree-sitter-goto-textobj "function.outer" t))
(evil-define-key 'normal 'tree-sitter-mode "]f" (+tree-sitter-goto-textobj "function.outer"))
(evil-define-key 'normal 'tree-sitter-mode "[F" (+tree-sitter-goto-textobj "call.outer" t))
(evil-define-key 'normal 'tree-sitter-mode "]F" (+tree-sitter-goto-textobj "call.outer"))
(evil-define-key 'normal 'tree-sitter-mode "[C" (+tree-sitter-goto-textobj "class.outer" t))
(evil-define-key 'normal 'tree-sitter-mode "]C" (+tree-sitter-goto-textobj "class.outer"))
(evil-define-key 'normal 'tree-sitter-mode "[c" (+tree-sitter-goto-textobj "comment.outer" t))
(evil-define-key 'normal 'tree-sitter-mode "]c" (+tree-sitter-goto-textobj "comment.outer"))
(evil-define-key 'normal 'tree-sitter-mode "[l" (+tree-sitter-goto-textobj "loop.outer" t))
(evil-define-key 'normal 'tree-sitter-mode "]l" (+tree-sitter-goto-textobj "loop.outer"))
(evil-define-key 'normal 'tree-sitter-mode "[i" (+tree-sitter-goto-textobj "conditional.outer" t))
(evil-define-key 'normal 'tree-sitter-mode "]i" (+tree-sitter-goto-textobj "conditional.outer"))


;; -- LSP --
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-position 'top)
(setq lsp-ui-doc-delay 0.2)
(setq lsp-ui-doc-include-signature nil)
(setq lsp-ui-doc-show-with-cursor nil)
(setq lsp-ui-doc-show-with-mouse t)
(setq lsp-ui-doc-max-height 20)
(setq lsp-lens-enable t)
(setq lsp-ui-sideline-enable t)
(setq lsp-ui-sideline-show-code-actions t)

;; -- FRINGE --
;; (add-hook! 'doom-init-ui-hook (fringe-mode nil))
;; ;;(setq left-fringe-width 32)
;; (add-hook! +dap-running-session-mode
;; (set-window-buffer nil (current-buffer)))
;; (set-fringe-style (quote (20 . 10)))
(after! doom-themes-ext-treemacs
  (with-eval-after-load 'treemacs
    (remove-hook 'treemacs-mode-hook #'doom-themes-hide-fringes-maybe)
    (advice-remove #'treemacs-select-window #'doom-themes-hide-fringes-maybe)))
;;(set-fringe-style (quote (12 . 8)))

;; -- KEYS --
(map! :leader "!" #'vterm)
(map! :leader "jt" #'centaur-tabs-ace-jump)

(map! :leader
      (:prefix ("v" . "visual")
       :desc "Narrow to region" "n" #'fancy-narrow-to-region
       :desc "Narrow to defun" "d" #'fancy-narrow-to-defun
       :desc "Widen" "w" #'fancy-widen))

(map! :leader :desc "Error lists" "cx" (lambda () (interactive) (+default/diagnostics '((:not posframe)))))


;; -- RUST --
(require 'dap-lldb)
(require 'dap-codelldb)
(require 'dap-cpptools)
;;(setq dap-lldb-debug-program `("/Users/mmeng/.vscode/extensions/vadimcn.vscode-lldb-1.9.0/lldb/bin/lldb"))

(setq lsp-rust-analyzer-debug-lens-extra-dap-args
      `(:MIMode "lldb"
        :miDebuggerPath "lldb-mi"
        :stopAtEntry t
        :externalConsole
        :json-false))

(dap-register-debug-template
 "Rust::LLDB Run Configuration"
 (list :type "lldb"
       :request "launch"
       :name "LLDB::Run"
       :gdbpath "rust-lldb"
       :cwd (lsp-workspace-root)
       ))

;; -- JAVA --
(setq lsp-java-vmargs
      '("-XX:+UseParallelGC" "-XX:GCTimeRatio=4" "-XX:AdaptiveSizePolicyWeight=90" "-Dsun.zip.disableMemoryMapping=true" "-Xmx4G" "-Xms100m"))

;; -- COPILOT --
;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; -- DOCS --
(set-docsets! 'python-mode "Python 3" "Flask")
(after! dash-docs
  (setq dash-docs-browser-func #'+lookup-xwidget-webkit-open-url-fn))

;; -- ORG --
(after! org
 (setq org-todo-keywords
      '((sequence "TODO" "IN_PROGRESS" "BLOCKED" "|" "DONE" "CANCELLED")))
  )
(after! org-roam
  :custom
  (org-roam-complete-everywhere)
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "${title}\n#+filetags: \n#+date: %U\n")
           :unnarrowed t)
          ("l" "programming language" plain
           "* Overview\n%?\n* Learning Plan\n\n* Links\n\n"
           :target (file+head "%<%Y%m%d%H%M%S>-lang-${slug}.org" "${title}\n#+filetags: :LANG:\n")
           :unnarrowed t)
          ("r" "reading notes" plain
           "Title: ${title} \nLink: %^{Link}:\nTopics: %?\n* Notes\n\n* Thoughts\n\n"
           :target (file+head "%<%Y%m%d%H%M%S>-reading-${slug}.org" "${title}\n#+filetags: :READING:\n")
           :unnarrowed t)
          ("b" "book notes" plain
           "Title: %^{title} \n* Summary:\n%?\n* Chapters\n\n* Thoughts\n\n"
           :target (file+head "%<%Y%m%d%H%M%S>-book-${slug}.org" "${title}\n#+filetags: :BOOK:\n")
           :unnarrowed t)
          ("t" "thought" plain
           "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-thought-${slug}.org" "${title}\n#+filetags: :THOUGHT:\n")
           :unnarrowed t)
          ("p" "project tasks" plain
           "* Goals\n%?\n* Tasks\n** TODO Initial tasks\n\n* Dates\n"
           :target (file+head "%<%Y%m%d%H%M%S>-thought-${slug}.org" "${title}\n#+filetags: :PROJECT:\n#+date: %U\n")
           :unnarrowed t)
          ))
  )
(advice-add #'org-roam-fontify-like-in-org-mode :around (lambda (fn &rest args) (save-excursion (apply fn args))))
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
