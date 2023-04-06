const extra = {
  eas: {
    projectId: '',
  },
  google: {
    apiKey: '',
  },
  ads: {
    ios: {
      banner: '',
      rewardedInterstitial: '',
    },
    android: {
      banner: '',
      rewardedInterstitial: '',
    },
  },
  api: {
    url: '',
    endpoint: 'graphql',
  },
  awsConfig: {
    Auth: {
      mandatorySignIn: false,
      region: 'eu-west-1',
      userPoolId: '',
      userPoolWebClientId: '',
      oauth: {
        domain: '',
        scope: ['email', 'profile', 'openid', 'aws.cognito.signin.user.admin'],
        responseType: 'code',
        redirectSignIn: 'com.nox.noxapp://',
        redirectSignOut: 'com.nox.noxapp://',
        urlOpener: null,
      },
    },
  },
  giphy: {
    ios: {
      apiKey: '',
    },
    android: {
      apiKey: '',
    },
  },
  appsFlyer: {
    devKey: '',
    appId: '',
  },
  awsService: {
    baseUrl: '',
    imgLy: {
      audio: '/audio',
      stickers: '/stickers',
    },
    visual: {
      request: '/visuals/request',
      broadcast: '/visuals/broadcast',
    },
  },
  logGraphQLErrors: process.env.APP_ENV === 'development',
  useAppsFlyer: process.env.APP_ENV === 'production',
}

export const defaultConfig = extra

module.exports = ({ config }) => {
  const env = process.env.APP_ENV ?? 'development'
  const isProduction = env === 'production'

  const envExtras = {
    production: {
      ...extra,
      //TODO: REPLACE WITH PRODUCTION ONE AFTER FIRST MEP: https://apps.admob.com/v2/apps/list
      ads: {
        ios: {
          banner: '',
          rewardedInterstitial: '',
        },
        android: {
          banner: '',
          rewardedInterstitial: '',
        },
      },
      api: {
        url: '',
        endpoint: 'graphql',
      },
      awsConfig: {
        Auth: {
          mandatorySignIn: false,
          region: 'eu-west-1',
          userPoolId: '',
          userPoolWebClientId: '',
          oauth: {
            domain: '',
            scope: ['email', 'profile', 'openid', ''],
            responseType: 'code',
            redirectSignIn: 'com.nox.noxapp://',
            redirectSignOut: 'com.nox.noxapp://',
            urlOpener: null,
          },
        },
      },
      giphy: {
        ios: {
          apiKey: '',
        },
        android: {
          apiKey: '',
        },
      },
      awsService: {
        ...extra.awsService,
        baseUrl: '',
      },
    },
    development: {
      ...extra,
      logGraphQLErrors: process.env.LOG_GRAPHQL_ERRORS,
    },
    staging: {
      ...extra,
      api: {
        url: '',
        endpoint: 'graphql',
      },
      awsConfig: {
        Auth: {
          mandatorySignIn: false,
          region: 'eu-west-1',
          userPoolId: '',
          userPoolWebClientId: '',
          oauth: {
            domain: '',
            scope: ['email', 'profile', 'openid', ''],
            responseType: 'code',
            redirectSignIn: 'com.nox.noxapp://',
            redirectSignOut: 'com.nox.noxapp://',
            urlOpener: null,
          },
        },
      },
      awsService: {
        ...extra.awsService,
        baseUrl: '',
      },
    },
  }

  return {
    ...config,
    name: isProduction ? 'NOX' : `NOX.${env}`,
    extra: envExtras[env],
    plugins: [
      ...config.plugins,
      [
        'expo-build-properties',
        {
          android: {
            compileSdkVersion: 31,
            targetSdkVersion: 31,
            buildToolsVersion: '31.0.0',
          },
          ios: {
            deploymentTarget: '13.0',
          },
        },
      ],
      [
        'expo-tracking-transparency',
        {
          userTrackingPermission:
            'This identifier will be used to deliver personalized ads to you.',
        },
      ],
      ['react-native-imglysdk'],
      ['react-native-appsflyer', { shouldUseStrictMode: false }],
      [
        'react-native-vision-camera',
        {
          cameraPermissionText: '$(PRODUCT_NAME) needs access to your Camera.',

          // optionally, if you want to record audio:
          enableMicrophonePermission: true,
          microphonePermissionText: '$(PRODUCT_NAME) needs access to your Microphone.',
        },
      ],
      [
        'expo-media-library',
        {
          photosPermission: 'Allow $(PRODUCT_NAME) to access your photos.',
          savePhotosPermission: 'Allow $(PRODUCT_NAME) to save photos.',
          isAccessMediaLocationEnabled: true,
        },
      ],
    ],
  }
}
