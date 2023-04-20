import 'expo-dev-client'
import 'intl'
import 'intl/locale-data/jsonp/en'
import React, { FC, memo, useCallback, useState } from 'react'
import { Button, Text, View } from 'react-native'
import { VideoEditorModal } from 'react-native-videoeditorsdk'

const App: FC<any> = memo(() => {
  const [showVideoEditorModal, setShowVideoEditorModal] = useState(true)
  const [message, setMessage] = useState('')
  const onCancel = useCallback(() => {
    const errorMessage = 'User cancelled the modal'
    console.log(errorMessage)
    setMessage(errorMessage)
    setShowVideoEditorModal(false)
  }, [])
  const onError = useCallback((error: any) => {
    console.log(error)
    setMessage(JSON.stringify(error, null, 2))
    setShowVideoEditorModal(false)
  }, [])
  const onExport = useCallback((result: any) => {
    console.log(result)
    setMessage(JSON.stringify(result, null, 2))
    setShowVideoEditorModal(false)
  }, [])
  return (
    <View>
      <Text>{message}</Text>
      <Button onPress={() => setShowVideoEditorModal(true)} title={`Show modal`} />
      <VideoEditorModal
        onCancel={onCancel}
        onError={onError}
        onExport={onExport}
        video={'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4'}
        visible={showVideoEditorModal}
      />
    </View>
  )
})

export default App
