---
title: git rebase
# tag: 面试
reward: true
---

## git rebase

### 1. Commands
```
p, pick <提交> = 使用提交 
r, reword <提交> = 使用提交，但编辑提交说明 
e, edit <提交> = 使用提交，但停止以便在 shell 中修补提交 
s, squash <提交> = 使用提交，但挤压到前一个提交 
f, fixup [-C | -c] <提交> = 类似于 "squash"，但只保留前一个提交 
                   的提交说明，除非使用了 -C 参数，此情况下则只 
                   保留本提交说明。使用 -c 和 -C 类似，但会打开 
                   编辑器修改提交说明 
x, exec <命令> = 使用 shell 运行命令（此行剩余部分） 
b, break = 在此处停止（使用 'git rebase --continue' 继续变基） 
d, drop <提交> = 删除提交 
l, label <label> = 为当前 HEAD 打上标记 
t, reset <label> = 重置 HEAD 到该标记 
m, merge [-C <commit> | -c <commit>] <label> [# <oneline>] 
.       创建一个合并提交，并使用原始的合并提交说明（如果没有指定 
.       原始提交，使用注释部分的 oneline 作为提交说明）。使用 
.       -c <提交> 可以编辑提交说明。
```

### 2. 中断
就是需要手动执行 git rebase --continue
仅在中断状态下, 可以执行git rebase --abort来退出rebase操作, 会恢复到rebase之前的状态
以下两种常见的场景场景会出现中断
1. edit command
2. 出现冲突

#### 2.1 edit command
常见于修改指定commit的内容
修改完成之后需要git add, 此时可以有两种操作
1. git commit --amend, 会把刚才的改动合到当前commit里, 此时还是处于edit状态, 可以继续改代码, commit --amend, 也可以执行rebase --continue结束当前commit的操作
2. git rebase --continue, 自动执行commit --amend, 并且结束当前commit的操作, 进到下一个commit或者结束rebase

#### 2.2 出现冲突
常见于
1. 合并分支
2. 使用edit改了上一个commit的内容, 到了下一个commit的时候, 和刚才修改的内容发生冲突
解决办法和merge/pull出现冲突是一样的
解决好冲突之后, 确保执行了git add, 然后git rebase --continue

### Reference
https://www.golinuxcloud.com/git-rebase/

https://git-scm.com/book/en/v2/Git-Branching-Rebasing
