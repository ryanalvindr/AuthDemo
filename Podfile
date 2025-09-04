# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'AuthDemo' do
  pod 'SnapKit'


  target 'AuthDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AuthDemoUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  # 1) Disable Xcode 15+ script sandboxing everywhere (Pods + app targets)
  # This removes the "Sandbox: rsync deny file-write-create ..." error.
  (installer.pods_project.targets +
   installer.aggregate_targets.map(&:user_project).uniq.flat_map { |p| p.targets }).each do |t|
    t.build_configurations.each do |config|
      config.build_settings['ENABLE_USER_SCRIPT_SANDBOXING'] = 'NO'
    end
  end
end
