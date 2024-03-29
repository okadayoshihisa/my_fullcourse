// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap";
import "../stylesheets/application.scss";
import '@fortawesome/fontawesome-free/js/all';
import 'jquery';
import "preview_image.js";
import "google_map.js";
import "form.js";

Rails.start()
ActiveStorage.start()
