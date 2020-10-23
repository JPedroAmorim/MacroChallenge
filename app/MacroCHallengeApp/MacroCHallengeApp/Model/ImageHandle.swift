////
////  ImageHandle.swift
////  MacroCHallengeApp
////
////  Created by Joao Flores on 23/10/20.
////
//
//import UIKit
//
//class ImageHandle {
//
//	var backgroundQueue: OperationQueue {
//		let queue = OperationQueue()
//		queue.maxConcurrentOperationCount = 3
//		return queue
//	}
//
//	init() {
//		let imageDownloadOperation = BlockOperation {
//			PromotionDAO().recoverImage(imageFile: self.imageHeader, imagePlaceholder: "Duplo Salada") { (image, error) in
//				guard let image = image else {
//					self.imageProduct.image = UIImage(named: "logo")
//					return
//				}
//				OperationQueue.main.addOperation {
//					self.imageProduct.image = image
//				}
//			}
//		}
//		self.backgroundQueue.addOperation(imageDownloadOperation)
//	}
//
//	func recoverImage(imageFile: String?, imagePlaceholder: String, completion: @escaping (UIImage?,Error?) ->()) {
//
//		let placeholderImage = UIImage(named: imagePlaceholder)
//		guard let imageFile = imageFile else {
//			completion(placeholderImage, nil)
//			return
//		}
//		storage.reference().child("\(storageName)/\(imageFile)").downloadURL { (imageUrl, err) in
//			if let err = err {
//				print(err.localizedDescription)
//				completion(nil,err)
//			}else {
//				do {
//					let imageView = UIImageView()
//					print(imageUrl)
//
//					//completion(placeholderImage, nil)
//					if let imageURL = imageUrl {
//
//
//						let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
//
//							if let error = error {
//								print ("ERROR:\(error.localizedDescription)")
//							} else if let data = data {
//
//								let image = UIImage(data: data)
//
//								completion(image,nil)
//							}
//
//
//						}
//
//						task.resume()
//					}
//
//
//
//				} catch {
//					print("erro na imagem")
//				}
//			}
//		}
//	}
//
//
//}
