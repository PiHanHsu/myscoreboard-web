module ApplicationHelper


def user_avatar(user)
 if user.head?
   image_url = user.head.url(:thumb)
 elsif user.fb_pic?
   image_url = user.fb_pic
 else
   image_url = "default_head.png"
 end
 image_tag image_url
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


end



