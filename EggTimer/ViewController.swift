//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation//Reproductor de audio

class ViewController: UIViewController {
    
    
    //MARK: - Outlets
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    
    
    //MARK: - Actions
    @IBAction func hardnessPressed(_ sender: UIButton){
        timer.invalidate()//Invalida el progeso del tiempo si se aprieta otro boton mientras se ejecuta un tiempo
        let hardness = sender.currentTitle!//Manda el texto del boton
        totalTime = eggTimes[hardness]!//Segun el boton presionado, se agrega el tiempo total
        
        //Reinicio de tarea
        progressBar.progress = 0.0//Se inicializa la barra a 0, esta puede llegar a 1.0 siendo este el 100%
        secondsPassed = 0//Inicializacion del tiempo transcurrido
        titleLabel.text = hardness
        
        //Manejador del timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    //MARK: - Obj C Methods
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1//Agregar un segundo a los segundos transcurridos
            progressBar.progress = Float(secondsPassed) / Float(totalTime)//Transcurrir la barra de progreso segun el tiempo total y el tiempo transcurrido, devuelve un float que viene siendo el procentaje de progreso
            print(Float(secondsPassed) / Float(totalTime))//Se imprime en consola el valor de la operacion
        } else {//Cuando el tiempo termina
            timer.invalidate()//Se invalida el timer, ya no avanza
            titleLabel.text = "DONE!"//Cambia texto a hecho
            
            
            //Reproducir sonido
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
