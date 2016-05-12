require 'spec_helper'

describe Semantics::Thing do
  let(:cp_id) { 123 }
  let(:obj_id) { 1 }

  describe '.all' do

    before do
      stub_request(:get, 'https://api.ax-semantics.com/v1/allthings/?content_project_pk=123&page_size=100000')
        .with(headers: headers)
        .to_rack(FakeAxSemantics)
    end

    it 'lists all things' do
      things = Semantics::Thing.all(cp_id)
      expect(things.count).to eq(1)
      expect(things.first).to be_kind_of(Semantics::Thing)
    end
  end

  describe '.find' do
    subject { Semantics::Thing.find(cp_id, obj_id) }

    before do
      stub_request(:get, 'https://api.ax-semantics.com/v1/content-project/123/thing/1/')
        .with(headers: headers)
        .to_rack(FakeAxSemantics)

      # stub bad request
      stub_request(:get, 'https://api.ax-semantics.com/v1/content-project/1/thing//')
        .with(headers: headers)
        .to_rack(FakeAxSemantics)
    end

    describe 'the found thing' do
      its('status') { is_expected.to eq 'not requested' }
      its('created') { is_expected.to eq '2016-05-02T09:19:07.172345Z' }
      its('modified') { is_expected.to eq '2016-05-02T09:19:07.172636Z' }
      its('uid') { is_expected.to eq '123' }
      its('name') { is_expected.to eq 'foobar' }
      its('pure_data') { is_expected.to eq('key' => 'value') }
      its('content_project') { is_expected.to eq cp_id }
    end

    it 'can throw an appropriated error' do
      expect do
        Semantics::Thing.find(1, nil)
      end.to raise_error Semantics::ApiError
    end
  end

  describe '.create' do
    before do
      stub_request(:post, 'https://api.ax-semantics.com/v1/content-project/123/thing/')
        .with(headers: headers, body: thing_post_body)
        .to_rack(FakeAxSemantics)
    end

    it 'creates a thing' do
      uid = 1
      pure_data = { key: 'value' }
      name =  'foobar'
      thing = Semantics::Thing.create(cp_id, uid, name, pure_data)
      expect(thing).to be_kind_of(Semantics::Thing)
    end
  end

  context "Update methods" do

    let(:name) { 'BobDoe' }
    let(:pure_data) { { 'name' => 'Bob Doe' } }
    let(:uid) { 99 }

    before do
      stub_request(:put, 'https://api.ax-semantics.com/v1/content-project/123/thing/1/')
        .with(headers: headers, body: thing_put_body)
        .to_rack(FakeAxSemantics)
    end

    describe '#update' do
      it 'updates a thing' do
        thing = Semantics::Thing.new({'content_project' =>  cp_id, 'id' => obj_id})
        updated_thing = thing.update(uid, name, pure_data)
        expect(updated_thing).to be_kind_of(Semantics::Thing)
      end
    end

    describe '.update' do
      it 'updates a thing' do
        updated_thing = Semantics::Thing.update(cp_id, obj_id, uid, name, pure_data)
        expect(updated_thing).to be_kind_of(Semantics::Thing)
      end
    end
  end

  describe '.generate_content' do
    before do
      stub_request(:post, 'https://api.ax-semantics.com/v1/content-project/123/thing/1/generate_content/?force=true')
        .to_rack(FakeAxSemantics)
    end

    it 'generates content' do
      status = Semantics::Thing.generate_content(cp_id, obj_id)
      expect(status).to eq 'SUCCESS'
    end
  end

  private

  def thing_put_body
    {
      uid: 99,
      name: 'BobDoe',
      content_project: 123,
      pure_data: { name: 'Bob Doe' }
    }
  end

  def thing_post_body
    {
      uid: 1,
      name: 'foobar',
      content_project: 123,
      pure_data: { key: 'value' }
    }
  end
end
