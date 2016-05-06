require 'spec_helper'

describe Semantics::ContentProject do
  describe '.all' do
    it 'returns a list of content projects' do
      projects = Semantics::ContentProject.all
      expect(projects.count).to eq(1)
      expect(projects.first).to be_kind_of(Semantics::ContentProject)
    end
  end

  describe '.find' do
    subject { Semantics::ContentProject.find(1) }

    describe 'the found content project' do
      its('name') { is_expected.to eq 'NEW_CP' }
      its('id') { is_expected.to eq 1 }
      its('engine_configuration') { is_expected.to eq 526 }
      its('thing_type') { is_expected.to eq 'jsonthing' }
    end
  end

  describe '.create' do
    it 'creates a new content_project' do
      content_project = Semantics::ContentProject.create('NEW_CP', '123')
      expect(content_project).to be_kind_of(Semantics::ContentProject)
      expect(content_project.name).to eq('NEW_CP')
    end
  end
end
