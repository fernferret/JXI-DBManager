begin
	require 'metric_fu'

	MetricFu::Configuration.run do |config|
		config.graphs = []
		config.metrics = [:flog]
		config.flog = { :dirs_to_flog => ['app'] }
	end
rescue LoadError
end
