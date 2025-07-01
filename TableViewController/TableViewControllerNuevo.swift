//
//  TableViewControllerNuevo.swift
//  TableViewController
//
//  Created by Dnilson Achahuanco on 11/06/25.
//

import UIKit

/*
class TableViewCellNuevo:UITableViewCell{
    @IBOutlet weak var etiqueta: UILabel!
    @IBOutlet weak var imagenNumeros: UIImageView!
}
*/
class TableViewControllerNuevo: UITableViewController {
    // Acciones personalizadas al deslizar una fila (Eliminar, Insertar) usando UIContextualAction (iOS 11+)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let eliminarAction = UIContextualAction(style: .destructive, title: "Eliminar") { (action, view, completionHandler) in
            self.arregloNumeros.remove(at: indexPath.row)
            tableView.reloadData()
            completionHandler(true)
        }
        eliminarAction.backgroundColor = UIColor.red

        let insertarAction = UIContextualAction(style: .normal, title: "Insertar") { (action, view, completionHandler) in
            let ultimoElemento = self.arregloNumeros[self.arregloNumeros.count - 1]
            self.arregloNumeros.append(String(Int(ultimoElemento)! + 1))
            tableView.reloadData()
            completionHandler(true)
        }
        insertarAction.backgroundColor = UIColor.green

        let configuration = UISwipeActionsConfiguration(actions: [eliminarAction, insertarAction])
        return configuration
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isEditing = true
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        setEditing(true, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if (self.isEditing) {
            self.editButtonItem.title = "Editar"
        } else {
            self.editButtonItem.title = "Hecho"
        }
    }

    // MARK: - Table view data source

    var arregloNumeros:[String] = ["1", "2", "3", "4"]
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arregloNumeros.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = arregloNumeros[indexPath.row]
        switch cell.textLabel?.text {
        case "1":
            cell.imageView?.image = UIImage(named: "ICONOS/1.png")
            cell.detailTextLabel?.text = "Celda numero 1"
        case "2":
            cell.imageView?.image = UIImage(named: "ICONOS/2.png")
            cell.detailTextLabel?.text = "Celda numero 2"
        case "3":
            cell.imageView?.image = UIImage(named: "ICONOS/3.png")
            cell.detailTextLabel?.text = "Celda numero 3"
        case "4":
            cell.imageView?.image = UIImage(named: "ICONOS/4.png")
            cell.detailTextLabel?.text = "Celda numero 4"
        default:
            print("No hay mas elementos para llenar imagen")
            cell.detailTextLabel?.text = "Celda fuera de rango"
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let valorSeleccionado = indexPath.row
        self.performSegue(withIdentifier: "pantallaDosSegue", sender: valorSeleccionado)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pantallaDosSegue" {
            let valorRecibido = sender as? Int
            let pantalla2: ViewControllerVer = segue.destination as! ViewControllerVer
            pantalla2.valorRecibido = arregloNumeros[valorRecibido!]
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)
            arregloNumeros.remove(at: indexPath.row)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the
            // array, and add a new row to the table view
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let objetoMovido = self.arregloNumeros[fromIndexPath.row]
        arregloNumeros.remove(at: fromIndexPath.row)
        arregloNumeros.insert(objetoMovido, at: to.row)
        NSLog("%@", "\(fromIndexPath.row) => \(to.row) \(arregloNumeros)")
    }

    // Permite que todas las filas sean movibles
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         self.tableView.isEditing = true
     }

    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
