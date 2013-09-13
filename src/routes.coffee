module.exports = exports

exports.routes =
  get: [
    { path: "/clients", action: "clientsIndex" }
    { path: "/credentials", action: "credentialsIndex" }
    { path: "/entry-requests", action: "entryRequestsIndex" }
    { path: "/entry-request/:id", action: "entryRequestShow" }
    { path: "/groups", action: "groupsIndex" }
    { path: "/identities", action: "identitiesIndex" }
    { path: "/identity/:id", action: "identityShow" }
    { path: "/qrcode", action: "qrCodeShow" }
    { path: "/schedules", action: "schedulesIndex" }
    { path: "/schedule/:id", action: "scheduleShow" }
    { path: "/sites", action: "sitesIndex" }
    { path: "/site/:id", action: "siteShow" }
    { path: "/site/:siteid/entry-points", action: "entryPointsIndex" }
    { path: "/site/:siteid/entry-point/:id", action: "entryPointShow" }
    { path: "/tokens", action: "tokensIndex" }
    { path: "/token/:id", action: "tokenShow" }
    { path: "/users", action: "usersIndex" }
    { path: "/widgets", action: "widgetsIndex" }
    { path: "/widget/:id", action: "widgetShow" }
  ]
  post: [
    { path: "/clients", action: "clientsCreate" }
    { path: "/credentials", action: "credentialsCreate" }
    { path: "/entry-requests", action: "entryRequestsCreate" }
    { path: "/groups", action: "groupsCreate" }
    { path: "/identities", action: "identitiesCreate" }
    { path: "/schedules", action: "schedulesCreate" }
    { path: "/sites", action: "sitesCreate" }
    { path: "/site/:siteid/entry-points", action: "entryPointsCreate" }
    { path: "/tokens", action: "tokensCreate" }
    { path: "/users", action: "usersCreate" }
    { path: "/widgets", action: "widgetsCreate" }
  ]
  put: [
    { path: "/entry-request/:id", action: "entryRequestUpdate" }
    { path: "/identity/:id", action: "identityUpdate" }
    { path: "/schedule/:id", action: "scheduleUpdate" }
    { path: "/site/:id", action: "siteUpdate" }
    { path: "/site/:siteid/entry-point/:id", action: "entryPointUpdate" }
    { path: "/token/:id", action: "tokenShow" }
    { path: "/widget/:id", action: "widgetUpdate" }
  ]
  delete: [
    { path: "/entry-request/:id", action: "entryRequestDestroy" }
    { path: "/identity/:id", action: "identityDestroy" }
    { path: "/schedule/:id", action: "scheduleDestroy" }
    { path: "/site/:id", action: "siteDestroy" }
    { path: "/site/:siteid/entry-point/:id", action: "entryPointDestroy" }
    { path: "/token/:id", action: "tokenDestroy" }
    { path: "/widget/:id", action: "widgetDestroy" }
  ]