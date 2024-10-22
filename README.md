# legend 传奇

`Legend` is a very interesting project where you can input your birth-year and province/state, and it will calculate your virtual but reasonable remaining lifetime in days, hours, minutes, and seconds.  
`传说`是一个非常有趣的项目，您可以输入您的出生年份和省份/州，它会计算您的虚拟但合理的剩余寿命，以天、小时、分钟和秒为单位。

## High-Priority TO-DO 

- [x] 加两个按钮，用于测试函数
  
- [x] 创建一个配置文件的软链接(便于版本管理)
  
- [ ] Load 当前配置,然后保存配置
  
- [ ] 重置 `randomseed_sec` 并写入配置
  
    
  


## TO-DO

- [ ] 一个新页面来创建/保存用户信息(随机数一年内只允许变一次,自己要说的话，还有随机数可以随之而变

- [ ] 程序启动的时候，Load Config 读取用户数据即可

- [ ] 广西: 82.34(女) 74.31(男)  还要取一个 正负2年(365天 \* 2 的上下限,按秒随机)的随机数(第一次创建后就持久化)
    365 \* 2 \* 24 \* 3600 = 0 ~ 63072000 的随机数，减一年然后加上这个随机数,并且这个随机数，每年都会变一次 (如果超过预定年-2年的这个寿命最小值，则随机数为从当前时间起+1年后的4年的随机数)

- [ ] 个人信息初始化、持久化(出生年月、省份),第一次本地注册的时候随机数也一同产生并持久化到 ... 本地sqlite/json 之类的配置文件来保存 (未来可以扩展到联网存到统一的数据库去)

- [ ] 重构~>页面独立出来

- [ ] 背景图: 地球一粒沙子 / 流星划过 ...

- [ ] 个人信息初始化、持久化(出生年月、省份),第一次本地注册的时候随机数也一同产生并持久化...

- [ ] 本地sqlite/json 之类的存，但是未来可以扩展到联网存到统一的数据库去

- [ ] OpenSource

- [ ] 多语言支持  ...  简繁中/英/日  ...

- [ ] Free. 且所有数据离线存本地(不联网,不索取...网络权限)

- [ ] 你想对你自己说的一两句话

    (随机显示出来, 或者按照排序显示,每年只能说一次? 从当前发出时间后算起1年内不准修改)

- [ ] 多用户使用

- [ ] 所有数据离线存本地(不联网,不索取...网络权限)



## MISC

配置文件位置:
`/Users/<user_name>/Library/Containers/com.example.legend/Data/config.yaml`



--------------------------------

## 参考/来源

- [平均年龄数据来源](https://zh.wikipedia.org/zh-hans/中华人民共和国各省级行政区预期寿命列表)
