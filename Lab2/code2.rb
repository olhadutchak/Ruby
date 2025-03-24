require 'json'

contacts = {}

def add_contact(contacts, name, phone)
  contacts[name] = { number: phone }
  puts "Contact \"#{name}\" added successfully."
end

def update_contact(contacts, old_name, new_name: nil, new_phone: nil)
  if contacts.key?(old_name)
    contacts[old_name][:number] = new_phone if new_phone
    if new_name && new_name != old_name
      contacts[new_name] = contacts.delete(old_name)
    end
    puts "Contact updated."
  else
    puts "Contact not found."
  end
end

def remove_contact(contacts, name)
  if contacts.delete(name)
    puts "Contact \"#{name}\" deleted."
  else
    puts "Contact not found."
  end
end

def show_contacts(contacts)
  if contacts.empty?
    puts "Your contact list is empty."
  else
    puts "\nYour contacts:"
    contacts.each { |name, details| puts "- #{name}: #{details[:number]}" }
  end
end

def save_to_file(contacts, filename)
  File.write(filename, JSON.pretty_generate(contacts))
  puts "Contacts saved to \"#{filename}\"."
end

def load_from_file(filename)
  File.exist?(filename) ? JSON.parse(File.read(filename)) : {}
end

def menu
  puts "\nChoose an action:"
  puts "1. View all contacts"
  puts "2. Add a contact"
  puts "3. Update a contact"
  puts "4. Delete a contact"
  puts "5. Save to file"
  puts "6. Load from file"
  puts "7. Exit"
end

loop do
  menu
  print "Your choice: "
  choice = gets.chomp.to_i

  case choice
  when 1
    show_contacts(contacts)
  when 2
    print "Enter contact name: "
    name = gets.chomp
    print "Enter phone number: "
    phone = gets.chomp
    add_contact(contacts, name, phone)
  when 3
    print "Enter the name of the contact to update: "
    old_name = gets.chomp
    print "New name (press Enter to keep the same): "
    new_name = gets.chomp
    print "New phone number (press Enter to keep the same): "
    new_phone = gets.chomp
    update_contact(contacts, old_name, new_name: new_name.empty? ? nil : new_name, new_phone: new_phone.empty? ? nil : new_phone)
  when 4
    print "Enter the name of the contact to delete: "
    name = gets.chomp
    remove_contact(contacts, name)
  when 5
    print "Enter filename to save: "
    filename = gets.chomp
    save_to_file(contacts, filename)
  when 6
    print "Enter filename to load: "
    filename = gets.chomp
    contacts = load_from_file(filename)
    puts "Contacts loaded from \"#{filename}\"."
  when 7
    puts "Goodbye!"
    break
  else
    puts "Invalid choice, please try again."
  end
end
