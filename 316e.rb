# 316e: https://www.reddit.com/r/dailyprogrammer/comments/6coqwk/20170522_challenge_316_easy_knights_metric/

def solve d_x, d_y
  moves = [
    [-1, -2], [1, -2], [-1, 2], [1, 2],
    [-2, -1], [2, -1], [-2, 1], [2, 1]
  ]
  visited = {{:x => 0, :y => 0} => nil}
  q = [{:x => 0, :y => 0}]

  until q.empty?
    curr = q.shift
  
    if curr[:x] == d_x && curr[:y] == d_y
      path = []

      while visited[curr]
        path << curr
        curr = visited[curr]
      end
        
      return path.reverse
    end

    moves.each do |move|
      next_position = {:x => curr[:x] + move[0], :y => curr[:y] + move[1]}
      
      if !visited.key? next_position
        visited[next_position] = curr
        q << next_position
      end
    end
  end
end

soln = solve 3, 7
puts soln
puts soln.size
