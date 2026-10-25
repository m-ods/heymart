-- Seed data for heymart-db
-- This file contains all initial content migrated from Markdown files

-- Insert default admin user (password should be changed after first login)
-- Default password: "changeme123" (hashed)
INSERT INTO users (email, name, role, password, created_at, updated_at) 
VALUES (
  'martin@assemblyai.com',
  'Martin Schweiger',
  'admin',
  '$2a$10$abcdefghijklmnopqrstuvwxyz123456789',
  datetime('now'),
  datetime('now')
);

-- Insert blog posts
INSERT INTO posts (title, slug, excerpt, content, published_at, status, created_at, updated_at) VALUES
(
  'You should work out of whatever platform you like',
  'platform-agnostic-work',
  'Work should be able to move with your preferred tools.',
  '{"root":{"children":[{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"One of my dreams for the future is that work becomes platform agnostic.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"I''m not asking for more regulation or \"open standards\".","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"I''m saying that each of us have our preferred platforms that all fundamentally do the same thing.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Messages, channels, threads, DMs, cc, bcc","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Tasks, tickets, status updates, issues, complaints, forms","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Events, calendars, meetings, availabilities, scheduling, timezones","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"And every time we work with someone else, there''s that awkward phase of where we''re going to land and which stack we''re going to adopt.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"But you come with your own preferences, your own workflows, your own tools.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"You should be able to bring them to work with you.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"It should feel as insignificant/unimportant as the brand of screwdriver that you use because at the end of the day, all screwdrivers do the same thing.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"I for example really hate email.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"It has never made sense to me.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"I only email when I''m forced to.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"I would much rather get a text on Telegram for person-to-person communication.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Email to me is basically a giant spam folder with the occasional nugget.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"I wonder if the fastest path to this vision is with agents that constantly do the translation for us.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Agents that monitor all the platforms and then put things in the right place, for you.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1}],"direction":"ltr","format":"","indent":0,"type":"root","version":1}}',
  datetime('2024-01-15'),
  'published',
  datetime('now'),
  datetime('now')
),
(
  'Humans love bathing',
  'humans-love-bathing',
  'A short note on baths, showers, and saunas.',
  '{"root":{"children":[{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Humans love bathing.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Other countries that love baths:","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1},{"children":[{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Finland","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"listitem","version":1,"value":1},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Korea","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"listitem","version":1,"value":2},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Taiwan","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"listitem","version":1,"value":3},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Japan","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"listitem","version":1,"value":4},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Germany","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"listitem","version":1,"value":5},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Every kid ever","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"listitem","version":1,"value":6},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Brazilians apparently love showering","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"listitem","version":1,"value":7}],"direction":"ltr","format":"","indent":0,"type":"list","version":1,"listType":"bullet","start":1,"tag":"ul"},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Something about bathing is relaxing. I personally am addicted to going to the sauna.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1}],"direction":"ltr","format":"","indent":0,"type":"root","version":1}}',
  datetime('2024-02-20'),
  'published',
  datetime('now'),
  datetime('now')
),
(
  'Confessions of a Hedonist',
  'confessions-of-a-hedonist',
  'A one-line warning.',
  '{"root":{"children":[{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"The endstate of hedonism is self-loathing.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1}],"direction":"ltr","format":"","indent":0,"type":"root","version":1}}',
  datetime('2024-03-10'),
  'published',
  datetime('now'),
  datetime('now')
);

