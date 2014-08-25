require 'minitest/autorun'
require './cli.rb'
require 'pp'
MiniTest.autorun
p CLI.instance_methods - Object.instance_methods


module TestMethods
  def foo(id)
    next_nodes_from(id)
  end
end

class CLI
  include TestMethods
end

class TestCLI < MiniTest::Test
  def setup
    hash = {
      aa: :hige,
      ii: :cc,
      hoge: :hige
    }
    @x = CLI.new
    @x.graph.instance_eval do
      route(hash)
      save(:hige,:png)
    end

    @hash = hash
    #pp @x
    #@x.define_branch(:hoge) do
    #end
  end
  
  def test_nil
    assert @x
  end
  
  def test_foo
    puts 'test_foo'
    # pp @x.foo(:hoge)
  
  end
  
  # TODO
  def test_sketch
    assert (CLI.new @hash)
  end

  def test_run
    # @x.run
    @x.autorun
  end
  
  def test_print_out
    @x.print_out(:test, :png)
  end

end


#pp x
#pp x.methods
