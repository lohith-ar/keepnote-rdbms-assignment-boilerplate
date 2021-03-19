### Expected Solution

Create the tables for Note, Category, Reminder, User, UserNote, NoteReminder and NoteCategory.

User table fields: user_id, user_name, user_added_date, user_password, user_mobile

Note table fields: note_id, note_title, note_content, note_status, note_creation_date

Category table fields : category_id, category_name, category_descr, category_creation_date, category_creator

Reminder table fields : reminder_id, reminder_name, reminder_descr, reminder_type, reminder_creation_date, reminder_creator

NoteCategory table fields : notecategory_id, note_id, category_id

Notereminder table fields : notereminder_id, note_id, reminder_id

usernote table fields : usernote_id, user_id, note_id

##CREATING TABLES:
create database KeepNote
use KeepNote
create table Note (note_id int primary key, note_title varchar(25), note_content varchar(50), note_status varchar(15), note_creation_date date not null);
create table Category(category_id int primary key,category_name varchar(15), category_descr varchar(100), category_creation_date date not null, category_creator varchar(15))
create table Reminder(reminder_id int primary key,reminder_name varchar(15), reminder_descr varchar(100), reminder_type varchar(15), reminder_creation_date date, reminder_creator char(20))
create table User( user_id int primary key,user_name varchar(20), user_added_date date, user_password varchar(20), user_mobile char(10))
create table UserNote(usernote_id int primary key,user_id int, note_id int)
create table NoteReminder( notereminder_id int primary key,note_id int, reminder_id int)
create table NoteCategory( notecategory_id int primary key,note_id int, category_id int)


Insert the rows into the created tables (Note, Category, Reminder, User, UserNote, NoteReminder and NoteCategory).

Fetch the row from User table based on Id and Password.

Fetch all the rows from Note table based on the field note_creation_date.

Fetch all the Categories created after the particular Date.

Fetch all the Note ID from UserNote table for a given User.

Write Update query to modify particular Note for the given note Id.

Fetch all the Notes from the Note table by a particular User.

Fetch all the Notes from the Note table for a particular Category.

Fetch all the reminder details for a given note id.

Fetch the reminder details for a given reminder id.

##INSERT&FETCH:
insert into NoteCategory values(2,2,2 );
insert into NoteReminder values(2, 2,2 );
insert into UserNote values(1, 1, 1);
insert into User values(2, 'sai',curdate(),'password','9999999991');
insert into Reminder values(2, 'buy fruits','buy 5 apples and vegetables','remind',curdate(), 'sai');
insert into Category values(2, 'fruits&vegetables', 'fruits&vegetables category',curdate(), 'sai');
insert into Note values(1, 'note tite1' ,' this is new note title1', 'active' , '2021-03-17');
insert into Note values(2, 'note tite2' ,' this is new note title2', 'active' , '2021-03-17');
select * from User where user_id=1 and user_password='password'
select * from Category where category_creation_date> '2021-03-17';
select note_id from usernote where user_id=1;
update note set note_content ='this is modified note1' where note_id =1;
select * from note where note_id = (select note_id from usernote where user_id =1)
select * from note where note_id = (select note_id from notecategory where notecategory_id =1)
select * from reminder where reminder_id = (select note_id from notereminder where note_id =1)
select * from reminder where reminder_id =1;


Write a query to create a new Note from particular User (Use Note and UserNote tables - insert statement).

Write a query to create a new Note from particular User to particular Category(Use Note and NoteCategory tables - insert statement)

Write a query to set a reminder for a particular note (Use Reminder and NoteReminder tables - insert statement)

Write a query to delete particular Note added by a User(Note and UserNote tables - delete statement)

Write a query to delete particular Note from particular Category(Note and NoteCategory tables - delete statement)

##INSERT&DELETE:
insert into note (note_id, note_title, note_content, note_status, note_creation_date) values(3, 'note tite3' ,' this is new note title3', 'active' , curdate()) 
insert into usernote values(5,5,5)
insert into note (note_id, note_title, note_content, note_status, note_creation_date) values(6, 'note tite4' ,' this is new note title4', 'active' , curdate()) 
insert into notecategory values(5,6,5)
insert into reminder values(3,'go for movie','go to jaathirathnalu movie at 10pm','movie reminder',curdate(), 'lohith')
insert into notereminder value(5,6,5)
delete note, usernote from note inner join usernote on (note.note_id= usernote.note_id) where usernote.note_id=1;
delete note, notecategory from note inner join notecategory on (note.note_id= notecategory.note_id) where notecategory.note_id=2;



Create a trigger to delete all matching records from UserNote, NoteReminder and NoteCategory table when :
	1. A particular note is deleted from Note table (all the matching records from UserNote, NoteReminder and NoteCategory should be removed automatically) 
	2. A particular user is deleted from User table (all the matching notes should be removed automatically)

##TRIGGERS:
DELIMITER &&
CREATE trigger afterdelete_in_note
after delete ON note for each row
begin
	delete from usernote where note_id = old.note_id;
	delete from notereminder where note_id = old.note_id;
	delete from notecategory where note_id = old.note_id;
end &&

DELIMITER &&
CREATE trigger afterdelete_in_user
after delete ON user for each row
begin
	declare a integer;
	set a = (select note_id from usernote where user_id = old.user_id);
	delete from usernote where note_id = old.user_id;
	delete from notereminder where note_id = a;
	delete from notecategory where note_id = a;
end &&


