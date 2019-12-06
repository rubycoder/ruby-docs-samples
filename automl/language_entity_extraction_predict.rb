# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

def entity_extraction_predict actual_project_id:, actual_model_id:, actual_content:
  # Predict.
  # [START automl_language_entity_extraction_predict]
  require "google/cloud/automl"

  project_id = "YOUR_PROJECT_ID"
  model_id = "YOUR_MODEL_ID"
  content = "text to predict"
  # [END automl_language_entity_extraction_predict]
  # Set the real values for these variables from the method arguments.
  project_id = actual_project_id
  model_id = actual_model_id
  content = actual_content
  # [START automl_language_entity_extraction_predict]

  prediction_client = Google::Cloud::AutoML::Prediction.new

  # Get the full path of the model.
  model_full_id = prediction_client.class.model_path project_id, "us-central1", model_id
  payload = {
    text_snippet: {
      content:   content,
      # Types: 'text/plain', 'text/html'
      mime_type: "text/plain"
    }
  }

  response = prediction_client.predict model_full_id, payload

  response.payload.each do |annotation_payload|
    puts "Text Extract Entity Types: #{annotation_payload.display_name}"
    puts "Text Score: #{annotation_payload.text_extraction.score}"
    text_segment = annotation_payload.text_extraction.text_segment
    puts "Text Extract Entity Content: #{text_segment.content}"
    puts "Text Start Offset: #{text_segment.start_offset}"
    puts "Text End Offset: #{text_segment.end_offset}"
  end
  # [END automl_language_entity_extraction_predict]
end