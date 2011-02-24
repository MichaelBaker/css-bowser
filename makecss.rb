include Java
import javax.imageio.ImageIO
MyFile = java.io.File

PixelSize = 20

def write_beginning(io , height , width)
  io.write "<html>\n"\
           "  <head>\n"\
           "    <style type=\"text/css\">\n"\
           "      .a {\n"\
           "        margin:             0;\n"\
           "        padding:            0;\n"\
           "        border:             none;\n"\
           "        width:              #{PixelSize}px;\n"\
           "        height:             #{PixelSize}px;\n"\
           "        display:            inline-block;\n"\
           "        position:           absolute;\n"\
           "        -webkit-transition: -webkit-transform 0.5s;\n"\
           "        -moz-transition:    -moz-transform 0.5s;\n"\
           "        z-index:            100;\n"\
           "      }\n"\
           "      .a:hover {\n"\
           "        -webkit-transform:  translateX(20px);\n"\
           "        -moz-transform:     translateX(20px);\n"\
           "        z-index:            300;\n" \
           "        -webkit-box-shadow: 2px 2px 5px black;\n"\
           "        -moz-box-shadow:    2px 2px 5px black;\n"\
           "        opacity:            0.9;\n"\
           "      }\n"\
           "      .b {\n"\
           "        position:   absolute;\n"\
           "        background: url(\"happy.png\") top left no-repeat;\n"\
           "        width:      #{PixelSize}px;\n"\
           "        height:     #{PixelSize}px;\n"\
           "        z-index:    50;\n"\
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
  color = "ffffff" unless /[^\.]{6}/ =~ color
  "<div class = \"a\" style = \"background-color:##{color};"\
                 "top:  #{y * PixelSize}px;"\
                 "left: #{x * PixelSize}px;"\
                 "\"></div>\n"\
   "<div class = \"b\" style = \""\
                  "top:  #{y * PixelSize}px;"\
                  "left: #{x * PixelSize}px;"\
                  "\"></div>\n"
end

def make_html(io,img_name)
  image = ImageIO.read( MyFile.new(img_name) )

  write_beginning io , image.getHeight() , image.getWidth()

  (0...image.getHeight).each do |y|
    (0...image.getWidth).each do |x|
      io.write make_div(to_hex(image.getRGB(x,y)) , x , y)
    end
  end

  write_bottom(io)

end

File.open "#{ARGV[0].split(".")[0]}.html" , "w" do |file|
  make_html file , ARGV[0]
end