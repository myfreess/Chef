BEGIN {
LOCAL=0 #定纸带头于纸带开头(#･∀･)
#定纸带长为100
for(i=0;i<100;i++){
TAPE[i]=0
}
#循环点数为0
Loop[count]=i
i=0 #i留着给实现循环用
printf "location[%d]: ", LOCAL
}

###eval主体
###########
# <	纸带头左移
# >	纸带头右移
# + 指针指向的字节的值加一（当前单元的数值+1）
# - 指针指向的字节的值减一（当前单元的数值-1）
# ,	输入内容到指针指向的单元（输入一个字符，将其ASCII码保存到当前指针所指单元）
# .	将指针指向的存储单元的内容作为字符输出（将ASCII码输出为字符）
# [	如果当前指针指向的存储单元为零，向后跳转到对应的 ] 指令处
# ]	如果当前指针指向的存储单元不为零，向前跳转到对应的 [ 指令处
function eval(cmd, localvar){
#printf "cmd: %s\n", cmd
if(cmd=="+"){
chnum(1)
} else if(cmd=="-"){
chnum(-1)
} else if(cmd==">"){
move(1)
} else if(cmd=="<"){
move(-1)
} else if(cmd=="."){
print TAPE[LOCAL]
} else if(cmd==","){
printf "> "
getline localvar
if(localvar<256&&localvar>-1){
chnum(localvar)
}}

else{
print "Fault"
}
###结束
}
###eval结束
###########

function move(i){
if(LOCAL+i<100&&LOCAL+i>-1){
LOCAL = LOCAL + i
} else{
print "False"
}
}
###Move around
##############


####处理命令列表
function task_proc(cmd_str, p, tmpstr,len){
len=length(cmd_str)
#printf "len: %s\n", len
#printf "cmd_str: %s\n", cmd_str
for(p=1;p<len+1;p++){
tmpstr=substr(cmd_str, p, 1)
#太TMD疯狂了!
#在awk中用substr()取出字符串的第一个字符，应用下标1，但是下标用0也可以取到第一个字符!!
###好吧，我不该带来那种字符串是Array的思想
#print p
#printf "tmp: %s\n", tmpstr
if(tmpstr==" "){
printf ""
} else if(tmpstr=="["){
i++
Loop[count]=i #存档总个数
Loop[i]=p #循环开始位置
if(TAPE[LOCAL]==0){
p+=index(substr(cmd_str,p+1,length(cmd_str )-p), "]")
}} else if(tmpstr=="]"){
if(TAPE[LOCAL]!=0){
#调用最近的存档
p=Loop[i]
} else{
#若为0则结束循环，并删档
delete Loop[i]
i--
Loop[count]=i
}} else{
eval(tmpstr)
}}}




function chnum(j, tmpnum){
tmpnum=j+TAPE[LOCAL]
if(tmpnum>255){
TAPE[LOCAL]=tmpnum-256
} else if(tmpnum<0){
TAPE[LOCAL]=tmpnum+256
} else{
TAPE[LOCAL]=tmpnum}
}



###进入read eval print loop
###########################

{task_proc($0)


printf "location[%d]: ", LOCAL
}

