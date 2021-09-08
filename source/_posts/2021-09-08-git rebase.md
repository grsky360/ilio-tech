---
title: git rebase
# tag: 面试
reward: true
---

## git rebase
<!-- more -->

比如你的分支是dev, 你要拉master
rebase的话, 相当于基于master, 一个一个cherry-pick dev比master多出来的commit
如果某个或者某几个cherry-pick有冲突, 需要每个cherry-pick单独来解决
如果用merge的话, 只需要解决一次就行了