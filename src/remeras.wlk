class Remera
{
	var property talle /* numero */
	var property color /* cadena */
	var property costoBase = 80
	method precio()
	method recargaPorTalle() 
	{ 
		if( talle > 40 )
			costoBase += 20
	}
}

class RLisa inherits Remera
{
	const tipo = "lisa"
	
	method tipo() = tipo
	
	method recargaPorColor()
	{
		if(color == "otro")
			costoBase += (costoBase * 0.1)
	}
	
	override method precio()
	{
		self.recargaPorTalle()
		self.recargaPorColor()
		return costoBase
	}
}

class RBordada inherits Remera
{
	const tipo = "bordada"
	const property cantidadDeColores
	
	method tipo() = tipo
	
	
	method recargaPorBordado() { costoBase += 20 + cantidadDeColores * 10 }
	
	override method precio()
	{
		self.recargaPorTalle()
		self.recargaPorBordado()
		return costoBase
	}
}

class RSublimada inherits Remera
{
	const tipo = "sublimada"
	var property ancho
	var property alto
	var property marca
	var property costoPorDerechos
	
	method tipo() = tipo
	
	method superficie() = ancho * alto
	
	method recargaPorSublimada() { costoBase += self.superficie() * 0.5 }
	
	method recargaPorDerechos() { costoBase += costoPorDerechos }
	
	override method precio()
	{
		self.recargaPorTalle()
		self.recargaPorSublimada()
		self.recargaPorDerechos()
		return costoBase
	}	
	
}

