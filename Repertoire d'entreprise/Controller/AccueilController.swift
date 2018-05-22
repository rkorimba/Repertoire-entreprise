//
//  AccueilController.swift
//  Repertoire d'entreprise
//
//  Created by Riad Korimbacus on 22/05/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit
import CoreData


class AccueilController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var cellID = "PersonneCell"
   
    var entreprises = [Entreprise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchEntreprises()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return entreprises.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if let employes = entreprises[section].employes?.allObjects as? [Personne] {
            return employes.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if let employes = entreprises[indexPath.section].employes?.allObjects as? [Personne] {
            let employeDeLaCell = employes[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? PersonneCell {
                cell.miseEnPlace(personne: employeDeLaCell)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return entreprises[section].nom
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       
        switch editingStyle {
        case .delete:
            if let personneASupprimer = entreprises[indexPath.section].employes?.allObjects[indexPath.row] as? Personne {
                contexte.delete(personneASupprimer)
                do {
                    try contexte.save()
                } catch {
                    print(error.localizedDescription)
                }
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default: break
        }
    }
    
    func fetchEntreprises() {
       
        let requete: NSFetchRequest<Entreprise> = Entreprise.fetchRequest()
        let tri = NSSortDescriptor(key: "nom", ascending: true)
        requete.sortDescriptors = [tri]
        do {
            entreprises = try contexte.fetch(requete)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }

}
