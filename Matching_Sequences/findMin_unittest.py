import random
import unittest
from findMin import *
# Revision: 1.000
# Python Version: 2.7.8
# Date: 8/1/2014
# Author: Inderjit Jutla
# Use: Unit test for Counsyl interview algorithm
#
# Summary: used for unit testing the algorith in findMin


class findMin_unittest(unittest.TestCase):

    def test_counsyl000(self):
        """Tests Counsyl dataset 000"""
        filename = 'test_cases/input000.txt'
        self.assertEqual(processFile(filename), float(340))

    def test_counsyl001(self):
        """Tests Counsyl dataset 001"""
        filename = 'test_cases/input001.txt'
        self.assertEqual(processFile(filename), float(260))

    def test_easy_solution(self):
        """Tests a simple custom data set"""
        filename = 'test_cases/test000.txt'
        self.assertEqual(processFile(filename), float(2000)/10 + 2*5)

    def test_high_fastTransfer(self):
        """Tests data set with very fast transfer time"""
        filename = 'test_cases/test001.txt'
        self.assertEqual(processFile(filename), float(22)/40 + 2*1*2)

    def test_tricky(self):
        """Tests data set with lots of overlap and redundancy"""
        filename = 'test_cases/test002.txt'
        self.assertEqual(processFile(filename), float(9+1+10)/40 + 2*1*3)

    def test_no_solution(self):
        """Tests simple data set with a single missing link"""
        filename = 'test_cases/test003.txt'
        self.assertEqual(processFile(filename), -1)

    def test_long(self):
        """Tests long data set with many duplicates of all packets, except 2"""
        filename = 'test_cases/test004.txt'
        self.assertEqual(processFile(filename), 20.0/5 + 2*20*5)

    def test_overlaps(self):
        """Tests custom dataset with large overlaps"""
        filename = 'test_cases/test005.txt'
        self.assertEqual(processFile(filename), 500)

    def test_process(self):
        """Tests dictionary data processing with only unique packets"""
        data = []
        for i in range(0, 1000, 2):
            data.append((i, i+1))
        end_dict = processData(data)
        self.assertEquals(len(end_dict.keys()), 500)

    def test_process(self):
        """Tests dictionary data processing with only 1 unique packets"""
        data = []
        for i in range(0, 1000, 1):
            data.append((0, 500))
        end_dict = processData(data)
        self.assertEquals(len(end_dict.keys()), 1)

if __name__ == '__main__':
    unittest.main()
