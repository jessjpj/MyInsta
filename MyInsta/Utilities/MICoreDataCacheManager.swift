//
//  MICoreDataCacheManager.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 23/03/2025.
//

import CoreData
import Foundation

class MICoreDataCacheManager: MICacheManagerProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    func savePosts(_ posts: [MIPost]) {
        // Clear existing posts before saving new ones
        clearCache()
        
        for post in posts {
            let postEntity = PostEntity(context: context)
            postEntity.id = post.id
            postEntity.caption = post.caption
            postEntity.likes = Int32(post.likes)

            let userEntity = UserEntity(context: context)
            userEntity.id = post.user.id
            userEntity.name = post.user.name
            userEntity.avatarThumb = post.user.avatarThumb
            postEntity.user = userEntity

            for media in post.media {
                let mediaEntity = MediaEntity(context: context)
                mediaEntity.url = media.url
                mediaEntity.type = media.type
                mediaEntity.resolution = media.resolution
                postEntity.addToMedia(mediaEntity)
            }

            for comment in post.comments {
                let commentEntity = CommentEntity(context: context)
                commentEntity.text = comment.text

                let commentUserEntity = UserEntity(context: context)
                commentUserEntity.id = comment.user.id
                commentUserEntity.name = comment.user.name
                commentUserEntity.avatarThumb = comment.user.avatarThumb
                commentEntity.user = commentUserEntity
                
                postEntity.addToComments(commentEntity)
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save posts to Core Data: \(error)")
        }
    }

    func loadPosts() -> [MIPost]? {
        let fetchRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        
        do {
            let postEntities = try context.fetch(fetchRequest)
            let posts = postEntities.map { postEntity in
                // Convert PostEntity to MIPost
                let user = MIUser(
                    id: postEntity.user?.id ?? "",
                    name: postEntity.user?.name ?? "",
                    avatarThumb: postEntity.user?.avatarThumb ?? ""
                )
                
                let media = (postEntity.media as? Set<MediaEntity>)?.map { mediaEntity in
                    MIMedia(
                        url: mediaEntity.url ?? "",
                        type: mediaEntity.type ?? "",
                        resolution: mediaEntity.resolution ?? ""
                    )
                } ?? []
                
                let comments = (postEntity.comments as? Set<CommentEntity>)?.map { commentEntity in
                    MIComment(
                        user: MIUser(
                            id: commentEntity.user?.id ?? "",
                            name: commentEntity.user?.name ?? "",
                            avatarThumb: commentEntity.user?.avatarThumb ?? ""
                        ),
                        text: commentEntity.text ?? ""
                    )
                } ?? []
                
                return MIPost(
                    id: postEntity.id ?? "",
                    user: user,
                    caption: postEntity.caption ?? "",
                    media: media,
                    likes: Int(postEntity.likes),
                    comments: comments
                )
            }
            return posts
        } catch {
            print("Failed to fetch posts from Core Data: \(error)")
            return nil
        }
    }

    func isCacheValid() -> Bool {
        return true
    }

    func clearCache() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PostEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to clear cache: \(error)")
        }
    }
}
