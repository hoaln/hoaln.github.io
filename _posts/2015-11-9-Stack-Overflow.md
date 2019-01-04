Stack ?
 
 
Stack là vùng nhớ dành cho các biến local, địa chỉ của bộ đếm chương trình. Trong ứng dụng nhúng với tài nguyên giới hạn,  phần mềm nếu thiết kế không tốt có thể dẫn đến tràn stack , từ đó gây ra những lỗi với hiện tượng khó xác đinh lúc runtime. Để tránh việc này, các nhà lập trình được khuyến cáo không khai báo một mảng local quá lớn và không dùng đệ quy trong các ứng dụng nhúng.

 Tuy nhiên, trong một hệ thống phần mềm phức tạp viết bởi nhiều người và không thể kiểm soát được mã nguồn viết bởi người khác, nhu cầu kiểm tra hệ thống phần mềm hiện tại đã chiếm bao nhiêu tài nguyên stack là điều cần thiết.

- Ví dụ một dự án porting một framework sang 1 board nhúng mà chúng ta không chắc chắn được chúng có đủ tài nguyên để chạy được hay không thì việc kiểm tra stack chính là kiểm tra tính khả thi của dự án

- Khi gặp bug hiện tượng lạ lúc run-time, điều đầu tiên nghĩ đến là stack đã bị tràn dẫn đến những undefined behavior và lúc đó cũng cần check lại stack đang có.
 

Kiểm tra stack hiện đang được dùng có thể bằng nhiều cách:

- Sử dụng các chương trình tính toán stack ví dụ như call_graph, thường được tích hợp vào IDE hoặc chạy standlone. Chúng sẽ dựa vào việc cách các hàm gọi nhau để tính ra điểm sâu nhất của stack, hàm nào là điểm sâu nhất ..... Tuy nhiên cách này sẽ không tính toán được nếu lời gọi hàm của chúng ta thông qua các con trỏ hàm. Một số IDE hỗ trợ các #pragma calls để chúng ta chỉ thị cho chương trình tính stack biết là các hàm nào sẽ được gọi. Tuy nhiên, nếu các ngắt gọi thì vẫn không tính toán được.

- Dự đoán điểm sâu nhất của chương trình ( nghi ngờ nó gây tràn stack) và tính giá trị stack tại điểm đó. ( Khai báo một biến và so sánh địa chỉ của biến đó với đỉnh stack).

- Nếu việc dự đoán điểm sâu nhất của chương trình là khó khăn thì chúng ta cần một ngắt timer tần số đủ nhanh, và mỗi lần vào ngắt lại lưu lại giá trị hiện thời của con trỏ stack (khai báo 1 biến mới và lấy địa chỉ của nó), từ đó có thể biết được điểm sâu nhất của stack có vượt quá đỉnh stack hay không. Tuy nhiên vẫn có xác suất là tại thời điểm chúng ta lấy giá trị con trỏ stack thì nó không phải là điểm sâu nhất (dù timer hoạt động tần số khá cao)

- Fill bộ nhớ với 1 pattern cố định ví dụ như 0xDEADBEEF và sau đó kiểm tra từ đỉnh stack xuống, giá trị đầu tiên khác với pattern cố định là 0xDEADBEEF trên thì đó nhiều khả năng là điểm sâu nhất của stack mà chương trình hiện giờ đạt tới. (chú ý: không chắc chắn đó là điểm sâu nhất của stack ví dụ như khi khai báo một mảng rất lớn mà không khởi tạo hay thay đổi giá trị của mảng đó thì dù kích thước mảng có thể vượt quá stack nhưng các pattern cố định lưu ở vùng nhớ đó vẫn không thay đổi).

- Để bảo vệ tràn stack, các chip nhúng có MPU (Memory Protection Unit) thường cấu hình một vùng biên bảo vệ trên đỉnh stack là vùng nhớ read-only. Khi chương trình cố gắng ghi vào vùng đó sẽ có exception và lập trình viên biết được thời điểm stack đã bị tràn.

 

Tóm lại, có nhiều cách từ đơn giản (viết thêm mã) đến phức tạp (dùng tool), để estimate stack hiện dùng so với tài nguyên đang có, các lập trình viên có thể sử dụng với các mục đích khác nhau (bring up hệ thống, debug lỗi)