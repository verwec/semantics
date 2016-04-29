require 'spec_helper'

describe Semantics::ContentProject do
  describe '#find' do
    it 'returns the right attributes' do
      VCR.use_cassette('get_content_project') do
        content_project = Semantics::ContentProject.find(4591)
        expect(content_project.id).to eq (4591)
        expect(content_project.name).to eq ("Anbieter landingpages")
      end
    end
  end

  describe '#create' do
    it 'creates a new content_project' do
      VCR.use_cassette('create_content_project') do
        content_project = Semantics::ContentProject.create('neues cp2', 526)
        expect(content_project.name).to eq('neues cp2')
      end
    end
  end
end
