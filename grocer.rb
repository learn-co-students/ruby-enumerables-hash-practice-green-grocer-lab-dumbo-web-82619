def consolidate_cart(cart)
  # code here  
  output_hash = {}
  cart.each do |items|
    items.each do |item, item_data|
      if !output_hash[item]
        output_hash[item] = item_data.merge({:count => 1})
      else 
        output_hash[item][:count] += 1
      end 
    end 
  end 
  output_hash
end

def apply_coupons(cart, coupons)
  # code here
  
end

def apply_clearance(cart)
  # code here
  
end

def checkout(cart, coupons)
  # code here 
 
end

