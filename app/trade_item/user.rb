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
            a
        end
        
        def initialize
            self.credits = 100
            self.name = "<nameless user>"
            self.owned_items = Array.new
        end
               
        def to_s
            "User #{self.name} with #{self.credits} credits, owns #{self.owned_items.length} items"
        end
    end
end