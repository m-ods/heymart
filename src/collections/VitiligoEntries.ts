import type { CollectionConfig } from 'payload'

export const VitiligoEntries: CollectionConfig = {
  slug: 'vitiligo-entries',
  admin: {
    useAsTitle: 'date',
    defaultColumns: ['date', 'images'],
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: 'date',
      type: 'text',
      required: true,
      unique: true,
      admin: {
        description: 'YYYY-MM format (e.g., "2026-04")',
      },
    },
    {
      name: 'text',
      type: 'textarea',
      admin: {
        description: 'Optional text note for this entry',
      },
    },
    {
      name: 'images',
      type: 'relationship',
      relationTo: 'media',
      hasMany: true,
      required: true,
      admin: {
        description: 'Photos for this timeline entry',
      },
    },
  ],
}
