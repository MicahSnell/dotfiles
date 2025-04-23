;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; setup package.el, add melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; fetch package list if not present
(or (file-exists-p package-user-dir) (package-refresh-contents))

;; ensure selected packages are installed
(setq package-selected-packages
      '(arduino-mode
        go-mode
        treemacs
        xresources-theme))
(package-install-selected-packages)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; set first available font
(cond
 ((find-font (font-spec :name "Source Code Pro"))
  (set-frame-font "Source Code Pro 12" nil t))
 ((find-font (font-spec :name "DejaVu Sans Mono"))
  (set-frame-font "DejaVu Sans Mono 12" nil t))
  ((find-font (font-spec :name "Classic Console"))
  (set-frame-font "Classic Console 18" nil t)))

(setq frame-title-format (list "emacs@" system-name ": %b"))

;; load xresources theme if in graphical frame, wombat otherwise
(if (window-system)
    (load-theme 'xresources t)
  (load-theme 'wombat t))

;; no startup screen, no tool/menu bars, no scroll bars
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)
(scroll-bar-mode 0)
(fringe-mode 0)

;; show current row and column in status bar
(setq line-number-mode t)
(setq column-number-mode t)

;; show line numbers in all modes
(global-display-line-numbers-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; behavior
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; auto refresh emacs buffers when saved elsewhere to disk
(global-auto-revert-mode t)
(setq auto-revert-remote-files t)

;; take y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; dont wrap lines onto the same line but not
(setq-default truncate-lines t)

;; use spaces instead of tabs for all buffers
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

;; wrap at 89 for all buffers
(setq-default auto-fill-function 'do-auto-fill)
(setq-default fill-column 89)

;; set default tab width to 2 for all buffers
(setq-default default-tab-width 2)
(setq-default tab-width 2)

;; highlight matching parenthesis
(show-paren-mode t)

;; delete highlighted text
(delete-selection-mode t)

;; delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; automatically add a newline at the end of a file when saved
(setq require-final-newline t)

;; save backup files to ~/.emacs.d/saves
(setq backup-directory-alist '(("." . "~/.emacs.d/saves")))

;; scroll line by line
(setq scroll-step 1
      scroll-conservatively 10000)

;; dont run ediff controls in a separate window
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; require confirmation before closing
(setq confirm-kill-emacs 'y-or-n-p)

;; write custom-save-variables to /dev/null
(setq custom-file null-device)

;; don't disable up/down case region functions
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; paste with middle mouse button at cursor rather than mouse
(setq mouse-yank-at-point t)

;; case sensitive search/replace
(setq case-fold-search nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; custom functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; duplicate line and comment it out, bound to C-c C-d
(defun duplicate-line ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-ring-save
   (point)
   (line-end-position))
  (comment-region
   (point)
   (line-end-position))
  (move-end-of-line 1)
  (open-line 1)
  (next-line 1)
  (yank)
  (move-beginning-of-line 1)
  (indent-for-tab-command))

;; move to the next window, bound to C-xn
(defun my-next-window ()
  (interactive)
  (other-window 1))

;; move to the previous window, bound to C-xp
(defun my-previous-window ()
  (interactive)
  (other-window -1))

(defun delete-word (arg)
  (interactive "p")
  (if (use-region-p)
      (delete-region (region-beginning) (region-end))
    (delete-region (point) (progn (forward-word arg) (point)))))

(defun delete-backward-word (arg)
  (interactive "p")
  (delete-word (- arg)))

(defun insert-todo-comment ()
  "Inserts a TODO comment"
  (interactive)
  (comment-indent)
  (indent-for-tab-command)
  (insert "TODO(mts): "))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; key binds
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)
(global-set-key [f1] 'ispell-word)
(global-set-key [f2] 'ispell-buffer)
(global-set-key "\C-xa" 'mark-whole-buffer)
(global-set-key "\C-c\C-d" 'duplicate-line)
(global-set-key "\C-xn" 'my-next-window)
(global-set-key "\C-xp" 'my-previous-window)
(global-set-key "\C-x?" 'help)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-d" 'delete-word)
(global-set-key "\M-h" 'delete-backward-word)
(global-unset-key "\C-xi")
(global-set-key "\C-xit" 'insert-todo-comment)
(global-set-key "\C-xir" 'string-insert-rectangle)
(global-unset-key "\M-k")
(global-unset-key "\M-l")
(global-set-key "\M-j" 'windmove-left)
(global-set-key "\M-k" 'windmove-up)
(global-set-key "\M-l" 'windmove-down)
(global-set-key "\M-;" 'windmove-right)
(global-set-key "\M--"
  (lambda ()
    (interactive)
    (split-window-below)
    (other-window 1)
    (call-interactively #'find-file)))
(global-set-key "\M-\\"
  (lambda ()
    (interactive)
    (split-window-right)
    (other-window 1)
    (call-interactively #'find-file)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; language specific settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; autoselect modes based on file name suffixes
(setq auto-mode-alist (append (list
  (cons "\\.h$" 'c++-mode)
  (cons "\\.hpp$" 'c++-mode)
  (cons "\\.cpp$" 'c++-mode)
  (cons "\\.cxx$" 'c++-mode)
  (cons "\\.c++$" 'c++-mode)
  (cons "\\.cc$" 'c++-mode)
  (cons "\\.html$" 'html-mode)
  (cons "\\.java$" 'java-mode)
  (cons "\\.js$" 'js-mode)
  (cons "\\.jsx$" 'js-mode)
  (cons "\\.css$" 'css-mode)
  (cons "\\.qss$" 'css-mode)
  (cons "\\.ino$" 'arduino-mode)
  (cons "\\.pde$" 'arduino-mode)
  (cons "\\.go$" 'go-mode)
  (cons "\\.todo$" 'org-mode))
  auto-mode-alist))

;; c++ mode
(add-hook 'c++-mode-hook #'(lambda ()
  (local-unset-key "\C-c\C-d")
  (setq c-basic-offset 2)
  (setq fill-column 89)
  ;; indent case statements from switch
  (c-set-offset 'case-label '+)
  ;; dont indent case statement braces
  (c-set-offset 'statement-case-open 0)
  ;; indent preprocessor statements
  (c-set-offset (quote cpp-macro) 0 nil)
  ;; four spaces on constructor initializer list
  (c-set-offset 'member-init-intro 4)
  ;; no indent on parenthesis
  (c-set-offset 'substatement-open 0)))

;; java mode
(add-hook 'java-mode-hook #'(lambda ()
  (setq fill-column 89)
  (setq java-indent-level 2)))

;; html mode
(add-hook 'html-mode-hook #'(lambda ()
  (setq fill-column 89)
  (setq (make-local-variable 'sgml-basic-offset) 2)))

;; javascript mode
(add-hook 'js-mode-hook #'(lambda ()
  (setq fill-column 89)
  (setq js-indent-level 2)))

;; css mode
(add-hook 'css-mode-hook #'(lambda ()
  (setq fill-column 89)
  (setq css-indent-offset 2)))

;; shell script mode
(add-hook 'sh-mode-hook #'(lambda ()
  (setq fill-column 89)
  (setq sh-basic-offset 2)
  (setq sh-indentation 2)))

;; go mode
(add-hook 'go-mode-hook #'(lambda ()
  (local-unset-key "\C-c\C-d")))

;; treemacs mode
(add-hook 'treemacs-mode-hook (lambda ()
  (face-remap-add-relative 'treemacs-hl-line-face nil
                           :background (x-get-resource "background-alt" ""))
  (display-line-numbers-mode 0)))

;; org mode
(add-hook 'org-mode-hook #'(lambda ()
  (local-unset-key "\M-h")
  (local-set-key (kbd "M-p") 'org-metaup)
  (local-set-key (kbd "M-n") 'org-metadown)))

;; start with treemacs workspace if specified
(add-hook 'emacs-startup-hook (lambda ()
  (require 'treemacs)
  (if (getenv "WORKSPACE")
      (progn
        (treemacs-do-switch-workspace (getenv "WORKSPACE"))
        (treemacs-select-window)))))
