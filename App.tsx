/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import {useEffect} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  useColorScheme,
  View,
  Button,
  NativeModules,
  NativeEventEmitter,
} from 'react-native';

import {Colors, Header} from 'react-native/Libraries/NewAppScreen';

function App(): React.JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  // Add Event Listener for IntelliWebViewPostMessage API
  useEffect(() => {
    // Subscribe to the event when the App component mounts
    const eventEmitter = new NativeEventEmitter(NativeModules.WebViewModule);
    const subscription = eventEmitter.addListener(
      'IntelliWebViewPostMessage',
      postMessage => {
        // Handle the received postMessage
        console.log('ReactNative PostMessage Full Body:', postMessage);

        try {
          // The PostMessage is received as a JSON String, so we need to parse it
          const parsedMessage = JSON.parse(postMessage);
          if (parsedMessage && parsedMessage.stage) {
            console.log('ReactNative PostMessage Stage:', parsedMessage.stage);
          } else {
            console.warn(
              'ReactNative invalid PostMessage format:',
              parsedMessage,
            );
          }
        } catch (error) {
          console.error('ReactNative error parsing PostMessage:', error);
        }
      },
    );

    // Unsubscribe from the event when the component unmounts
    return () => {
      subscription.remove();
    };
  }, []); // Empty dependency array means this effect runs once when the component mounts

  // Add Callback to NativeModules for presenting the IntelliWebView
  const handleOpenWebView = () => {
    NativeModules.WebViewModule.presentWebView(
      'https://wippy.intelliprove.com/?action_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImVtYWlsIjoiIiwiY3VzdG9tZXIiOiJ0ZXN0aW5nLWFwaS1rZXkiLCJncm91cCI6InN1cGVyLWFkbWluIiwibWF4X21lYXN1cmVtZW50X2NvdW50IjoxMDAwMCwidXNlcl9pZCI6ImFiMWJiMTQ1YjcyMTQ4ZjRhZmY3ZTgwYjBmMjVmMWUxIiwiYXV0aDBfdXNlcl9pZCI6bnVsbH0sIm1ldGEiOnt9LCJleHAiOjIwNzE3NTQwNDh9.LNVfPgR9GlfflaiRPiYoyYW7eVN7vEknNy6TJCeDzzk',
    );
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={backgroundStyle.backgroundColor}
      />
      <ScrollView
        contentInsetAdjustmentBehavior="automatic"
        style={backgroundStyle}>
        <Header />
        <View
          style={{
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
          }}>
          <Button title="Open WebView" onPress={handleOpenWebView} />
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

export default App;
