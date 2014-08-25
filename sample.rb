require './cli.rb'

cli = CLI.sketch({
  start: [:first,:second],
  first: :second,
  second: :end
})
cli.print_out(:sample,:png)

cli.instance_eval do
  scene :start do
    puts "start"
    if rand(2) == 0 
      :first
    else
      :second
    end
  end
  scene :first do
    puts "first step"
    :second
  end
  scene :second do
    puts "second step"
    :end
  end
  scene :end do
    puts "END"
  end
end

cli.run
require 'pp'
pp cli
