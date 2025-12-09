import 'package:flutter/material.dart';

/// 신고 사유를 받는 바텀시트 (간단 폼)
class ReportSheet extends StatefulWidget {
  final String itemId;
  const ReportSheet({super.key, required this.itemId});

  @override
  State<ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<ReportSheet> {
  String? _reason;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('신고 사유를 선택하세요',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              _chip('저작권 침해'),
              _chip('부적절한 이미지'),
              _chip('스팸/광고'),
              _chip('기타'),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: '추가 설명 (선택)',
              hintStyle: TextStyle(color: Colors.white54),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54)),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () {
                // 실제로는 서버로 신고 데이터 전송
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('신고가 접수되었습니다. 감사합니다.')),
                );
              },
              child: const Text('신고하기'),
            ),
          )
        ],
      ),
    );
  }

  Widget _chip(String label) {
    final selected = _reason == label;
    return ChoiceChip(
      label: Text(label,
          style: TextStyle(color: selected ? Colors.black : Colors.white)),
      selected: selected,
      selectedColor: Colors.white,
      backgroundColor: Colors.white10,
      onSelected: (_) => setState(() => _reason = label),
    );
  }
}
