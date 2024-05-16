import 'package:cloudflare_ai/src/text_summarization/response.dart';

import '../services/network_service.dart';
import 'models.dart';

class TextSummarizationModel {
  late String accountId;
  late String apiKey;
  late TextSummarizationModels model;
  late bool raw;
  NetworkService networkService = NetworkService();
  late String baseUrl;

  TextSummarizationModel({
    required this.accountId,
    required this.apiKey,
    this.model = TextSummarizationModels.BART_LARGE_CNN,
    this.raw = true,
  }) {
    baseUrl = "https://api.cloudflare.com/client/v4/accounts/$accountId/ai/run";
  }

  Future<TextSummarizationResponse> summarize(String text,
      {int maxLength = 1024}) async {
    Map<String, dynamic> res =
        await networkService.post("$baseUrl/${model.value}", apiKey, {
      "input_text": text,
      "max_length": maxLength,
    });
    TextSummarizationResponse response =
        TextSummarizationResponse.fromJson(res);
    return response;
  }
}
