//
//  ApiConstants.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 14/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation


struct ParseKeys {
    let baseUrl: String = "https://parse.udacity.com/parse/classes"
    let parseId: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    let apiKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
}

struct ParseObjectKey {
    let studentLocation = "StudentLocation"
    let studentInformation = "StudentInformation"
}

struct Methods {
    let get = "GET"
    let post = "POST"
    let put = "PUT"
    let delete = "DELETE"
}

struct ParseParameterKeys {
    let limit = "limit"
    let skip = "skip"
    let order = "order"
    let objectId = "objectId"
    let uniqueKey = "uniqueKey"
}

struct ParseResponseKeys {
    let results = "results"
    let createdAt = "createdAt"
    let objectId = "objectId"
    let firstName = "firstName"
    let lastName = "lastName"
    let latitude = "latitude"
    let longitude = "longitude"
    let mapString = "mapString"
    let mediaURL = "mediaURL"
    let uniqueKey = "uniqueKey"
    let updatedAt = "updatedAt"
}

struct UdacityKeys {
    let baseUrl: String = "https://onthemap-api.udacity.com/v1/session"
}

struct UdacityParametersKeys {
    let udacity = "udacity"
    let username = "username"
    let password = "password"
}

struct UdacityResponseKeys {
    let account = "account"
    let registered = "registered"
    let key = "key"
    let session = "session"
    let id = "id"
    let expiration = "expiration"
    let user = "user"
    let lastName = "last_name"
    let socialAccounts = "social_accounts"
    let mailingAddress = "mailing_address"
    let cohortKeys = "_cohort_keys"
    let signature = "_signature"
    let stripeCustomerId = "_stripe_customer_id"
    let guardKey = "guard"
    let canEdit = "can_edit"
    let permissions = "permissions"
    let derivation = "derivation"
    let behavior = "behavior"
    let principalRef = "principal_ref"
    let ref = "ref"
    let allowedBehaviors = "allowed_behaviors"
    let subjectKind = "subject_kind"
    let facebookId = "_facebook_id"
    let timezone = "timezone"
    let sitePreference = "site_preferences"
    let occupation = "occupation"
    let image = "_image"
    let firstName = "first_name"
    let jabberId = "jabber_id"
    let languages = "languages"
    let badges = "_badges"
    let location = "location"
    let externalServicePassword = "external_service_password"
    let principals = "_principals"
    let enrollments = "_enrollments"
    let email = "email"
    let verificationCodeSent = "_verification_code_sent"
    let verified = "_verified"
    let address = "address"
    let websiteUrl = "website_url"
    let externalAccounts = "external_accounts"
    let bio = "bio"
    let coachingData = "coaching_data"
    let tags = "tags"
    let affiliateProfiles = "_affiliate_profiles"
    let hasPassword = "_has_password"
    let emailPreferences = "email_preferences"
    let okUserResearch = "ok_user_research"
    let masterOk = "master_ok"
    let okCourse = "ok_course"
    let resume = "_resume"
    let nickname = "nickname"
    let employerSharing = "employer_sharing"
    let memberships = "_memberships"
    let current = "current"
    let groupRef = "group_ref"
    let creationTime = "creation_time"
    let expirationTime = "expiration_time"
    let zendeskId = "zendesk_id"
    let linkedinUrl = "linkedin_url"
    let googleId = "_google_id"
    let imageUrl = "_image_url"
}






