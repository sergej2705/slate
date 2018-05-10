---
title: to.photo API Reference

# language_tabs: # must be one of https://git.io/vQNgJ
#  - java

toc_footers:
  - <a href='https://github.com/lord/slate'>Documentation Powered by Slate</a>

includes:
  - orders
  - portals
  - errors

search: true
---

# Introduction

<%= diagram('singlesubcart.wsd') %>

Welcome to the to.photo API! You can use our API to access to.photo API endpoints, which will serve you 24/7 with beautiful, high quality photo products.

# Roles

3 roles are distinguished throughout this documentation.

| Name            | Abbreviation | Description  |
| --------------- | ------------ | ------------ |
| Server          | S            | Everything the server does in response to API-requests |
| Mandator        | M            | Integrational role between Server und User/Frontend. Some data originates from the user and is just routed through to the server while some is process / workflow specific | 
| User / Customer | U            | The User who is ordering photo products through the system. In general the order process has indirect character via additional meta information available in the domain of the mandator's domain |

# Portal / Mandator

Portals are mandator specific and are meant to describe a specific project or public facing product. 

It is thinkable to correlate specific price and / or product profiles to a portal at mandator-side.

# Authentication

to.photo uses Basic Auth to allow access to the API. To get new Basic Auth Credentials contact your personal Key Account Manager.

to.photo expects for the Basic Auth to be included in all API requests to the server in a header that looks like the following:

`Authorization: yourkeyhere`

The supplied token has to match the [Portal and Mandator](#portal-mandator).

# Workflow
