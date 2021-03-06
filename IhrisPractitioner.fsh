Invariant:      ihris-age-18
Description:    "birthDate must be more than 18 years ago."
Expression:     "birthDate < today() - 18 years"
Severity:       #error


Profile:        IhrisPractitioner
Parent:         Practitioner
Id:             iHRISPractitioner
Title:          "iHRIS Practitioner"
Description:    "iHRIS profile of Practitioner."
* identifier 0..* MS
* identifier ^label = "Identifier"
* identifier ^constraint[0].key = "ihris-search-identifier"
* identifier ^constraint[0].severity = #error
* identifier ^constraint[0].expression = "'Practitioner' | 'identifier' | iif(system.exists(), system & '|' & value, value)"
* identifier ^constraint[0].human = "The identifier must be unique and another record has this identifier"
* identifier.use MS
* identifier.use ^label = "Use"
* identifier.type MS
* identifier.type ^label = "Type"
* identifier.type.coding 0..1 MS
* identifier.type.coding ^label = "Type"
* identifier.system MS
* identifier.system ^label = "System"
* identifier.value MS
* identifier.value ^label = "Value"
* name 1..* MS
* name ^label = "Name"
* name.use MS
* name.use ^label = "Use"
* name.family 1..1 MS
* name.family ^label = "Family"
* name.family ^constraint[0].key = "ihris-name-check"
* name.family ^constraint[0].severity = #error
* name.family ^constraint[0].expression = "matches('^[A-Za-z ]*$')"
* name.family ^constraint[0].human = "Name must be only text."
* name.given 1..* MS
* name.given ^label = "Given Name"
* name.prefix MS
* name.prefix ^label = "Prefix"
* name.suffix MS
* name.suffix ^label = "Suffix"
* telecom 1..* MS
* telecom ^label = "Telecom"
* telecom ^constraint[0].key = "ihris-search-phonenumber"
* telecom ^constraint[0].severity = #error
* telecom ^constraint[0].expression = "'Practitioner' | 'phonenumber:contains' | where(system='phone').value.replace('+','')"
* telecom ^constraint[0].human = "The phone number must be unique and another record has this phone number"
* telecom.system 1..1 MS
* telecom.system ^label = "Contact Type"
* telecom.use MS
* telecom.use ^label = "Use"
* telecom.value 1..1 MS
* telecom.value ^label = "Value"
* address 0..* MS
* address ^label = "Address"
* address.use MS
* address.use ^label = "Use"
* address.type MS
* address.type ^label = "Type"
* address.line 0..1 MS
* address.line ^label = "Line"
* address.city MS
* address.city ^label = "City"
* address.district MS
* address.district ^label = "District"
* address.state MS
* address.state ^label = "State"
* address.postalCode MS
* address.postalCode ^label = "Postal Code"
* address.country MS
* address.country ^label = "Country"
* gender 1..1 MS
* gender ^label = "Gender"
* birthDate MS
* birthDate ^label = "Birth Date"
* birthDate obeys ihris-age-18
* birthDate ^minValueQuantity.system = "http://unitsofmeasure.org/"
* birthDate ^minValueQuantity.code = #a
* birthDate ^minValueQuantity.value = 100
* birthDate ^maxValueQuantity.system = "http://unitsofmeasure.org/"
* birthDate ^maxValueQuantity.code = #a
* birthDate ^maxValueQuantity.value = -18
* active 1..1 MS
* active ^label = "Active"
* photo 0..1 MS
* photo ^label = "Photo"
* communication 0..* MS
* communication ^label = "Communication"
* communication.coding 1..1 MS
* communication.coding ^label = "Language"
* communication.extension contains
    IhrisPractitionerLanguageProficiency named proficiency 0..* MS
* communication.extension[proficiency] MS
* communication.extension[proficiency] ^label = "Language Proficiency"
* communication.extension[proficiency].extension[level].valueCoding MS
* communication.extension[proficiency].extension[type].valueCoding MS
* extension contains
    IhrisPractitionerResidence named residence 0..1 MS and
    IhrisPractitionerNationality named nationality 0..1 and
    IhrisPractitionerMaritalStatus named maritalStatus 0..1 and
    IhrisPractitionerDependents named dependents 0..1
// * extension[residence].valueReference MS

Extension:      IhrisPractitionerLanguageProficiency
Id:             ihris-practitioner-language-proficiency
Title:          "iHRIS Practitioner Language Proficiency"
Description:    "iHRIS extension for Practitioner Language Proficiency."
* ^context.type = #element
* ^context.expression = "Practitioner"
* extension contains
    level 0..1 MS and
    type 0..* MS
