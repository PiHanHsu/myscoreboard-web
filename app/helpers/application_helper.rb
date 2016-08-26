module ApplicationHelper


def user_avatar(user)
 if user.head?
   image_url = user.head.url(:medium)
 elsif user.fb_pic?
   image_url = user.fb_pic
 else
   image_url = "default_head.png"
 end
 image_tag(image_url, height: '150', width: '150')
end


def user_head(user)
 if user.head?
   image_url = user.head.url(:thumb)
 elsif user.fb_pic?
   image_url = user.fb_pic
 else
   image_url = "default_head.png"
 end
 image_tag(image_url, height: '32', width: '32')
end


def user_image(user)
 if user.head?
   image_url = user.head.url(:medium)
 elsif user.fb_pic?
   image_url = user.fb_pic
 else
   image_url = "default_head.png"
 end
 image_tag(image_url, height: '200', width: '200', class: "user_image")
end

def best_partner(user)
 if user.head?
   image_url = user.head.url(:medium)
 elsif user.fb_pic?
   image_url = user.fb_pic
 else
   image_url = "default_head.png"
 end
 image_tag(image_url, height: '90', width: '90', class: "user_image")
end

def last_two_game(user)
 if user.head?
   image_url = user.head.url(:medium)
 elsif user.fb_pic?
   image_url = user.fb_pic
 else
   image_url = "default_head.png"
 end
 image_tag(image_url, height: '50', width: '50', class: "user_image2")
end

def user_photo_games(user)
 if user.head?
   image_url = user.head.url(:medium)
 elsif user.fb_pic?
   image_url = user.fb_pic
 else
   image_url = "default_head.png"
 end
 image_tag(image_url, height: '45', width: '45', class: "head_image")
end


end
