BEGIN {

		print "/* ------------coffee.awk--------- */"
		print "         "
}

function forloop(localvar){
		if($7 == "{"){
				localvar=" {"
				}
		if($5 == "->"){
		print "for (int " $2 " = " $4 "; " $2 " < " $6 "; " $2 "++)" localvar
        }
}

{
		if($1 == "for"){
				forloop()
        }
		else{
				print $0
        }

}

				
