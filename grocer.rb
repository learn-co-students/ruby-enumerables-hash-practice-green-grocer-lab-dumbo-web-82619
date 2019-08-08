def consolidate_cart(cart)
  # code here  
  output_hash = {}
  
  cart.each do |item|
    item.each do |item_name, item_info|
      if !output_hash[item_name]
        output_hash[item_name] = item_info.merge(count: 1)
      else 
        output_hash[item_name][:count] += 1
      end 
    end 
  end 
  output_hash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_key = "#{coupon[:item]} W/COUPON"
        if !!cart[new_key]
          cart[new_key][:count] += coupon[:num]
        else 
          cart[new_key] = {
            price: coupon[:cost] / coupon[:num],
            clearance: cart[coupon[:item]][:clearance],
            count: coupon[:num]
          }
        end 
        cart[coupon[:item]][:count] -= coupon[:num]
      end 
    end 
  end 
  cart 
end

def apply_clearance(cart)
  # code here
  cart.each do |item_name, item_info|
    if item_info[:clearance]
      item_info[:price] = (item_info[:price] * 0.8).round(2)
    end 
  end 
  cart 
end

def checkout(cart, coupons)
  # code here 
  consolidated_cart = consolidate_cart(cart)
  applied_coupons_cart = apply_coupons(consolidated_cart, coupons)
  everything_applied_cart = apply_clearance(applied_coupons_cart)
  
  price = 0 
  everything_applied_cart.each do |item_name, item_info|
    price += item_info[:price] * item_info[:count]
  end 
  price > 100 ? (price * 0.9).round(2) : price
end

