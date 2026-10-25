import path from 'path'
import { fileURLToPath } from 'url'
import { buildConfig } from 'payload'
import { sqliteAdapter } from '@payloadcms/db-sqlite'
import { lexicalEditor } from '@payloadcms/richtext-lexical'
import { r2Storage } from '@payloadcms/storage-r2'

// Collections
import { Users } from './collections/Users'
import { Posts } from './collections/Posts'
import { VitiligoEntries } from './collections/VitiligoEntries'
import { Media } from './collections/Media'
import { Pages } from './collections/Pages'

// Globals
import { SiteSettings } from './globals/SiteSettings'

const filename = fileURLToPath(import.meta.url)
const dirname = path.dirname(filename)

export default buildConfig({
  admin: {
    user: Users.slug,
    importMap: {
      baseDir: path.resolve(dirname),
    },
  },
  collections: [Users, Posts, VitiligoEntries, Media, Pages],
  globals: [SiteSettings],
  editor: lexicalEditor({}),
  secret: process.env.PAYLOAD_SECRET || 'your-secret-key-here',
  typescript: {
    outputFile: path.resolve(dirname, 'payload-types.ts'),
  },
  db: sqliteAdapter({
    client: {
      url: process.env.DATABASE_FILE_PATH ? `file:${process.env.DATABASE_FILE_PATH}` : 'file:./db/database.db',
    },
  }),
  // plugins: [
  //   r2Storage({
  //     collections: {
  //       media: true,
  //     },
  //     bucket: process.env.R2_BUCKET_NAME || 'heymart-media',
  //     config: {
  //       accountId: process.env.R2_ACCOUNT_ID || '',
  //       accessKeyId: process.env.R2_ACCESS_KEY_ID || '',
  //       secretAccessKey: process.env.R2_SECRET_ACCESS_KEY || '',
  //     },
  //   }),
  // ],
  plugins: [],
})
