# 3D reconstruction using 2D cross_section(2020/12~2021/03)
- Reconstructing a 2D cross section into 3D is followed by watching the paper.

## 1. Process
### (1) Paper review
- After reviewing and summarizing the thesis, make a [PPT](https://github.com/young3984/3D_reconstruction_using_2D_cross_section/blob/master/PPT/Reconstruction.pdf).
### (2) Heat equation[[Codes]](https://github.com/young3984/3D_reconstruction_using_2D_cross_section/tree/master/Code/Heat_equation)
- Approximating heat equations in an implicit method. [[Codes]](https://github.com/young3984/3D_reconstruction_using_2D_cross_section/tree/master/Code/Heat_equation)

  ![heat](https://user-images.githubusercontent.com/68014282/123136552-05a3d680-d48e-11eb-804d-12a170b286a7.gif)
- Approximating the above method using Gauss Seidel iteration.[[Codes]](https://github.com/young3984/3D_reconstruction_using_2D_cross_section/tree/master/Code/Heat_equation)
 
  ![heat_2D (1)](https://user-images.githubusercontent.com/68014282/123108776-ac2fad80-d475-11eb-9bd6-5f1362a71359.gif)
### (3) Reconstruct using the modified Cahn-Hilliard equation.  [[Code]](https://github.com/young3984/3D_reconstruction_using_2D_cross_section/tree/master/Code/Cahn_Hilliard)
- Result

![image](https://user-images.githubusercontent.com/68014282/123136966-78ad4d00-d48e-11eb-823f-4c657e463439.jpg)
 
For detailed process and results, please check the [PPT](https://github.com/young3984/3D_reconstruction_using_2D_cross_section/tree/master/PPT) and [[Code]](https://github.com/young3984/3D_reconstruction_using_2D_cross_section/tree/master/Code).

### (3) Reference
```
[1] SEUNGGYU LEE, YONGHO CHOI, DOYOON LEE, HONG-KWON JO, SEUNGHYUN LEE,SUNGHYUN MYUNG, AND JUNSEOK KIM, [A MODIFIED CAHN–HILLIARD EQUATION FOR 3D VOLUME
RECONSTRUCTION FROM TWO PLANAR CROSS SECTIONS], KSIAM Vol.19, No.1, 47–56, 2015
```

