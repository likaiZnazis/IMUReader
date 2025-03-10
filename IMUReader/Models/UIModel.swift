//
//  UIModel.swift
//  IMUReader
//
//  Created by Martins Vitols on 21/02/2025.
//
//We have a bunch of section headings that will change based on what button is pressed or what content is shown inside the main section
enum HeadingType {
    //Here are a bunch of different tab headings that could be shown
    case home, createSet, instructions, startMeasuring
}
var navigationHistory: [HeadingType] = []
