# UniGear — cập nhật Figma ngày 24/10/2026

Thiết kế được chỉnh trực tiếp trong [file Figma UniGear](https://www.figma.com/design/6tbh0sWgQJ0u1wu0ceaC66/E-commerce?node-id=0-1). Tài liệu này ghi lại các thay đổi và điểm vào prototype; không phải mã nguồn ứng dụng hoặc bản xuất đầy đủ của file Figma.

Các quyết định dưới đây thay mô tả tương ứng trong bản ghi thiết kế ngày 23/10/2026. Các tài liệu kế hoạch cũ chưa được đồng bộ toàn bộ theo lần chỉnh Figma này.

## Danh mục và kết quả sản phẩm

- Rê chuột vào **Danh mục sản phẩm** để mở menu; rê vào nhóm để hiện danh mục con.
- Nhóm **Laptop, PC, Tablet** có Laptop học tập, Laptop gaming, PC văn phòng, PC gaming, Tablet học tập và Tablet đồ họa.
- Nhóm phụ kiện có Chuột, Bàn phím, Tai nghe, Hub & cáp và Giá đỡ; các mục dẫn tới kết quả tương ứng.
- Trang kết quả dùng dropdown gồm **Giá giảm dần, Giá tăng dần, Mới nhất, Lượt xem**. Prototype có trạng thái danh sách cho từng lựa chọn.
- Đã bỏ dòng mô tả “Thiết bị & phụ kiện cho góc học tập”.
- Nội dung và giá sản phẩm Laptop/PC/Tablet là dữ liệu minh họa.

Điểm vào: [Trang chủ](https://www.figma.com/design/6tbh0sWgQJ0u1wu0ceaC66/E-commerce?node-id=7-280).

## Bỏ thông báo trên web

- Bỏ mục thông báo trên thanh điều hướng của Customer, Seller và Admin, cùng các thẻ thông báo trên giao diện tablet.
- Bỏ ba màn trung tâm thông báo C17, S16 và M22, đồng thời gỡ các liên kết prototype tới chúng.
- Căn lại thanh điều hướng và tăng chiều rộng ô tìm kiếm trên header Customer.
- Giữ email tự động và màn xem trước email; sửa nội dung hướng dẫn để thể hiện gửi kết quả qua email.

Đã đối chiếu trang 3–4 của đề final do người dùng cung cấp: `C:/IU_SCHOOL/Code/WEB APP/final_project_description_v3.pdf`. Notification Center là một lựa chọn trong nhóm tính năng nâng cao, không phải tính năng bắt buộc riêng. Nhóm giữ ba lựa chọn chính: upload ảnh có xem trước/kiểm tra/lưu trữ, dashboard có biểu đồ tương tác và email tự động có mẫu. Các chức năng này vẫn cần triển khai thực sự trong ứng dụng.

## Đơn hàng Customer

Thay bộ tìm kiếm, lọc, sắp xếp, phân trang và bảng cũ trên C08 bằng năm tab. Bên dưới là thẻ đơn hàng có ảnh minh họa sản phẩm, tên shop, mã đơn, phân loại, số lượng, giá, tổng thanh toán và nút xem chi tiết.

| Tab | Dữ liệu minh họa | Điểm vào |
|---|---|---|
| Tất cả | 3 đơn hàng | [C08](https://www.figma.com/design/6tbh0sWgQJ0u1wu0ceaC66/E-commerce?node-id=8-857) |
| Chờ xác nhận | SO-A1024 / TechNest | [Chờ xác nhận](https://www.figma.com/design/6tbh0sWgQJ0u1wu0ceaC66/E-commerce?node-id=152-9486) |
| Đang giao | SO-B1024 / CampusGear | [Đang giao](https://www.figma.com/design/6tbh0sWgQJ0u1wu0ceaC66/E-commerce?node-id=152-9519) |
| Đã nhận | SO-A0980 / TechNest | [Đã nhận](https://www.figma.com/design/6tbh0sWgQJ0u1wu0ceaC66/E-commerce?node-id=152-9552) |
| Khiếu nại | CP-0022 yêu cầu hoàn 215.000đ; CP-0021 yêu cầu hoàn 100.000đ | [Khiếu nại](https://www.figma.com/design/6tbh0sWgQJ0u1wu0ceaC66/E-commerce?node-id=152-9585) |

Theo yêu cầu mới của người dùng, tab Khiếu nại là nơi xem các yêu cầu hoàn tiền đang **Chờ Admin duyệt**. Gửi yêu cầu chưa thay đổi số dư. Nút **Xem yêu cầu** dẫn tới đúng hồ sơ khiếu nại hiện có; các thẻ đơn thường dẫn tới màn chi tiết đơn tương ứng. Trạng thái giao hàng và trạng thái xử lý yêu cầu hoàn tiền là hai thông tin riêng.

## Kiểm tra đã thực hiện

- Kiểm tra ba overlay danh mục và 12 dropdown sắp xếp; xác minh 48 trạng thái kết quả và thứ tự giá tăng/giảm.
- Xác nhận không còn ba màn thông báo hoặc liên kết tới các màn đã xóa; màn email vẫn tồn tại.
- Kiểm tra ảnh trang chủ, Seller, Admin và tablet sau khi bỏ thông báo.
- Xác minh cả năm tab đơn hàng, 20 liên kết chuyển tab không tính tab đang chọn, số thẻ tương ứng 3/1/1/1/2 và ảnh sản phẩm trên từng thẻ.
- Xác nhận bộ lọc cũ đã được gỡ khỏi các màn danh sách đơn mới; tab Khiếu nại có hai trạng thái Chờ Admin duyệt.
- Kiểm tra ảnh màn Tất cả và Khiếu nại sau khi sửa chiều rộng các hàng, căn tab, trạng thái, tổng tiền và nút thao tác.

Các kiểm tra trên xác minh cấu trúc, liên kết và bố cục prototype Figma. Chưa dùng chúng làm bằng chứng kiểm thử API, lưu dữ liệu, gửi email hoặc giao dịch hoàn tiền của ứng dụng.
