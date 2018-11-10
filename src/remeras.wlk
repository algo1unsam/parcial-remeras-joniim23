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
	
	// TODO Mal calculado el recargo, no coincide con el enunciado.
	method recargaPorBordado() { costoBase += 20 + cantidadDeColores * 10 }
	
	override method precio()
	{	
		// TODO Esto no funciona, tiene problemas con el manejo del efecto, deberías calcular el precio en el momento.
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
	
	// TODO Los costos por derechos dependen de la marca, deberías modelarlo como un objeto.
	var property marca
	var property costoPorDerechos
	
	method tipo() = tipo
	
	method superficie() = ancho * alto
	
	method recargaPorSublimada() { costoBase += self.superficie() * 0.5 }
	
	method recargaPorDerechos() { costoBase += costoPorDerechos }
	
	override method precio()
	{
		// TODO Grave: mal manejado el efecto
		self.recargaPorTalle()
		self.recargaPorSublimada()
		self.recargaPorDerechos()
		return costoBase
	}	
	
}

