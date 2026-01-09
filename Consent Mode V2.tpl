___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Consent Mode V2",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "Template que define e atualiza os tipos de consentimento definidos pelo usuário.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "label1",
    "displayName": "Insira o trigger \"Consent Initialization - All Pages\" ou o evento \"gtm.init_consent\" para que a configuração padrão de consentimento seja definida antes do disparo das demais tags!"
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "consent",
    "displayName": "",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "Consent type",
        "name": "consent_type",
        "type": "SELECT",
        "selectItems": [
          {
            "value": "ad_storage",
            "displayValue": "ad_storage"
          },
          {
            "value": "analytics_storage",
            "displayValue": "analytics_storage"
          },
          {
            "value": "ad_personalization",
            "displayValue": "ad_personalization"
          },
          {
            "value": "ad_user_data",
            "displayValue": "ad_user_data"
          },
          {
            "value": "functionality_storage",
            "displayValue": "functionality_storage"
          },
          {
            "value": "personalization_storage",
            "displayValue": "personalization_storage"
          }
        ]
      },
      {
        "defaultValue": "",
        "displayName": "Data Layer event",
        "name": "data_layer_event",
        "type": "TEXT"
      }
    ],
    "help": "Tipo de consentimento e seu respectivo evento no data layer para configuração:\nRef.: https://developers.google.com/tag-platform/security/concepts/consent-mode?hl\u003den"
  },
  {
    "type": "SELECT",
    "name": "event_name",
    "displayName": "Default {{Event}} variable from data layer",
    "macrosInSelect": true,
    "selectItems": [],
    "simpleValueType": true,
    "help": "Variável que retorna o valor de \"event\" do data layer"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Inicia com o analytics_storage aceito e o restante negado. Se disparar para o restante, aceitar. Senão, manter negado
/*
adopt-visitor-consent-ready
- analytics_storage

adopt-accept-marketing
- ad_storage
- ad_personalization
- personalization_storage

adopt-accept-statistics
- ad_user_data

adopt-accept-performance


adopt-accept-functional
- functionality_storage
*/

const log = require('logToConsole');
const setDefaultConsentState = require('setDefaultConsentState');
const updateConsentState = require('updateConsentState');
log('data =', data);


let event_name = data.event_name;
let consent = data.consent;
//event_name == consent[0].data_layer_event

if(event_name == 'gtm.init_consent'){
  setDefaultConsentState({
    'analytics_storage': 'granted',
    'ad_storage': 'denied',
    'ad_personalization': 'denied',
    'personalization_storage': 'denied',
    'ad_user_data': 'denied',
    'functionality_storage': 'denied'
  });
} else {
consent.forEach(p => {
  if(p.data_layer_event == event_name){
    switch(p.consent_type) {
      case 'analytics_storage':
        updateConsentState({
          'analytics_storage': 'granted',
        });
      break;
      case 'ad_storage':
        updateConsentState({
          'ad_storage': 'granted'
        });
      break;
      case 'ad_personalization':
        updateConsentState({
          'ad_personalization': 'granted'
        });
      break;
      case 'personalization_storage':
        updateConsentState({
          'personalization_storage': 'granted'
        });
      break;
      case 'ad_user_data':
        updateConsentState({
          'ad_user_data': 'granted'
        });
      break;
      case 'functionality_storage':
        updateConsentState({
          'functionality_storage': 'granted'
        });
      break;
    }
  } 
});
}


// Chame data.gtmOnSuccess depois que a tag for concluída.
data.gtmOnSuccess();


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
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
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
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 09/01/2026, 17:39:42


