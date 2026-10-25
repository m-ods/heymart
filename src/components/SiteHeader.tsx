import Link from 'next/link'
import styles from './SiteHeader.module.css'

const navItems = [
  { label: 'Home', href: '/' },
  { label: 'Scribbles', href: '/blog' },
  { label: 'Loves', href: '/loves' },
  { label: 'Now', href: '/now' },
]

export function SiteHeader() {
  return (
    <header className={styles.siteHeader}>
      <Link className={styles.logoLink} href="/" aria-label="HeyMart home">
        HeyMart
      </Link>
      <nav aria-label="Primary navigation">
        {navItems.map((item) => (
          <Link key={item.href} href={item.href}>
            {item.label}
          </Link>
        ))}
      </nav>
    </header>
  )
}
