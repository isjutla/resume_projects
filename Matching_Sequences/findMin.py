from sys import stdin
import json
from bisect import *
# Revision: 1.000
# Python Version: 2.7.8
# Date: 8/1/2014
# Author: Inderjit Jutla
# Use: as example code
#
# Summary: in this problem we know we have n bits of data, index starting at 0.
# But we're given random intervals of the data, and we need to find
# the best set of intervals whose union is all bits. Our constraint
# is that reading an interval takes time, with an associated bitrate 'b'.
# But each packet also has cost no matter the size: the latency 'a'. We want.
# We want to minimize the cost of getting all the bits of the data. As in
# the set of packets that will take the lowest time to read.
# The data is read in from stdin as follows:
# n
# a
# b
# total # of packets
# (x,y)
# (v,w)
# etc...
# Where (x,y) for example is a packet from x to y, x included,
# y not included.
#
# The algorithm is a dynamic algorithm. The given problem
# consists of connecting overlapping regions. We need to
# overlap regions until we have a complete set of data from
# 0 to n. Say (k,n) is the last packet we use in the optimal
# solution. Then we know that there must be a packet that ends
# between [k,n) connecting to it. We only need to find the most
# optimal (lowest time) set of packets that ends at [k,n) because
# all costs associated with packet (k,n) itself is constant.
#
# Thus if T(x_i) is the optimal cost that connects all the bits
# to x, using packet (i,x) Then T(x_i) = min(T(k) + 2*L + B(x_i)/b).
# For all k where k is all the packets that end within the range of x_i.
# B(x_i) is the length of packet x_i and b is the bitrate. L is the latency.
# We examine all packets that end at x. To find the global
# optimum solution for a packet that ends at x. Since the problem can
# be built up from packets that end at low values. I start with the lowest
# end points. Initializing T(0) to 0.
#
# This implementation makes things easier by encoding the original data
# into a dictionary where the key is a unique end of the set of packets,
# and the value is all the associated (unique) starting points. Reading in the
# data takes O(n) time initially, and then putting the data into the
# dictionary takes O(n^2) time since I check for duplicate starting
# points: each time I check takes time proportional to the size of the
# array and since the array grows => summation 1 to n => O(n^2). I
# could have reduced this complexity by not checking for duplicates but
# for data with a lot of duplicates, the time will carry over to my algorithm.
# So I chose to removed duplicates. Appending to the end of a list takes O(1)
# time in python. Sorting the data of course takes O(nlogn)
#
# The algorithm itself contains 3 for loops. The 2 outer for loops simply
# go over all the (unique) set of packets => n. Then the final inner
# loop examines all the packets that end within the range of the packet
# being examined. Best case would be packets that have very small ranges,
# where the runtime would approach O(n). Worst case would be packets with
# very large ranges where the runtime of the inner loop would grow as the
# packet ends increase => 1 + 2 +... n => O(n^2). Thus the overall runtime
# will be O(n^2)


def findMin(end_dict=[], var=[1, 1, 1, 1]):
    """Main algorithm for solving problem
    input 'end_dict': dictionary where keys are the unique packet end points
    and value is a list of associated starting points
    @input 'var': [n, size cost, constant cost, #of packets]
    @output: min time to download data of size var[0] rounded to 3 decimals
    also prints out this time (if it exists) rounded to 3 decimals
    """

    times = {}
    times[0] = float(0)
    ends = end_dict.keys()
    ends.sort()

    for elem in ends:
        times[elem] = float("inf")
        right = bisect(ends, elem)
        for ii in end_dict[elem]:
            if(ii == 0):  # for any n, the best solution will always be (0,n)
                times[elem] = float(elem)/var[2] + 2*var[1]
            else:
                ii_const = float(elem - ii)/var[2]+2*var[1]
                for j in range(bisect_left(ends, ii), bisect_left(ends, elem)):
                    j_const = ii_const + times[ends[j]]
                    if(j_const < times[elem]):
                        times[elem] = j_const

    if((var[0] in times) and (times[var[0]] != float("inf"))):
        print '{0:.3f}'.format(times[var[0]])
        return(round(times[var[0]], 3))
    else:
        return(-1)


def processData(data=[]):
    """Processes intial data in dictionary of unique ends
    @input 'data': list of 2-tuples where each 2 tuple is
    a packet (a,b)
    @output: dictionary where keys are the unique packet end points
    and value is a list of associated starting points
    """

    end_dict = {}
    for i in data:
        end_dict[i[1]] = []
    for i in data:
        if i[0] not in end_dict[i[1]]:
            end_dict[i[1]].append(i[0])
    return(end_dict)


def processFile(filename):
    """Runs algorithm bases on file, used for unit testing
    @input 'filename': relative path of file, string
    @output: minimum time as specified by algorithm, rounded to 3 decimals
    """

    f = open(filename, 'r')
    var = []
    data = []
    for x in range(4):
        var.append(int(f.readline()))
    for temp in f:
        data.append(json.loads('['+temp+']'))
    return(findMin(processData(data), var))

if __name__ == "__main__":
    """main, returns min time based on stdin input"""
    f = stdin
    var = []
    data = []
    for x in range(4):
        var.append(int(f.readline()))
    for temp in f:
        data.append(json.loads('[' + temp + ']'))
    findMin(processData(data), var)
