require 'spec_helper'

describe Semantics::ContentProject do
  before  do
    stub_request(:get, 'https://api.ax-semantics.com/v1/content-project/')
      .with(headers: headers)
      .to_rack(FakeAxSemantics)
  end

  describe '.all' do
    it 'returns a list of content projects' do
      projects = Semantics::ContentProject.all
      expect(projects.count).to eq(1)
      expect(projects.first).to be_kind_of(Semantics::ContentProject)
    end
  end

  describe '.find' do
    subject { Semantics::ContentProject.find(1) }

    before do
      stub_request(:get, 'https://api.ax-semantics.com/v1/content-project/1/')
        .with(headers: headers)
        .to_rack(FakeAxSemantics)
    end

    describe 'the found content project' do
      its('name') { is_expected.to eq 'NEW_CP' }
      its('id') { is_expected.to eq 1 }
      its('engine_configuration') { is_expected.to eq 526 }
      its('thing_type') { is_expected.to eq 'jsonthing' }
    end
  end

  describe '.create' do
    before do
      stub_request(:post, 'https://api.ax-semantics.com/v1/content-project/')
        .with(headers: headers, body: content_project_post_body)
        .to_rack(FakeAxSemantics)
    end

    it 'creates a new content_project' do
      content_project = Semantics::ContentProject.create('NEW_CP', '123')
      expect(content_project).to be_kind_of(Semantics::ContentProject)
      expect(content_project.name).to eq('NEW_CP')
    end
  end

  private

  def content_project_post_body
    {
      name: 'NEW_CP',
      engine_configuration: '123'
    }
  end
end
