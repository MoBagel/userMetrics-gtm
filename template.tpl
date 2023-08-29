﻿___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "userMetrics tracking",
  "brand": {
    "id": "brand_dummy",
    "displayName": "",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGMAAABjCAMAAAC45U6nAAABBVBMVEX///8nvO4nvO4nvO4nvO4nvO4nvO4nvO4nvO4nvO4nvO4nvO4nvO4nvO4nvO4nvO4napIjVHwaN2AbM1wZKFMZOmEkXIRNdLlNdLk6XJIaLVcgSnJNdLlNdLkuRXYhTXRNdLlNdLlNdLkgMV4aO2MaJlJNdLlNdLlNdLkZKFRNdLlNdLkiV35NdLk4U4gaPWUaNV4uRngiT3YobZUbNF0eLFkoO2ojYYksQnIhMl8bQmkbKlZNdLkoPGs0ToIpPWwZJlIjXoYeLVovSHobKVUrbpgzTYArQXAfL1xNdLknvO4pjLcYJVEqgqsmotFNdLkql8RJb7Elr98/XphGaqlCZKH///8raAGeAAAASnRSTlMAIEBwgMCwYBAw8OCQ0FCg7uTg6Pbk4CBwy+7iYMDg6BCA8OTo9kDgkPcw0OtQ9uvt6O336+ji8Ovo4vCg6Pft9ejr8O7G7uTgsIhLkaQAAAMKSURBVHjardeLVtNAEIDhSds0bUopIDYVGkiDpLW1VcQLalEUVFgWBii8/6uogGeFJruTnXwPkP/M7uYGlpxSuVJxXbdaqXilGhSuXnZ98UCj6jlQHGehIVI1ywWNs+gKjVYd2EoNYeA6wOK4gmCBs2IVQeMvWg/RFGQLYKXuixyaNuvliXz8OiPBiDASzIhKMCP87eZvfM0XllygcoW1CtCUBUOdulIMTaBoCRYPzOqCx68xNry4bXcEl0/YDTaPfaj4R8sTBXBAqyoKUAYtcbq0vPJE3lpdedo+Oy94sYLOMzlnbf1M5FWDDN0QcUOmWd28ELksQpqoF+MfWzLD81P2bXhXQNyWCqPiwpykj3cupc7mlfWmRwP8Zya1XpBHgYeGIzQ1lJdWjXGMykSavLrK/zbs4v82pNFrUqSUkVANfqSUkVANfkQ1xvjIjqRF6I1hjI/MJMkb8rmKRmjZkLvUxgDnXEuiC9orPcEUkugt6XkV9THFO0m0S/k77GGa95Jo9cr8ZRLFmGYiqT4IDUeNodl01iANNYZmQ3iDtNRDJM0efRDT63yEyF0seaZfqgAzfZRUn/RfDB3MNJFk+lMVYrbP3MVqwS1UGIMs68ZIUGEMsqJ/jujMJJXud3CKWvuS6FzzExWi1iV1tU7FnCrc66PCWa0lzY8zmnyRJG3NtxsafbVreEBs0CPt7ARgQZF2dgKwoEg7OwFIsper4Xtg0cDJgdT7phKNOjwUIs3Nd+o92KqBpqF3eEBpNEowp4dk1/vGZ6JfgRRdVBiVtbtCDdIEmMv14ZFMsy6E60GWPuZ0szO//ds/PAeyTdHC7Oev42P519Hx1sbkBgPQGWMBRqAXI18H9KbIF4DeENlOwCRErgRMEmQKwSzkj8EdhD8G/2gFQBHFaK8HNAnnFqcaoKU4ALKQcaaoohHa6ALwIvwEP6IS/Ag/oURTzCFOwEoHyUYBWBqOyHc3QydGs3AILFHPVOmPQYtfCVWBZ3ySMcIggAKNB+Gj6590hlC8YdK7100i24v8BvBDqt3lMGjaAAAAAElFTkSuQmCC"
  },
  "description": "Inject 8ndpoint userMetrics for user segmentation.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "targetTable",
    "displayName": "BigQuery Table Name",
    "simpleValueType": true,
    "canBeEmptyString": true
  },
  {
    "type": "TEXT",
    "name": "gaAccount",
    "displayName": "Google Analytics Measurement ID",
    "simpleValueType": true,
    "canBeEmptyString": true,
    "valueValidators": [
      {
        "type": "REGEX",
        "args": [
          "^G-\\w{10}$"
        ],
        "errorMessage": "GA ID should be \"G-XXXXXXXXXX\""
      }
    ],
    "valueHint": "G-XXXXXXXXXX"
  },
  {
    "type": "CHECKBOX",
    "name": "enableTdid",
    "checkboxText": "Enable Tdid Feature",
    "simpleValueType": true,
    "help": "It will send event \"get-tdid\" to Google Analytics"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const log = require('logToConsole');
const queryPermission = require('queryPermission');
const injectScript = require('injectScript');
const setInWindow = require('setInWindow');

const initData = () => {
  let endpointConfigs = {};
  for (let key in data) {
     if(key.indexOf('gtm')){
        endpointConfigs[key] = data[key];
     }
  }
  setInWindow('endpointConfigs', endpointConfigs, true);
};

const scriptUrl = 'https://tracking-library.8ndpoint.com/usermetrics.js';

const checkPermissions = () => {
  if (!queryPermission('inject_script', scriptUrl)) {
    log('Unable to inject script by permission');
    return false;
  }
  if (!queryPermission('access_globals', 'readwrite', 'endpointConfigs')) {
    log('Unable to access endpointConfigs` by permission');
    return false;
  }
  return true;
};

const onFailure = () => {
  log('Unable to inject script');
  data.gtmOnFailure();
};

if (checkPermissions()) {
  initData();
  injectScript(scriptUrl, undefined, onFailure, 'widget');
  data.gtmOnSuccess();
} else {
  data.gtmOnFailure();
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "endpointConfigs"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://tracking-library.8ndpoint.com/usermetrics*.js"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 8/28/2023, 6:04:05 PM

