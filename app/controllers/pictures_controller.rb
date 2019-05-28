class PicturesController < ApplicationController
  def recent
    @photos = Photo.all.order({ :created_at => :desc }).limit(25)

    render("pic_templates/time_list.html.erb")
  end

  def most_liked
    @photos = Photo.all.order({ :likes_count => :desc }).limit(25)

    render("pic_templates/liked_list.html.erb")
  end

  def show_details
    photo_id = params.fetch("some_id")

    @pic = Photo.where({ :id => photo_id }).at(0)

    render("pic_templates/details.html.erb")
  end
  
  def bye
    #Rails assigns:
    #params = {"id_to_delete" => "628"}
    
    pic_id = params.fetch("id_to_delete")
    picture = Photo.where({ :id => pic_id}).at(0)
    picture.destroy
    redirect_to("/popular")
  end 
  
  def existing_form
    pic_id = params.fetch("id_to_update")
    @pic = Photo.where({ :id => pic_id})[0]
    
    render("pic_templates/update.html.erb")
  end 
  
  def update_form
    pic_id_2 = params.fetch("id_to_update_2")
    @pic2 = Photo.where({ :id => pic_id_2})[0]
    
    @pic2.image = params.fetch("pic_image")
    @pic2.caption = params.fetch("pic_caption")
    @pic2.save

    redirect_to("/photos/" + pic_id_2)
  end
  
  def blank_form
    render("pic_templates/new_form.html.erb")
  end  

  def save_new_row
    #Save the info...
    p = Photo.new
    p.image = params.fetch("pic_image")
    p.caption = params.fetch("pic_caption")
    p.owner_id= params.fetch("poster_id")
    p.save
  
    redirect_to("/recent")
  end

  def add_fan
    pic_id_3 = params.fetch("picture_id")
    
    f = Like.new
    f.fan_id = params.fetch("liker_id")
    f.photo_id = params.fetch("picture_id")
    f.save

    redirect_to("/photos/" + pic_id_3)
  end

  def add_comment
    pic_id_4 = params.fetch("picture_id")
    
    c = Comment.new
    c.photo_id = params.fetch("picture_id")
    c.body =  params.fetch("pic_comment")
    c.author_id = params.fetch("poster_id")
    c.save
    
    redirect_to("/photos/" + pic_id_4)
  end
end
