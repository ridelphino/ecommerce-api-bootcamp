shared_examples "paginatable concern" do |factory_name|
    context "When records fits page size" do
        let!(:records) { create_list(factory_name, 20) }

        context "When :page and :length are empty" do
            it "returns default 10 records" do
                paginated_records = described_class.paginate(nil, nil)
                expect(paginated_records.count).to eq 10
            end

            it "matches first 10 records" do
                paginated_records = described_class.paginate(nil, nil)
                expected_records = described_class.all[0..9]
                expect(paginated_records).to eq expected_records
            end
        end

        context "When :page id fulfilled and :length is empty" do
            let(:page) { 2 }

            it "returns default 10 records" do
                paginated_records = described_class.paginate(page, nil)
                expect(paginated_records.count).to eq 10
            end

            it "returns 10 records from right page" do
                paginated_records = described_class.paginate(page, nil)
                first_record_index = 10
                last_record_index = 19
                expected_records = described_class.all[first_record_index..last_record_index]
                expect(paginated_records).to eq expected_records
            end
        end

        context "When :page and :length are filfilled and fits records size" do
            let(:page) { 2 }
            let(:length) { 5 }

            it "returns right quantity of records" do
                paginated_records = described_class.paginate(page, length)
                expect(paginated_records.count).to eq 5
            end

            it "returns records from right page" do
                paginated_records = described_class.paginate(page, length)
                first_record_index = 5
                last_record_index = 9
                expected_records = described_class.all[first_record_index..last_record_index]
                expect(paginated_records).to eq expected_records
            end
        end

        context "When :page and length are filfilled and does not fit records size" do
            let(:page) { 2 }
            let(:length) { 30 }

            it "does not return any record" do
                paginated_records = described_class.paginate(page, length)
                expect(paginated_records.count).to eq 0
            end

            it "returns empty result" do
                paginated_records = described_class.paginate(page, length)
                expect(paginated_records).to_not be_present
            end
        end

    end

    context "When records does not fit page size" do
        let!(:records) { create_list(factory_name, 7) }

        it "when :page and : length are empty" do
            paginated_records = described_class.paginate(nil, nil)
            expect(paginated_records.count).to eq 7
        end

        it "matches first 7 records" do
            paginated_records = described_class.paginate(nil, nil)
            expected_records = described_class.all[0..6]
            expect(paginated_records).to eq expected_records
        end

        context "When :page is filfilled and :length is empty" do
            let(:page) { 2 }

            it "does not return any record" do
                paginated_records = described_class.paginate(page, nil)
                expect(paginated_records.count).to eq 0
            end

            it "returns empty result" do
                paginated_records = described_class.paginate(page, nil)
                expect(paginated_records).to_not be_present
            end
        end

        context "When :page and :length are filfilled" do
            let(:page) { 2 }
            let(:length) { 5 }

            it "returns right quantity of records" do
                paginated_records = described_class.paginate(page, length)
                expect(paginated_records.count).to eq 2
            end

            it "returns records from right page" do
                paginated_records = described_class.paginate(page, length)
                first_record_index = 5
                last_record_index = 6
                expected_records = described_class.all[first_record_index..last_record_index]
                expect(paginated_records).to eq expected_records
            end
        end
    end
end
