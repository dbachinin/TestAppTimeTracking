module AvatarHelper
	def create_avatar(id)
		Avatar.new(id).make_userpic
	end
	def create_task_icon(id)
		Avatar.new(id).create_icon
	end
	class Avatar
		def initialize(id)
			@id, @uri = id, uri
		end
		attr_accessor :id, :uri
		def make_userpic
			list = Magick::ImageList.new
			list.new_image(150, 150, Magick::SolidFill.new('white'))
			pic = Magick::Draw.new
			pictarr = []
			until pictarr.include?("1") and pictarr.include?("0")
				pictarr = []
				9.times{|i| i / 3.0 == i / 3 ? pictarr << ["0","1"].sample : pictarr << pictarr[i-2]}
			end
			
			i = 0
			color = Magick::colors.map{ |colorinfo|colorinfo.name}.grep_v(%r{white|gray|black|light|yellow|cream|beige|snow|ice|ivory|[0-9]}i).sample
			(0..100).step(50) do |y|
				(0..100).step(50) do |x|
					pic.fill_opacity(0)
					pic.stroke(color)
					pic.fill(color) 
					pic.stroke_width(1)
					pic.rectangle(x,y,x+50,y+50) if pictarr[i] != "0"
					i+=1
				end
			end
			pic.draw(list)
			@f_name = "#{id}.png"
			list.write("app/assets/images/avatars/" + @f_name)
			uri = "app/assets/images/avatars/" + @f_name
			uri
		end

		def create_icon
			list = Magick::ImageList.new
			list.new_image(150, 150, Magick::SolidFill.new('white'))
			pic = Magick::Draw.new
			pictarr = []
			until pictarr.include?("1") and pictarr.include?("0")
				pictarr = []
				9.times{|i| i / 3.0 == i / 3 ? pictarr << ["0","1"].sample : pictarr << pictarr[i-2]}
			end
			i = 0
			(0..100).step(50) do |y|
				(0..100).step(50) do |x|
					color = Magick::colors.map{ |colorinfo|colorinfo.name}.grep_v(%r{white|gray|black|light|yellow|cream|beige|snow|ice|ivory|[0-9]}i).sample
					pic.fill_opacity(0)
					pic.stroke(color)
					pic.fill(color) 
					pic.stroke_width(1)
					pic.rectangle(x,y,x+50,y+50) if pictarr[i] != 0
					i+=1
				end
			end
			pic.draw(list)
			@f_name = "#{id}.png"
			list.write("app/assets/images/avatars/" + @f_name)
			uri = "app/assets/images/avatars/" + @f_name
			uri
		end

	end
end