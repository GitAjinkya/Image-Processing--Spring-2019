1.Input Image

![image](https://user-images.githubusercontent.com/50030413/67422257-12c53f80-f5a0-11e9-9942-79bb9a95b580.png)

The input image is clearly motion blurred. We can estimate this blur in frequency domain

2.Frequency domain representation of the input image

![image](https://user-images.githubusercontent.com/50030413/67422325-3e482a00-f5a0-11e9-8662-5f34a635b264.png)

The frequency domain image looks like this. The black horizontal lines are the frequencies that are lost. These frequencies can be estimated by using wiener filter. 
We know that this is motion blur, we must estimate the amount of motion and its direction.

3.  Estimated Motion blur

![image](https://user-images.githubusercontent.com/50030413/67422518-a434b180-f5a0-11e9-9a71-a621b354b22e.png)

This motion is blur is caused by 35x1 psf at an angle of 90 degrees.

Also, the output image had some additive noise whose variance can be estimated by the flat areas of the image which was found out be 12.

Now we can deconvolve the image given all the information using wiener filter.

4. Deblurred Image

![image](https://user-images.githubusercontent.com/50030413/67422606-d3e3b980-f5a0-11e9-976c-972bb7a96ae5.png)

All the letters are clearly readable. 
The edges are blurred a little since we have used edge taper to make up for the lost frequency information outside image boundary. 
