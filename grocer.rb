def consolidate_cart(cart)
  hash = {}
  cart.each do |item|
    key = item.keys
    if hash[key[0]]  # if is in hash add count by 1
      hash[key[0]][:count] += 1 
    else
      item.values.each {|item| hash[key[0]] = item } # add values to hash
      hash[key[0]][:count] = 1   
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  hash = cart
  coupons.each do |coupon|
    item = coupon[:item]
    amount = coupon[:num]
    cost = coupon[:cost]

    if hash[item] && hash[item][:count] >= amount                        # if coupon is in the hash
      hash[item][:count] -= amount      # minus amount of coupon
      if hash["#{item} W/COUPON"]       # if there is another coupon in the hash for same item
        hash["#{item} W/COUPON"][:count] += amount
      else                                  
      hash["#{item} W/COUPON"] = {      
        :price => cost * 1.0 / amount,
        :count => amount,
        :clearance => hash[item][:clearance]
      }      
       end 
    end
  end 
  hash 
end

def apply_clearance(cart)
  hash = cart
  cart.each do |product,value|
    if value[:clearance] 
      hash[product][:price] = (hash[product][:price] * 0.8).round(2)
    end
   end
  hash
end

def checkout(cart, coupons)
  hash = consolidate_cart(cart)
  hash = apply_coupons(hash,coupons)
  hash = apply_clearance(hash)
  total = 0
  hash.each { |product, value| total += (hash[product][:price] * hash[product][:count]) }
  total < 100 ? total : (total * 0.9).round(2)
end