* extension[level].value[x] only Coding
* extension[level].valueCoding 0..1 MS
* extension[level].valueCoding from http://terminology.hl7.org/ValueSet/v3-LanguageAbilityProficiency
* extension[level].valueCoding ^label = "Proficiency Level"
* extension[type] ^label = "Proficiency Type"
* extension[type].value[x] only Coding
* extension[type].valueCoding 0..1 MS
* extension[type].valueCoding ^label = "Proficiency Type"
* extension[type].valueCoding from http://terminology.hl7.org/ValueSet/v3-LanguageAbilityMode

Extension:      IhrisPractitionerResidence
Id:             ihris-practitioner-residence
Title:          "iHRIS Practitioner Residence"
Description:    "iHRIS extension for Practitioner residence."
* ^context.type = #element
* ^context.expression = "Practitioner"
* value[x] only Reference
* valueReference 1..1 MS
* valueReference ^label = "Residence"
* valueReference ^constraint[0].key = "ihris-location-residence"
* valueReference ^constraint[0].severity = #warning
* valueReference ^constraint[0].expression = "reference.matches('^Location/')"
* valueReference ^constraint[0].human = "Must be a location"
* valueReference only Reference(Location)
* valueReference.reference 1..1 MS
* valueReference.reference ^label = "Location"
* valueReference.type 0..0
* valueReference.identifier 0..0
* valueReference.display 0..0

Extension:      IhrisPractitionerDependentDetail
Id:             ihris-practitioner-dependent-detail
Title:          "iHRIS Practitioner Dependent Detail"
Description:    "iHRIS extension for Practitioner Dependent Detail."
* ^context.type = #element
* ^context.expression = "Practitioner"
* extension contains name 1..1 MS and
    birthDate 1..1 MS
* extension[name].value[x] only string
* extension[name].valueString 1..1 MS
* extension[name].valueString ^label = "Dependent's Name"
* extension[birthDate].value[x] only date
* extension[birthDate].valueDate 1..1 MS
* extension[birthDate].valueDate ^label = "Dependent's Date of Birth"

Extension:      IhrisPractitionerNationality
Id:             ihris-practitioner-nationality
Title:          "iHRIS Practitioner Nationality"
Description:    "iHRIS extension for Practitioner nationality."
* ^context.type = #element
* ^context.expression = "Practitioner"
* value[x] only Coding
* valueCoding 1..1 MS
* valueCoding ^label = "Nationality"
* valueCoding from http://hl7.org/fhir/ValueSet/iso3166-1-2 (required)

Extension:      IhrisPractitionerMaritalStatus
Id:             ihris-practitioner-marital-status
Title:          "iHRIS Practitioner Marital Status"
Description:    "iHRIS extension for Practitioner marital status."
* ^context.type = #element
* ^context.expression = "Practitioner"
* value[x] only Coding
* valueCoding 1..1 MS
* valueCoding ^label = "Marital Status"
* valueCoding from http://hl7.org/fhir/ValueSet/marital-status (required)

Extension:      IhrisPractitionerDependents
Id:             ihris-practitioner-dependents
Title:          "iHRIS Practitioner Dependents"
Description:    "iHRIS extension for Practitioner number of dependents."
* ^context.type = #element
* ^context.expression = "Practitioner"
* value[x] only positiveInt
* valuePositiveInt 1..1 MS
* valuePositiveInt ^label = "Number of Dependents"


Instance:       IhrisPractitionerQuestionnaire
InstanceOf:     IhrisQuestionnaire
Usage:          #definition
* title = "iHRIS Practitioner Questionnaire"
* description = "iHRIS Practitioner initial data entry questionnaire."
* id = "ihris-practitioner"
* url = "http://ihris.org/fhir/Questionnaire/ihris-practitioner"
* name = "ihris-practitioner"
* status = #active
* date = 2020-06-22
* purpose = "Data entry page for practitioners."

* item[0].linkId = "Practitioner"
* item[0].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner"
* item[0].text = "Health Worker|Primary demographic details"
* item[0].type = #group

* item[0].item[0].linkId = "Practitioner.name[0]"
* item[0].item[0].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.name"
* item[0].item[0].text = "Name"
* item[0].item[0].type = #group

