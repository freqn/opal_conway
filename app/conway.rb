# Grid generator

require 'opal'
require 'opal-jquery'
 
class Grid
  attr_reader :height, :width, :canvas, :context, :max_x, :max_y
 
  CELL_HEIGHT = 15;
  CELL_WIDTH  = 15;
 
  def initialize
    @height  = `$(window).height()`                  
    @width   = `$(window).width()`                   
    @canvas  = `document.getElementById(#{canvas_id})` 
    @context = `#{canvas}.getContext('2d')`
    @max_x   = (height / CELL_HEIGHT).floor           
    @max_y   = (width / CELL_WIDTH).floor             
  end
 
  def draw_canvas
    `#{canvas}.width  = #{width}`
    `#{canvas}.height = #{height}`
 
    x = 0.5
    until x >= width do
      `#{context}.moveTo(#{x}, 0)`
      `#{context}.lineTo(#{x}, #{height})`
      x += CELL_WIDTH
    end
 
    y = 0.5
    until y >= height do
      `#{context}.moveTo(0, #{y})`
      `#{context}.lineTo(#{width}, #{y})`
      y += CELL_HEIGHT
    end
 
    `#{context}.strokeStyle = "#eee"`
    `#{context}.stroke()`
  end
 
  def canvas_id
    'conwayCanvas'
  end
 
end
 
grid = Grid.new
grid.draw_canvas

# Fill / Unfill cells

def fill_cell(x,y)
  x *= CELL_WIDTH;
  y *= CELL_HEIGHT;
  `#{context}.fillStyle = "#000"`
  `#{context}.fillRect(#{x.floor+1}, #{y.floor+1}, #{CELL_WIDTH-1}, #{CELL_HEIGHT-1})`
end

def unfill_cell(x,y)
  x *= CELL_WIDTH;
  y *= CELL_HEIGHT;
  `#{context}.clearRect(#{x.floor+1}, #{y.floor+1}, #{CELL_WIDTH-1}, #{CELL_HEIGHT-1})`
end

# Identify cursor position

def get_cursor_position(event)
  if(event.page_x && event.page_y)
    x = event.page_x;
    y = even.page_y;
  else
    doc = Opal.Document[0]
    x = event[:clientX] + doc.scrollLeft +
      doc.document.Element.scrollLeft;
    y = event[:clientY] + doc.body.scrollTop +
      doc.document.Element.scrollTop;
    end
  end

