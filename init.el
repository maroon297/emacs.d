;;; package --- Summary

;;; Commentary:
;;; Added by Package.el.  This must come before configurations of
;;; installed packages.  Don't delete this line.  If you don't want it,
;;; just comment it out by adding a semicolon to the start of the line.
;;; You may delete these explanatory comments.

;;; Code:
(prefer-coding-system 'utf-8)

(package-initialize)

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
(add-to-list 'default-frame-alist '(font . "Cica"))

;; Japanese font
 (set-fontset-font t 'japanese-jisx0208 (font-spec :family "IPAGothic"))

(global-set-key (kbd "<zenkaku-hankaku>") 'toggle-input-method)

(package-initialize)

(add-to-list 'load-path "~/.emacs.d/site-lisp")

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
(defun next-line (arg)
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
;;(setq initial-frame-alist
;;   (append (list
;; 表示位置
;;      '(top . 0)
;;      '(left . 0)
;; サイズ
;;      '(width . 150)  ;横
;;      '(height . 60)) ;縦
;;     initial-frame-alist))
;;(setq default-frame-alist initial-frame-alist)

;;閉じ括弧を自動的に追加
(electric-pair-mode 1)

;; El-Get設定
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;async設定(Helmにいる？)
;(el-get-bundle async)

;;Helm設定
(el-get-bundle helm)
(require 'helm-config)
(helm-mode 1)

;;helm-miniキーマップ
(global-set-key (kbd "C-c h") 'helm-mini)

;;M-xをhelm-M-xに
(global-set-key (kbd "M-x") 'helm-M-x)

;;キルリングを表示する
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;;helm-find-files
(global-set-key (kbd "C-x C-f") 'helm-find-files)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (company graphql magit-popup async))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; neotree をインストールする
(el-get-bundle neotree)
;; F8でnetreee-windowが開くようにする
(global-set-key [f8] 'neotree-toggle)

;;company
(el-get-bundle company-mode/company-mode)
(with-eval-after-load 'company
      (setq company-auto-expand t) ;; 1個目を自動的に補完
      (setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
      (setq company-idle-delay 0) ; 遅延なしにすぐ表示
      (setq company-minimum-prefix-length 2) ; デフォルトは4
      (setq company-selection-wrap-around t) ; 候補の最後の次は先頭に戻る
      (setq completion-ignore-case t)
      (setq company-dabbrev-downcase nil)
      (global-set-key (kbd "C-M-i") 'company-complete)
      ;; C-n, C-pで補完候補を次/前の候補を選択
      (define-key company-active-map (kbd "C-n") 'company-select-next)
      (define-key company-active-map (kbd "C-p") 'company-select-previous)
      (define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
      (define-key company-active-map (kbd "C-h") nil) ;; C-hはバックスペース割当のため無効化
      (define-key company-active-map (kbd "C-S-h") 'company-show-doc-buffer) ;; ドキュメント表示はC-Shift-h

      ;; 未選択項目
      (set-face-attribute 'company-tooltip nil
                  :foreground "#36c6b0" :background "#244f36")
      ;; 未選択項目&一致文字
      (set-face-attribute 'company-tooltip-common nil
                    :foreground "white" :background "#244f36")
      ;; 選択項目
      (set-face-attribute 'company-tooltip-selection nil
                  :foreground "#a1ffcd" :background "#007771")
      ;; 選択項目&一致文字
      (set-face-attribute 'company-tooltip-common-selection nil
                    :foreground "white" :background "#007771")
      ;; スクロールバー
      (set-face-attribute 'company-scrollbar-fg nil
                  :background "#4cd0c1")
      ;; スクロールバー背景
      (set-face-attribute 'company-scrollbar-bg nil
                  :background "#002b37")
      )
;;fly-check
(el-get-bundle flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;;PlantUML設定
(el-get-bundle plantuml-mode)
;; plantuml.jar の path を設定
(setq org-plantuml-jar-path "~/.emacs.d/plantuml.jar")
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
(add-to-list 'auto-mode-alist '("\\.pu\\'" . plantuml-mode))
(setq plantuml-options "-charset UTF-8")
			 
;;ensime
(el-get-bundle ensime)
(require 'ensime)
(setq ensime-startup-notification nil)

(el-get-bundle markdown-mode)
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

;; markdownのコマンドのパス追加
(setq markdown-command "jq --slurp --raw-input '{\"text\": \"\\(.)\", \"mode\": \"gfm\"}' | curl -sS --data @- https://api.github.com/markdown")

;;helm-gtags
(el-get-bundle helm-gtags)

;;html live preview
(el-get-bundle skeeto/impatient-mode)
(el-get-bundle skeeto/emacs-web-server)
(el-get-bundle htmlize)

;########################################
; web-mode setting
;#######################################

(el-get-bundle fxbois/web-mode)
(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))

(defun web-mode-hook ()
  "Hooks for Web mode."

  ;; indent
  (setq web-mode-html-offset   2)
  (setq web-mode-style-padding 2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2)
  (setq web-mode-markup-indent-offset 2)

  (local-set-key (kbd "C-m") 'newline-and-indent)
  
  ;; auto tag closing
  ;0=no auto-closing
  ;1=auto-close with </
  ;2=auto-close with > and </
  (setq web-mode-tag-auto-close-style 2)
)
(add-hook 'web-mode-hook 'web-mode-hook)

;;mozc
(require 'mozc)  ; or (load-file "/path/to/mozc.el")
(setq default-input-method "japanese-mozc")
(setq mozc-candidate-style 'overlay)

;; magit
(el-get-bundle magit/transient)
(el-get-bundle magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; vue-mode
(el-get-bundle mmm-mode)
(el-get-bundle AdamNiederer/vue-mode)
(el-get-bundle AdamNiederer/vue-html-mode)
(el-get-bundle AdamNiederer/ssass-mode)
(el-get-bundle Fanael/edit-indirect)
(el-get-bundle codesuki/add-node-modules-path)
(require 'flycheck)
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
(eval-after-load 'vue-mode
  '(add-hook 'vue-mode-hook #'add-node-modules-path))
(flycheck-add-mode 'javascript-eslint 'vue-mode)
(flycheck-add-mode 'javascript-eslint 'vue-html-mode)
(flycheck-add-mode 'javascript-eslint 'css-mode)
(add-hook 'vue-mode-hook 'flycheck-mode)

;;; init.el ends here

