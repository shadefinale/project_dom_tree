require_relative '../lib/node.rb'

describe DOMNode do

  let(:dnode){DOMNode.new('span')}

  describe '#initialize' do

    it 'should have proper element type when initialized' do
      expect(dnode.element).to eq('span')
    end

    it 'should have no class if initialized with no class' do
      expect(dnode.classes).to eq('')
    end

    it 'should have no id if initialized with no id' do
      expect(dnode.id).to be_nil
    end

    it 'should have no children when initalized' do
      expect(dnode.children).to eq([])
    end

    it 'should have no parent when initialized' do
      expect(dnode.parent).to be_nil
    end
  end

  describe '#classes' do

    it 'should take classes array and return string' do
      new_node = DOMNode.new('span', ["class1", "class2"])
      expect(new_node.classes).to eq("class1 class2")
    end
  end

  describe '#add_class' do
    it 'should be able to have additional classes' do
      dnode.add_class('new')
      expect(dnode.classes).to eq('new')
    end

    it 'should ve able to have multiple additional classes' do
      dnode.add_class('new')
      dnode.add_class('class')
      expect(dnode.classes).to eq('new class')
    end
  end

  describe '#set_id' do
    it 'should give an id to a node without one' do
      dnode.set_id('id')
      expect(dnode.id).to eq('id')
    end

    it 'should overwrite old id' do
      pre_node = DOMNode.new('span', [], 'bob')
      pre_node.set_id('jack')
      expect(pre_node.id).to eq('jack')
    end
  end

  describe '#text' do

    it 'should return both the before and after text' do
      pre_node = DOMNode.new('span', [], 'bob', ["before", "after"])
      expect(pre_node.text).to eq('before after')
    end

    it 'should not have leading space if no before text' do
      pre_node = DOMNode.new('span', [], 'bob', ["", "after"])
      expect(pre_node.text).to eq('after')
    end

  end

  describe '#before_text' do
    it 'should add text to the before part of the text array' do
      dnode.before_text += ("before")
      expect(dnode.text).to eq('before')
    end

    it 'should return the before text if not assigning' do
      pre_node = DOMNode.new('span', [], 'bob', ["before", ""])
      expect(pre_node.before_text).to eq("before")
    end
  end

  describe '#after_text' do
    it 'should add text to the after part of the text array' do
      dnode.after_text += ("after")
      expect(dnode.text).to eq('after')
    end

    it 'should return the after text if not assigning' do
      pre_node = DOMNode.new('span', [], 'bob', ["","after"])
      expect(pre_node.after_text).to eq("after")
    end
  end

  describe '#is_void?' do

    it 'should return true if void element (cannot have content)' do
      void_node = DOMNode.new('img')
      expect(void_node.is_void?).to be true
    end

    it 'should return false if non void element (can have content)' do
      expect(dnode.is_void?).to be false
    end
  end
end