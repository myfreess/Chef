### Coffee.awk

我看到很多CProgram示例中的for循环是这样:

```c
for(int i=0; i < 10; i++) {
     <body>
}
```

而Python是这样:

```c
for i in range(0, 10):
....<body>
```

coffee.awk可以对C做一个等效转换，让C的for写成这样:

```
for i in 0 -> 10 {
   <body>
}
```

当然了，大括号换行也没问题。不过说到实用性……完全没有。
