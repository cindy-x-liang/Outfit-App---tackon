//
////APICaller.swift
////ChatAI
////Created by Afraz Siddiqui on 12/12/22.
//
//import OpenAISwift
//import Foundation
//final class APICaller {
//    static let shared = APICaller ()
//    
//    @frozen enum Constants {
//        static let key = "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"
//    }
//    
//    private var client: OpenAISwift?
//    
//    private init() {}
//    
//    
//    public func setup()
//    { let apiConfig = OpenAISwift.Config.makeDefaultOpenAI(apiKey: "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")
//        client = OpenAISwift(config: apiConfig) }
//    
//    public func getResponse (input: String, completion: @escaping (Result<String, Error>) -> Void) {
//        
//        client?.sendCompletion(with: input, completionHandler: { result in
//            switch result {
//            case .success (let model):
//                let output = model.choices?.first?.text ?? ""
//                completion(.success (output))
//            case .failure (let error):
//                completion(.failure (error))
//            }
//        })
//    }
//}
//
//  testLangChain.swift
//  langchain_implementation
//
//  Created by Cindy Liang on 7/15/23.
//

import Foundation
import LangChain


public class chatBot {

    var input = ["human_input": ""]
    //var output = ["Answer":""]
//    let template = """
//
//
//    %@
//    Human: %@
//    Assistant:
//    """
    
//    let prompt = PromptTemplate(input_variables: ["history", "human_input"], template: """
//
//
//    %@
//    Human: %@
//    Assistant:
//    """)


    

    let chatgpt_chain = LLMChain(
        llm: OpenAI(),
        prompt: PromptTemplate(input_variables: ["history", "human_input"], partial_variable: [:], template: """
                Give me an outfit recommendation in 25 words for the following weather:
    
    
    Human: {human_input}
    Assistant:
    """),
        //parser: Nothing(),
        memory: ConversationBufferWindowMemory()
    )
    
    func run(userInput: String) async -> String {
    
            input["human_input"] =  userInput
            var output = await chatgpt_chain.predict(args: input)
            print(input["human_input"]!)
        print(output!)
            
        
        
            //TO DOs for CINDY
            //maybe add embeddings https://fauna.com/blog/building-ai-applications-with-openai-pinecone-langchain-fauna
            
            
            //ask wanna book flights -- or just directly give
            //ask wanna look at hotel info
            //find apis for the hotel info
        
        
        //string search or regex comparison
        //fake data for flight
        //seed flight and hotel data stuff and put it into sql lite database
        //read from sql lite dataabase
        //only need flights between dallas and nyc
       
        
        return output!
    }
    

    
}
