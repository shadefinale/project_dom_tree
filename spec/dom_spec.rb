require_relative '../lib/dom.rb'

describe DOMReader do

  let(:dreader){DOMReader.new}

  describe '#initialize' do

    it 'should have only a root document when initalized' do
      expect(dreader.stack[0].element).to eq("Document")
    end

  end

  describe '#build_tree' do

    it 'should create proper node structure (simple)' do
      simple_file = "<html> <head> <body> </body> </head> </html>".split(" ")
      allow(File).to receive(:readlines).and_return(simple_file)
      dreader.build_tree(simple_file)
      expect(dreader.stack[0].children.length).to eq(1)
    end

    it 'should not give void elements children' do
      simple_file = "<html> <img> <body> </body> </html>".split(" ")
      allow(File).to receive(:readlines).and_return(simple_file)
      dreader.build_tree(simple_file)
      expect(dreader.stack[0].children[0].children[0].children.length).to eq(0)
    end

    it 'should give the document multiple children' do
      simple_file = "<html> </html> <head> </head> <body> </body>".split(" ")
      allow(File).to receive(:readlines).and_return(simple_file)
      dreader.build_tree(simple_file)
      expect(dreader.stack[0].children.length).to eq(3)
    end
  end

end