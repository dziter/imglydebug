module.exports = {
  testTimeout: 5000,
  preset: 'jest-expo',
  transformIgnorePatterns: [
    'node_modules/(?!((jest-)?react-native|@react-native(-community)?)|expo(nent)?|@expo(nent)?/.*|@expo-google-fonts/.*|react-navigation|@react-navigation/.*|@unimodules/.*|unimodules|sentry-expo|native-base|react-native-svg|@miblanchard/react-native-slider|apollo-link-offline)',
  ],
  moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json'],
  setupFilesAfterEnv: ['./jest.setup.js'],
  moduleNameMapper: {
    '^expo-constants$': './__mocks__/expo-constants.js',
  },
}
