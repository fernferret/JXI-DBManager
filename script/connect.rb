require 'dbi'
db = DBI.connect("DBI:SQLRelay:host=titan.csse.rose-hulman.edu;port=3334;socket=/tmp/mysock.socket","rhodeska","change")
stmt=db.prepare("select * from mytable")
stmt.execute()