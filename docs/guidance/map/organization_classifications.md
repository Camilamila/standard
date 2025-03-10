# Organization classifications

Many publishers wish to disclose and monitor information about different classifications of organizations involved in contracting processes. Example classifications include organization ownership, incorporation, sector, location, and number of employees. We recognise that publishing information about a variety of organization characteristics, for example women-owned and/or indigenous-owned organizations, is an important part of monitoring participation in public procurement.

Some organization classifications, such as organization scale, can be published using a specific extension in OCDS. Many other classifications are context-specific, and for this case, we provide an organization classification extension that allows publishers to provide their own classifications.

There are therefore two options that are encouraged for publishing organization classifications.

1. For classifications that have become standardized, there are specific OCDS extension fields that ought to be used. At present, this only applies to organization scale, which ought to be disclosed using the [party scale extension](https://extensions.open-contracting.org/en/extensions/partyScale/master/). This extension adds a `scale` field to the `parties.details` block, to indicate the size or scale of an organization, in particular commercial enterprises or economic operators.
1. For non-standardized options, such as classifying forms of organization ownership, publishers ought to use the [organization classification extension](https://extensions.open-contracting.org/en/extensions/organizationClassification/1.1/). This extension adds a [`classifications`](../../schema/reference.md#classification) array to the `parties.details` block to enable the categorization of organizations. Each `classification.id` field ought to contain a code from the particular scheme given in the `classification.scheme` field. Details about the particular organization characteristic that is being disclosed ought to be provided in the `classification.description` field. The given `classification.scheme` can be an existing scheme (drawn from the open [itemClassificationScheme codelist](../../schema/codelists.md#item-classification-scheme)), or a local scheme for a particular publisher. In both cases, we encourage publishers to provide details of all schemes and classification codes used in their [publication policy](../publish.md#finalize-your-publication-policy), to help users understand the data.

As fields become standardized through the use of option 2, the information can be migrated to _also_ be published via specific extensions as in option 1. Publishers can continue to publish the information in the organization classification extension to preserve backwards compatibility in data sets.

A third, discouraged, example approach using local extensions is also given below, for situations where neither of the above two approaches apply to a specific use case.

## Worked examples

### Option 1: standardized options

#### Organization scale

In the example below, Moldova has disclosed information about the 'Companie mică' organization using the [party scale extension](https://extensions.open-contracting.org/en/extensions/partyScale/master/). The scale is given as 'micro', from the [partyScale codelist](https://extensions.open-contracting.org/en/extensions/partyScale/master/codelists/).

```{jsoninclude} ../../examples/organization-classification/moldova_organization_scale.json
:jsonpointer:
:expand: releases, parties, details
:title: party_scale
```

### Option 2: Organization classification extension

In the examples below, two different publishers have disclosed information about organizations involved in their contracting processes. An organization classification needs to consist of at least two parts: an identifier for the list (scheme) from which the classification is taken, and an identifier for the category from that list being applied. It is useful to also publish a text label and/or URI that users can draw on to interpret the classification. In the first example below, the publisher re-uses an existing `classification.scheme`. In the second example below, where a publisher wishes to track specific policy-related data, a local list of categories is used in preference to mapping to a generic set.

#### Classification schemes

Each `classification` block contains fields to provide information about the `description` (a textual description or title for the classification code), `id` (the classification code), `uri` (to uniquely identify the classification code) and `scheme`. The `scheme` value can be drawn from the open [itemClassificationScheme codelist](../../schema/codelists.md#item-classification-scheme) (where the `Category` value is "organization"), or it can be a local scheme. Schemes are given to classify the activities of procuring authorities (i.e. procuring entities and/or buyers).

Where an appropriate scheme is not listed in the [itemClassificationScheme codelist](../../schema/codelists.md#item-classification-scheme), publishers can specify their own scheme. Publishers can either re-use an alternative scheme, or provide their own. Where publishers provide their own local schemes, they ought to prefix their `scheme` code with an [ISO-3166-1 alpha-3 country code](https://en.wikipedia.org/wiki/ISO_3166-1) to preserve its global uniqueness. Details of this local scheme, and a list of possible codes, ought to be described in the [publication policy](../publish.md#finalize-your-publication-policy).

#### Example 2.1 disclosing data using existing schemes

In the first fictional example below, the UK has disclosed a code from two different European Commission (EC) schemes, 'TED_CE_ACTIVITY' and 'TED_CA_TYPE' to classify the organization whose name is "London Borough of Haringey". Refer to the  [itemClassificationScheme codelist](../../schema/codelists.md#item-classification-scheme) for further details of these schemes.

Note that the `classification.id` relates to the id of the code in the `classification.scheme` given, rather than its position in the `classifications` array. Therefore, the first `classification` shows that the `id` of 'Regional or local authority' in the 'TED_CA_TYPE' scheme is 'REGIONAL_AUTHORITY', and the second `classification` shows that the `id` of 'General public services' in the 'COFOG' scheme is '01'.

```{jsoninclude} ../../examples/organization-classification/uk_organization_classification.json
:jsonpointer:
:expand: releases, parties, details, classifications
:title: organization_classifications
```

#### Example 2.2 disclosing data using a local scheme

The second example below is set in the fictional city of Ciudad Ficticia in Colombia. The procurement team wishes to monitor the participation of women-owned businesses in procurement according to specific policy priorities. The first organization declared in the `parties` array is a women-owned business, so they add a `classifications` array to it with just one `classification` object. In this object, the local  `classification.scheme` is 'COL-CF-MON' and the `classification.id` is 'NPDM'. Note that the `classification.id` contains the relevant classification code from the given scheme, rather than being an internal identifier in the `classifications` array.

In their publication policy, the procurement team documents all possible codes for COL-CF-MON with definitions of each code, including explaining that 'NPDM' is for businesses registered with the local Chamber of Commerce where ownership and control is at least 51% women.

```{jsoninclude} ../../examples/organization-classification/fictional_wob_organization_classification.json
:jsonpointer:
:expand: releases, parties, details, classifications
:title: organization_classification
```

### Option 3: Local extensions

A third, discouraged, option is for publishers to use local extensions to disclose organization classification information. This option is discouraged because it is difficult for data users to compare organization classifications across multiple data sets that use many different approaches to disclosing similar information. However, in the absence of standardized options, where there is a specific use case for the data, this can be the most appropriate short-term option. Local extensions ought to document the structure and meaning of the additional fields they describe: please refer to the [extensions documentation](extensions).

For example, although tracking women-owned organizations is shown example 2.2 above, this data only provides information on entities that have been registered as women-owned. Organizations without the classification can be not women-owned, women-owned but not registered as such, or the information might not be known.

To disambiguate these cases, a publisher can choose to publish a flag field for the relevant organization classification. In the fictional example below, Dhanghadi has created a local extension so they can publish data in the `parties.details` block on an organization that is `femaleChaired`, with the values of the field being either `true` or `false`. The publisher would document the structure of this field and its meaning in the local extension files.

```{jsoninclude} ../../examples/organization-classification/dhangadhi_female_chaired_example.json
:jsonpointer:
:expand: releases, parties, details
:title: femaleChaired
```
