//
// Food101.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class Food101Input : MLFeatureProvider {

    /// Image of a food as color (kCVPixelFormatType_32BGRA) image buffer, 299 pixels wide by 299 pixels high
    var image: CVPixelBuffer

    var featureNames: Set<String> {
        get {
            return ["image"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "image") {
            return MLFeatureValue(pixelBuffer: image)
        }
        return nil
    }
    
    init(image: CVPixelBuffer) {
        self.image = image
    }
}

/// Model Prediction Output Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class Food101Output : MLFeatureProvider {

    /// Source provided by CoreML

    private let provider : MLFeatureProvider


    /// Confidence and label of predicted food as dictionary of strings to doubles
    lazy var foodConfidence: [String : Double] = {
        [unowned self] in return self.provider.featureValue(for: "foodConfidence")!.dictionaryValue as! [String : Double]
    }()

    /// Label of predicted food as string value
    lazy var classLabel: String = {
        [unowned self] in return self.provider.featureValue(for: "classLabel")!.stringValue
    }()

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(foodConfidence: [String : Double], classLabel: String) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["foodConfidence" : MLFeatureValue(dictionary: foodConfidence as [AnyHashable : NSNumber]), "classLabel" : MLFeatureValue(string: classLabel)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class Food101 {
    var model: MLModel

/// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: Food101.self)
        return bundle.url(forResource: "Food101", withExtension:"mlmodelc")!
    }

    /**
        Construct a model with explicit path to mlmodelc file
        - parameters:
           - url: the file url of the model
           - throws: an NSError object that describes the problem
    */
    init(contentsOf url: URL) throws {
        self.model = try MLModel(contentsOf: url)
    }

    /// Construct a model that automatically loads the model from the app's bundle
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration
        - parameters:
           - configuration: the desired model configuration
           - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct a model with explicit path to mlmodelc file and configuration
        - parameters:
           - url: the file url of the model
           - configuration: the desired model configuration
           - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    init(contentsOf url: URL, configuration: MLModelConfiguration) throws {
        self.model = try MLModel(contentsOf: url, configuration: configuration)
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as Food101Input
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as Food101Output
    */
    func prediction(input: Food101Input) throws -> Food101Output {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as Food101Input
           - options: prediction options 
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as Food101Output
    */
    func prediction(input: Food101Input, options: MLPredictionOptions) throws -> Food101Output {
        let outFeatures = try model.prediction(from: input, options:options)
        return Food101Output(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface
        - parameters:
            - image: Image of a food as color (kCVPixelFormatType_32BGRA) image buffer, 299 pixels wide by 299 pixels high
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as Food101Output
    */
    func prediction(image: CVPixelBuffer) throws -> Food101Output {
        let input_ = Food101Input(image: image)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface
        - parameters:
           - inputs: the inputs to the prediction as [Food101Input]
           - options: prediction options 
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as [Food101Output]
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    func predictions(inputs: [Food101Input], options: MLPredictionOptions = MLPredictionOptions()) throws -> [Food101Output] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [Food101Output] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  Food101Output(features: outProvider)
            results.append(result)
        }
        return results
    }
}
