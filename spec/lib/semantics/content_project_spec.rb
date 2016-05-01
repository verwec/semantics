require 'spec_helper'

describe Semantics::ContentProject do
  describe '#find' do

    let(:cp_id) { 4591 }
    let(:content_project) do
      VCR.use_cassette('get_content_project') do
        Semantics::ContentProject.find(4591)
      end
    end
    subject { content_project }

    describe 'the found content project' do
      its('name') { is_expected.to include "Anbieter landingpages" }
      its('id') { is_expected.to eq 4591 }
      its('axcompany_name') { is_expected.to eq 'marketing@volders.de' }
      its('engine_configuration') { is_expected.to eq 526 }
      its('count_things') { is_expected.to eq 162 }
      its('count_generated_texts') { is_expected.to eq 151 }
      its('thing_type') { is_expected.to eq 'jsonthing' }
    end

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
