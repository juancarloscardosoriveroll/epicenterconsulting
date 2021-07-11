# Welcome to Davis & Co Database Platform

## Index
* Features
* File Structure
* Database Structure
* Application Structure

## Features
- Configurable 
    - Change any Label 
    - Enable any Validation 
- User Management
    - Required Sessions 
    - Security Framework
    - Personalized Menus
- Simple Experience
    - Asynch updates
    - Catch errors
    - Hub-like navigations
    - Responsive template

## File Structure
- Application.cfc (app settings)
- index.cfm (starting page)
- "/assets" (media)
- "/functions" (scripts)
    - helper: general tools
    - users: user related
- "/includes" (building blocks)
    - sections: /*.cfm
    - scripts: /*.js,css & udfs
    - daForm: CFM/JQuery Asynch handler
    - custom: errors.json, labels.json
    - config: settings.json, permits.json
- "/template" (framework)
    - start: /admin/dist/index.html
- "/tests" (temp)
- "/views" (nav pages /?view=)

## Database Structure
- _users : contains records of system accounts
- _permits : gives specic permit to specific user 
_ _errors : holds any catched exceptions

## Application Structure
- Application.datasource : registered CF Datasource for SQL
- Application.urlPath : Path to root of hosted app (webfacing)
- this.mappings.root : Path to root of hosted app (filesystem)
- this.devMode : set to true to force Login and block all pages
- ?init : restarts the application
