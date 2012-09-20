# author: Paul Frischknecht, #11-110-814
module TradeItem
    class Item
        attr_accessor :name, :price, :active, :owner
        
        def self.named_priced_owned(name, price, owner)
            item = self.new
            item.name = name
            item.price = price
            item.owner = owner
            owner.add_owned(item)
            item
        end
        
        #buy if possible (not possible if inactive, not enough credits or buyer = owner)
        def buy?(buyer)
            if buyer.credits < self.price or not self.active or buyer == self.owner
                false
                return # AK this probably does the right thing by accident:
								# `return` without anything to return gives `nil`, which is
								# somewhat false as well. You want
								# `return false` though. It is possible and used for early returning.
								# Fully idiomatic it would be:
            end
						return false if buyer.credits < self.price or not self.active or buyer == self.owner
						# or if you want to focus on the different options:
						return false if buyer.credits < self.price
						return false unless self.active
						return false if buyer == self.owner
						# ---
						
						# Methods with a question mark are "predicates", that are 
						# *functions* that *return booleans*. This method does return
						# booleans, but it has side effects (the owner changes, ...),
						# therefore it is no function. You can do something like
						# `buy!(item) if buy?(item)` to fix this.
            owner.credits += self.price
            buyer.credits -= self.price
            self.owner.remove_owned(self)
            self.owner = buyer            
            buyer.add_owned(self)
            self.active = false
            true           
        end
        
        def initialize
            self.price = 0
            self.name = "<unnamed item>" # AK prefer nil or ""
            self.active = false
        end
        
        def to_s
            a = "inactive" 
            if self.active # AK this doesn't look quite right.
                a = "active"
            end
						# You could either save the state as a symbol, not a boolean, but
						# that would mess up other things. But you could also use the
						# ternary operator ?:
						
            "Item #{self.name} owned by #{self.owner.name} costs #{self.price} credits is #{a} (for trading)"

            "Item #{self.name} owned by #{self.owner.name} costs #{self.price} credits is #{self.active ? "active" : "inactive"} (for trading)"
        end
    end
end
