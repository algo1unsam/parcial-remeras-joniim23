import remeras.*

object empresa 
{
	var pedidos = []
	
	method agregarPedido (pedido) = pedidos.add(pedido)
	
	method totalFacturadoPorEmpresa() = pedidos.sum { pedido => pedido.costo() }
	
	method totalFacturadoPorSucursal(sucursal) = 
		self.pedidosDeSucursal(sucursal).sum { pedido => pedido.costo() }
	method pedidosDeSucursal(sucursal) = pedidos.filter { pedido => pedido.sucursal() == sucursal }
	
	method sucursalQueMasFacturo() = self.sucursales().max {sucursal => self.totalFacturadoPorSucursal(sucursal) }
	method sucursales() = pedidos.map { pedido => pedido.sucursal() }.asSet()
	
	method pedidosDeColor(color) = pedidos.count{ pedido => pedido.remeraTipo().color() == color }
	
	method pedidoMasCaroDeLaEmpresa() = pedidos.max { pedido => pedido.costo() }
	
	method sucursalesConTotalidadDeTallesVendidos() = self.sucursales().filter { sucursal => self.sucursalQueVendioTodosLosTalles(sucursal) }
	method sucursalQueVendioTodosLosTalles(sucursal) = self.pedidosDeSucursal(sucursal).all { pedido => pedido.remeraTipo().talle() == (32..48) }
	
} 

class Sucursal
{
	var property seDescuentaAPartirDe = 10	
}

class Pedido
{
	const property sucursal /* nombre de sucursal */
	const property remeraTipo
	const property cantidadDeRemeras
	
	//TODO GRAVE Todo esto debería delegarse en remera y aprovechar el polimorfismo.
	//si sublimadaMarca pertenece a convenios de sucursal, el descuento devuelve 0.2, sino devuelve 0.1
	method descuento () {
		if (cantidadDeRemeras >= sucursal.seDescuentaAPartirDe())
			return remeraTipo.descuento() 
		else return 1
	}
	
	method subtotal() = remeraTipo.precio() * cantidadDeRemeras
	
	method costo() = self.subtotal() * self.descuento()
}
