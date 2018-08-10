// 346e: https://www.reddit.com/r/dailyprogrammer/comments/7p5p2o/20180108_challenge_346_easy_cryptarithmetic_solver/

"use strict";

const digitize = (mapping, word) => +word.map(e => mapping[e]).join("");

const solved = (mapping, ops, sum, letters) => 
  mapping[sum[0]] && 
  ops.every(e => mapping[e[0]]) && 
  letters.every(e => mapping[e] !== null) &&
  ops.reduce(
    (a, e) => a + digitize(mapping, e), 0
  ) === digitize(mapping, sum)
;

const solve = (mapping, ops, sum, letters, i, used) => {
  if (i < letters.length) {
    for (let j = 0; j <= 9; j++) {
      if (!used[j]) { 
        used[j] = 1;
        mapping[letters[i]] = j;
        
        if (solved(mapping, ops, sum, letters) || 
            solve(mapping, ops, sum, letters, i + 1, used)) {
          return mapping; 
        }

        used[j] = 0;
        mapping[letters[i]] = null;
      }
    }
  }
};

const cryptarithms = [
  "WHAT + WAS + THY == CAUSE",
  "HIS + HORSE + IS == SLAIN",
  "HERE + SHE == COMES",
  "FOR + LACK + OF == TREAD",
  "I + WILL + PAY + THE == THEFT"
];

cryptarithms.forEach(e => {
  const s = e.split(/\W+/);
  const mapping = s.reduce((a, e) => {
    e.split("").forEach(c => a[c] = 0);
    return a;
  }, {});
  let [sum, ...ops] = s.reverse();
  sum = sum.split("");
  ops = ops.map(e => e.split(""));
  const letters = Array.from(new Set(e.split("").filter(e => e.match(/[A-Z]/))));
  const soln = solve(mapping, ops, sum, letters, 0, Array(10).fill(null));
  
  if (soln) {
    console.log(
      `${e}\n{${Object.keys(soln).sort().map(e => `"${e}"=>${soln[e]}`).join(", ")}}\n`
    ); 
  }
  else {
    console.log(`${e} has no solution\n`);
  }
});
