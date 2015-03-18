import QtQuick 2.0

import QtQuick 2.0
import QtQuick.Particles 2.0

ParticleSystem {
    id: root
    width: 240
    height: 120

    Emitter {
        emitRate: 400
        lifeSpan: 8000
        size: 24
        sizeVariation: 16
        velocity: PointDirection {x: root.width/10; y: root.height/10;}
        acceleration: PointDirection {x: -root.width/40; y: -root.height/40; xVariation: -root.width/20; yVariation: -root.width/20}
    }

    CustomParticle {
        vertexShader:"
            uniform lowp float qt_Opacity;
            varying lowp float fFade;
            varying highp vec2 fPos;

            void main() {
                qt_TexCoord0 = qt_ParticleTex;
                highp float size = qt_ParticleData.z;
                highp float endSize = qt_ParticleData.w;

                highp float t = (qt_Timestamp - qt_ParticleData.x) / qt_ParticleData.y;

                highp float currentSize = mix(size, endSize, t * t);

                if (t < 0. || t > 1.)
                currentSize = 0.;

                highp vec2 pos = qt_ParticlePos
                - currentSize / 2. + currentSize * qt_ParticleTex          // adjust size
                + qt_ParticleVec.xy * t * qt_ParticleData.y         // apply velocity vector..
                + 0.5 * qt_ParticleVec.zw * pow(t * qt_ParticleData.y, 2.);

                gl_Position = qt_Matrix * vec4(pos.x, pos.y, 0, 1);

                //highp float fadeIn = min(t * 20., 1.);
                //highp float fadeOut = 1. - max(0., min((t - 0.75) * 4., 1.));

                highp float fadeIn =0.2;
                highp float fadeOut = 0.2;


                fFade = fadeIn * fadeOut * qt_Opacity;
                fPos = vec2(pos.x/320., pos.y/480.);
            }
        "
        //! [0]
        fragmentShader: "
            varying highp vec2 fPos;
            varying lowp float fFade;
            varying highp vec2 qt_TexCoord0;
            void main() {//*2 because this generates dark colors mostly
                highp vec2 circlePos = qt_TexCoord0*2.0 - vec2(1.0,1.0);
                highp float dist = length(circlePos);
                highp float circleFactor = max(min(1.0 - dist, 1.0), 0.0);
                //gl_FragColor = vec4(fPos.x*3.0 - fPos.y, fPos.y*3.0 - fPos.x, fPos.x*fPos.y*2.0, 0.0) * circleFactor * fFade;
                  gl_FragColor = vec4(fPos.x*3.0 - fPos.y, fPos.y*3.0 - fPos.x, 1.0, 0.0) * circleFactor * fFade;
                //gl_FragColor = vec4(255, 255, 255, 0.0) * circleFactor * fFade;
            }"
        //! [0]

    }
}


