class StoryChoice {
  const StoryChoice({
    required this.text,
    required this.nextNodeId,
    this.affectionDelta = 0,
    this.courageDelta = 0,
  });

  final String text;
  final int nextNodeId;
  final int affectionDelta;
  final int courageDelta;
}

class StoryNode {
  const StoryNode({
    required this.id,
    required this.title,
    required this.story,
    required this.dialogue,
    required this.mood,
    required this.backgroundAsset,
    required this.choices,
  });

  final int id;
  final String title;
  final String story;
  final String dialogue;
  final String mood;
  final String backgroundAsset;
  final List<StoryChoice> choices;
}

class EndingResult {
  const EndingResult({
    required this.title,
    required this.story,
    required this.backgroundAsset,
  });

  final String title;
  final String story;
  final String backgroundAsset;
}

const int endingCheckNodeId = -1;
const int lostNodeId = -2;

const EndingResult lostEnding = EndingResult(
  title: 'Ending 4 - Mất Nhau',
  story:
      'Không còn tương tác gì nữa. Cuộc gặp nhau mùa hè trở thành điều chưa từng được nói thành lời.',
  backgroundAsset: 'assets/backgrounds/lost.svg',
);

const Map<int, StoryNode> storyNodes = {
  0: StoryNode(
    id: 0,
    title: 'Node 0 - Gặp Lại',
    story: 'Alice làm rơi sách. Bạn giúp nhặt lên cho cô ấy.',
    dialogue: '"Ơ... cảm ơn. Nhưng mà... tôi tự làm được mà!" 😳',
    mood: 'tsun',
    backgroundAsset: 'assets/backgrounds/summer_intro.svg',
    choices: [
      StoryChoice(
        text: 'Ừ, nhìn cũng không giống tự làm được lắm',
        affectionDelta: 1,
        courageDelta: 1,
        nextNodeId: 1,
      ),
      StoryChoice(text: 'Không có gì đâu', affectionDelta: 1, nextNodeId: 1),
    ],
  ),
  1: StoryNode(
    id: 1,
    title: 'Node 1 - Bắt Đầu Trò Chuyện',
    story: 'Sau lần gặp đó, bạn và Alice bắt đầu nói chuyện nhiều hơn.',
    dialogue: '"Tôi không quan tâm đâu... chỉ là thấy bạn hơi ồn ào." 😒',
    mood: 'tsun',
    backgroundAsset: 'assets/backgrounds/summer_intro.svg',
    choices: [
      StoryChoice(
        text: 'Nhắn tin cho Alice tối nay',
        courageDelta: 1,
        nextNodeId: 3,
      ),
      StoryChoice(
        text: 'Hẹn Alice đi ăn vào cuối tuần',
        courageDelta: 1,
        nextNodeId: 10,
      ),
    ],
  ),
  3: StoryNode(
    id: 3,
    title: 'Node 3 - Nhắn Tin',
    story: 'Bạn gửi tin nhắn đầu tiên cho Alice.',
    dialogue: '"Tôi không rảnh đâu... nhưng trả lời bạn một chút cũng được."',
    mood: 'tsun',
    backgroundAsset: 'assets/backgrounds/chat_evening.svg',
    choices: [
      StoryChoice(text: 'Nhắn tin mỗi ngày', affectionDelta: 1, nextNodeId: 7),
      StoryChoice(text: 'Đợi Alice nhắn trước', nextNodeId: 8),
    ],
  ),
  7: StoryNode(
    id: 7,
    title: 'Node 7 - Gần Nhau',
    story: 'Không khí giữa hai người bắt đầu dễ chịu hơn.',
    dialogue:
        '"Ở đây... cũng không tệ lắm. Ít nhất là... có người nói chuyện."',
    mood: 'dere',
    backgroundAsset: 'assets/backgrounds/close_moment.svg',
    choices: [
      StoryChoice(
        text: 'Có tôi mà',
        affectionDelta: 2,
        courageDelta: 1,
        nextNodeId: 9,
      ),
      StoryChoice(text: 'Ừ, cũng bình thường thôi', nextNodeId: 8),
    ],
  ),
  8: StoryNode(
    id: 8,
    title: 'Node 8 - Khoảng Cách',
    story:
        'Hai người vẫn nói chuyện, nhưng cả hai đều giữ một khoảng cách an toàn.',
    dialogue: '"Tôi vẫn ổn. Bạn không cần phải lo cho tôi đâu."',
    mood: 'tsun',
    backgroundAsset: 'assets/backgrounds/chat_evening.svg',
    choices: [
      StoryChoice(text: 'Chủ động hẹn gặp', courageDelta: 1, nextNodeId: 10),
      StoryChoice(text: 'Giữ nhịp độ hiện tại', nextNodeId: 13),
    ],
  ),
  9: StoryNode(
    id: 9,
    title: 'Node 9 - Tiến Thêm Một Bước',
    story: 'Bạn cảm nhận được Alice đang mở lòng hơn với bạn.',
    dialogue:
        '"Đừng tưởng là tôi cần bạn nhé... chỉ là nói chuyện với bạn dễ chịu thôi." 😳',
    mood: 'dere',
    backgroundAsset: 'assets/backgrounds/close_moment.svg',
    choices: [
      StoryChoice(text: 'Rủ Alice đi ăn', courageDelta: 1, nextNodeId: 10),
    ],
  ),
  10: StoryNode(
    id: 10,
    title: 'Node 10 - Đi Chơi',
    story: 'Hai bạn đi ăn. Alice cười rất nhiều trong buổi hẹn.',
    dialogue:
        '"Đừng nghĩ là tôi thích đi với bạn nhé! Chỉ là... hôm nay rảnh thôi!"',
    mood: 'tsun',
    backgroundAsset: 'assets/backgrounds/date_night.svg',
    choices: [
      StoryChoice(
        text: 'Ừ, tôi cũng không thích đâu',
        affectionDelta: 2,
        nextNodeId: 12,
      ),
      StoryChoice(
        text: 'Tôi thích đi với cậu',
        courageDelta: 1,
        nextNodeId: 12,
      ),
    ],
  ),
  12: StoryNode(
    id: 12,
    title: 'Node 12 - Dấu Hiệu Rõ Ràng',
    story:
        'Alice nhớ bạn thích ăn gì và chờ bạn tan học. Nhưng cô ấy vẫn phủ nhận.',
    dialogue: '"Đừng hiểu lầm nhé, tiện đường thôi!"',
    mood: 'dere',
    backgroundAsset: 'assets/backgrounds/close_moment.svg',
    choices: [
      StoryChoice(text: 'Quan tâm lại', affectionDelta: 2, nextNodeId: 14),
      StoryChoice(text: 'Giữ khoảng cách', nextNodeId: 13),
    ],
  ),
  13: StoryNode(
    id: 13,
    title: 'Node 13 - Nhịp Chậm',
    story: 'Mọi thứ giữ ở mức an toàn. Không ai vượt qua giới hạn.',
    dialogue: '"Chỉ là bạn thôi nhé, đừng hiểu lầm."',
    mood: 'tsun',
    backgroundAsset: 'assets/backgrounds/chat_evening.svg',
    choices: [
      StoryChoice(text: 'Chấp nhận như vậy', nextNodeId: endingCheckNodeId),
      StoryChoice(text: 'Dần xa nhau', nextNodeId: lostNodeId),
    ],
  ),
  14: StoryNode(
    id: 14,
    title: 'Node 14 - Cao Trào',
    story:
        'Alice nhìn đi chỗ khác rồi nói: "Có thể... tôi sẽ về nước sớm." Giọng cô ấy hơi run.',
    dialogue: '"Cũng không liên quan đến bạn đâu."',
    mood: 'tsun',
    backgroundAsset: 'assets/backgrounds/farewell_station.svg',
    choices: [
      StoryChoice(text: 'Liên quan chứ', courageDelta: 2, nextNodeId: 15),
      StoryChoice(text: 'Ừ, vậy à...', nextNodeId: 16),
    ],
  ),
  15: StoryNode(
    id: 15,
    title: 'Node 15 - Thổ Lộ',
    story:
        'Bạn nói ra cảm xúc của mình. Alice đỏ mặt và mất bình tĩnh trong vài giây.',
    dialogue:
        '"C-Cậu nói cái gì vậy chứ...! Tôi đâu có... thích cậu... nhưng mà... nếu là cậu thì... cũng được."',
    mood: 'dere',
    backgroundAsset: 'assets/backgrounds/farewell_station.svg',
    choices: [
      StoryChoice(
        text: 'Nắm lấy tay Alice',
        affectionDelta: 1,
        nextNodeId: endingCheckNodeId,
      ),
    ],
  ),
  16: StoryNode(
    id: 16,
    title: 'Node 16 - Không Nói',
    story: 'Bạn im lặng. Alice cười nhẹ, nhưng không nhìn bạn nữa.',
    dialogue: '"Ừ... vậy thì tốt."',
    mood: 'tsun',
    backgroundAsset: 'assets/backgrounds/farewell_station.svg',
    choices: [
      StoryChoice(text: 'Kết thúc câu chuyện', nextNodeId: endingCheckNodeId),
    ],
  ),
};

EndingResult resolveEnding({required int affection, required int courage}) {
  if (affection >= 5 && courage >= 4) {
    return const EndingResult(
      title: 'Ending 1 - Happy Ending',
      story:
          'Alice vẫn tsundere: "Đừng nghĩ là tôi sẽ nhớ cậu đâu nhé!" Nhưng cô ấy vẫn nhắn tin mỗi ngày và giữ liên lạc sau khi về nước. "...nhưng mà đừng biến mất đấy."',
      backgroundAsset: 'assets/backgrounds/happy.svg',
    );
  }

  if (affection >= 5 && courage < 4) {
    return const EndingResult(
      title: 'Ending 2 - Tiếc Nuối',
      story:
          'Alice rời đi. Tin nhắn cuối cùng là: "Tôi ghét cậu." "...vì cậu không nói gì cả."',
      backgroundAsset: 'assets/backgrounds/regret.svg',
    );
  }

  return const EndingResult(
    title: 'Ending 3 - Bạn Bè',
    story:
        'Alice vẫn nói: "Chỉ là bạn thôi nhé, đừng hiểu lầm!" Cả hai giữ một kỷ niệm đẹp nhưng không đi xa hơn.',
    backgroundAsset: 'assets/backgrounds/friend.svg',
  );
}
