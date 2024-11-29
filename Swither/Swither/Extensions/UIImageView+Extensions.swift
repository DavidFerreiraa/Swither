//
//  UIImage+Extensions.swift
//  Swither
//
//  Created by David Ferreira Lima on 29/11/24.
//

import UIKit

extension UIImage {
    static func from(url urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL string")
            completion(nil)
            return
        }
        
        // Fetch image data asynchronously
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle any error that occurred during fetching
            if let error = error {
                print("Error fetching image: \(error)")
                completion(nil)
                return
            }
            
            // If data is received, create the image
            if let data = data, let image = UIImage(data: data) {
                // Ensure the completion handler is called on the main thread
                DispatchQueue.main.async {
                    completion(image)
                }
                return
            } else {
                completion(nil)
                return
            }
        }.resume() // Start the task
    }
}
