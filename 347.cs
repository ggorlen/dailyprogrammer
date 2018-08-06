// 347: https://www.reddit.com/r/dailyprogrammer/comments/7qn07r/20180115_challenge_347_easy_how_long_has_the/

using System;
using System.Collections.Generic;

class Range {
    public int start;
    public int end;

    public Range(int start, int end) {
        this.start = start;
        this.end = end;
    }
}

class Solution {
    public static void Main(string[] args) {
        string[] input = {
            "1 3\n2 3\n4 5",
            "2 4\n3 6\n1 3\n6 8",
            "6 8\n5 8\n8 9\n5 7\n4 7",
            "15 18\n13 16\n9 12\n3 4\n17 20\n9 11\n17 18\n4 5\n5 6\n4 5\n5 6\n13 16\n2 3\n15 17\n13 14"
        };

        foreach (var test in input) {
            Console.WriteLine(LightDuration(test));
        }
    }
    
    static int LightDuration(string test) {
        List<Range> ranges = new List<Range>();
        
        foreach (string s in test.Split('\n')) {
            string[] r = s.Split(' ');
            ranges.Add(new Range(Convert.ToInt32(r[0]), Convert.ToInt32(r[1])));
        }
        
        ranges.Sort((a, b) => a.start - b.start);
        int total = 0;
        int start = ranges[0].start;
        int end = ranges[0].end;
        
        foreach (Range r in ranges) {
            if (r.start > end) {
                total += end - start;
                start = r.start;
                end = r.end;
            }
            else if (r.end > end) {
                end = r.end;
            }
        }
        
        return total + end - start;
    }

    static int LightDuration2(string test) {
        var occupied = new HashSet<int>();
        
        foreach (string s in test.Split('\n')) {
            string[] r = s.Split(' ');

            for (int i = Convert.ToInt32(r[0]); i < Convert.ToInt32(r[1]); i++) {
                occupied.Add(i);
            }
        }

        return occupied.Count;
    }
}
