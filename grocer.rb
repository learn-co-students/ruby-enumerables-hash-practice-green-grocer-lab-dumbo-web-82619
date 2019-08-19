require "pry"

def consolidate_cart(cart)
 hash={}
 cart.each_with_index do |item,index|
   item.each do |food,info|
     if hash [food]
       hash[food][:count]+=1 
     else
       hash [food]=info
       hash [food][:count]=1 
     end
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
  if cart.keys.include? coupon[:item]
    if cart[coupon[:item]][:count]>=coupon[:num]
      name = "#{coupon[:item]} W/COUPON" 
      if cart[name]
        cart[name][:count]+=coupon[:num]
      else
        cart[name] = {count: coupon[:num], price: coupon[:cost]/coupon[:num],
  clearance: cart[coupon[:item]][:clearance]}
end
cart[coupon[:item]][:count]-=coupon[:num]
    end 
   end
  end
  cart
 end

def apply_clearance(cart)
  cart.keys.each do |item|
if cart[item][:clearance]
  
  cart[item][:price] =(cart[item][:price])- (cart[item][:price]*0.20)
   end
  end
  cart
 end
 

def checkout(cart, coupons)
  consolidate =consolidate_cart(cart)
  coupons_added = apply_coupons(consolidate,coupons)
  discounts = apply_clearance(coupons_added)  
  
  total=0.0 
  discounts.keys.each do |item|
    total += discounts[item][:price ]*discounts[item][:count]
  end
    total > 100.00 ? (total)-(total*0.10): total
   end

