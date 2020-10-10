require_relative "./tree_node.rb"

class KnightPathFinder
    DIRS = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[-1,2],[1,-2],[-1.-2]]


    def initialize(position)
        @position = position
    end

    def self.root_node
        PolyTreeNode.new([0,0])
    end


    def self.valid_moves(pos)
        valid_pos_arr = []

        DIRS.each do |dir|
            dx, dy = dir #x = 2 y = 1
            new_pos = [pos[0] + dx, pos[1] + dy]  #new x position  #result of taking pos and adding increment of dirs
           if new_pos.all? { |pos| pos.between?(0,7)}
            valid_pos_arr << new_pos
           end
        end
        valid_pos_arr
    end

    def new_move_positions(pos) #[0,0]
        #new move position will call this and put the pos in valid position if its not alredy there USE SELECT!!!!!!!!
        # @considered_pos = [[2,1]]
        consider_pos = DIRS.select { |pos| KnightPathFinder.valid_moves(pos) }
    end
end




p knight = KnightPathFinder.root_node
p KnightPathFinder.valid_moves()

# 0 1 2 3 4 5 6 7
#[_,_,_,_,_,_,_,_] 0
#[_,_,_,_,_,_,_,_] 1
#[_,_,_,_,_,_,_,_] 2
#[_,_,_,_,_,_,_,_] 3
#[_,_,_,_,_,_,_,_] 4 
#[_,_,_,_,_,_,_,_] 5
#[_,_,_,_,_,_,_,_] 6
#[_,_,_,_,_,_,_,_] 7