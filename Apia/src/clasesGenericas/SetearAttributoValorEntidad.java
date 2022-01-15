package clasesGenericas;

import com.dogma.busClass.ApiaAbstractClass;
import com.dogma.busClass.BusClassException;
import com.dogma.busClass.object.Entity;
import com.dogma.busClass.object.Attribute;

public class SetearAttributoValorEntidad extends ApiaAbstractClass {

	private String nombre_atributo = "nombre_atributo";
	private String valor_atributo = "valor_atributo";
	private String tipo_atributo = "tipo_atributo";
	
	@Override
	protected void executeClass() throws BusClassException {
		
		Entity ent = this.getCurrentEntity();
		Attribute att = ent.getAttribute(nombre_atributo);
		if(tipo_atributo.equals("N")){
			Integer valor = Integer.parseInt("valor_atributo");
			att.setValue(valor);
		}else{
			att.setValue(valor_atributo);
		}

	}

}
