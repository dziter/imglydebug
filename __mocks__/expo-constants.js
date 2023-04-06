export default {
  deviceId: 'mocked-device-id',
  manifest: {
    extra: {
      api: {
        url: 'https://global.api.dev.nox.studiolapsus.com',
        endpoint: 'graphql',
      },
      awsService: {
        baseUrl: 'https://static.dev.nox.studiolapsus.com',
        imgLy: {
          audio: '/audio',
          stickers: '/stickers',
        },
        visual: {
          request: '/visuals/request',
          broadcast: '/visuals/broadcast',
        },
      },
      ads: {
        ios: {
          banner: 'ca-app-pub-3940256099942544/2934735716',
          rewardedInterstitial: 'ca-app-pub-3940256099942544/6978759866',
        },
        android: {
          banner: 'ca-app-pub-3940256099942544/2934735716',
          rewardedInterstitial: 'ca-app-pub-3940256099942544/6978759866',
        },
      },
      google: {
        apiKey: 'AIzaSyAzxQoipsJfFgBAusTjBfQkTEmt8EqcEGs',
      },
      giphy: {
        ios: {
          apiKey: '16AoqWr4smYqVKDQADU9JQiADadyDxJY',
        },
        android: {
          apiKey: '16AoqWr4smYqVKDQADU9JQiADadyDxJY',
        },
      },
      appsFlyer: {
        devKey: 'MptQjE4VBYAvDBDzsfynvD',
        appId: '1557526565',
      },
      awsConfig: {
        Auth: {
          mandatorySignIn: false,
          region: 'eu-west-1',
          userPoolId: 'eu-west-1_1vdZwcZsj',
          userPoolWebClientId: '1u73v9e2a2l1gp1cgsk32qv6o',
          oauth: {
            domain: 'auth.dev.nox.studiolapsus.com',
            scope: ['email', 'profile', 'openid', 'aws.cognito.signin.user.admin'],
            responseType: 'code',
            redirectSignIn: 'com.nox.noxapp://',
            redirectSignOut: 'com.nox.noxapp://',
            urlOpener: null,
          },
        },
      },
      useAppsFlyer: true,
    },
  },
  statusBarHeight: 45,
}
