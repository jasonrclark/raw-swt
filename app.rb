#! /usr/bin/env jruby

require 'swt'

module Swt
  module Widgets
    import org.eclipse.swt.widgets.Layout
  end
end

class SwtExample
  class MyLayout < ::Swt::Widgets::Layout
    def layout(*_)
    end
  end

  def initialize
    display = Swt::Widgets::Display.new
    red = display.get_system_color ::Swt::SWT::COLOR_RED
    green = display.get_system_color ::Swt::SWT::COLOR_GREEN

    @shell = Swt::Widgets::Shell.new
    @shell.background = red

    # This puts us in absolute mode, so we need to set everyone's position
    # explicitly. Fortunately, that's what we actually want since as a library
    # with our own positioning rules, we *know* where everything ought to be.
    @shell.layout = nil
    @shell.set_size 400, 400

    # Inner composite "content" that we'll append our controls into
    composite = Swt::Widgets::Composite.new @shell, ::Swt::SWT::NONE
    composite.layout = MyLayout.new
    composite.set_bounds 0, 0, 200, 200
    composite.background = green

    @shell.open
  end

  # This is the main gui event loop
  def start
    display = Swt::Widgets::Display.get_current

    # until the window (the Shell) has been closed
    while !@shell.isDisposed

      # check for and dispatch new gui events
      display.sleep unless display.read_and_dispatch
    end

    display.dispose
  end
end

SwtExample.new.start
