# contanrtDemo
  这是一个创建联系人的demo
  关于这个demo，唯一存在的问题是初始化运行是加载联系人的数据太慢，这会让用户感觉太突兀了，加载页面不是很有好，我曾
尝试过修改indexContacter这个函数，让遍历的速度更快一点，但是我还是，经过多的修改，我发现速度还是只能提高到3到4秒左右，
现在demo的速度是在大约5秒中左右加载出页面数据，当然这是我个人的通讯录，数据大约在100条左右，这样的性能完全不符合我的
预期的，但是我也没找到好的方法，希望以后在有更多经验的时候，来重新考量这个demo。
  这个demo利用的是iOS9的新特性CNContact来读取手机通讯录中的数据，功能上比较简单。用来显示一个通讯录，并在上面添加索引。
基本的UI设计是参考了系统自带的UI设计方案。利用CNContact中查到的数据，在利用26个英文字母重现构件一个新的二维数组，使得
能够进行索引（但这也成了上面出现问题的所在点）。在设计details的时候，由于思维走入了误区，一开始没有用tableView来显示
不同号码，而是用一种比较繁琐的方法（利用代码去生成UI，如果没有这个好嘛，就不生成，有多个就生成多个。虽然实现功能，但是
在UI布局上非常的繁琐，而且无法实现电话号码与所按下的button相联系，导致不能正常的拨号。）其实这个demo总花费的时间只有1个
礼拜左右，但由于思维的出错和一开始设计时没有考虑周全，还有其他的事情的延误，个人的情绪上的问题都是导致，这个话费1个月的
原因。
  我可能还会用一段时间进行完善这个demo。