* item[0].item[0].item[0].linkId = "Practitioner.name[0].use"
* item[0].item[0].item[0].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.name.use"
* item[0].item[0].item[0].text = "Name Usage"
* item[0].item[0].item[0].type = #choice
* item[0].item[0].item[0].required = true
* item[0].item[0].item[0].repeats = false
* item[0].item[0].item[0].readOnly = true
* item[0].item[0].item[0].answerOption.valueCoding = http://hl7.org/fhir/name-use#official
* item[0].item[0].item[0].answerOption.initialSelected = true

* item[0].item[0].item[1].linkId = "Practitioner.name[0].family"
* item[0].item[0].item[1].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.name.family"
* item[0].item[0].item[1].text = "Family Name"
* item[0].item[0].item[1].type = #string
* item[0].item[0].item[1].required = true
* item[0].item[0].item[1].repeats = false

* item[0].item[0].item[2].linkId = "Practitioner.name[0].given[0]"
* item[0].item[0].item[2].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.name.given"
* item[0].item[0].item[2].text = "Given Name(s)"
* item[0].item[0].item[2].type = #string
* item[0].item[0].item[2].required = true
* item[0].item[0].item[2].repeats = true

* item[0].item[0].item[3].linkId = "Practitioner.name[0].prefix[0]"
* item[0].item[0].item[3].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.name.prefix"
* item[0].item[0].item[3].text = "Prefix"
* item[0].item[0].item[3].type = #string
* item[0].item[0].item[3].required = false
* item[0].item[0].item[3].repeats = true

* item[0].item[0].item[4].linkId = "Practitioner.name[0].suffix[0]"
* item[0].item[0].item[4].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.name.suffix"
* item[0].item[0].item[4].text = "Suffix"
* item[0].item[0].item[4].type = #string
* item[0].item[0].item[4].required = false
* item[0].item[0].item[4].repeats = true

* item[0].item[1].linkId = "Practitioner.birthDate"
* item[0].item[1].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.birthDate"
* item[0].item[1].text = "Date of Birth"
* item[0].item[1].type = #date
* item[0].item[1].required = false
* item[0].item[1].repeats = false

* item[0].item[2].linkId = "Practitioner.gender"
* item[0].item[2].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.gender"
* item[0].item[2].text = "Gender"
* item[0].item[2].type = #choice
* item[0].item[2].answerValueSet = "http://hl7.org/fhir/ValueSet/administrative-gender"
* item[0].item[2].required = true
* item[0].item[2].repeats = false



* item[0].item[3].linkId = "Practitioner.telecom[0].use"
* item[0].item[3].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.telecom.use"
* item[0].item[3].text = "Telecom Use"
* item[0].item[3].type = #choice
* item[0].item[3].required = true
* item[0].item[3].repeats = false
* item[0].item[3].readOnly = true
* item[0].item[3].answerOption.valueCoding = http://hl7.org/fhir/contact-point-use#mobile
* item[0].item[3].answerOption.initialSelected = true

* item[0].item[4].linkId = "Practitioner.telecom[0].system"
* item[0].item[4].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.telecom.system"
* item[0].item[4].text = "Telecom System"
* item[0].item[4].type = #choice
* item[0].item[4].required = true
* item[0].item[4].repeats = false
* item[0].item[4].readOnly = true
* item[0].item[4].answerOption.valueCoding = http://hl7.org/fhir/contact-point-system#phone
* item[0].item[4].answerOption.initialSelected = true

* item[0].item[5].linkId = "Practitioner.telecom[0].value"
* item[0].item[5].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.telecom.value"
* item[0].item[5].text = "Mobile Phone"
* item[0].item[5].type = #string
* item[0].item[5].required = true
* item[0].item[5].repeats = false

* item[0].item[6].linkId = "Practitioner.telecom[1].use"
* item[0].item[6].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.telecom.use"
* item[0].item[6].text = "Telecom Use"
* item[0].item[6].type = #choice
* item[0].item[6].required = true
* item[0].item[6].repeats = false
* item[0].item[6].readOnly = true
* item[0].item[6].answerOption.valueCoding = http://hl7.org/fhir/contact-point-use#work
* item[0].item[6].answerOption.initialSelected = true

* item[0].item[7].linkId = "Practitioner.telecom[1].system"
* item[0].item[7].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.telecom.system"
* item[0].item[7].text = "Telecom System"
* item[0].item[7].type = #choice
* item[0].item[7].required = true
* item[0].item[7].repeats = false
* item[0].item[7].readOnly = true
* item[0].item[7].answerOption.valueCoding = http://hl7.org/fhir/contact-point-system#email
* item[0].item[7].answerOption.initialSelected = true

