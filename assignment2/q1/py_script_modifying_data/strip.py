#!/usr/bin/python

import sys 
for l in sys.stdin: 
	l = l.split(',')
	l = map(str.strip, l ) 
	if l[-1] == 'ad.' : 
		l[-1] = '1'
	else : 
		l[-1] = '-1'
	l = reduce(lambda a ,b : a + ' ' + b , l , '') 
	print l 

