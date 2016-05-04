require 'spec_helper'

describe Semantics::ContentProject do
  let(:engine_configuration) { 526 }

  describe '#all' do
    let(:cp_id) { 4748 }

    it 'lists all content projects' do
      VCR.use_cassette('all_content_project') do
        expect(Semantics::ContentProject.all.count).to be > 0
      end
    end
  end

  describe '#find' do
    let(:cp_id) { 4748 }
    let(:content_project) do
      VCR.use_cassette('get_content_project') do
        Semantics::ContentProject.find(cp_id)
      end
    end
    subject { content_project }

    describe 'the found content project' do
      its('name') { is_expected.to include 'TEST_PROJECT' }
      its('id') { is_expected.to eq cp_id }
      its('engine_configuration') { is_expected.to eq engine_configuration }
      its('count_things') { is_expected.to be > 0 }
      its('count_generated_texts') { is_expected.to eq  0 }
      its('thing_type') { is_expected.to eq 'jsonthing' }
    end

    it 'returns the right attributes' do
      VCR.use_cassette('get_content_project') do
        content_project = Semantics::ContentProject.find(cp_id)
        expect(content_project.id).to eq cp_id
        expect(content_project.name).to eq 'TEST_PROJECT'
      end
    end
  end

  describe '#create' do
    it 'creates a new content_project' do
      VCR.use_cassette('create_content_project') do
        content_project = Semantics::ContentProject
                          .create('NEW_CP', engine_configuration)
        expect(content_project.name).to eq('NEW_CP')
      end
    end
  end
end
