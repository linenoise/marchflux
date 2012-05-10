namespace :test do

	desc "Load test fixtures"
	task :load_fixtures do
		require './lib/bootstrap'
		puts "Loading fixtures..."
		Dir['./test/fixtures/*.rb'].sort.each do |fixture|
			puts fixture
			load fixture
			fixture_namespace = Marchflux::Test::Fixtures.const_get(fixture.split(/\//)[-1].split(/\./)[0].humanize)
			if fixture_namespace.respond_to?(:build)
				fixture_namespace.build
			else
				puts "   - No #build method in #{fixture_namespace}.  Skipping."
				next
			end
		end
	end

end