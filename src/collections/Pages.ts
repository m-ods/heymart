import type { CollectionConfig } from 'payload'

export const Pages: CollectionConfig = {
  slug: 'pages',
  admin: {
    useAsTitle: 'title',
    defaultColumns: ['title', 'slug', 'pageType'],
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: 'title',
      type: 'text',
      required: true,
    },
    {
      name: 'slug',
      type: 'text',
      required: true,
      unique: true,
      admin: {
        description: 'URL path (e.g., "been", "loves", "timebox")',
      },
    },
    {
      name: 'pageType',
      type: 'select',
      required: true,
      options: [
        { label: 'Been (Travel)', value: 'been' },
        { label: 'Loves', value: 'loves' },
        { label: 'Timebox', value: 'timebox' },
        { label: 'Wiki', value: 'wiki' },
        { label: 'Wiki MOS', value: 'wiki-mos' },
        { label: 'Home', value: 'home' },
      ],
    },
    {
      name: 'content',
      type: 'richText',
      admin: {
        description: 'Main content for the page',
      },
    },
    {
      name: 'data',
      type: 'json',
      admin: {
        description: 'Structured data for special page types (e.g., loves categories, travel destinations)',
      },
    },
  ],
}
