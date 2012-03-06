guard 'bundler' do
  watch('Gemfile')
end

guard 'rspec', version: 2, cli: "--color --format nested --tag ~js:true --drb",
  :all_after_pass => false, :all_on_start => true do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }
end