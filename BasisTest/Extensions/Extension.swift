//
//  Extension.swift
//  BasisTest
//
//  Created by Hitendra Dubey on 26/06/20.
//  Copyright © 2020 Hitendra Dubey. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
func setAnchors(top:NSLayoutYAxisAnchor?,left:NSLayoutXAxisAnchor?,bottom:NSLayoutYAxisAnchor?,right:NSLayoutXAxisAnchor?,paddingTop:CGFloat,paddingLeft:CGFloat,paddingBottom:CGFloat,paddingRight:CGFloat,height:CGFloat,width:CGFloat)
{
  self.translatesAutoresizingMaskIntoConstraints = false
  if let top = top
  {
    self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
  }
  if let left = left
  {
    self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
  }
  if let bottom = bottom
  {
    self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
  }
  if let right = right
  {
    self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
  }
  if height != 0
  {
    self.heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  if width != 0
  {
    self.widthAnchor.constraint(equalToConstant: width).isActive = true
  }
}
}
