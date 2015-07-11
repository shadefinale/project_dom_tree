require_relative '../lib/searcher.rb'
require_relative '../lib/dom.rb'


# TODO: SWITCH TO MOCK OBJECTS SOMEWAYSOMEHOW
describe TreeSearcher do
  let(:ts) do
    simple_file = ["<html>", "<head class=\"classy\">", "<img>", "<body id=\"unid\">", "</body>", "</head>", "</html>"]
    allow(File).to receive(:readlines).and_return(simple_file)
    dr = DOMReader.new
    dr.build_tree(simple_file)
    TreeSearcher.new(dr)
  end

  describe '#search_by' do

    context 'string searches' do

      it 'should be able to search for elements from the root' do
        expect(ts.search_by(:element, 'html').length).to eq(1)
      end

      it 'should be able to search for classes from the root' do
        expect(ts.search_by(:classes, 'classy').length).to eq(1)
      end

      it 'should be able to search for ids from the root' do
        expect(ts.search_by(:id, 'unid').length).to eq(1)
      end

      it 'should not be able to search for non-existing elements from the root' do
        expect(ts.search_by(:element, 'htmsfel').length).to eq(0)
      end

      it 'should not be able to search for non-existing classes from the root' do
        expect(ts.search_by(:classes, 'cdflassy').length).to eq(0)
      end

      it 'should not be able to search for non-existing ids from the root' do
        expect(ts.search_by(:id, 'uneeid').length).to eq(0)
      end

    end

    context 'regex searches' do

      it 'should be able to search for elements from the root' do
        expect(ts.search_by(:element, /html/).length).to eq(1)
      end

      it 'should be able to search for classes from the root' do
        expect(ts.search_by(:classes, /classy/).length).to eq(1)
      end

      it 'should be able to search for ids from the root' do
        expect(ts.search_by(:id, /unid/).length).to eq(1)
      end

      it 'should not be able to search for non-existing elements from the root' do
        expect(ts.search_by(:element, /htmsfel/).length).to eq(0)
      end

      it 'should not be able to search for non-existing classes from the root' do
        expect(ts.search_by(:classes, /cdflassy/).length).to eq(0)
      end

      it 'should not be able to search for non-existing ids from the root' do
        expect(ts.search_by(:id, /uneeid/).length).to eq(0)
      end

      it 'should be able to search for elements from the root (partial matches start)' do
        expect(ts.search_by(:element, /^ht/).length).to eq(1)
      end

      it 'should be able to search for elements from the root (partial matches end)' do
        expect(ts.search_by(:element, /ml$/).length).to eq(1)
      end

      it 'should be able to search for elements from the root (partial matches middle)' do
        expect(ts.search_by(:element, /^.*tm.*$/).length).to eq(1)
      end

    end

  end

  describe "#search_children" do

    it 'should not find img class in children of body' do
      body = ts.search_by(:element, 'body')[0]
      expect(ts.search_children(body, :element, 'img').length).to eq(0)
    end

    it 'should find img class in children of head' do
      body = ts.search_by(:element, 'head')[0]
      expect(ts.search_children(body, :element, 'img').length).to eq(1)
    end
  end

  describe '#search_ancestor' do

    it 'should have img find body as ancestor' do
      img = ts.search_by(:element, 'img')[0]
      expect(ts.search_ancestor(img, :element, 'head').length).to eq(1)
    end

    it 'should be able to search for parents by class' do
      img = ts.search_by(:element, 'img')[0]
      expect(ts.search_ancestor(img, :classes, 'classy').length).to eq(1)
    end

    it 'should not be able to find elements that are not its ancestor' do
      img = ts.search_by(:element, 'img')[0]
      expect(ts.search_ancestor(img, :element, 'id').length).to eq(0)
    end
  end

end