/* THIS FILE WAS GENERATED AUTOMATICALLY BY PAYLOAD. */
/* DO NOT MODIFY IT BECAUSE IT COULD BE REWRITTEN AT ANY TIME. */
import { RootLayout, handleServerFunctions } from '@payloadcms/next/layouts'
import React from 'react'
import '@payloadcms/next/css'

import config from '@/payload.config'
import { importMap } from '../../importMap'
import './custom.scss'

type Args = {
  children: React.ReactNode
}

const Layout = ({ children }: Args) => (
  <RootLayout 
    config={config} 
    importMap={importMap} 
    serverFunction={(args) => handleServerFunctions({ ...args, config, importMap })}
  >
    {children}
  </RootLayout>
)

export default Layout
