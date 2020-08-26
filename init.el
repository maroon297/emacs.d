;; package --- Summary

;;; Commentary:
;;; Added by Package.el.  This must come before configurations of
;;; installed packages.  Don't delete this line.  If you don't want it,
;;; just comment it out by adding a semicolon to the start of the line.
;;; You may delete these explanatory comments.

;;; Code:
(prefer-coding-system 'utf-8-unix)

;; プロセスが出力する文字コードを判定して、process-coding-system の DECODING の設定値を決定する
(setq default-process-coding-system '(undecided-dos . utf-8-unix))

(add-to-list 'load-path "~/.emacs.d/site-lisp")

;;------------------------;;
;;ユーティリティ
;;------------------------;;
;;kill-ring to clipboard
(cond(window-system
  (setq x-select-enable-clipboard t)
 ))

;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;;初期ディレクトリをホームディレクトリに設定
(setq default-directory "~/")
(setq command-line-default-directory "~/")

;;npmの場所設定
(setq exec-path (append exec-path '("/usr/local/bin")))
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))

;; メニューバーを非表示
(menu-bar-mode 0)

;; ツールバーを非表示
(tool-bar-mode 0)

;; C-hをbackspaceに
(global-set-key (kbd "C-h") 'delete-backward-char)

;;カラーテーマ設定

;; フォント設定
;; デフォルト フォント
(set-face-attribute 'default nil :family "Migu 1M" :height 120)
;; プロポーショナル フォント
(set-face-attribute 'variable-pitch nil :family "Migu 1M" :height 120)
;; 等幅フォント
(set-face-attribute 'fixed-pitch nil :family "Migu 1M" :height 120)
;; ツールチップ表示フォント
(set-face-attribute 'tooltip nil :family "Migu 1M" :height 90)

(global-set-key (kbd "<zenkaku-hankaku>") 'toggle-input-method)

;;shellの設定
(setq shell-file-name "/bin/bash")
(setq shell-command-switch "-c")
(setq explicit-shell-file-name shell-file-name)

;;------------------------;;

;; Window表示時のみ、テーマと透過度を設定する
(if window-system
    (progn
	  (load-theme 'misterioso t)
      (set-frame-parameter nil 'alpha 95)
  	  )
)

;; line numberの表示
(require 'linum)
(global-linum-mode 1)

;; tabサイズ
;;(setq tab-width 4)
;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)

;; default scroll bar消去
(scroll-bar-mode -1)

;; 現在ポイントがある関数名をモードラインに表示
(which-function-mode 1)

;; 対応する括弧をハイライト
(show-paren-mode 1)

;; リージョンのハイライト
(transient-mark-mode 1)

;; タイトルにフルパス表示
(setq frame-title-format "%f")

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message 1)

;; ターミナルで起動したときにメニューを表示しない
(if (eq window-system 'x)
    (menu-bar-mode 1) (menu-bar-mode 0))
(menu-bar-mode nil)

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; スクロールは1行ごとに
(setq mouse-wheel-scroll-amount '(1 ((shift) . 5)))

;; スクロールの加速をやめる
(setq mouse-wheel-progressive-speed nil)

;; bufferの最後でカーソルを動かそうとしても音をならなくする
(defun Next-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move arg)
    (end-of-buffer)))

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;; カーソル行をハイライトする
;;(global-hl-line-mode t)

;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)

;; 起動時のフレーム設定
(setq initial-frame-alist
   (append (list
;; 表示位置
      '(top . 0)
      '(left . 0)
;; サイズ
      '(width . 230)  ;横
      '(height . 53)) ;縦
     initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

;;閉じ括弧を自動的に追加
(electric-pair-mode 1)

;;------------------------;;
;;パッケージ設定
;;------------------------;;

(require 'package)

(when (not (assoc "melpa" package-archives))
  (setq package-archives (append '(("stable" . "https://stable.melpa.org/packages/")) package-archives))
  (setq package-archives (append '(("melpa" . "https://melpa.org/packages/")) package-archives))
  (setq package-archives (append '(("gnu" . "https://elpa.gnu.org/packages/")) package-archives)))

(package-initialize)

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; Enable defer and ensure by default for use-package
;; Keep auto-save/backup files separate from source code:  https://github.com/scalameta/metals/issues/1027
(setq use-package-always-defer t
      use-package-always-ensure t
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(use-package counsel
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 30) ;; minibufferのサイズを拡大！（重要）
  (setq ivy-extra-directories nil)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-plus)))
  (setq counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))
  :bind (("M-x" . 'counsel-M-x)
         ("C-x C-f" . 'counsel-find-file)
         )
  )
;;avy
(use-package avy)

;;magit
(use-package magit
  :bind (("C-x g" . 'magit-status))  
  )

(use-package company
  :ensure t
  :config
  (setq company-auto-expand t) ;; 1個目を自動的に補完
  (setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
  (setq company-idle-delay 0) ; 遅延なしにすぐ表示
  (setq company-minimum-prefix-length 2) ; デフォルトは4
  (setq company-selection-wrap-around t) ; 候補の最後の次は先頭に戻る
  (setq completion-ignore-case t)
  (setq company-dabbrev-downcase nil)
  (set-face-attribute 'company-tooltip nil
                      :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common nil
                      :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common-selection nil
                      :foreground "white" :background "steelblue")
  (set-face-attribute 'company-tooltip-selection nil
                      :foreground "black" :background "steelblue")
  (set-face-attribute 'company-preview-common nil
                      :background nil :foreground "lightgrey" :underline t)
  (set-face-attribute 'company-scrollbar-fg nil
                      :background "orange")
  (set-face-attribute 'company-scrollbar-bg nil
                      :background "gray40")
  :bind
  (("C-M-i" . company-complete))
  (:map company-active-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ("C-s" . company-filter-candidates)
        ("C-i" . company-complete-selection)
        ([tab] . company-complete-selection))
  (:map company-search-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous))
  :init
  (global-company-mode t)
  )

(use-package flymake)
(use-package rustic)
(setq rustic-lsp-server 'rust-analyzer)
(setq lsp-rust-analyzer-server-command '("~/.cargo/bin/rust-analyzer"))
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (company lsp-mode magit counsel use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
