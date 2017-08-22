{
	split($0, a, /:/)
	file=a[2]
	n = split(a[1], b, / /)
	for (i=1; i<= n; i++) {
		sum[i] = sum[i] + $i
	}
}
END {
	for (i=1; i<=n; i++) {
		printf("%10.2f ", sum[i])
	}
	print "total"
}
