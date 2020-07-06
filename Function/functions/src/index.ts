import functions = require('firebase-functions');
import admin = require('firebase-admin');
import { error } from 'firebase-functions/lib/logger';

admin.initializeApp(functions.config().firebase);

let msgData;

exports.notificationDataChangeTrigger = functions.firestore.document(
  'users/{usersId}/notificationData/{notificationDataId}'
).onCreate((snapshot, context)=>{
  msgData = snapshot.data();
  console.log(msgData)
  const idTo = msgData.userId
  
  admin.firestore().collection('users')
  .where('id', '==', idTo).get().then(querySnapshot =>{
    querySnapshot.forEach(userDetails=>{
      try {
        const payLoad = {
          notification: {
            title: 'You got a Notification!',
            body: 'Open It Now',
            badge: '1',
            sound:'default'
          }
        }

        admin.messaging().sendToDevice(userDetails.data().token,payLoad)
        .then(response=>{
          console.log('Message sent  ',response)
        })
        .catch(err=>{
          console.log('Error   ',error)
        })

      } catch (error) {
        
      }
    })
  })
  .catch()

  return null

})