---
layout: post
title: Mô hình active object trong thiết kế phần mềm nhúng
---

Bài viết này được viết từ năm 2017 khi đang phát triển platform cho các hệ máy thông tin quân sự tại Viettel. Từ đó đến nay, thư viện phần mềm dựa trên các khái niệm về active object này đã được ứng dụng ở các sản phẩm máy thông tin vô tuyến trong quân sự, HMI, Control-Box, BMS, Telematics-Box cho xe điện 2 bánh, dùng để implement hiệu quả các giao thức để tìm kênh truyền tốt nhất trên sóng HF, giao thức backbone trong xe điện trên nền CAN để download firmware, diagnostic, authentication; nền tảng hardware sử dụng cũng đa dạng từ Cortex M0 đến M7, chạy baremetal trên chip low-end 8K ram đến chạy đa luồng trên nền RTOS trên những dòng mcu tài nguyên dồi dào hơn. 

![](https://raw.githubusercontent.com/hoaln/hoaln.github.io/master/active_object_images/active-object-thiet-ke-pm-nhung-1.jpg)

![](https://raw.githubusercontent.com/hoaln/hoaln.github.io/master/active_object_images/active-object-thiet-ke-pm-nhung-2.jpg)

![](https://raw.githubusercontent.com/hoaln/hoaln.github.io/master/active_object_images/active-object-thiet-ke-pm-nhung-3.jpg)

![](https://raw.githubusercontent.com/hoaln/hoaln.github.io/master/active_object_images/active-object-thiet-ke-pm-nhung-4.jpg)