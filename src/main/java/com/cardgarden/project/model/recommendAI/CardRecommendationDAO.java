package com.cardgarden.project.model.recommendAI;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Repository;

@Repository
public class CardRecommendationDAO implements CardRecommendationDAOInterface {

    public static void main(String[] args) throws Exception {
        // 1. 환경변수로 프로젝트 루트 경로를 가져오기 (없으면 현재 디렉토리 ".")
        String appRoot = System.getenv("CARD_PROJECT_ROOT");
        if (appRoot == null || appRoot.isEmpty()) {
            appRoot = "."; // 기본값: 현재 실행 디렉토리
        }
        File rootDir = new File(appRoot);

        // 2. 실행할 쉘 스크립트와 인자(예시: 패턴ID)
        String scriptPath = "./run_recommend.sh";
        String patternId = "1"; // 예시

        // 3. 프로세스 빌더 설정 (작업 디렉토리 지정)
        ProcessBuilder pb = new ProcessBuilder(scriptPath, patternId);
        pb.directory(rootDir);
        pb.redirectErrorStream(true); // stdout+stderr 통합

        Process process = pb.start();
        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream(), "UTF-8"));

        String jsonStr = null;
        StringBuilder allOutput = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            allOutput.append(line).append("\n");
            line = line.trim();
            if (line.startsWith("[") && line.endsWith("]")) {
                jsonStr = line;
                break;
            }
        }

        process.waitFor();

        System.out.println("==== PYTHON OUTPUT LOG ====\n" + allOutput);

        if (jsonStr == null) {
            throw new RuntimeException("JSON 결과를 찾을 수 없습니다. (파이썬 스크립트가 정상적으로 동작했는지 확인해 주세요)");
        }

        // 결과 리스트 파싱
        List<CardRecommendationDAO.CardRecommendResult> list = CardRecommendationDAO.parse(jsonStr);

        // 결과 출력 (테스트)
        for (CardRecommendResult result : list) {
            System.out.println("card_id: " + result.card_id + ", expected_match: " + result.expected_match);
        }
    }

    // 추천 결과 저장용 클래스
    public static class CardRecommendResult {
        public int card_id;
        public double expected_match;

        public CardRecommendResult(int card_id, double expected_match) {
            this.card_id = card_id;
            this.expected_match = expected_match;
        }
    }

    // JSON 문자열을 파싱하여 결과 객체 리스트로 변환
    public static List<CardRecommendResult> parse(String jsonStr) throws Exception {
        JSONParser parser = new JSONParser();
        JSONArray arr = (JSONArray) parser.parse(jsonStr);
        List<CardRecommendResult> result = new ArrayList<>();
        for (Object obj : arr) {
            JSONObject rec = (JSONObject) obj;
            int cardId = ((Number) rec.get("card_id")).intValue();
            double expectedMatch = ((Number) rec.get("expected_match")).doubleValue();
            result.add(new CardRecommendResult(cardId, expectedMatch));
        }
        return result;
    }
}
