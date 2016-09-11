CREATE DATABASE IF NOT EXISTS sawa_zen_dev;

USE sawa_zen_dev;

CREATE TABLE IF NOT EXISTS articles (
  id INT(11) NOT NULL AUTO_INCREMENT,
  title VARCHAR(200) NOT NULL,
  content TEXT,
  eye_catching TEXT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS images (
  id INT(11) NOT NULL AUTO_INCREMENT,
  url TEXT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS users (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(128),
  password_digest VARCHAR(128),
  access_key VARCHAR(128),
  access_secret_key VARCHAR(128),
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY (id)
);
