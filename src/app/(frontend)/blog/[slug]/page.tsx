import { getPayload } from 'payload'
import config from '@/payload.config'
import { notFound } from 'next/navigation'
import { SiteHeader } from '@/components/SiteHeader'
import { serializeLexical } from '@/lib/serializeLexical'
import styles from './page.module.css'

// Force dynamic rendering
export const dynamic = 'force-dynamic'

type Props = {
  params: Promise<{ slug: string }>
}

export async function generateMetadata({ params }: Props) {
  const { slug } = await params
  const payload = await getPayload({ config })

  const { docs } = await payload.find({
    collection: 'posts',
    where: {
      slug: {
        equals: slug,
      },
    },
    limit: 1,
  })

  const post = docs[0]

  if (!post) {
    return {
      title: 'Post Not Found',
    }
  }

  return {
    title: `${post.title} - HEYMART`,
    description: post.excerpt || '',
  }
}

export default async function BlogPostPage({ params }: Props) {
  const { slug } = await params
  const payload = await getPayload({ config })

  const { docs } = await payload.find({
    collection: 'posts',
    where: {
      slug: {
        equals: slug,
      },
    },
    limit: 1,
  })

  const post = docs[0]

  if (!post) {
    notFound()
  }

  const content = typeof post.content === 'string' 
    ? post.content 
    : serializeLexical(post.content)

  return (
    <div className={styles.body}>
      <main className={styles.page}>
        <SiteHeader />

        <article className={styles.post}>
          <header>
            <h1>{post.title}</h1>
          </header>

          <div 
            className={styles.content}
            dangerouslySetInnerHTML={{ __html: content }}
          />
        </article>
      </main>
    </div>
  )
}
