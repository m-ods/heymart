-- Payload CMS v3 Schema for D1 (SQLite)
-- Database: heymart-db (e752bf27-b893-4edf-bc84-d6c2f367e68f)

-- Users collection
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  name TEXT NOT NULL,
  role TEXT NOT NULL DEFAULT 'editor',
  salt TEXT,
  hash TEXT,
  loginAttempts INTEGER DEFAULT 0,
  lockUntil INTEGER,
  resetPasswordToken TEXT,
  resetPasswordExpiration INTEGER,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS users_email_idx ON users(email);
CREATE INDEX IF NOT EXISTS users_created_at_idx ON users(created_at);

-- Posts collection
CREATE TABLE IF NOT EXISTS posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  excerpt TEXT,
  content TEXT NOT NULL,
  published_at TEXT,
  status TEXT NOT NULL DEFAULT 'draft',
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS posts_slug_idx ON posts(slug);
CREATE INDEX IF NOT EXISTS posts_status_idx ON posts(status);
CREATE INDEX IF NOT EXISTS posts_published_at_idx ON posts(published_at);

-- Media collection
CREATE TABLE IF NOT EXISTS media (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  filename TEXT NOT NULL,
  mime_type TEXT,
  filesize INTEGER,
  width INTEGER,
  height INTEGER,
  alt TEXT,
  url TEXT,
  thumbnail_url TEXT,
  card_url TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS media_filename_idx ON media(filename);

-- Vitiligo Entries collection
CREATE TABLE IF NOT EXISTS vitiligo_entries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date TEXT NOT NULL UNIQUE,
  text TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS vitiligo_entries_date_idx ON vitiligo_entries(date);

-- Vitiligo Entry Images (relationship)
CREATE TABLE IF NOT EXISTS vitiligo_entries_images (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  vitiligo_entry_id INTEGER NOT NULL,
  media_id INTEGER NOT NULL,
  order_index INTEGER NOT NULL DEFAULT 0,
  FOREIGN KEY (vitiligo_entry_id) REFERENCES vitiligo_entries(id) ON DELETE CASCADE,
  FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS vitiligo_entries_images_entry_idx ON vitiligo_entries_images(vitiligo_entry_id);
CREATE INDEX IF NOT EXISTS vitiligo_entries_images_media_idx ON vitiligo_entries_images(media_id);

-- Pages collection
CREATE TABLE IF NOT EXISTS pages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  page_type TEXT NOT NULL,
  content TEXT,
  data TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS pages_slug_idx ON pages(slug);
CREATE INDEX IF NOT EXISTS pages_type_idx ON pages(page_type);

-- Site Settings global
CREATE TABLE IF NOT EXISTS site_settings (
  id INTEGER PRIMARY KEY CHECK (id = 1),
  site_name TEXT NOT NULL DEFAULT 'HEYMART',
  tagline TEXT,
  top_links TEXT,
  navigation TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Payload migrations tracking
CREATE TABLE IF NOT EXISTS payload_migrations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  batch INTEGER NOT NULL,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Record this migration
INSERT INTO payload_migrations (name, batch) VALUES ('001_initial_schema', 1);
