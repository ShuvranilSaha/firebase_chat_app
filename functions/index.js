const { admin } = require('firebase-admin/lib/database');
const functions = require('firebase-functions');

admin.initializeApp();

exports.myFunction = functions.firestore
.document('chat/{message}')
.onCreate((snapshot, context) => {
    return admin.messaging().sentToTopic('chat', {
        notification: {
            title: snapshot.data().username,
            body: snapshot.data().text,
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        },
    });
});
