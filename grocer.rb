def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each do |line_item_array| 
    line_item_array.each do |item,key_val|
      new_cart[item] ||= key_val
      if new_cart[item][:count]
        new_cart[item][:count] += 1 
      else
        new_cart[item][:count] = 1 
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
   coupons.each do |coupon|
   coupon.each do 
      item = coupon[:item]
      if cart[item] && cart[item][:count] >= coupon[:num]
        if cart["#{item} W/COUPON"]
          cart["#{item} W/COUPON"][:count] += coupon[:num] 
        else cart["#{item} W/COUPON"] = {:price => (coupon[:cost]/coupon[:num]), :clearance => cart[item][:clearance], :count => coupon[:num]}
        end
      cart[item][:count] -= coupon[:num]  
      end
                end 
                end  
    
  # code here
  cart
end

def apply_clearance(cart)
  # code here
    cart.each  do |item, discount| 
    if discount[:clearance] == true 
      discount[:price] = (discount[:price] *
      0.8).round(2) 
    end 
  end 
cart 
end

def checkout(cart, coupons) 
  total = 0 
  consolidated = consolidate_cart(cart)
  couponed = apply_coupons(consolidated, coupons) 
  clearanced = apply_clearance(couponed)
  clearanced.each do |item, disc| 
    total += (disc[:price] * disc[:count])
  end 
 total > 100 ? (total *0.9).round(2) : total*1
end


