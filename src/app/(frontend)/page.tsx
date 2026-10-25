import { getPayload } from 'payload'
import config from '@/payload.config'
import Link from 'next/link'
import styles from './page.module.css'

// Force dynamic rendering
export const dynamic = 'force-dynamic'

export default async function HomePage() {
  const payload = await getPayload({ config })
  
  const { docs: posts } = await payload.find({
    collection: 'posts',
    where: {
      status: {
        equals: 'published',
      },
    },
    sort: '-publishedAt',
    limit: 10,
  })

  const siteSettings = await payload.findGlobal({
    slug: 'site-settings',
  })

  const topLinks = siteSettings?.topLinks || []

  return (
    <div className={styles.body}>
      <main className={styles.container}>
        <header className={styles.logoRow}>
          <h1 className={styles.logo}>HeyMart</h1>
        </header>

        <div className={styles.content}>
          <section className={styles.aboutBox} aria-labelledby="about-heading">
            <div className={`${styles.boxHeader} ${styles.aboutHeader}`}>
              <span id="about-heading">Hello! I&apos;m Mart</span>
            </div>
            <div className={styles.aboutContent}>
              <p>This is my corner of the internet where I plan to build a public record of my work.</p>
              <p>
                First of all you should know that I&apos;m a husband, father, and a hacker. I work at{' '}
                <a href="https://www.assemblyai.com/" target="_blank" rel="noopener noreferrer">
                  AssemblyAI
                </a>
                .
              </p>
              <p>
                You can see a rough breakdown of what I&apos;m up to <a href="/now">here</a>.
              </p>

              <h2>Some quick facts:</h2>
              <ul>
                <li>
                  I taught myself to code by doing challenges on{' '}
                  <a href="https://codingbat.com" target="_blank" rel="noopener noreferrer">
                    CodingBat
                  </a>
                  .
                </li>
                <li>I live in sunny Singapore 🇸🇬 with my wife and daughter.</li>
                <li>
                  I really like computers, jets, coffee, music, and games. Full gift preferences live on my{' '}
                  <a href="/loves">Loves</a> page.
                </li>
              </ul>

              <p>Feel free to explore my site and get in touch! I love making friends with new people :)</p>

              <div className={styles.writingBlock}>
                <h2>Scribbles</h2>
                <ul className={styles.postList}>
                  {posts.map((post) => (
                    <li key={post.id}>
                      <Link href={`/blog/${post.slug}`}>{post.title}</Link>
                    </li>
                  ))}
                </ul>
              </div>
            </div>
          </section>

          <aside className={styles.linksBox} aria-labelledby="links-heading">
            <div className={`${styles.boxHeader} ${styles.linksHeader}`}>
              <span id="links-heading">Top Links</span>
            </div>
            <ol className={styles.linksList}>
              {topLinks.map((link: any, i: number) => (
                <li key={i}>
                  <span className={styles.linkIndex}>{i + 1}.</span>
                  <a
                    href={link.href}
                    target={link.href.startsWith('http') ? '_blank' : undefined}
                    rel={link.href.startsWith('http') ? 'noopener noreferrer' : undefined}
                  >
                    {link.label}
                  </a>
                </li>
              ))}
            </ol>
          </aside>
        </div>
      </main>
    </div>
  )
}
