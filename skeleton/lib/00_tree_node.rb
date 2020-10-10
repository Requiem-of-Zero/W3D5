require 'byebug'
class PolyTreeNode

    attr_reader :value, :children, :parent

    def initialize(value, parent=nil, children=[])
        @parent = parent
        @children = children
        @value = value
    end

    #parent = (current node)

    #new node aka new parent

    def parent=(new_node)
        if @parent == nil  #never had a parent
            @parent = new_node
            @parent.children << self
        elsif new_node == nil #our new parent is nil // there is no parent for us :(
            @parent = nil
        else                    #we had a parent but now were getting a new one 
            @parent.children.delete(self)
            @parent = new_node
            @parent.children << self
        end
    end

    
    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        child_node.parent = nil
    end

    def dfs(target_val)
        return self if self.value == target_val

        self.children.each do |child|
            search_res = child.dfs(target_val)
            return search_res if search_res != nil
        end
        nil
    end

    def bfs(target_val)

        @queue = [self]
        until @queue.empty?
            current = @queue.shift #one element of our array return current if current.value == target_val
            @queue += current.children
        end
        nil
    end

    #unshift pop
    #FIFO

    def inspect
        "<Node val: #{value} children: #{children}>"
    end
end