* item[0].item[8].linkId = "Practitioner.telecom[1].value"
* item[0].item[8].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.telecom.value"
* item[0].item[8].text = "Work Email"
* item[0].item[8].type = #string
* item[0].item[8].required = false
* item[0].item[8].repeats = false

* item[0].item[9].linkId = "Practitioner.active"
* item[0].item[9].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.active"
* item[0].item[9].text = "Active"
* item[0].item[9].type = #boolean
* item[0].item[9].required = true
* item[0].item[9].repeats = false

* item[1].linkId = "Practitioner.address[0]"
* item[1].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.address"
* item[1].text = "Home Address"
* item[1].type = #group

* item[1].item[0].linkId = "Practitioner.address[0].use"
* item[1].item[0].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.address.use"
* item[1].item[0].text = "Address Use"
* item[1].item[0].type = #choice
* item[1].item[0].required = true
* item[1].item[0].repeats = false
* item[1].item[0].readOnly = true
* item[1].item[0].answerOption.valueCoding = http://hl7.org/fhir/address-use#home
* item[1].item[0].answerOption.initialSelected = true

* item[1].item[1].linkId = "Practitioner.address[0].type"
* item[1].item[1].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.address.type"
* item[1].item[1].text = "Address Type"
* item[1].item[1].type = #choice
* item[1].item[1].required = true
* item[1].item[1].repeats = false
* item[1].item[1].readOnly = true
* item[1].item[1].answerOption.valueCoding = http://hl7.org/fhir/address-type#physical
* item[1].item[1].answerOption.initialSelected = true

* item[1].item[2].linkId = "Practitioner.address[0].line"
* item[1].item[2].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.address.line"
* item[1].item[2].text = "Street Address"
* item[1].item[2].type = #string
* item[1].item[2].required = false
* item[1].item[2].repeats = true

* item[1].item[3].linkId = "Practitioner.address[0].city"
* item[1].item[3].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.address.city"
* item[1].item[3].text = "City"
* item[1].item[3].type = #string
* item[1].item[3].required = false
* item[1].item[3].repeats = false

* item[1].item[4].linkId = "Practitioner.address[0].district"
* item[1].item[4].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.address.district"
* item[1].item[4].text = "District"
* item[1].item[4].type = #string
* item[1].item[4].required = false
* item[1].item[4].repeats = false

* item[1].item[5].linkId = "Practitioner.address[0].state"
* item[1].item[5].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.address.state"
* item[1].item[5].text = "State"
* item[1].item[5].type = #string
* item[1].item[5].required = false
* item[1].item[5].repeats = false

* item[1].item[6].linkId = "Practitioner.address[0].postalCode"
* item[1].item[6].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.address.postalCode"
* item[1].item[6].text = "Postal Code"
* item[1].item[6].type = #string
* item[1].item[6].required = false
* item[1].item[6].repeats = false

* item[1].item[7].linkId = "Practitioner.address[0].country"
* item[1].item[7].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.address.country"
* item[1].item[7].text = "Country"
* item[1].item[7].type = #string
* item[1].item[7].required = false
* item[1].item[7].repeats = false

* item[2].linkId = "PractitionerRole"
* item[2].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitionerRole"
* item[2].text = "Position|Position the person holds"
* item[2].type = #group
* item[2].extension[constraint][0].extension[key].valueId = "ihris-start-end-date"
* item[2].extension[constraint][0].extension[severity].valueCode = #error
* item[2].extension[constraint][0].extension[expression].valueString = "where(linkId='PractitionerRole.period.end').answer.first().valueDateTime.empty() or where(linkId='PractitionerRole.period.end').answer.first().valueDateTime >= where(linkId='PractitionerRole.period.start').answer.first().valueDateTime"
* item[2].extension[constraint][0].extension[human].valueString = "The end date must be after the start date."

* item[2].item[0].linkId = "PractitionerRole.practitioner"
* item[2].item[0].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitionerRole#PractitionerRole.practitioner"
* item[2].item[0].text = "Practitioner"
* item[2].item[0].type = #string
* item[2].item[0].required = true
* item[2].item[0].repeats = false
* item[2].item[0].readOnly = true
* item[2].item[0].answerOption.valueString = "__REPLACE__Practitioner"
* item[2].item[0].answerOption.initialSelected = true

* item[2].item[1].linkId = "PractitionerRole.code"
* item[2].item[1].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitionerRole#PractitionerRole.code"
* item[2].item[1].text = "Job Title"
* item[2].item[1].type = #choice
* item[2].item[1].answerValueSet = "http://ihris.org/fhir/ValueSet/ihris-job"
* item[2].item[1].required = true
* item[2].item[1].repeats = false

