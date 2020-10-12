require_relative "./tree_node.rb"
require 'byebug'

class KnightPathFinder
    DIRS = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[-1,2],[1,-2],[-1,-2]]

    attr_accessor :position, :considered_pos, :root_node

    def initialize(position)
        @root_node = PolyTreeNode.new(position)
        @considered_pos = [position] 
        build_move_tree
    end


    def self.valid_moves(pos)
        valid_pos_arr = []

        DIRS.each do |dir|
            dx, dy = dir 
            new_pos = [pos[0] + dx, pos[1] + dy] 
           if new_pos.all? { |pos| pos.between?(0,7)}
            valid_pos_arr << new_pos
           end
        end
        valid_pos_arr
    end
    
    def new_move_positions(pos) #[2,1]
        
        valid = KnightPathFinder.valid_moves(pos) #[4,2]

        new_moves = valid.select{|pos| !@considered_pos.include?(pos)}
        @considered_pos += new_moves
        new_moves
    end

    def build_move_tree

        queue = [root_node] 

        until queue.empty?
            current = queue.shift
            new_pos = new_move_positions(current.value)  #get new moves from the current node's value
            new_pos.each do |pos| #iterate through the new_pos arr
                child_node = PolyTreeNode.new(pos) #create a new node for every new position
                # child_node.parent = current # can do this or add child 
                current.add_child(child_node)
                queue << child_node #shovel in each new child node
            end
        end
        root_node
    end

    def find_path(end_pos)
        trace_path_back(root_node.dfs(end_pos))
    end

    def trace_path_back(end_node)
        #find parent value and add into an array 
        res = [] #[3,3]
        current = end_node
        until current.nil?
            res.unshift(current.value)
            current = current.parent
        end
        res
    end

end


knight = KnightPathFinder.new([0,0])

p knight.find_path([7, 6]) #[0,0],[1,2],[3,3]
# p knight.build_move_tree
p knight.find_path([6, 2])
# p knight.trace_path_back([3, 3])

# 0 1 2 3 4 5 6 7
#[_,_,_,_,_,_,_,_] 0
#[_,_,_,_,_,_,_,_] 1
#[_,_,_,_,_,_,_,_] 2
#[_,_,_,_,_,_,_,_] 3
#[_,_,_,_,_,_,_,_] 4 
#[_,_,_,_,_,_,_,_] 5
#[_,_,_,_,_,_,_,_] 6
#[_,_,_,_,_,_,_,_] 7


#check the length of considered positions array for build move tree (the length needs to be 64).uniq