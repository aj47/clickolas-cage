import { useState, useEffect } from 'react'

import './SidePanel.css'
import Popup from '../popup/Popup'

export const SidePanel = () => {

  return (
    <div style={{width: "50%"}}>
      <Popup/>
    </div>
  )
}

export default SidePanel
