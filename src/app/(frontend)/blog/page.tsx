import { getPayload } from 'payload'
import config from '@/payload.config'
import Link from 'next/link'
import { SiteHeader } from '@/components/SiteHeader'
import styles from './page.module.css'

// Force dynamic rendering
export const dynamic = 'force-dynamic'

export default async function BlogPage() {
  const payload = await getPayload({ config })
  
  const { docs: posts } = await payload.find({
    collection: 'posts',
    where: {
      status: {
        equals: 'published',
      },
    },
    sort: '-publishedAt',
  })

  return (
    <div className={styles.body}>
      <main className={styles.page}>
        <SiteHeader />
        <section className={styles.blogBox} aria-labelledby="blog-heading">
          <div className={styles.boxHeader}>
            <h1 id="blog-heading">Scribbles</h1>
          </div>
          <ul className={styles.postList}>
            {posts.map((post) => (
              <li key={post.id}>
                <Link href={`/blog/${post.slug}`}>{post.title}</Link>
              </li>
            ))}
          </ul>
        </section>
      </main>
    </div>
  )
}
