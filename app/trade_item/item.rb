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
        
        #buy if possible
        def buy?(buyer)
            if buyer.credits < self.price or not self.active
                false
                return
            end
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
            self.name = "<unnamed item>"
            self.active = false
        end
        
        def to_s
            a = "inactive"
            if self.active
                a = "active"
            end
            "Item #{self.name} owned by #{self.owner.name} costs #{self.price} credits is #{a} (for trading)"
        end
    end
end