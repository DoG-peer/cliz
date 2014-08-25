require 'gviz'

module AutoRun
  def autorun
    at_exit do
      run
    end
  end
end

class CLI

  attr_accessor :graph
  def initialize(hash = nil)
    @graph = Gviz.new
    @scenes = {end: Proc.new{}}
    
    @position = :start
    @params = {}
    
    sketch hash if hash
  end

  # should has key :start
  def sketch(hash)
    @graph.route(hash)
  end
  
  def self.sketch(hash)
    self.new(hash)
  end
  
  # block may change @params.
  # should return symbol
  # this allows "gets" and "puts"
  def scene(symbol,&block)
    @scenes[symbol] = block
  end

  include AutoRun
  def run
    if prepared?
      @position ||= :start
      loop do
        @position = @scenes[@position].call
        if @position == :end
          @scenes[:end].call
          break
        end
        
        unless node_id_list.include? @position
          raise "illegal position!!"
        end
      end
    else
      puts "Not prepared!!"
      p left
    end
  end
  
  def print_out(title, format = :png)
    @graph.save(title, format)
  end

  private
  def node_id_list
    @graph.instance_variable_get(:@nodes).keys
  end

  def edges_as_hash
    eds = @graph.instance_variable_get(:@edges).keys
    eds.map! do |e|
      parse_edge_id(e)
    end
    val = {}
    eds.each do |k,v|
      val[k] ||= []
      val[k] << v
    end
    val
  end

  # edge :hoge_hige
  def parse_edge_id(id)
    if id.to_s =~ /^(\w+)_(\w+)$/
      [$1,$2].map(&:to_sym)
    else 
      raise "Not edge-id format!!"
    end
  end

  def next_nodes_from(node_id)
    edges_as_hash[node_id]
  end

  def prepared?
    flag = ( node_id_list.sort == @scenes.keys.sort )
    flag &= (node_id_list.include? :start) 
  end

  def left
    [ 
      node_id_list - @scenes.keys,
      @scenes.keys - node_id_list
    ]
  end

end