* item[2].item[2].linkId = "PractitionerRole.period.start"
* item[2].item[2].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitionerRole#PractitionerRole.period.start"
* item[2].item[2].text = "Start Date"
* item[2].item[2].type = #dateTime
* item[2].item[2].required = false
* item[2].item[2].repeats = false

* item[2].item[3].linkId = "PractitionerRole.period.end"
* item[2].item[3].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitionerRole#PractitionerRole.period.end"
* item[2].item[3].text = "End Date"
* item[2].item[3].type = #dateTime
* item[2].item[3].required = false
* item[2].item[3].repeats = false

* item[2].item[4].linkId = "PractitionerRole.location[0]"
* item[2].item[4].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitionerRole#PractitionerRole.location"
* item[2].item[4].text = "Facility"
* item[2].item[4].type = #reference
* item[2].item[4].required = true
* item[2].item[4].repeats = false

* item[3].linkId = "Practitioner.identifier"
* item[3].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.identifier"
* item[3].text = "Identifiers|Identifiers for the practitioner"
* item[3].type = #group

* item[3].item[0].linkId = "Practitioner.identifier[0]"
* item[3].item[0].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.identifier"
* item[3].item[0].text = "Identifier"
* item[3].item[0].type = #group
* item[3].item[0].repeats = true
* item[3].item[0].required = false

* item[3].item[0].item[0].linkId = "Practitioner.identifier[0].system"
* item[3].item[0].item[0].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.identifier.system"
* item[3].item[0].item[0].text = "System"
* item[3].item[0].item[0].type = #string
* item[3].item[0].item[0].repeats = false
* item[3].item[0].item[0].required = false

* item[3].item[0].item[1].linkId = "Practitioner.identifier[0].value"
* item[3].item[0].item[1].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.identifier.value"
* item[3].item[0].item[1].text = "ID Number"
* item[3].item[0].item[1].type = #string
* item[3].item[0].item[1].repeats = false
* item[3].item[0].item[1].required = false

* item[3].item[0].item[2].linkId = "Practitioner.identifier[0].type"
* item[3].item[0].item[2].definition = "http://ihris.org/fhir/StructureDefinition/iHRISPractitioner#Practitioner.identifier.type"
* item[3].item[0].item[2].text = "ID Type"
* item[3].item[0].item[2].type = #choice
* item[3].item[0].item[2].answerValueSet = "http://hl7.org/fhir/ValueSet/identifier-type"
* item[3].item[0].item[2].repeats = false
* item[3].item[0].item[2].required = false

Instance:       IhrisPractitionerWorkflowEndRole
InstanceOf:      Questionnaire
Usage:          #definition
* title = "iHRIS End Role Workflow"
* description = "iHRIS workflow to end a current role/job"
* id = "ihris-endrole"
* url = "http://ihris.org/fhir/Questionnaire/ihris-endrole"
* name = "ihris-endrole"
* status = #active
* date = 2020-08-09
* purpose = "Workflow page for ending a role/job."

* item[0].linkId = "PractitionerRole"
* item[0].text = "Job End Date"
* item[0].type = #group

* item[0].item[0].linkId = "period.end"
* item[0].item[0].text = "End Date"
* item[0].item[0].type = #date
* item[0].item[0].required = true
* item[0].item[0].repeats = false

Instance:       IhrisPractitionerWorkflowPromotion
InstanceOf:      Questionnaire
Usage:          #definition
* title = "iHRIS End Role Workflow"
* description = "iHRIS workflow to record a promotion"
* id = "ihris-promotion"
* url = "http://ihris.org/fhir/Questionnaire/ihris-promotion"
* name = "ihris-promotion"
* status = #active
* date = 2020-08-09
* purpose = "Workflow page for recording a promotion."

* item[0].linkId = "PractitionerRole"
* item[0].text = "Promotion Details"
* item[0].type = #group

* item[0].item[0].linkId = "period.end"
* item[0].item[0].text = "Position Change Date"
* item[0].item[0].type = #date
* item[0].item[0].required = true
* item[0].item[0].repeats = false

* item[0].item[1].linkId = "code"
* item[0].item[1].text = "New Job Title"
* item[0].item[1].type = #choice
* item[0].item[1].answerValueSet = "http://ihris.org/fhir/ValueSet/ihris-job"
* item[0].item[1].required = true
* item[0].item[1].repeats = false

