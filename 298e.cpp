// 298e: https://www.reddit.com/r/dailyprogrammer/comments/5llkbj/2017012_challenge_298_easy_too_many_parentheses/

#include <iostream>
#include <map>
#include <stack>
#include <sstream>
using namespace std;

string deparenthesize(string s) {
    stringstream ss;
    map<int, int> remove;
    stack<char> stack;

    for (int i = 0; i < s.size(); i++) {
        if (s[i] == '(') {
            stack.push(i);
        }
        else if (s[i] == ')') {
            int match = stack.top();
            stack.pop();

            if (i - match == 1 || i < s.size() - 1 && 
                match > 0 && s[i+1] == ')' && s[match-1] == '(') {
                remove[match] = 1;
                remove[i] = 1;
            }
        }
    }
    
    for (int i = 0; i < s.size(); i++) {
        if (remove.find(i) == remove.end()) {
            ss << s[i];
        }
    }

    return ss.str();
}

int main() {
    string tests[][2] = {
        {"(((3)))", "(3)"},
        {"((a((bc)(de)))f)", "((a((bc)(de)))f)"}, 
        {"(((zbcd)(((e)fg))))", "((zbcd)((e)fg))"},
        {"ab((c))", "ab(c)"},
        {"()", ""},
        {"((fgh()()()))", "(fgh)"},
        {"()(abc())", "(abc)"}
    };

    for (auto &t : tests) {
        string res = deparenthesize(t[0]);

        if (res == t[1]) {
            cout << t[0] << " --> " << res << endl;
        }
        else {
            cout << "error: " << t[0] << " --> " << res << " but should have been " << t[1] << endl;
            exit(1);
        }
    }

    return 0;
}
