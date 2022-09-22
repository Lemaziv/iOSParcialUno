//
//  PokemonListViewController.swift
//  ParcialUno
//
//  Created by Universidad Anahuac on 21/09/22.
//

import UIKit

class PokemonListViewController: UIViewController {

    
    @IBOutlet weak var pokemonTableView: UITableView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var containerLoadingView: UIView!
    
    var pokemons: [Pokemon] = []
    var currentPokemon: Pokemon? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //pokemonTableView.register(UINib(nibName: "PokemonViewCell", bundle: nil), forCellReuseIdentifier: "pokemonCell")
        //pokemonTableView.dataSource = self
        //pokemonTableView.delegate = self
        //loadingIndicatorView.hidesWhenStopped = true
        //loadingIndicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
            self.loadPokemons()
        }

    }
    
    func loadPokemons(){
        let urlBase = "https://www.superheroapi.com/api.php/423212276549393/1"
        let listPokemonEndPoint = URL.init(string: "\(urlBase)")!
        let task = URLSession.shared.dataTask(with: listPokemonEndPoint){data, response, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let result = try! jsonDecoder.decode(Heroes.self, from: data)
                print(result)
                DispatchQueue.main.sync {
                    self.containerLoadingView.isHidden = true
                    self.loadingIndicatorView.stopAnimating()
                    self.pokemonTableView.reloadData()
                }
                
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonDetailSegue" {
            let destino = segue.destination as? PokemonDetailViewController
            destino?.pokemon = currentPokemon
        }
    }
    
}

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = pokemonTableView.dequeueReusableCell(withIdentifier: "pokemonCell") as? PokemonViewCell
        if(cell == nil){
            cell = PokemonViewCell()
        }
        let item = pokemons[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentPokemon = pokemons[indexPath.row]
        performSegue(withIdentifier: "pokemonDetailSegue", sender: nil)
    }


}
