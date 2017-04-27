CREATE TABLE user (
  uid serial not null primary key,
  username varchar(20) not null unique,
  email varchar(256) not null unique,
  password varchar(30) not null
);

CREATE TABLE category (
  cid serial not null primary key,
  name varchar(20) not null unique
);

CREATE TABLE gee (
  gid serial not null primary key,
  user int not null references user(uid),
  name varchar(20) not null unique,
  description varchar(20) not null,
  category int not null references category(cid),
  expiration_date timestamp not null
);

CREATE TABLE field (
  fid serial not null primary key,
  gee int not null references gee(gid),
  name varchar(20) not null,
  type char(3) not null,
  min_value int,
  max_value int,
  unique (gee, name)
);

CREATE TABLE alternative (
  aid serial not null primary key,
  field int not null references field(fid),
  value varchar(20) not null,
  unique (field, value)
);

CREATE TABLE bet (
  bid serial not null primary key,
  user int not null references user(uid),
  gee int not null references gee(gid),
  quantity int not null
);

CREATE TABLE value (
  vid serial not null primary key,
  bet int not null references bet(bid),
  field int not null references field(fid),
  value int not null
);
