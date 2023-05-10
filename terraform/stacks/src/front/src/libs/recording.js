import { MediaRecorder } from 'extendable-media-recorder';
import * as constants from './constants.js';
import { S3Client } from '@aws-sdk/client-s3';
import { CognitoIdentityClient } from "@aws-sdk/client-cognito-identity";
import { fromCognitoIdentityPool } from "@aws-sdk/credential-provider-cognito-identity";
import { PutObjectCommand } from '@aws-sdk/client-s3';

const audioContext = new AudioContext();
const s3Client = new S3Client({
    region: constants.REGION,
    credentials: fromCognitoIdentityPool({
        client: new CognitoIdentityClient({ region: constants.REGION }),
        identityPoolId: constants.IDENTITY_POOL_ID,
        })
    });

let id = '';
let chunks = [];
let recorder = null;
let mediaStream = null;
let chunknum = 0;
let counter = 0;

const mediaStreamConstraints = {
    audio: {
        sampleRate:  44100,
        noiseSuppression: true,
        echoCancellation: true
    },
    video: false
 };

export const startRecording = async (language, callback) => {
    id = Date.now()
    chunknum = 0;
    counter = 0;

    if (!language) {
        return false;
    }

    navigator.mediaDevices.getUserMedia(mediaStreamConstraints)
        .then( mediaStream => {

            // Makes the mediastream global
            //window.resultingMediaStream = resultingMediaStream;

            // Create the audio source and connect it to the recorder
            const audioSource = audioContext.createMediaStreamSource(mediaStream);
            recorder = new MediaRecorder(mediaStream);

            // Push the audio chunks to the array when data is available
            recorder.addEventListener('dataavailable', event => {
                chunks.push(event.data);
            });

            // Upload the audio file to S3 when recording is stopped
            recorder.addEventListener('stop', () => {
                const audioBlob = new Blob(chunks, { type: chunks[0].type });

                // Upload the audio file to S3
                counter ++;
                const params = {
                    Bucket: constants.BUCKET,
                    Key: constants.ACCOUNT_ID + '/' + constants.REGION + '/audio/' + constants.SESSION_ID + "/" + constants.SESSION_ID + "-" + counter + ".wav",
                    Body: audioBlob
                };
                const command = new PutObjectCommand(params);

                try {
                    const response = s3Client.send(command);
                    console.log(response);
                } catch (err) {
                    console.error(err);
                }
                

                // Clear the audio chunks array
                chunks = [];
            });

            // Start recording
            recorder.start();
        })
        .catch(error => {
            console.error(error);
        });
};

// Stop capturing the audio stream
export const stopRecording = async () => {
    recorder.stop();
    mediaStream.getTracks().forEach(track => track.stop());
  }
