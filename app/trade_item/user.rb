# author: Paul Frischknecht, #11-110-814
module TradeItem
    class User
        attr_accessor :name, :credits, :owned_items
        
        def self.named(name)
            user = self.new
            user.name = name
            user
        end
        
        def add_owned(item)
            self.owned_items.push(item)
        end
        
        def remove_owned(item)
            self.owned_items.delete(item)
        end
        
        def items_to_sell
            a = Array.new
            self.owned_items.each {|item| 
                if item.active
                    a.push(item)
                end
            } 
            a # AK as you can imagine, this is a very common task, so this is the faster way:
						self.owned_items.select {|item| item.active}
						# or if you are very economic about characters:
						owned_items.select(&:active)
        end
        
        def initialize
            self.credits = 100
            self.name = "<nameless user>" # AK you probably shouldn't make it a string. maybe leave it `nil`? or if it needs to be a string, use ""?
            self.owned_items = Array.new # Ruby uses literals, so you should write
						#self.owned_items = []

						# you can also take parameters in the constructor, if certain values NEED to be provided by the named constructor (name probably is such a case)
        end
               
        def to_s
            "User #{self.name} with #{self.credits} credits, owns #{self.owned_items.length} items"
        end
    end
end
