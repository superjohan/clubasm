#define PI 3.1415926535897932384626433832795

uniform vec2 resolution;

vec2 iResolution = resolution;
float iTime = u_time * 0.05;
vec2 fragCoord = gl_FragCoord.xy;

float x1 = (iResolution.x*sin(iTime*1.9+0.3))/2.0;
float y1 = (iResolution.y*cos(iTime*3.1+1.0))/2.0;
float x2 = (iResolution.x*sin(iTime*1.2+1.5))/2.0;
float y2 = (iResolution.y*cos(iTime*2.7+2.3))/2.0;
float x3 = (iResolution.x*sin(iTime*2.1+3.5))/2.0;
float y3 = (iResolution.y*cos(iTime*3.5+4.3))/2.0;

float pix1 = atan2((iResolution.y/2.0+y1)-fragCoord.y,(iResolution.x/2.0+x1)-fragCoord.x);
float pix2 = atan2((iResolution.y/2.0+y2)-fragCoord.y,(iResolution.x/2.0+x2)-fragCoord.x);
float pix3 = atan2((iResolution.y/2.0+y3)-fragCoord.y,(iResolution.x/2.0+x3)-fragCoord.x);

//    float shade = floor(3.999*(sin(pix1*8.0+pix2*8.0+pix3*8.0)+1.0)/2.0)/4.0;

float shade = (sin(pix1*8.0)+sin(pix2*8.0)+sin(pix3*8.0))/3.0;
float adjusted = 0.9 + (shade * 0.1);

// Output to screen
_output.color = vec4(adjusted, adjusted, adjusted, 1.0);
