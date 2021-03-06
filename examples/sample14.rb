#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz::new( "G" ) { |graph|
  graph.node[:shape] = "ellipse"
  graph.node[:color] = "black"
  
  graph[:color] = "black"
  
  graph.cluster0( ) do |cluster|
    cluster[:label] = "process #1"
    cluster[:style] = "filled"
    cluster[:color] = "lightgrey"
    
    cluster.node[:style] = "filled"
    cluster.node[:color] = "white"
    
    cluster.a0 << cluster.a1
    cluster.a1 << cluster.a2
    cluster.a2 << cluster.a3
  end
  
  graph.cluster1( :label => "process #2", :color => "blue" ) do |cluster|
    cluster.node[:style] = "filled"
    cluster.node[:color] = "lightgrey"
    
    cluster.b0 << cluster.b1
    cluster.b1 << cluster.b2
    cluster.b2 << cluster.b3
  end
  
  graph.start :shape => "Mdiamond"
  graph.endn :shape => "Msquare", :label => "end"
  
  graph.start << graph.cluster0.a0
  graph.start << graph.cluster1.b0
  graph.cluster0.a1 << graph.cluster1.b3
  graph.cluster1.b2 << graph.cluster0.a3
  graph.cluster0.a3 << graph.cluster0.a0
  graph.cluster0.a3 << graph.endn
  graph.cluster1.b3 << graph.endn
}.output( :path => '/usr/local/bin/', :png => "#{$0}.png" )