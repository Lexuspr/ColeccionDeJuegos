//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by MAC10 on 30/04/18.
//  Copyright © 2018 TECSUP. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var JuegoImageView: UIImageView!

    @IBOutlet weak var eliminarBoton: UIButton!
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var juego:Juego?  = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if juego != nil{
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        } else {
            eliminarBoton.isHidden = true
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagenSeleccionada = info[UIImagePickerControllerOriginalImage] as! UIImage
        JuegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func fotosTapped(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func agregarTapped(_ sender: UIButton) {
        if juego != nil {
            juego!.titulo = tituloTextField.text
            juego!.imagen = UIImagePNGRepresentation(JuegoImageView.image!) as NSData?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = UIImagePNGRepresentation(JuegoImageView.image!) as NSData?
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        }
    
    @IBAction func eliminarTapped(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


