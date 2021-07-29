//
//  CoreDataModel.swift
//  VaxGuideSG
//
//  Created by Owrmac on 29/7/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // creating Users() object array
    var users = [Users]()
    
    func addNewUser(email: String, fullname: String, nric: String, password: String, phone: String) {
        
        // Getting the User() object, Managed Object, from the managed object context
        let user = Users(context: context)
        user.email = String(email)
        user.fullname = String(fullname)
        user.nric = String(nric)
        user.password = String(password)
        user.phone = String(phone)
        
        do {
            try context.save()
            
        } catch {
            print("Error in addNewUser: \(error.localizedDescription)")
        }
    }
    
    func fetchAllUsers() -> [Users] {
        
        do {
            // Fetching employee managed objects from store and assigning them to employees arr
            users = try context.fetch(Users.fetchRequest())
            
        } catch {
            print("Error in fetchAllUsers: \(error.localizedDescription)")
        }
        
        return users

    }
    
    func updateUser(user: Users, email: String, fullname: String, nric: String, phone: String){
        user.email = email
        user.fullname = fullname
        user.nric = nric
        user.phone = phone
        
        do {
            try context.save()

        } catch {
            
        }
        
    }
    
    
}

