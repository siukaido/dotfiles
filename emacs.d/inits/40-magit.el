(eval-after-load 'magit
  '(progn
     ;; 文字色変更
     (set-face-foreground 'magit-diff-file-header "#00FFFF") ; Diffのファイル名部分
     (set-face-foreground 'magit-diff-hunk-header "#00AADD") ; Diffのhunk部分
     (set-face-foreground 'magit-section-title    "#FF00FF") ; 見出し部分
     (set-face-foreground 'magit-diff-add         "#00FF00") ; 追加行
     (set-face-foreground 'magit-diff-del         "#FF0000") ; 削除行

     ;; 背景色変更
     (set-face-background 'magit-diff-file-header "blue")    ; Diffのファイル名部分
     (set-face-background 'magit-diff-hunk-header "#000000") ; Diffのhunk部分
     (set-face-background 'magit-section-title    "#000000") ; 見出し部分
     (set-face-background 'magit-diff-add         "#000000") ; 追加行
     (set-face-background 'magit-diff-del         "#000000") ; 削除行

     (setq magit-diff-refine-hunk 'all)
     (set-face-background 'magit-item-highlight "#000000")
))
