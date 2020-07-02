import numpy as np

def crop_img(im, crop_size=60):
    '''
    画像の周りをcrop_sizeだけ切り落とします
 
    Params
    ----------------
        im: image (NumPy Array)
        crop_size: crop size (int)
 
    Returns
    ----------------
        im: croped image (NumPy Array)
 
    '''
 
    im = im[crop_size:-crop_size, crop_size:-crop_size, :]
 
    return im