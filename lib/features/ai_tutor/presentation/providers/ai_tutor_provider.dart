import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/openai_service.dart';

enum MessageRole { user, assistant }

class ChatMessage {
  final String id;
  final String content;
  final MessageRole role;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.role,
    required this.timestamp,
  });

  Map<String, String> toApiFormat() => {
    'role': role == MessageRole.user ? 'user' : 'assistant',
    'content': content,
  };
}

class AiTutorState {
  final List<ChatMessage> messages;
  final bool isStreaming;
  final String streamingText;
  final String? error;

  const AiTutorState({
    this.messages = const [],
    this.isStreaming = false,
    this.streamingText = '',
    this.error,
  });

  AiTutorState copyWith({
    List<ChatMessage>? messages,
    bool? isStreaming,
    String? streamingText,
    String? error,
  }) {
    return AiTutorState(
      messages: messages ?? this.messages,
      isStreaming: isStreaming ?? this.isStreaming,
      streamingText: streamingText ?? this.streamingText,
      error: error,
    );
  }
}

final aiTutorProvider = StateNotifierProvider<AiTutorNotifier, AiTutorState>((ref) {
  return AiTutorNotifier(ref.watch(openAiServiceProvider));
});

class AiTutorNotifier extends StateNotifier<AiTutorState> {
  final OpenAiService _openAiService;

  AiTutorNotifier(this._openAiService) : super(const AiTutorState());

  Future<void> sendMessage(String message) async {
    // Add user message
    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: message,
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isStreaming: true,
      streamingText: '',
    );

    try {
      final history = state.messages
          .where((m) => m.role != MessageRole.user || m.id != userMsg.id)
          .map((m) => m.toApiFormat())
          .toList();

      String fullResponse = '';

      await for (final chunk in _openAiService.chatStream(
        userMessage: message,
        history: history,
      )) {
        fullResponse += chunk;
        state = state.copyWith(streamingText: fullResponse);
      }

      // Add assistant message
      final assistantMsg = ChatMessage(
        id: '${DateTime.now().millisecondsSinceEpoch}_ai',
        content: fullResponse,
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, assistantMsg],
        isStreaming: false,
        streamingText: '',
      );
    } catch (e) {
      final errorMsg = ChatMessage(
        id: '${DateTime.now().millisecondsSinceEpoch}_err',
        content: 'Sorry, I encountered an error. Please try again. If the issue persists, check your internet connection.',
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, errorMsg],
        isStreaming: false,
        streamingText: '',
        error: e.toString(),
      );
    }
  }

  void clearChat() {
    state = const AiTutorState();
  }
}
