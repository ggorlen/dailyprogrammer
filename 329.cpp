// 329: https://www.reddit.com/r/dailyprogrammer/comments/6x77p1/20170831_challenge_329_intermediate_solve_the/

#include <deque>
#include <iostream>
#include <map>
using namespace std;

typedef struct {
    int capacity;
    int water;
} Bucket;

int solve(Bucket *m, Bucket *n, int *l, map<string, int> *seen, deque<pair<int, int>> *path) {
    if (m->water == *l || n->water == *l) {
        return 1;
    }

    string key = to_string(m->water) + " " + to_string(n->water);

    if (seen->find(key) == seen->end()) {
        seen->insert(pair<string, int>(key, 1));
        
        int mPrevWater = m->water;
        int nPrevWater = n->water;

        // fill a bucket with water until it is full
        m->water = m->capacity;

        if (solve(m, n, l, seen, path)) { 
            path->push_front(pair<int, int>(m->capacity, nPrevWater));
            return 1; 
        }

        m->water = mPrevWater;

        n->water = n->capacity;

        if (solve(m, n, l, seen, path)) { 
            path->push_front(pair<int, int>(mPrevWater, n->capacity));
            return 1; 
        }

        n->water = nPrevWater;

        // empty a bucket
        m->water = 0;

        if (solve(m, n, l, seen, path)) { 
            path->push_front(pair<int, int>(0, nPrevWater));
            return 1; 
        }

        m->water = mPrevWater;

        n->water = 0;

        if (solve(m, n, l, seen, path)) { 
            path->push_front(pair<int, int>(mPrevWater, 0));
            return 1; 
        }

        n->water = nPrevWater;

        // transfer water from one bucket into the other until the target bucket is full
        int mGain = m->capacity - m->water;
        int transferAmount = n->water - mGain >= 0 ? mGain : n->water;
        m->water += transferAmount;
        n->water -= transferAmount;

        if (solve(m, n, l, seen, path)) { 
            path->push_front(pair<int, int>(mPrevWater + transferAmount, nPrevWater - transferAmount));
            return 1; 
        }

        m->water -= transferAmount;
        n->water += transferAmount;

        int nGain = n->capacity - n->water;
        transferAmount = m->water - nGain >= 0 ? nGain : m->water;
        m->water -= transferAmount;
        n->water += transferAmount;

        if (solve(m, n, l, seen, path)) { 
            path->push_front(pair<int, int>(mPrevWater - transferAmount, nPrevWater + transferAmount));
            return 1; 
        }

        n->water = nPrevWater;
        m->water += transferAmount;
        n->water -= transferAmount;
    }

    return 0;
}

int main() {
    // 3 5 4
    // 6 16 7
    // 101 317 64
    // 571 317 420
    // 1699 1409 1334
    Bucket m = {1699, 0};
    Bucket n = {1409, 0};
    int l = 1334;

    map<string, int> seen;
    deque<pair<int, int>> path;
    
    if (solve(&m, &n, &l, &seen, &path)) {
        for (auto &p : path) { 
            cout << p.first << ", " << p.second << endl; 
        }
    }
    else {
        cout << "No solution" << endl;
    }
    
    return 0;
}
