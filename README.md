cliz
====

DSL for CLI, using gviz for drawing pictures

How to Use
====

First, setup the sketch of your CLI application.
You need ":start", since applications need starting points.

```rb

cli = CLI.sketch({
  start: :hoge,
  hoge: :end
})

```

If graphviz is installed, You can check this sketch as a picture.

```rb

cli.print_out(:title, :png)

```

Of course, you can choose formats other than "png".

Next, work out the details.
Write codes for each scene. Define what happens in the scene, and show the next scene as a symbol.

```rb

cli.scene :start do
  puts "starting"
  :hoge # next scene
end

```

After you end these tasks, you can run this application.
Run it!!

```rb

cli.run

```

That's almost all.
