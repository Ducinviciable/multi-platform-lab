🎮 Tên truyện: “Mùa hè năm ấy, có Alice” (Tsundere ver.)
🧩 Tính cách Alice (rất quan trọng để code dialogue)
Hay nói kiểu:
“Đừng hiểu lầm nhé!”
“Tôi không quan tâm đâu…”
Nhưng hành động lại:
quan tâm bạn
nhớ những thứ nhỏ nhặt

Hiện thêm biểu cảm (😒 / 😳) để tăng cảm xúc
🌱 STORY (Nâng cấp các node chính)
🔹 Node 0 – Gặp lại (Tsundere intro)

Story:
Alice làm rơi sách. Bạn giúp.

Dialogue Alice:

“Ơ… cảm ơn. Nhưng mà… tôi tự làm được mà!” 😳

Choice:

“Ừ, nhìn cũng không giống tự làm được lắm” (+affection +1, +courage +1) → Node 1
“Không có gì đâu” (+affection +1) → Node 1

👉 Note: tsundere thích bị “trêu nhẹ” hơn là quá hiền 😄

🔹 Node 3 – Nhắn tin (Tsundere chat)

Story:
Bạn nhắn tin cho Alice.

Dialogue:

“Tôi không rảnh đâu… nhưng trả lời bạn một chút cũng được.”

Choice:

Nhắn tin mỗi ngày (+affection +1) → Node 7
Đợi Alice nhắn → Node 8
🔹 Node 7 – Gần nhau (bắt đầu lộ “dere”)

Story:
Alice nói:

“Ở đây… cũng không tệ lắm. Ít nhất là… có người nói chuyện.”

(ngập ngừng)

Choice:

“Có tôi mà 😄” (+affection +2, +courage +1) → Node 9
“Ừ, cũng bình thường thôi” → Node 8
🔹 Node 10 – Đi chơi (tsundere peak moment)

Story:
Hai bạn đi ăn.

Alice nói:

“Đừng nghĩ là tôi thích đi với bạn nhé! Chỉ là… hôm nay rảnh thôi!”

Nhưng cô ấy cười rất nhiều.

Choice:

“Ừ, tôi cũng không thích đâu 😏” (+affection +2) → Node 12
“Tôi thích đi với cậu” (+courage +1) → Node 12
🔹 Node 12 – Dấu hiệu rõ ràng

Story:
Alice bắt đầu:

nhớ bạn thích ăn gì
chờ bạn tan học

Nhưng vẫn nói:

“Đừng hiểu lầm nhé, tiện đường thôi!”

Choice:

Quan tâm lại (+affection +2) → Node 14
Giữ khoảng cách → Node 13
🔹 Node 14 – Cao trào (Tsundere break)

Story:
Alice nói (nhìn đi chỗ khác):

“Có thể… tôi sẽ về nước sớm.”

Im lặng một lúc, cô ấy nói thêm:

“Cũng không liên quan đến bạn đâu.”

(giọng hơi run)

Choice:

“Liên quan chứ.” (+courage +2) → Node 15
“Ừ, vậy à…” → Node 16
🔹 Node 15 – Thổ lộ (Tsundere payoff 🔥)

Story:
Bạn nói ra.

Alice đỏ mặt:

“C-Cậu nói cái gì vậy chứ…!”
“Tôi đâu có… thích cậu…”
(ngập ngừng)
“…nhưng mà… nếu là cậu thì… cũng được.”

👉 Đây là moment ăn tiền nhất game 😄

🔹 Node 16 – Không nói

Story:
Bạn im lặng.

Alice cười nhẹ:

“Ừ… vậy thì tốt.”

Nhưng lần này, cô ấy không nhìn bạn nữa.

🎯 ENDINGS (giữ logic cũ nhưng thêm tsundere flavor)
💚 Ending 1 – Happy (Tsundere Love)

affection >= 5 && courage >= 4

Story:
Alice vẫn tsundere:

“Đừng có nghĩ là tôi sẽ nhớ cậu đâu nhé!”

Nhưng vẫn:

nhắn tin mỗi ngày
giữ liên lạc sau khi về nước

👉 Hidden line:

“...nhưng mà đừng biến mất đấy.”

💔 Ending 2 – Tiếc nuối (Tsundere đau nhất)

affection >= 5 && courage < 4

Story:
Alice rời đi.

Tin nhắn cuối:

“Tôi ghét cậu.”
“…vì cậu không nói gì cả.”

👉 Đây là ending “đau nhưng hay”

🌤 Ending 3 – Bạn bè

affection < 5

Alice vẫn kiểu:

“Chỉ là bạn thôi nhé, đừng hiểu lầm!”

💀 Ending 4 – Mất nhau

(Node 18)

Không còn tương tác.

🔥 Tips làm game hay hơn (quan trọng với tsundere)

1. Dialogue phải “2 lớp”
   Lời nói: lạnh
   Hành động: ấm

👉 Ví dụ:

nói: “tôi không quan tâm”
nhưng: vẫn chờ bạn 2. Hiển thị cảm xúc

Bạn có thể thêm:

String mood = "tsun"; // tsun / dere 3. Event đặc biệt nên có
Trời mưa (tsundere dễ soft)
Bệnh (cô ấy chăm bạn nhưng phủ nhận)
Ghen nhẹ
