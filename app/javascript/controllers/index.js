// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import CloseButtonController from "./close_button_controller"
application.register("close-button", CloseButtonController)

import InlaySelectController from "./inlay_select_controller"
application.register("inlay-select", InlaySelectController)

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)

import NotificationReadController from "./notification_read_controller"
application.register("notification-read", NotificationReadController)

import TagsInputController from "./tags_input_controller"
application.register("tags-input", TagsInputController)
