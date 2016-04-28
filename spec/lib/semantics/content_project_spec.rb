require 'spec_helper'

describe Semantics::ContentProject do
  describe '#find' do
    it 'returns a content_project' do
      content_project = Semantics::ContentProject.find(4591)
      expect(content_project.class).to eq(Semantics::ContentProject)
    end

    it 'returns the right attributes' do
      content_project = Semantics::ContentProject.find(4591)
      expect(content_project.id).to eq (4591)
      expect(content_project.name).to eq ("Anbieter landingpages")
    end
  end

  describe '#create' do
    it 'creates a new content_project' do
      content_project = Semantics::ContentProject.create('neues cp2', 526)
      expect(content_project.name).to eq('neues cp2')
    end
  end
end
