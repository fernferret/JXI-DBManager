begin
	require 'metric_fu'

	MetricFu::Configuration.run do |config|
		config.graphs = [:flog, :reek]
		config.metrics = [:flog,:reek,:stats, :saikuro]
		config.flog = { :dirs_to_flog => ['app'] }
		config.reek = { :dirs_to_reek => ['app', 'lib'] }
		config.saikuro  = { :output_directory => 'tmp/metric_fu/scratch/saikuro',:input_directory => ['app'],:cyclo => "",:filter_cyclo => "0",:warn_cyclo => "11",:error_cyclo => "16",:formater => "text"} #this needs to be set to "text"
	end
rescue LoadError
end
