#define LETTER_A "/BlockFont/A.png"
#define LETTER_B "/BlockFont/B.png"
#define LETTER_C "/BlockFont/C.png"
#define LETTER_D "/BlockFont/D.png"
#define LETTER_E "/BlockFont/E.png"
#define LETTER_F "/BlockFont/F.png"
#define LETTER_G "/BlockFont/G.png"
#define LETTER_H "/BlockFont/H.png"
#define LETTER_I "/BlockFont/I.png"
#define LETTER_J "/BlockFont/J.png"
#define LETTER_K "/BlockFont/K.png"
#define LETTER_L "/BlockFont/L.png"
#define LETTER_M "/BlockFont/M.png"
#define LETTER_N "/BlockFont/N.png"
#define LETTER_O "/BlockFont/O.png"
#define LETTER_P "/BlockFont/P.png"
#define LETTER_Q "/BlockFont/Q.png"
#define LETTER_R "/BlockFont/R.png"
#define LETTER_S "/BlockFont/S.png"
#define LETTER_T "/BlockFont/T.png"
#define LETTER_U "/BlockFont/U.png"
#define LETTER_V "/BlockFont/V.png"
#define LETTER_W "/BlockFont/W.png"
#define LETTER_X "/BlockFont/X.png"
#define LETTER_Y "/BlockFont/Y.png"
#define LETTER_Z "/BlockFont/.png"
#define NUMBER_0 "/BlockFont/0.png"
#define NUMBER_1 "/BlockFont/1.png"
#define NUMBER_2 "/BlockFont/2.png"
#define NUMBER_3 "/BlockFont/3.png"
#define NUMBER_4 "/BlockFont/4.png"
#define NUMBER_5 "/BlockFont/5.png"
#define NUMBER_6 "/BlockFont/6.png"
#define NUMBER_7 "/BlockFont/7.png"
#define NUMBER_8 "/BlockFont/8.png"
#define NUMBER_9 "/BlockFont/9.png"

#define LOAD(x) if (!LoadSingle(x)) exit(1);

LOAD(LETTER_A);
LOAD(LETTER_B);
LOAD(LETTER_C);
LOAD(LETTER_D);
LOAD(LETTER_E);
LOAD(LETTER_F);
LOAD(LETTER_G);
LOAD(LETTER_H);
LOAD(LETTER_I);
LOAD(LETTER_J);
LOAD(LETTER_K);
LOAD(LETTER_L);
LOAD(LETTER_M);
LOAD(LETTER_N);
LOAD(LETTER_O);
LOAD(LETTER_P);
LOAD(LETTER_Q);
LOAD(LETTER_R);
LOAD(LETTER_S);
LOAD(LETTER_T);
LOAD(LETTER_U);
LOAD(LETTER_V);
LOAD(LETTER_W);
LOAD(LETTER_X);
LOAD(LETTER_Y);
LOAD(LETTER_Z);
LOAD(NUMBER_0);
LOAD(NUMBER_1);
LOAD(NUMBER_2);
LOAD(NUMBER_3);
LOAD(NUMBER_4);
LOAD(NUMBER_5);
LOAD(NUMBER_6);
LOAD(NUMBER_7);
LOAD(NUMBER_8);
LOAD(NUMBER_9);

#undef LOAD
}

#ifdef __APPLE__
    #include <CoreFoundation/CoreFoundation.h>
    #include <CoreGraphics/CoreGraphics.h>
#endif /* __APPLE__ */

bool LoadSingle(CString location)
{
#ifdef __APPLE__
    FileBufferRef buffer = (FileBufferRef)GGRequestFunctionCallback(kGGActionGetResource, (MemoryAddress)location);
    if (!buffer) return false;

    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, buffer->data, buffer->size, NULL);
    CGImageRef image = CGImageCreateWithPNGDataProvider(dataProvider, NULL, false, kCGRenderingIntentDefault);
    double *imageData = (double *)CGImageGetDecode(image);
    CGImageRelease(image);
    CGDataProviderRelease(dataProvider);
    free(buffer->data);
    free(buffer);

    GLint textureID = 0;
#else /* NOT_APPLE */
    // Load Image normally
#endif /* __APPLE__ */

    return true;
}
