-- Insert Pages
INSERT INTO pages (title, slug, page_type, content, data, created_at, updated_at) VALUES
(
  'Places I''ve been',
  'been',
  'been',
  '{"root":{"children":[{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"18 countries, 43 cities (16 countries if you don''t count layovers).","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1}],"direction":"ltr","format":"","indent":0,"type":"root","version":1}}',
  '{"destinations":[{"country":"USA","cities":[{"name":"New York","visits":"Dec 2021, Sep–Oct 2023, Oct 2024, Mar 2026 (twice), Jul–Aug 2026"},{"name":"Boston","visits":"Dec 2021, Jun 2025"},{"name":"Philadelphia","visits":"Dec 2021"},{"name":"Orlando","visits":"Feb 2023"},{"name":"San Francisco","visits":"Jul 2023, Oct 2025"},{"name":"Seattle","visits":"Jul 2023"},{"name":"Atlanta","visits":"Oct 2023"},{"name":"Las Vegas","visits":"Jan–Feb 2024"},{"name":"Austin","visits":"Jan 2025"},{"name":"Miami","visits":"Feb 2026"}]},{"country":"Canada","cities":[{"name":"Toronto","visits":"Sep–Oct 2025"},{"name":"Vancouver","visits":"layover"}]},{"country":"Brazil","cities":[{"name":"Rio de Janeiro","visits":"as a kid"}]},{"country":"France","cities":[{"name":"Paris","visits":"as a kid"}]},{"country":"Germany","cities":[{"name":"Munich","visits":"Sep 2023"}]},{"country":"Switzerland","cities":[{"name":"Zurich","visits":"layover"}]},{"country":"Turkey","cities":[{"name":"Istanbul","visits":"layover"}]},{"country":"China","cities":[{"name":"Shenzhen","visits":"Dec 2019"},{"name":"Huangshan","visits":"Dec 2019"},{"name":"Chengdu","visits":"Dec 2019"},{"name":"Beijing","visits":"Dec 2019"}]},{"country":"Hong Kong","cities":[{"name":"Hong Kong","visits":"Nov–Dec 2019"}]},{"country":"Taiwan","cities":[{"name":"Taipei","visits":"May 2026"}]},{"country":"Japan","cities":[{"name":"Tokyo","visits":"Jul 2026"}]},{"country":"South Korea","cities":[{"name":"Jeju","visits":"Apr 2023, Jun–Jul 2026"},{"name":"Busan","visits":"Apr 2023"},{"name":"Seoul","visits":"Apr 2023"}]},{"country":"Thailand","cities":[{"name":"Phuket","visits":"Mar 2023"}]},{"country":"Vietnam","cities":[{"name":"Da Nang","visits":"Nov 2023"},{"name":"Hoi An","visits":"Nov 2023"},{"name":"Ho Chi Minh City","visits":"as a kid"}]},{"country":"Philippines","cities":[{"name":"Bacolod","visits":"Mar 2024"}]},{"country":"Malaysia","cities":[{"name":"Johor Bahru","visits":"many trips, 2023–2026"},{"name":"Langkawi","visits":"Apr 2024"},{"name":"Penang","visits":"high school"}]},{"country":"Indonesia","cities":[{"name":"Bali","visits":"Dec 2024"},{"name":"Yogyakarta","visits":"as a kid"},{"name":"Bintan","visits":"as a kid"},{"name":"Batam","visits":"as a kid"}]},{"country":"Australia","cities":[{"name":"Gold Coast","visits":"Nov 2022"},{"name":"Brisbane","visits":"Nov 2022"},{"name":"Perth","visits":"Jul 2025"},{"name":"Melbourne","visits":"Sep 2026"}]}]}',
  datetime('now'),
  datetime('now')
),
(
  'Loves',
  'loves',
  'loves',
  NULL,
  '{"categories":[{"title":"Food & Drink","items":[{"label":"Coffee"},{"label":"Cata Coffee at East Coast","href":"https://catacoffee.com/"},{"label":"Pizza"},{"label":"Sourdough bread"},{"label":"Corn thins","href":"https://www.cornthins.com/"},{"label":"Chocolate cake"},{"label":"Ice cream"},{"label":"Watermelon"},{"label":"Sparkling water","href":"https://aarke.com/en-row/collections/carbonators/products/carbonator-pro-matte-black"}]},{"title":"Machines & Making","items":[{"label":"My Cafelat machine","href":"https://www.cafelat.com/robot.html"},{"label":"Craft: clean code"},{"label":"Assembling IKEA furniture","href":"https://www.ikea.com/"},{"label":"Design"},{"label":"Art"},{"label":"Animations"},{"label":"Video"}]},{"title":"Culture","items":[{"label":"Music"},{"label":"YouTube","href":"https://www.youtube.com/"},{"label":"Comedy"},{"label":"History"},{"label":"Marketing"}]},{"title":"Materials","items":[{"label":"Stainless steel"},{"label":"Silver"},{"label":"Solid wood"},{"label":"Gold"},{"label":"Diamond"},{"label":"Cotton"}]},{"title":"Body & Place","items":[{"label":"Strength training"},{"label":"Pilates"},{"label":"Sauna"},{"label":"Beach"},{"label":"Travelling"},{"label":"Jets","shout":true},{"label":"Cars"}]},{"title":"Good Experiences","items":[{"label":"Petting zoos"},{"label":"Fine dining","href":"https://naeum.sg/"},{"label":"Obscure travel destinations","href":"https://www.atlasobscura.com/"},{"label":"Last minute plans","href":"https://www.kayak.com/"},{"label":"Quiet fun with people I love"}]},{"title":"Good Products","items":[{"label":"La-Z-Boy chair","href":"https://www.la-z-boy.com/"},{"label":"Pianos","href":"https://www.steinway.com/"},{"label":"New Balance shoes","href":"https://www.newbalance.com/"}]},{"title":"People & Faith","items":[{"label":"Family"},{"label":"Kids"},{"label":"God"}]}]}',
  datetime('now'),
  datetime('now')
),
(
  'Daily Timebox Planner',
  'timebox',
  'timebox',
  NULL,
  NULL,
  datetime('now'),
  datetime('now')
),
(
  'Martin Schweiger',
  'wiki',
  'wiki',
  NULL,
  NULL,
  datetime('now'),
  datetime('now')
),
(
  'Wikipedia Manual of Style',
  'wiki-mos',
  'wiki-mos',
  '{"root":{"children":[{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"Condensed guidelines from Wikipedia:Manual of Style and MoS/Biography, applied to this project.","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1}],"direction":"ltr","format":"","indent":0,"type":"root","version":1}}',
  NULL,
  datetime('now'),
  datetime('now')
);

-- Insert Site Settings
INSERT INTO site_settings (site_name, tagline, top_links, navigation, created_at, updated_at) VALUES (
  'HEYMART',
  'Software engineer and builder',
  '[{"label":"X (Twitter)","href":"https://x.com/martschweiger"},{"label":"GitHub","href":"https://github.com/m-ods"},{"label":"LinkedIn","href":"https://www.linkedin.com/in/martinschweiger/"},{"label":"YouTube","href":"#"},{"label":"Email","href":"mailto:martin@assemblyai.com"}]',
  '[{"label":"Home","href":"/"},{"label":"Scribbles","href":"/blog"},{"label":"Loves","href":"/loves"},{"label":"Now","href":"/now"}]',
  datetime('now'),
  datetime('now')
);
