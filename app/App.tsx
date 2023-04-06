import 'expo-dev-client'
import 'intl'
import 'intl/locale-data/jsonp/en'
import React, { FC, memo } from 'react'
import { VideoEditorModal } from 'react-native-videoeditorsdk'

const App: FC<any> = memo(() => {
  return (
    <VideoEditorModal
      onCancel={() => console.log('canceled')}
      onError={(error) => console.log(error)}
      onExport={(result) => console.log(result)}
      video={'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4'}
      visible={true}
    />
  )
})

export default App
