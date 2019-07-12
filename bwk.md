<h1 align="center">bwk</h1>

Awk写的brainfuck实现。~`,`未实现~(有实现了但不安全)且`.`只能打印当前字节的数字而非ASCII符号。

测试结果:

```
awk -f brainfuck.awk
location[0]: ++++++ [ > ++++++++++ < - ] > +++++ .
65 #正是ASCII符号'A'!
location[1]:
```
