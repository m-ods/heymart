# HEYMART - Personal Website with Payload CMS v3

Martin Schweiger's personal website, rebuilt with **Payload CMS v3** running on **Cloudflare Workers** with **D1 (SQLite)** database and **R2** storage.

Live site: [heym.art](https://heym.art)

## 🏗️ Architecture

- **CMS**: Payload CMS v3
- **Frontend**: Next.js 15 with React 19
- **Database**: Cloudflare D1 (SQLite)
- **Media Storage**: Cloudflare R2
- **Hosting**: Cloudflare Workers (via @cloudflare/next-on-pages)
- **Custom Domain**: `heym.art`

## 📋 Prerequisites

- Node.js 18+ and npm
- Cloudflare account with Workers/Pages enabled
- Wrangler CLI installed: `npm install -g wrangler`
- Cloudflare account ID: `df5bcb0a018879e7c77f79718dd0cced`

## 🚀 Cloudflare Resources (Already Provisioned)

The following resources are configured in `wrangler.jsonc`:

- **D1 Database**: `heymart-db`
  - Database ID: `e752bf27-b893-4edf-bc84-d6c2f367e68f`
  - Binding: `D1`
  
- **R2 Bucket**: `heymart-media`
  - Binding: `R2`
  - Used for media/image uploads

- **Worker**: `heymart`
  - Custom domain: `heym.art`

## 🛠️ Local Development Setup

### 1. Clone and Install Dependencies

```bash
git clone <repo-url>
cd heymart
npm install
```

### 2. Configure Environment Variables

Copy the example environment file:

```bash
cp .env.example .env
```

Edit `.env` and configure:

```env
# SQLite database file path (for local development)
DATABASE_FILE_PATH=./db/database.db

# Payload CMS secret key (generate with: openssl rand -base64 32)
PAYLOAD_SECRET=your-secret-key-here

# Cloudflare R2 credentials
R2_ACCOUNT_ID=df5bcb0a018879e7c77f79718dd0cced
R2_ACCESS_KEY_ID=your-access-key-id
R2_SECRET_ACCESS_KEY=your-secret-access-key
R2_BUCKET_NAME=heymart-media
R2_PUBLIC_URL=https://your-public-url.r2.dev

# Next.js
NEXT_PUBLIC_SERVER_URL=http://localhost:3000
```

### 3. Initialize Local Database

Create the database directory and run migrations:

```bash
mkdir -p db
# The migrations will run automatically on first start
```

### 4. Run Migrations (if needed manually)

```bash
npm run migrate
```

### 5. Seed Initial Data

Import existing content from Markdown files:

```bash
npm run seed
```

This will create:
- Admin user (email: `martin@assemblyai.com`, password: `changeme123`)
- All blog posts from markdown files
- Site settings
- Page stubs

⚠️ **Change the default password after first login!**

### 6. Start Development Server

```bash
npm run dev
```

Visit:
- Frontend: http://localhost:3000
- Admin Panel: http://localhost:3000/admin

## 🗄️ Database Schema & Migrations

### Applying Migrations to Remote D1 Database

The SQL migration files are in `/migrations/`:

1. **`001_initial_schema.sql`** - Creates all tables and indexes
2. **`002_seed_data.sql`** - Seeds initial content

#### Apply via Cloudflare Dashboard

```bash
# Apply schema migration
wrangler d1 execute heymart-db --file=./migrations/001_initial_schema.sql --remote

# Apply seed data
wrangler d1 execute heymart-db --file=./migrations/002_seed_data.sql --remote
```

#### Verify Migration Status

```bash
wrangler d1 execute heymart-db --command="SELECT * FROM payload_migrations" --remote
```

#### Query Tables

```bash
# List all posts
wrangler d1 execute heymart-db --command="SELECT id, title, slug, status FROM posts" --remote

# Check users
wrangler d1 execute heymart-db --command="SELECT id, email, name, role FROM users" --remote
```

## 📦 Collections

### Posts
Blog articles with:
- Title, slug, excerpt
- Rich text content (Lexical editor)
- Published date and status

### Media
Images and files stored in R2:
- Filename, MIME type, filesize
- Auto-generated thumbnails
- Dimensions (width/height)

### Vitiligo Entries
Timeline entries with:
- Date (YYYY-MM format)
- Text description
- Multiple images (relationship to Media)

### Pages
Static pages like `/been`, `/loves`, `/timebox`, `/wiki`:
- Title and slug
- Page type
- Rich text content
- Structured JSON data

### Users
Admin users with authentication:
- Email and password
- Role (admin/editor)
- API key support for agent access

## 🌐 Globals

### Site Settings
- Site name and tagline
- Top links
- Navigation menu items

## 🚢 Production Deployment

### 1. Build for Production

```bash
npm run build
```

This will:
- Build Payload CMS
- Build Next.js app
- Create Cloudflare Workers-compatible output

### 2. Deploy to Cloudflare Workers

```bash
npm run deploy
```

Or manually with Wrangler:

```bash
npx wrangler pages deploy .vercel/output/static --project-name=heymart
```

### 3. Configure Bindings (if not in wrangler.jsonc)

Bindings are already configured in `wrangler.jsonc`, but you can verify:

```bash
wrangler pages deployment list --project-name=heymart
```

### 4. Environment Variables for Production

Set these in Cloudflare Dashboard (Workers & Pages > heymart > Settings > Environment Variables):

- `PAYLOAD_SECRET`
- `R2_ACCOUNT_ID`
- `R2_ACCESS_KEY_ID`
- `R2_SECRET_ACCESS_KEY`
- `R2_BUCKET_NAME`
- `R2_PUBLIC_URL`
- `NEXT_PUBLIC_SERVER_URL` (set to `https://heym.art`)

## 🎨 Pages & Routes

### Public Routes
- `/` - Home page
- `/blog` - Blog listing
- `/blog/[slug]` - Individual blog posts
- `/been` - Travel destinations
- `/loves` - Favorite things (Stardew Valley theme)
- `/timebox` - Daily planner
- `/vitiligo` - Photo timeline
- `/wiki` - Personal Wikipedia-style page
- `/wiki-mos` - Wikipedia Manual of Style reference

### Admin Routes
- `/admin` - Payload CMS admin panel
- `/api/*` - Payload REST API endpoints

## 🔐 Agent-Friendly API Access

Payload CMS v3 supports:
- **REST API**: `/api/posts`, `/api/media`, etc.
- **GraphQL API**: `/api/graphql`
- **API Keys**: Generate in Users collection for agent authentication

Example API call:

```bash
curl -H "Authorization: users API-Key YOUR_KEY" \
  https://heym.art/api/posts?where[status][equals]=published
```

## 🖼️ Migrating Vitiligo Images

The original vitiligo images are in `/public/vitiligo/`. To migrate:

1. Upload images via Payload admin (`/admin/collections/media`)
2. Create vitiligo entries linking to uploaded media
3. Or use the Media collection API to bulk upload

## 📝 Content Migration Notes

All existing content has been migrated from Astro/Markdown to Payload CMS:

- ✅ Blog posts (3 posts)
- ✅ Site settings (navigation, top links)
- ✅ Page stubs (been, loves, timebox, wiki)
- ⏳ Vitiligo images (need manual upload due to R2 setup)

## 🧪 Type Generation

Payload auto-generates TypeScript types:

```bash
npm run generate:types
```

Types are output to `src/payload-types.ts`.

## 🛡️ Security Notes

- Default admin password is `changeme123` - **CHANGE THIS IMMEDIATELY**
- Never commit `.env` files
- Use environment variables for all secrets
- Enable 2FA for Cloudflare account

## 📚 Additional Resources

- [Payload CMS v3 Docs](https://payloadcms.com/docs)
- [Cloudflare D1 Docs](https://developers.cloudflare.com/d1/)
- [Cloudflare R2 Docs](https://developers.cloudflare.com/r2/)
- [Next.js on Cloudflare Workers](https://github.com/cloudflare/next-on-pages)

## 🐛 Troubleshooting

### Database Locked Error

If you see "database is locked":
```bash
rm -rf db/database.db-*
```

### Payload Build Errors

Clear Next.js cache:
```bash
rm -rf .next
npm run build
```

### R2 Upload Issues

Verify R2 credentials and bucket permissions in Cloudflare dashboard.

## 📄 License

Personal project - All rights reserved.

---

Built with ❤️ by Martin Schweiger
