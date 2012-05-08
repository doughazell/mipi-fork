namespace :messaging do
    desc "Evaluate all messages to ensure the text has been populated. This should be run following the loading of test fixtures."
    task :initialise => :environment do
        SubscriptionMessageDataElement.find(:all).each do |message|
            message.evaluate
        end
        
        puts SubscriptionMessageDataElement.find(:all).count.to_s
        puts "Done!"
    end

    desc "Display all messages currently stored in the system."    
    task :display do
        MessageDataElement.all.each do |message|
            puts message.message_text
        end
    end
    
    task :poll_pending_evaluations do
        SubscriptionEvalutaionQueue.evaluate_all
    end
end