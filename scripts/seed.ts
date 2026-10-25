#!/usr/bin/env tsx
/**
 * Seed script to import existing content from markdown files into Payload CMS
 * Run with: npm run seed
 */

import { getPayload } from 'payload'
import config from '../src/payload.config'
import fs from 'fs'
import path from 'path'
import { fileURLToPath } from 'url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)

// Blog posts content (from markdown files)
const blogPosts = [
  {
    title: 'You should work out of whatever platform you like',
    slug: 'platform-agnostic-work',
    excerpt: 'Work should be able to move with your preferred tools.',
    content: `One of my dreams for the future is that work becomes platform agnostic.

I'm not asking for more regulation or "open standards".
I'm saying that each of us have our preferred platforms that all fundamentally do the same thing.

Messages, channels, threads, DMs, cc, bcc
Tasks, tickets, status updates, issues, complaints, forms
Events, calendars, meetings, availabilities, scheduling, timezones

And every time we work with someone else, there's that awkward phase of where we're going to land and which stack we're going to adopt.

But you come with your own preferences, your own workflows, your own tools.
You should be able to bring them to work with you.
It should feel as insignificant/unimportant as the brand of screwdriver that you use because at the end of the day, all screwdrivers do the same thing.

I for example really hate email.
It has never made sense to me.
I only email when I'm forced to.

I would much rather get a text on Telegram for person-to-person communication.
Email to me is basically a giant spam folder with the occasional nugget.

I wonder if the fastest path to this vision is with agents that constantly do the translation for us.
Agents that monitor all the platforms and then put things in the right place, for you.`,
    publishedAt: '2024-01-15',
    status: 'published' as const,
  },
  {
    title: 'Humans love bathing',
    slug: 'humans-love-bathing',
    excerpt: 'A short note on baths, showers, and saunas.',
    content: `Humans love bathing.

Other countries that love baths:

- Finland
- Korea
- Taiwan
- Japan
- Germany
- Every kid ever
- Brazilians apparently love showering

Something about bathing is relaxing. I personally am addicted to going to the sauna.`,
    publishedAt: '2024-02-20',
    status: 'published' as const,
  },
  {
    title: 'Confessions of a Hedonist',
    slug: 'confessions-of-a-hedonist',
    excerpt: 'A one-line warning.',
    content: 'The endstate of hedonism is self-loathing.',
    publishedAt: '2024-03-10',
    status: 'published' as const,
  },
]

async function seed() {
  console.log('🌱 Starting seed process...')

  const payload = await getPayload({ config })

  try {
    // 1. Create admin user
    console.log('👤 Creating admin user...')
    const existingUsers = await payload.find({
      collection: 'users',
      limit: 1,
    })

    if (existingUsers.totalDocs === 0) {
      await payload.create({
        collection: 'users',
        data: {
          email: 'martin@assemblyai.com',
          password: 'changeme123',
          name: 'Martin Schweiger',
          role: 'admin',
        },
      })
      console.log('✅ Admin user created (email: martin@assemblyai.com, password: changeme123)')
      console.log('⚠️  PLEASE CHANGE THE PASSWORD AFTER FIRST LOGIN!')
    } else {
      console.log('✅ Admin user already exists')
    }

    // 2. Seed blog posts
    console.log('\n📝 Seeding blog posts...')
    for (const post of blogPosts) {
      const existing = await payload.find({
        collection: 'posts',
        where: {
          slug: {
            equals: post.slug,
          },
        },
        limit: 1,
      })

      if (existing.totalDocs === 0) {
        await payload.create({
          collection: 'posts',
          data: {
            ...post,
            content: {
              root: {
                type: 'root',
                children: post.content.split('\n\n').map((para) => ({
                  type: 'paragraph',
                  children: [
                    {
                      type: 'text',
                      text: para,
                      version: 1,
                    },
                  ],
                  direction: 'ltr',
                  format: '',
                  indent: 0,
                  version: 1,
                })),
                direction: 'ltr',
                format: '',
                indent: 0,
                version: 1,
              },
            },
          },
        })
        console.log(`  ✅ Created: ${post.title}`)
      } else {
        console.log(`  ⏭️  Skipped: ${post.title} (already exists)`)
      }
    }

    // 3. Seed site settings
    console.log('\n⚙️  Seeding site settings...')
    await payload.updateGlobal({
      slug: 'site-settings',
      data: {
        siteName: 'HEYMART',
        tagline: 'Software engineer and builder',
        topLinks: [
          { label: 'X (Twitter)', href: 'https://x.com/martschweiger' },
          { label: 'GitHub', href: 'https://github.com/m-ods' },
          { label: 'LinkedIn', href: 'https://www.linkedin.com/in/martinschweiger/' },
          { label: 'YouTube', href: '#' },
          { label: 'Email', href: 'mailto:martin@assemblyai.com' },
        ],
        navigation: [
          { label: 'Home', href: '/' },
          { label: 'Scribbles', href: '/blog' },
          { label: 'Loves', href: '/loves' },
          { label: 'Now', href: '/now' },
        ],
      },
    })
    console.log('✅ Site settings updated')

    // 4. Seed pages
    console.log('\n📄 Seeding pages...')
    const pages = [
      {
        title: "Places I've been",
        slug: 'been',
        pageType: 'been',
        data: {
          destinations: [
            {
              country: 'USA',
              cities: [
                { name: 'New York', visits: 'Dec 2021, Sep–Oct 2023, Oct 2024, Mar 2026 (twice), Jul–Aug 2026' },
                { name: 'Boston', visits: 'Dec 2021, Jun 2025' },
                { name: 'Philadelphia', visits: 'Dec 2021' },
                { name: 'Orlando', visits: 'Feb 2023' },
                { name: 'San Francisco', visits: 'Jul 2023, Oct 2025' },
                { name: 'Seattle', visits: 'Jul 2023' },
                { name: 'Atlanta', visits: 'Oct 2023' },
                { name: 'Las Vegas', visits: 'Jan–Feb 2024' },
                { name: 'Austin', visits: 'Jan 2025' },
                { name: 'Miami', visits: 'Feb 2026' },
              ],
            },
            // ... add more countries
          ],
        },
      },
      {
        title: 'Loves',
        slug: 'loves',
        pageType: 'loves',
      },
      {
        title: 'Daily Timebox Planner',
        slug: 'timebox',
        pageType: 'timebox',
      },
      {
        title: 'Martin Schweiger',
        slug: 'wiki',
        pageType: 'wiki',
      },
    ]

    for (const page of pages) {
      const existing = await payload.find({
        collection: 'pages',
        where: {
          slug: {
            equals: page.slug,
          },
        },
        limit: 1,
      })

      if (existing.totalDocs === 0) {
        await payload.create({
          collection: 'pages',
          data: page as any,
        })
        console.log(`  ✅ Created: ${page.title}`)
      } else {
        console.log(`  ⏭️  Skipped: ${page.title} (already exists)`)
      }
    }

    console.log('\n✨ Seed process completed successfully!')
    console.log('\n📋 Next steps:')
    console.log('  1. Visit http://localhost:3000/admin to log in')
    console.log('  2. Change the default password')
    console.log('  3. Upload vitiligo images to the Media collection')
    console.log('  4. Create vitiligo entries linking to those images')
  } catch (error) {
    console.error('❌ Error during seed:', error)
    process.exit(1)
  }

  process.exit(0)
}

seed()
