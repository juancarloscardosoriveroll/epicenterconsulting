# Welcome to Davis & Co Database Platform

## Index
* Features
* File Structure
* Database Structure
* Application Structure
* To-do's

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
- Application.cfc (app settings)
- index.cfm (starting page)


## Database Structure
- _users : contains records of system accounts
- _permits : gives specic permit to specific user 
- _errors : holds any catched exceptions

## Application Structure
- Application.datasource : registered CF Datasource for SQL
- Application.urlPath : Path to root of hosted app (webfacing)
- this.mappings.root : Path to root of hosted app (filesystem)
- this.devMode : set to true to force Login and block all pages
- ?init : restarts the application


## to-do's
- USERS
    - Implement Password Change (self can change, rest only with permit)
    - Implement User Profile Update (remember to put userID on header)
    - Implement User isActive Change
    - Implement Associated Profile with Permits
    - Implement Selectable Profile on Account Create/Edit
    - Implement Login (discard password recovery/reset, internal task)
    - Implement Logout (Session.userID)
    - Factorize labels (userEdit)
    - Validate Access Permits (userEdit)
    - Setup TestScripts for Users Functions
- GENERAL
    - Migrate Labels & Errors to DB
    - BlockUI in daForm to prevent Duplicate Inserts
    - Session expiry/Redirect to Logout
    - Script Database Tables in Admin Section