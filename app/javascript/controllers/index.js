import { application } from "./application"

import { Alert, Autosave, Dropdown, Modal, Tabs, Popover, Toggle, Slideover, ColorPreview } from "tailwindcss-stimulus-components"
application.register('alert', Alert)
application.register('autosave', Autosave)
application.register('color-preview', ColorPreview)
application.register('dropdown', Dropdown)
application.register('modal', Modal)
application.register('popover', Popover)
application.register('slideover', Slideover)
application.register('tabs', Tabs)
application.register('toggle', Toggle)

import controllers from './**/*_controller.js'
controllers.forEach((controller) => {
  application.register(controller.name, controller.module.default)
})

