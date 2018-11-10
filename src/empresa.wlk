import remeras.*

object empresa 
{
	var sucursales = []
	
	method agregarSucursales (sucursal) { sucursales.add(sucursal) }
	
	method totalFacturadoPorEmpresa() = sucursales.sum { sucursal => sucursal.totalFacturado() }
	
	method sucursalQueMasFacturo() = sucursales.max { sucursal => sucursal.totalFacturado() }
	
	method remerasVendidasDeColor(color) = sucursales.sum { sucursal => sucursal.totalDePedidosPorColor(color)}
	
	method pedidoMasCaroDeLaEmpresa() = sucursales.max { sucursal => sucursal.pedidoMasCaro() }
	
	method sucursalesQueVendieronTodosLosTalles() = sucursales.filter { sucursal => sucursal.vendioTodosLosTalles()}
} 

class Sucursal
{
	var property seDescuentaAPartirDe = 10
	var property descuentoDeRemerasSublimadas = 20
	var property descuentoNormal = 10
	var pedidos = []
	var convenios = []
	
	method agregarPedidos ( pedido ) { pedidos.add(pedido) } // TODO Por qué agregar pedidos en plural si agrega uno solo?
	
	method agregarConvenio ( convenio ) { convenios.add(convenio) } // Este está bien.
		
	method descuento (pedido) 
	{
		// TODO GRAVE Todo esto debería delegarse en remera y aprovechar el polimorfismo.
		if ( pedido.cantidadDeRemeras() / seDescuentaAPartirDe >= 1 or pedido.tipo() == "bordada" )
			return 0
		if ( self.buscarConvenio(pedido.marca() ) )
			return descuentoDeRemerasSublimadas
		else 
			return descuentoNormal
	}
	
	// TODO Buscar convenio no es un buen nombre para un método que devuelve un booleano
	method buscarConvenio(convenio) = convenios.contains(convenio) 

	// TODO Este método es innecesario.	
	method costoPorPedido(pedido)
	{
		return pedido.costo()
	}
	
	method totalFacturado()= pedidos.sum { pedido => pedido.costo() 
	}
	
	method totalDePedidosPorColor(color) = pedidos.sum{ pedido => pedido.cantidadDeRemerasDeColor(color) }
	
	method pedidoMasCaro() = pedidos.max { pedido => pedido.costo() }
	
	/* no lo supe resolver */
	method vendioTodosLosTalles() = pedidos.any { pedido => pedido.talle() == (32..48) }
}

class Pedido
{
	const property tipo /* tipo de remera */
	var property talle /* numero */
	const property sucursal /* nombre de sucursal */
	const property marca = null
	
	var remeras = []
	
	method agregarRemeras(remera)
	{
		if (remera.tipo() == tipo and remera.talle() == talle )
			remeras.add(remera)
		else
			throw new Exception ("La remera no es del tipo " + tipo )
	}
	
	method cantidadDeRemeras() = remeras.size()
	
	method cantidadDeRemerasDeColor(color) = remeras.count { remera => remera.color() == color } 
	
	method descuento() = sucursal.descuento(self) 
	
	method costoParcial() = remeras.sum { remera => remera.precio() }
	
	method costo() = self.costoParcial() - self.descuento() * self.costoParcial() / 100
}
