include Java
import javax.imageio.ImageIO
MyFile = java.io.File

PixelSize = 10

def write_beginning(io , height , width)
  io.write "<html>\n"\
           "  <head>\n"\
           "    <style type=\"text/css\">\n"\
           "      div {\n"\
           "        margin:   0;\n"\
           "        padding:  0;\n"\
           "        border:   none;\n"\
           "        width:    #{PixelSize}px;\n"\
           "        height:   #{PixelSize}px;\n"\
           "        display:  inline-block;\n"\
           "        position: absolute;\n"\
           "      }\n"\
           "    </style>\n"\
           "  </head>\n"\
           "  <body style=\"height:#{height * PixelSize}px;width:#{width * PixelSize}px;padding:0;margin:auto;position:relative\">\n"
end

def write_bottom(io)
  io.write   "</body>"\
           "</html>"
end

def to_hex(int)
  # int = int.abs + (1 << 31)
  sprintf( '%x' , int )[-6..-1]
end

def make_div(color , x , y)
  "<div style = \"background:##{color};"\
                 "top: #{y * PixelSize}px;"\
                 "left: #{x*PixelSize}px;"\
                 "\"></div>\n"
end

def make_html(io,img_name)
  image = ImageIO.read( MyFile.new(img_name) )

  write_beginning io , image.getHeight() , image.getWidth()

  (0...image.getHeight).each do |y|
    (0...image.getWidth).each do |x|
      io.write make_div(to_hex(image.getRGB(x,y)) , x , y)
    end
    io.write "<br />"
  end

  write_bottom(io)

end

File.open "junk.html" , "w" do |file|
  make_html file , "bowser.jpg"
end