namespace :stats do

	desc "Geographic statistics on recorded fluxes"
	task :geographic do
		require './lib/bootstrap'
		all_fluxes = Marchflux::Flux.all.count
		fluxes_with_geodata = Marchflux::Flux.where(:latitude.gt => 0).count
		percent_with_geodata = fluxes_with_geodata.to_f / all_fluxes.to_f

		puts "Total fluxes: #{all_fluxes.to_s}"
		puts "Fluxes with geodata: #{fluxes_with_geodata.to_s}"
		puts "Percent of fluxes with geodata: #{percent_with_geodata.to_s}%"
	end

end