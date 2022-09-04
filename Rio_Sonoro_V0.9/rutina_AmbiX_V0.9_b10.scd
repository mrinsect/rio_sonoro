
//////////////////////////////////////////////////
///////////////RUTINA AMBIX//////////////////////
//////////////////////////////////////////////////

///////////Variables

~cond_ambix_xfade_manual = Condition.new(false);
~cond_ambix_1 = Condition.new(false);
~ambix_btn_xfade_check = false;


///////////////FUNCIONES/////////////////////



///Revisa al iniciar el programa qué subcategorías contienen archivos, quitando de los diccionarios y bloqueando en la GUI las categorías y subcategorías vacías.

~c_AmbiX_bloq_naturaleza = 0;
~c_AmbiX_bloq_sociedad = 0;
~c_AmbiX_bloq_artilugios = 0;
~c_AmbiX_bloq_quietud = 0;

///Naturaleza
if(~ambi_agua.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(0, 0);
	~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
});
if(~ambi_aire.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(0, 1);
	~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
});
if(~ambi_tierra.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(0, 2);
	~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
});
if(~ambi_fuego.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(0, 3);
	~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
});
if(~ambi_plantas.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(0, 4);
	~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
});
if(~ambi_animales.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(0, 5);
	~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
});
if(~ambi_humanos.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(0, 6);
	~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
});
if(~ambi_ecosistemas.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(0, 7);
	~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
});
if(~c_AmbiX_bloq_naturaleza == 8, {
	{~gui_ambix_chkb_natur.value = false;
	~gui_ambix_chkb_natur.enabled = false}.defer;
	~categorias_ambi.removeAt(\naturaleza);
});

///Sociedad
if(~ambi_rurales.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(1, 0);
	~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
});
if(~ambi_ciudad.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(1, 1);
	~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
});
if(~ambi_puertos.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(1, 2);
	~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
});
if(~ambi_domestico.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(1, 3);
	~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
});
if(~ambi_oficinas.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(1, 4);
	~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
});
if(~ambi_fabricas.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(1, 5);
	~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
});
if(~ambi_trabajo.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(1, 6);
	~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
});
if(~ambi_entretenimiento.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(1, 7);
	~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
});
if(~ambi_muchedumbres.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(1, 8);
	~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
});
if(~ambi_ceremonias.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(1, 9);
	~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
});
if(~ambi_parques.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(1, 10);
	~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
});
if(~ambi_indicadores.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(1, 11);
	~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
});
if(~c_AmbiX_bloq_sociedad == 12, {
	{~chkb_ambi_soc.value = false;
	~chkb_ambi_soc.enabled = false}.defer;
	~categorias_ambi.removeAt(\sociedad);
});



///Artilugios
if(~ambi_mecanismos.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(2, 0);
	~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
});
if(~ambi_maquinaria.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(2, 1);
	~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
});
if(~ambi_transportes.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(2, 2);
	~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
});
if(~ambi_guerra.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(2, 3);
	~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
});
if(~ambi_construccion.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(2, 4);
	~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
});
if(~ambi_ventiladores.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(2, 5);
	~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
});
if(~ambi_herramientas.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(2, 6);
	~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
});
if(~c_AmbiX_bloq_artilugios == 7, {
	{~chkb_ambi_arti.value = false;
	~chkb_ambi_arti.enabled = false}.defer;
	~categorias_ambi.removeAt(\artilugios);
});


///Quietud
if(~ambi_hum.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(3, 0);
	~c_AmbiX_bloq_quietud = ~c_AmbiX_bloq_quietud + 1
});
if(~ambi_vacio.size <= 0,{
	~f_gui_ambix_subcat_bloq.value(3, 1);
	~c_AmbiX_bloq_quietud = ~c_AmbiX_bloq_quietud + 1
});
if(~c_AmbiX_bloq_quietud == 2, {
	{~chkb_ambi_silencio.value = false;
	~chkb_ambi_silencio.enabled = false}.defer;
	~categorias_ambi.removeAt(\quietud);
});


/////Función para bloquear en la GUI subcategorías AmbiX vacías y removerlas del diccionario. Llamada en rutina_AmbiX --> ~f_selector_ambix

~f_gui_ambix_subcat_bloq = { arg cat, subcat;
	switch (cat,
		0, {{~gui_array_ambix_subc_nature[subcat].enabled_(false).valueAction_(false)}.defer;
			("ambix_naturaleza " + subcat + " bloqueada").postln;
			switch(subcat,
				0, {
				~ambi_naturaleza.removeAt(\agua);
			},
				1, {
				~ambi_naturaleza.removeAt(\aire);
			},
				2, {
				~ambi_naturaleza.removeAt(\tierra);
			},
				3, {
				~ambi_naturaleza.removeAt(\fuego);
			},
				4, {
				~ambi_naturaleza.removeAt(\plantas);
			},
				5, {
				~ambi_naturaleza.removeAt(\animales);
			},
				6, {
				~ambi_naturaleza.removeAt(\humanos);
			},
				7,{
					~ambi_naturaleza.removeAt(\ecosistemas);
				}
			 );
		},
		1, {{~gui_array_ambix_subc_soc[subcat].enabled_(false).valueAction_(false)}.defer;
			("ambix_sociedad " + subcat + " bloqueada").postln;
			switch(subcat,
				0, {
					~ambi_sociedad.removeAt(\rurales)
				},
				1, {
					~ambi_sociedad.removeAt(\ciudad)
				},
				2, {
					~ambi_sociedad.removeAt(\puertos)
				},
				3, {
					~ambi_sociedad.removeAt(\domestico)
				},
				4, {
					~ambi_sociedad.removeAt(\oficinas)
				},
				5, {
					~ambi_sociedad.removeAt(\fabricas)
				},
				6, {
					~ambi_sociedad.removeAt(\trabajo)
				},
				7, {
					~ambi_sociedad.removeAt(\entretenimiento)
				},
				8, {
					~ambi_sociedad.removeAt(\muchedumbres)
				},
				9, {
					~ambi_sociedad.removeAt(\ceremonias)
				},
				10, {
					~ambi_sociedad.removeAt(\parques)
				},
				11, {
					~ambi_sociedad.removeAt(\indicadores)
				}
			)

		},
		2, {{~gui_array_ambix_subc_arti[subcat].enabled_(false).valueAction_(false)}.defer;
			("ambix_artilugios " + subcat + " bloqueada").postln;
			switch(subcat,
				0, {
					~ambi_artilugios.removeAt(\mecanismos)
				},
				1, {
					~ambi_artilugios.removeAt(\maquinaria)
				},
				2, {
					~ambi_artilugios.removeAt(\transportes)
				},
				3, {
					~ambi_artilugios.removeAt(\guerra)
				},
				4, {
					~ambi_artilugios.removeAt(\construccion)
				},
				5, {
					~ambi_artilugios.removeAt(\ventiladores)
				},
				6, {
					~ambi_artilugios.removeAt(\herramientas)
				}
			)
		},
		3, {{~gui_array_ambix_subc_silencio[subcat].enabled_(false).valueAction_(false)}.defer;
			("ambix quietud y silencio subcat " + subcat + " bloqueada").postln;
			switch(subcat,
				0, {
					~ambi_quietud.removeAt(\hum);
				},
				1, {
					~ambi_quietud.removeAt(\vacio);
				}
			)
		}
)};


///~categorias_ambi.findKeyForValue(~cat_sel)  ---- para buscar la llave de un valor


///revisar esta función
(
~f_selector_ambix = {
	var cat_sel, key_subcat, i_paisaje;

	/// Detiene el proceso hasta que haya elegido una grabación
	~cond_ambix_1.test = false;
 	~cond_ambix_1.signal;

	///selecciona al azar una categoría
	~cat_sel = ~categorias_ambi.keys.choose;
	"f_selector_ambix ****1****".postln;

	///quitar esa línea cuando use más categorías
	///~cat_sel = [\naturaleza, \sociedad].choose;

	///Verifica si la categoría elegida tiene elementos o no. Si no tiene elige otra al azar.
	while({(~categorias_ambi.at(~cat_sel)).size <= 0}, {~cat_sel = ~categorias_ambi.keys.choose; "f_selector_ambix ****while****".postln;});

	///selecciona al azar una subcategoría de la categoría seleccionada.
	key_subcat = ~categorias_ambi.at(~cat_sel).keys.choose;
	"f_selector_ambix ****2****".postln;

	switch(~cat_sel.asString,
	"naturaleza", {
			"Se eligió naturaleza".postln;
			("key_subcat = " + key_subcat).postln;

		switch(key_subcat.asString,
				"agua",{
					i_paisaje = rrand(0, ~ambi_agua.size - 1);
					("i_paisaje = " + i_paisaje).postln;
					~ambix_paisaje = ~ambi_agua[i_paisaje];
					("paisaje seleccionado de agua " + ~ambix_paisaje).postln;

					///quita el paisaje de la lista correspondiente
					~ambi_agua.removeAt(i_paisaje);

					///revisa si esa subcategoría aún tiene archivos. Si no, la bloquea en la GUI y la quita del diccionario
			if((~ambi_agua.size <= 0),{~ambi_naturaleza.removeAt(\agua);
						"agua vacío".postln;
						~f_gui_ambix_subcat_bloq.value(0,0);
						~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;

/// Si se vaciaron todas las subcategorías de esta categoría, quita la categoría del diccionario y
/// la bloquea en la GUI
						if(~c_AmbiX_bloq_naturaleza >= 8, {
							{~gui_ambix_chkb_natur.value = false;
							~gui_ambix_chkb_natur.enabled = false}.defer;
							~categorias_ambi.removeAt(\naturaleza);
						});
					});
		},
			"aire",{
					i_paisaje = rrand(0, ~ambi_aire.size - 1);
					~ambix_paisaje = ~ambi_aire[i_paisaje];
					("paisaje seleccionado de aire " + ~ambix_paisaje).postln;

					///quita el paisaje de la lista correspondiente
					~ambi_aire.removeAt(i_paisaje);

///revisa si esa subcategoría aún tiene archivos. Si no, la bloquea en la GUI y la quita del diccionario
			if((~ambi_aire.size <= 0),{~ambi_naturaleza.removeAt(\aire);
						"aire vacío".postln;
						~f_gui_ambix_subcat_bloq.value(0,1);
						~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
					});

					if(~c_AmbiX_bloq_naturaleza >= 8, {
							{~gui_ambix_chkb_natur.value = false;
							~gui_ambix_chkb_natur.enabled = false}.defer;
							~categorias_ambi.removeAt(\naturaleza);
					});
		},
				"tierra", {
					i_paisaje = rrand(0, ~ambi_tierra.size - 1);
					~ambix_paisaje = ~ambi_tierra[i_paisaje];
					("paisaje seleccionado de tierra" + ~ambix_paisaje).postln;
					///quita el paisaje de la lista correspondiente
					~ambi_tierra.removeAt(i_paisaje);
					///revisa si esa subcategoría aún tiene archivos. Si no, la bloquea en la GUI
					if((~ambi_tierra.size <= 0),{~ambi_naturaleza.removeAt(\tierra);
						"tierra vacío".postln;
						~f_gui_ambix_subcat_bloq.value(0,2);
						~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
					});

					if(~c_AmbiX_bloq_naturaleza >= 8, {
							{~gui_ambix_chkb_natur.value = false;
							~gui_ambix_chkb_natur.enabled = false}.defer;
							~categorias_ambi.removeAt(\naturaleza);
					});
		},
				"fuego", {
					i_paisaje = rrand(0, ~ambi_fuego.size - 1);
					~ambix_paisaje = ~ambi_fuego[i_paisaje];
					("paisaje seleccionado de fuego" + ~ambix_paisaje).postln;
					//quita el paisaje de la lista correspondiente
					~ambi_fuego.removeAt(i_paisaje);

					///revisa si esa subcategoría aún tiene archivos. Si no, la bloquea en la GUI
					if((~ambi_fuego.size <= 0),{~ambi_naturaleza.removeAt(\fuego);
						"fuego vacío".postln;
						~f_gui_ambix_subcat_bloq.value(0,3);
						~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
					});

					if(~c_AmbiX_bloq_naturaleza >= 8, {
							{~gui_ambix_chkb_natur.value = false;
							~gui_ambix_chkb_natur.enabled = false}.defer;
							~categorias_ambi.removeAt(\naturaleza);
					});
		},
				"plantas", {
					i_paisaje = rrand(0, ~ambi_plantas.size - 1);
					~ambix_paisaje = ~ambi_plantas[i_paisaje];
					("paisaje seleccionado de plantas " + ~ambix_paisaje).postln;
					///quita el paisaje de la lista correspondiente
					~ambi_plantas.removeAt(i_paisaje);
					if((~ambi_plantas.size <= 0),{~ambi_naturaleza.removeAt(\plantas);
						"plantas vacío".postln;
						~f_gui_ambix_subcat_bloq.value(0,4);
						~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
					});

					if(~c_AmbiX_bloq_naturaleza >= 8, {
							{~gui_ambix_chkb_natur.value = false;
							~gui_ambix_chkb_natur.enabled = false}.defer;
							~categorias_ambi.removeAt(\naturaleza);
					});

		},
			"animales", {
					i_paisaje = rrand(0, ~ambi_animales.size - 1);
					~ambix_paisaje = ~ambi_animales[i_paisaje];
					("paisaje seleccionado de animales" + ~ambix_paisaje).postln;
					~ambi_animales.removeAt(i_paisaje);
					if((~ambi_animales.size <= 0),{~ambi_naturaleza.removeAt(\animales);
						"animales vacío".postln;
						~f_gui_ambix_subcat_bloq.value(0,5);
						~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
					});

					if(~c_AmbiX_bloq_naturaleza >= 8, {
							{~gui_ambix_chkb_natur.value = false;
							~gui_ambix_chkb_natur.enabled = false}.defer;
							~categorias_ambi.removeAt(\naturaleza);
					});
		},
					"humanos", {
					i_paisaje = rrand(0, ~ambi_humanos.size - 1);
						~ambix_paisaje = ~ambi_humanos[i_paisaje];
						("paisaje seleccionado de humanos" + ~ambix_paisaje).postln;
						~ambi_humanos.removeAt(i_paisaje);
					if((~ambi_humanos.size <= 0),{~ambi_naturaleza.removeAt(\humanos);
						"ambi_humanos vacío".postln;
						~f_gui_ambix_subcat_bloq.value(0,6);
						~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
					});

					if(~c_AmbiX_bloq_naturaleza >= 8, {
							{~gui_ambix_chkb_natur.value = false;
							~gui_ambix_chkb_natur.enabled = false}.defer;
							~categorias_ambi.removeAt(\naturaleza);
					});
					},
			"ecosistemas", {
					i_paisaje = rrand(0, ~ambi_ecosistemas.size - 1);
					~ambix_paisaje = ~ambi_ecosistemas[i_paisaje];
					("paisaje seleccionado de ecosistemas" + ~ambix_paisaje).postln;
					~ambi_ecosistemas.removeAt(i_paisaje);
					if((~ambi_ecosistemas.size <= 0),{~ambi_naturaleza.removeAt(\ecosistemas);
						"ecosistemas vacío".postln;
						~f_gui_ambix_subcat_bloq.value(0,7);
						~c_AmbiX_bloq_naturaleza = ~c_AmbiX_bloq_naturaleza + 1;
					});

					if(~c_AmbiX_bloq_naturaleza >= 8, {
							{~gui_ambix_chkb_natur.value = false;
							~gui_ambix_chkb_natur.enabled = false}.defer;
							~categorias_ambi.removeAt(\naturaleza);
					});

				}
		)},

		"sociedad", {
			"Se eligió sociedad".postln;
			("key_subcat = " + key_subcat).postln;
			switch(key_subcat.asString,
				"rurales",{
					i_paisaje = rrand(0, ~ambi_rurales.size - 1);
					~ambix_paisaje = ~ambi_rurales[i_paisaje];
					("paisaje seleccionado de regiones rurales" + ~ambix_paisaje).postln;
					~ambi_rurales.removeAt(i_paisaje);
					if((~ambi_rurales.size <= 0),{~ambi_sociedad.removeAt(\rurales);
						"regiones rurales vacío".postln;
						~f_gui_ambix_subcat_bloq.value(1,0);
						~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
					});
					if(~c_AmbiX_bloq_sociedad == 10, {
						{~chkb_ambi_soc.value = false;
							~chkb_ambi_soc.enabled = false}.defer;
						~categorias_ambi.removeAt(\sociedad);
					});
				},
					"ciudad", {
						i_paisaje = rrand(0, ~ambi_ciudad.size - 1);
						~ambix_paisaje = ~ambi_ciudad[i_paisaje];
						("paisaje seleccionado de ciudad" + ~ambix_paisaje).postln;
						~ambi_ciudad.removeAt(i_paisaje);
						if((~ambi_ciudad.size <= 0),{~ambi_sociedad.removeAt(\ciudad);
						"AmbiX: ciudad vacío".postln;
						~f_gui_ambix_subcat_bloq.value(1,1);
						~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
					});
					if(~c_AmbiX_bloq_sociedad == 10, {
						{~chkb_ambi_soc.value = false;
							~chkb_ambi_soc.enabled = false}.defer;
						~categorias_ambi.removeAt(\sociedad);
					});
					},
					"puertos", {
						i_paisaje = rrand(0, ~ambi_puertos.size - 1);
						~ambix_paisaje = ~ambi_puertos[i_paisaje];
						("paisaje seleccionado de puertos" + ~ambix_paisaje).postln;
						~ambi_puertos.removeAt(i_paisaje);
					if((~ambi_puertos.size <= 0),{~ambi_sociedad.removeAt(\puertos);
						"AmbiX: puertos vacío".postln;
						~f_gui_ambix_subcat_bloq.value(1,2);
						~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
					});
					if(~c_AmbiX_bloq_sociedad == 10, {
						{~chkb_ambi_soc.value = false;
							~chkb_ambi_soc.enabled = false}.defer;
						~categorias_ambi.removeAt(\sociedad);
					});
					},
					"domestico", {
						i_paisaje = rrand(0, ~ambi_domestico.size - 1);
						~ambix_paisaje = ~ambi_domestico[i_paisaje];
						("paisaje seleccionado de ámbito doméstico" + ~ambix_paisaje).postln;
						~ambi_domestico.removeAt(i_paisaje);
						if((~ambi_domestico.size <= 0),{~ambi_sociedad.removeAt(\domestico);
						"AmbiX: ámbito doméstico vacío".postln;
						~f_gui_ambix_subcat_bloq.value(1,3);
						~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
						});
					if(~c_AmbiX_bloq_sociedad == 10, {
						{~chkb_ambi_soc.value = false;
							~chkb_ambi_soc.enabled = false}.defer;
						~categorias_ambi.removeAt(\sociedad);
					});
					},
					"oficinas", {
						i_paisaje = rrand(0, ~ambi_oficinas.size - 1);
						~ambix_paisaje = ~ambi_oficinas[i_paisaje];
						("paisaje seleccionado de oficinas" + ~ambix_paisaje).postln;
						~ambi_oficinas.removeAt(i_paisaje);
						if((~ambi_oficinas.size <= 0),{~ambi_sociedad.removeAt(\oficinas);
						"AmbiX: oficinas vacío".postln;
						~f_gui_ambix_subcat_bloq.value(1,4);
						~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
						});
					if(~c_AmbiX_bloq_sociedad == 10, {
						{~chkb_ambi_soc.value = false;
							~chkb_ambi_soc.enabled = false}.defer;
						~categorias_ambi.removeAt(\sociedad);
					});
					},
					"fabricas",{
						i_paisaje = rrand(0, ~ambi_fabricas.size - 1);
						~ambix_paisaje = ~ambi_fabricas[i_paisaje];
						("paisaje seleccionado de fábricas" + ~ambix_paisaje).postln;
						~ambi_fabricas.removeAt(i_paisaje);
						if((~ambi_fabricas.size <= 0),{~ambi_sociedad.removeAt(\fabricas);
						"AmbiX: fábricas vacío".postln;
						~f_gui_ambix_subcat_bloq.value(1,5);
						~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
						});
					if(~c_AmbiX_bloq_sociedad == 10, {
						{~chkb_ambi_soc.value = false;
							~chkb_ambi_soc.enabled = false}.defer;
						~categorias_ambi.removeAt(\sociedad);
					});
					},
					"trabajo",{
						i_paisaje = rrand(0, ~ambi_trabajo.size - 1);
						~ambix_paisaje = ~ambi_trabajo[i_paisaje];
						("paisaje seleccionado de otros lugares de trabajo" + ~ambix_paisaje).postln;
						~ambi_trabajo.removeAt(i_paisaje);
						if((~ambi_trabajo.size <= 0),{~ambi_sociedad.removeAt(\trabajo);
						"AmbiX: otros lugares de trabajo vacío".postln;
						~f_gui_ambix_subcat_bloq.value(1,6);
						~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
						});
					if(~c_AmbiX_bloq_sociedad == 10, {
						{~chkb_ambi_soc.value = false;
							~chkb_ambi_soc.enabled = false}.defer;
						~categorias_ambi.removeAt(\sociedad);
					});
					},
					"entretenimiento",{
						i_paisaje = rrand(0, ~ambi_entretenimiento.size - 1);
						~ambix_paisaje = ~ambi_entretenimiento[i_paisaje];
						("paisaje seleccionado de entretenimiento" + ~ambix_paisaje).postln;
						~ambi_entretenimiento.removeAt(i_paisaje);
						if((~ambi_entretenimiento.size <= 0),{~ambi_sociedad.removeAt(\entretenimiento);
						"AmbiX: entretenimiento vacío".postln;
						~f_gui_ambix_subcat_bloq.value(1,7);
						~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
						});
					if(~c_AmbiX_bloq_sociedad == 10, {
						{~chkb_ambi_soc.value = false;
							~chkb_ambi_soc.enabled = false}.defer;
						~categorias_ambi.removeAt(\sociedad);
					});
					},
					"muchedumbres", {
						i_paisaje = rrand(0, ~ambi_muchedumbres.size - 1);
						~ambix_paisaje = ~ambi_muchedumbres[i_paisaje];
						("paisaje seleccionado de muchedumbres" + ~ambix_paisaje).postln;
						~ambi_muchedumbres.removeAt(i_paisaje);
						if((~ambi_muchedumbres.size <= 0),{~ambi_sociedad.removeAt(\muchedumbres);
						"AmbiX: muchedumbres vacío".postln;
						~f_gui_ambix_subcat_bloq.value(1,8);
						~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
						});
					if(~c_AmbiX_bloq_sociedad == 10, {
						{~chkb_ambi_soc.value = false;
							~chkb_ambi_soc.enabled = false}.defer;
						~categorias_ambi.removeAt(\sociedad);
					});
					},
					"ceremonias",{
						i_paisaje = rrand(0, ~ambi_ceremonias.size - 1);
						~ambix_paisaje = ~ambi_ceremonias[i_paisaje];
						("paisaje seleccionado de ceremonias" + ~ambix_paisaje).postln;
						~ambi_ceremonias.removeAt(i_paisaje);
						if((~ambi_ceremonias.size <= 0),{~ambi_sociedad.removeAt(\ceremonias);
						"AmbiX: ceremonias vacío".postln;
						~f_gui_ambix_subcat_bloq.value(1,9);
						~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
						});
					if(~c_AmbiX_bloq_sociedad == 10, {
						{~chkb_ambi_soc.value = false;
							~chkb_ambi_soc.enabled = false}.defer;
						~categorias_ambi.removeAt(\sociedad);
					});
					},
					"parques", {
						i_paisaje = rrand(0, ~ambi_parques.size - 1);
						~ambix_paisaje = ~ambi_parques[i_paisaje];
						("paisaje seleccionado de parques y jardines" + ~ambix_paisaje).postln;
						~ambi_parques.removeAt(i_paisaje);
						if((~ambi_parques.size <= 0),{~ambi_sociedad.removeAt(\parques);
						"AmbiX: parques y jardines vacío".postln;
						~f_gui_ambix_subcat_bloq.value(1,10);
						~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
						});
					if(~c_AmbiX_bloq_sociedad == 10, {
						{~chkb_ambi_soc.value = false;
							~chkb_ambi_soc.enabled = false}.defer;
						~categorias_ambi.removeAt(\sociedad);
					});
					},
					"indicadores",{
						i_paisaje = rrand(0, ~ambi_indicadores.size - 1);
						~ambix_paisaje = ~ambi_indicadores[i_paisaje];
						("paisaje seleccionado de indicadores sonoros" + ~ambix_paisaje).postln;
						~ambi_indicadores.removeAt(i_paisaje);
						if((~ambi_indicadores.size <= 0),{~ambi_sociedad.removeAt(\indicadores);
						"AmbiX: indicadores sonoros vacío".postln;
						~f_gui_ambix_subcat_bloq.value(1,11);
						~c_AmbiX_bloq_sociedad = ~c_AmbiX_bloq_sociedad + 1;
						});
					if(~c_AmbiX_bloq_sociedad == 10, {
						{~chkb_ambi_soc.value = false;
							~chkb_ambi_soc.enabled = false}.defer;
						~categorias_ambi.removeAt(\sociedad);
					});
					}
			)
		},
		"artilugios", {
			"Se eligió artilugios mecánicos".postln;
			("key_subcat = " + key_subcat).postln;
			switch(key_subcat.asString,
				"mecanismos", {
					i_paisaje = rrand(0, ~ambi_mecanismos.size - 1);
					~ambix_paisaje = ~ambi_mecanismos[i_paisaje];
					("paisaje seleccionado de mecanismos varios" + ~ambix_paisaje).postln;
					~ambi_mecanismos.removeAt(i_paisaje);
					if((~ambi_mecanismos.size <= 0),{~ambi_artilugios.removeAt(\mecanismos);
						"AmbiX: mecanismos varios vacío".postln;
						~f_gui_ambix_subcat_bloq.value(2,0);
						~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
					});
					if(~c_AmbiX_bloq_artilugios == 7, {
						{~chkb_ambi_arti.value = false;
							~chkb_ambi_arti.enabled = false}.defer;
						~categorias_ambi.removeAt(\artilugios);
					});
				},
				"maquinaria", {
					i_paisaje = rrand(0, ~ambi_maquinaria.size - 1);
					~ambix_paisaje = ~ambi_maquinaria[i_paisaje];
					("paisaje seleccionado de maquinaria industrial" + ~ambix_paisaje).postln;
					~ambi_maquinaria.removeAt(i_paisaje);
					if((~ambi_maquinaria.size <= 0),{~ambi_artilugios.removeAt(\maquinaria);
						"AmbiX: maquinaria industrial vacío".postln;
						~f_gui_ambix_subcat_bloq.value(2,1);
						~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
					});
					if(~c_AmbiX_bloq_artilugios == 7, {
						{~chkb_ambi_arti.value = false;
							~chkb_ambi_arti.enabled = false}.defer;
						~categorias_ambi.removeAt(\artilugios);
					});
				},
				"transportes", {
					i_paisaje = rrand(0, ~ambi_transportes.size - 1);
					~ambix_paisaje = ~ambi_transportes[i_paisaje];
					("paisaje seleccionado de transportes" + ~ambix_paisaje).postln;
					~ambi_transportes.removeAt(i_paisaje);
					if((~ambi_transportes.size <= 0),{~ambi_artilugios.removeAt(\transportes);
						"AmbiX: transportes vacío".postln;
						~f_gui_ambix_subcat_bloq.value(2,2);
						~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
					});
					if(~c_AmbiX_bloq_artilugios == 7, {
						{~chkb_ambi_arti.value = false;
							~chkb_ambi_arti.enabled = false}.defer;
						~categorias_ambi.removeAt(\artilugios);
					});
				},
				"guerra", {
					i_paisaje = rrand(0, ~ambi_guerra.size - 1);
					~ambix_paisaje = ~ambi_guerra[i_paisaje];
					("paisaje seleccionado de máquinas de guerra" + ~ambix_paisaje).postln;
					~ambi_guerra.removeAt(i_paisaje);
					if((~ambi_guerra.size <= 0),{~ambi_artilugios.removeAt(\guerra);
						"AmbiX: máquinas de guerra vacío".postln;
						~f_gui_ambix_subcat_bloq.value(2,3);
						~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
					});
					if(~c_AmbiX_bloq_artilugios == 7, {
						{~chkb_ambi_arti.value = false;
							~chkb_ambi_arti.enabled = false}.defer;
						~categorias_ambi.removeAt(\artilugios);
					});
				},
				"construccion", {
					i_paisaje = rrand(0, ~ambi_construccion.size - 1);
					~ambix_paisaje = ~ambi_construccion[i_paisaje];
					("paisaje seleccionado de maquinaria de construcción-demolición" + ~ambix_paisaje).postln;
					~ambi_construccion.removeAt(i_paisaje);
					if((~ambi_construccion.size <= 0),{~ambi_artilugios.removeAt(\construccion);
						"AmbiX: maquinaria de construcción-demolición vacío".postln;
						~f_gui_ambix_subcat_bloq.value(2,4);
						~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
					});
					if(~c_AmbiX_bloq_artilugios == 7, {
						{~chkb_ambi_arti.value = false;
							~chkb_ambi_arti.enabled = false}.defer;
						~categorias_ambi.removeAt(\artilugios);
					});
				},
				"ventiladores", {
					i_paisaje = rrand(0, ~ambi_ventiladores.size - 1);
					~ambix_paisaje = ~ambi_ventiladores[i_paisaje];
					("paisaje seleccionado de ventiladores-aires acondicionados" + ~ambix_paisaje).postln;
					~ambi_ventiladores.removeAt(i_paisaje);
					if((~ambi_ventiladores.size <= 0),{~ambi_artilugios.removeAt(\ventiladores);
						"AmbiX: ventiladores-aires acondicionados vacío".postln;
						~f_gui_ambix_subcat_bloq.value(2,5);
						~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
					});
					if(~c_AmbiX_bloq_artilugios == 7, {
						{~chkb_ambi_arti.value = false;
							~chkb_ambi_arti.enabled = false}.defer;
						~categorias_ambi.removeAt(\artilugios);
					});
				},

				"herramientas", {
					i_paisaje = rrand(0, ~ambi_herramientas.size - 1);
					~ambix_paisaje = ~ambi_herramientas[i_paisaje];
					("paisaje seleccionado de herramientas" + ~ambix_paisaje).postln;
					~ambi_herramientas.removeAt(i_paisaje);

					if((~ambi_herramientas.size <= 0),{~ambi_artilugios.removeAt(\herramientas);
						"AmbiX: herramientas vacío".postln;
						~f_gui_ambix_subcat_bloq.value(2,6);
						~c_AmbiX_bloq_artilugios = ~c_AmbiX_bloq_artilugios + 1;
					});

					if(~c_AmbiX_bloq_artilugios == 7, {
						{~chkb_ambi_arti.value = false;
							~chkb_ambi_arti.enabled = false}.defer;
						~categorias_ambi.removeAt(\artilugios);
					});
				}
			)

		},
		"quietud", {
			"Se eligió quietud y silencio".postln;
			("key_subcat = " + key_subcat).postln;
			switch(key_subcat.asString,
				"hum", {
					i_paisaje = rrand(0, ~ambi_hum.size - 1);
					~ambix_paisaje = ~ambi_hum[i_paisaje];
					("paisaje seleccionado de hum" + ~ambix_paisaje).postln;
					~ambi_hum.removeAt(i_paisaje);

					if((~ambi_hum.size <= 0),{~ambi_quietud.removeAt(\hum);
						"AmbiX: hum vacío".postln;
						~f_gui_ambix_subcat_bloq.value(3,0);
						~c_AmbiX_bloq_quietud = ~c_AmbiX_bloq_quietud + 1;

						if(~c_AmbiX_bloq_quietud == 2, {
							{~chkb_ambi_silencio.value = false;
							~chkb_ambi_silencio.enabled = false}.defer;
							~categorias_ambi.removeAt(\quietud);
						});
					});
				},

				"vacio", {
					i_paisaje = rrand(0, ~ambi_vacio.size - 1);
					~ambix_paisaje = ~ambi_vacio[i_paisaje];
					("paisaje seleccionado de espacio vacíos" + ~ambix_paisaje).postln;
					~ambi_vacio.removeAt(i_paisaje);

					if((~ambi_vacio.size <= 0),{~ambi_quietud.removeAt(\vacio);
						"AmbiX: espacios vacíos vacío".postln;
						~f_gui_ambix_subcat_bloq.value(3,1);
						~c_AmbiX_bloq_quietud = ~c_AmbiX_bloq_quietud + 1;

						if(~c_AmbiX_bloq_quietud == 2, {
							{~chkb_ambi_silencio.value = false;
							~chkb_ambi_silencio.enabled = false}.defer;
							~categorias_ambi.removeAt(\quietud);
						});
					});
				}
			);
		}
	);

	~cond_ambix_1.test = true;
 	~cond_ambix_1.signal;
};
);



//// Función: toma el tiempo y valor de la transición y los pasa al synthdef

~f_ambix_xfade = { arg xfdur, xfade;
~ambix_synth.set(\xfdur,xfdur, \xfade,xfade);
};



////////// Funciones para controles GUI de AmbiX

//Control de volumen general (incluido Fade-in y Fade Out)
// ~f_ambix_vol = {arg amp, lag;
// 	var r_vol, c_lag=lag;
// 	"f_ambix_vol activa".postln;
// 	~ambix_synth.set(\amp,amp, \amp_lag,lag);
//
// 	~f_ambix_vol_gui.value(amp, lag);


	/*r_vol = Routine{
	{c_lag >= 0}.while({
			{~ambix_gui_vol.string_("-->");
			~ambix_gui_vol_g_t.value = 1;
			~ambix_gui_vol_dur.string = c_lag}.defer;
			(0.1).wait;
			c_lag = c_lag.round(0.1) - 0.1;
		});
		{~ambix_gui_vol_g_t.value = 0;
		~ambix_gui_vol.string_(amp)}.defer;
		if(amp == 0,{
			"fade-out".postln;
			{~gui_ambix_btn_inicio.value = 0;
			~ambix_gui_comp.background_(Color.yellow.alpha_(0.5));
			}.defer;
			~r_ambix.stop;
			~ambix_synth.free;
			"rutina AmbiX detenida".postln;
		});

		r_vol.stop;

		};*/

	//r_vol.play;
//};



/// Función a ejecutar cuando se presione botón de transición manual y no llegue a A ó B
///se llama en el botón ~ambix_gui_btn_xfade

~f_ambix_xfade_manual = { arg xfdur, xfade;
	var morph = xfdur, routine;
	~cond_ambix_xfade_manual.test = false;
	{
		~ambix_gui_btn_A.value = 1;
		~ambix_gui_btn_B.value = 1;
		~ambix_gui_tiempo_paisaje_txt.string_("--");
	}.defer;


		"***f_ambix_xfade_manual_while".postln;
		~f_ambix_xfade.value(xfdur, xfade);
	routine = Routine({
		while({morph > 0.1},{
			morph = morph - 0.1;
			{~ambix_gui_xfade_dur.string_((morph).asInteger.asString);
			~ambix_gui_btn_xfade.enabled_(false)}.defer;
			0.1.wait;
		});
		{
			~ambix_gui_btn_xfade.enabled_(true);
			~ambix_gui_btn_xfade.value_(0);
		}.defer;
		routine.stop;
});
	routine.play;
};


// Función si se hace un XFade con tiempo manual directo de A a B.

~f_ambix_xfade_A_B_1 = { arg xfdur, xfade;
	var morph = xfdur, flecha=0, routine;
	~cond_ambix_xfade_manual.test = false;
	("condition A_B_1 inicial = " + ~cond_ambix_xfade_manual.test).postln;
	{
		~ambix_gui_btn_A.value = 1;
		~ambix_gui_btn_B.value = 1;
		~ambix_gui_tiempo_paisaje_txt.string_("--")
	}.defer;

	~f_ambix_xfade.value(xfdur, xfade);
	"***f_ambix_xfade_A_B_1".postln;
	routine = Routine({
	while({morph > 0.1},{
		{
			~ambix_gui_xfade_dur.string_((morph).asInteger.asString);
			~ambix_gui_btn_xfade.enabled_(false);
			~ambix_gui_fl.value = flecha;
		}.defer;
			flecha = flecha + 1;
			if(flecha >= 6, {flecha = 0});
			morph = morph - 0.1;
			0.1.wait;
			//("morph A_B_1 = " + morph).postln;
	});
	{
		~ambix_gui_btn_xfade.enabled_(true);
		~ambix_gui_btn_xfade.value_(0);
	}.defer;
	~cond_ambix_xfade_manual.test = true;
	"Condition A_B_1 = true".postln;
	~cond_ambix_xfade_manual.signal;
		routine.stop;
	});
	routine.play;
};




/// Función si se hace un XFade con tiempo manual directo de B a A.

~f_ambix_xfade_B_A_0 = { arg xfdur, xfade;
	var morph = xfdur, flecha=12, routine;
	~cond_ambix_xfade_manual.test = false;
	{
		~ambix_gui_btn_A.value = 1;
		~ambix_gui_btn_B.value = 1;
		~ambix_gui_tiempo_paisaje_txt.string_("--")
	}.defer;

		~f_ambix_xfade.value(xfdur, xfade);
		"***f_ambix_xfade_B_A_0".postln;
	routine = Routine({
	while({morph > 0.1},{
		{
			~ambix_gui_xfade_dur.string_((morph).asInteger.asString);
			~ambix_gui_btn_xfade.enabled_(false);
			~ambix_gui_fl.value = flecha;
		}.defer;

			flecha = flecha + 1;
			if(flecha >= 12, {flecha = 6});
			morph = morph - 0.1;
			0.1.wait;
		});
		{
			~ambix_gui_btn_xfade.enabled_(true);
			~ambix_gui_btn_xfade.value_(0);
		}.defer;
	~cond_ambix_xfade_manual.test = true;
	~cond_ambix_xfade_manual.signal;
		// probar con hang y unhang
		routine.stop;
	});
	routine.play;

};










/////////////////////////////Función general para la rutina de AmbiX


~f_ambix_r = {
~r_ambix = Routine({
	var morph_m=0, contador_1 = 0, contador_2=1, frag_psjB, frag_psjA, vent_final,  xfade_dur_psjA, xfade_dur_psjB, psjA, psjB, psA_W, psA_Y, psA_Z, psA_X, psB_W, psB_Y, psB_Z, psB_X, trigger_xfade=false, ch_xfade_m=false, cat, sub_cat, i_paisaje;


		// Selección del primer paisaje sonoro para AmbiX a través de esta función:

	~f_selector_ambix.value;

	//Espera a que la función eliga una grabación.
		~cond_ambix_1.wait;


	"*****************1************************".postln;


	//Carga la grabación selecionada en el los Buffer de A del SynthDef con XFade espectral

			psjA = ~ambix_paisaje;
			("AmbiX psjA = " + psjA).postln;
			(0.1).wait;

			psA_W = Buffer.readChannel(s, psjA.path, channels:[0]);
			psA_Y = Buffer.readChannel(s, psjA.path, channels:[1]);
			psA_Z = Buffer.readChannel(s, psjA.path, channels:[2]);
			psA_X = Buffer.readChannel(s, psjA.path, channels:[3]);

			s.sync;


	"*********2*************".postln;

	///Selección de Paisaje B

		~f_selector_ambix.value;
		~cond_ambix_1.wait;


	"*****************3************************".postln;

		//Carga la grabación selecionada en los buffers de B del SynthDef con XFade espectral

			psjB = ~ambix_paisaje;

			//psjB = ~categorias_ambi[~ambix_cat][~ambix_sub_cat][~ambix_i_paisaje];
		("Paisaje B = " + psjB).postln;
	(0.1).wait;

		psB_W = Buffer.readChannel(s, psjB.path, channels:[0]);
		psB_Y = Buffer.readChannel(s, psjB.path, channels:[1]);
		psB_Z = Buffer.readChannel(s, psjB.path, channels:[2]);
		psB_X = Buffer.readChannel(s, psjB.path, channels:[3]);

	s.sync;


	    ("AmbiX - Seleccionado paisaje B. Se remueve " + (psjB)).postln;


	"************4**************".postln;



//// Escoge al azar el tiempo que estará reproduciendo el paisaje A (debe incluir la duración del XFade, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones).


		frag_psjA = rrand(60, psjA.duration - 1);


		xfade_dur_psjB = rrand(60, frag_psjA);





////////////////////////////////// INICIA REPRODUCCIÓN DE PAISAJE A con Fade-in ////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////


		~ambix_synth = Synth('XFade_AmbiX', [
		\out,~ambiBus[10],
		\spec_bufA_W,~ambiX_fft_BufA_W,
		\spec_bufA_Y,~ambiX_fft_BufA_Y,
		\spec_bufA_Z,~ambiX_fft_BufA_Z,
		\spec_bufA_X,~ambiX_fft_BufA_X,

		\spec_bufB_W,~ambiX_fft_BufB_W,
		\spec_bufB_Y,~ambiX_fft_BufB_Y,
		\spec_bufB_Z,~ambiX_fft_BufB_Z,
		\spec_bufB_X,~ambiX_fft_BufB_X,

		\soundBufA_W,psA_W,
		\soundBufA_Y,psA_Y,
		\soundBufA_Z,psA_Z,
		\soundBufA_X,psA_X,

		\soundBufB_W,psB_W,
		\soundBufB_Y,psB_Y,
		\soundBufB_Z,psB_Z,
		\soundBufB_X,psB_X,

		\amp, 0,
		\amp_lag, 0.01

	],~ambiGroup[10], addAction:\addToHead);

		(0.1).wait;


		{
			var amp=~ambix_gui_vol_value_in.string.asInteger/100, lag=~ambix_gui_vol_tiempo_in.string.asInteger;
				~ambix_synth.set(\amp,amp, \amp_lag,lag);
				~f_ambix_vol_gui.value(amp, lag)
		}.defer;



		("AmbiX - Ahora suena A = " + psjA).postln;
		("AmbiX - Duración total de paisaje A = " + psjA.duration).postln;
		("AmbiX - Fragmento del paisaje A = " + frag_psjA).postln;
		("AmbiX - Duracion de transición a B = " + xfade_dur_psjB).postln;
		"~Ambix_xfade -> 1".postln;
		("Paisaje B = " + psjB).postln;

		{
			~ambix_gui_btn_A.value = 0;
			~ambix_gui_btn_B.value = 2;
		}.defer;


/////////////////////////// INICIA ESPERA PARA EL XFade ---> B ////////////////////////////////

		contador_1 = frag_psjA - xfade_dur_psjB;
		//("contador_1 = " + contador_1).postln;
		//contador_2 = 0;
		//vent_final = ~ambix_frag_psjA - xfade_dur_psjB;
		//~ambix_xfade = 2;
		~ambix_xfade_A_B = true;
		~ambix_xfade_B_A = false;
		ch_xfade_m = false;
		//ambix_gui_btn_xfade_block = true;
		{~ambix_gui_btn_xfade.enabled_(true);
			~ambix_gui_btn_xfade.value_(0);
		}.defer;


	"******************5******************".postln;
	while ({(trigger_xfade == false)},{
			{~ambix_gui_tiempo_paisaje_txt.string_((contador_1.round(0.1)).asString)}.defer;
			contador_1 = contador_1 - 0.1;
			//contador_2 = contador_2 + 0.1;
			{
				~ambix_gui_btn_A.value = 0;
				~ambix_gui_btn_B.value = 2;
				~ambix_gui_fl.value = 5;
			}.defer;

			if ((contador_1  <= 0),{
				trigger_xfade = true;
			});

			//// Si quiero mantener un XFade a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario hasta que haga el xfade manual a 1 (B)
			if(~ambix_btn_xfade_check == true,{
				{
					~ambix_gui_btn_A.value = 1;
					~ambix_gui_btn_B.value = 1;
					~ambix_gui_tiempo_paisaje_txt.string_("--");
				}.defer;
					"***Espero a f_ambix_xfade_manual".postln;
					~cond_ambix_xfade_manual.wait;
					ch_xfade_m = true;
					trigger_xfade = true;
					~ambix_btn_xfade_check = false;
				});
				(0.1).wait;
			});

			trigger_xfade = false;



////////////////////////////// INICIA EL MORPHING ---> B ///////////////////////////////////////////


//// El morphing a B se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje B a 1


		"********AmbiX-6********".postln;

	if(ch_xfade_m == false,{
		var flecha = 0;
		var dur_morph_B = xfade_dur_psjB;
			("AmbiX-AmbiX - transición a paisaje B = " + xfade_dur_psjB).postln;
			{
				~ambix_gui_btn_xfade.enabled_(false);
				~ambix_gui_btn_xfade.value_(2);
			}.defer;

			~ambix_synth.set(\xfdur,xfade_dur_psjB.round(0.1), \xfade, 1);

			{
			~ambix_gui_btn_A.value = 1;
			~ambix_gui_btn_B.value = 1;
			}.defer;

		"***AmbiX-XFade -> B (1) ".postln;

			//// Escoge al azar el tiempo que estará reproduciendo el paisaje B (debe incluir la duración del morphing, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones), o a que yo cambie ~wait_xfade_Front, lo que suceda primero. Inicia el morphing


		frag_psjB = rrand(60, psjB.duration - 1);

			("AmbiX-frag_psjB (1)= " + frag_psjB).postln;

		//// Escoge una duración de morphing de regreso a A


			xfade_dur_psjA = rrand(60, frag_psjB);   ////ver si esto sustituye a la variable global

			("AmbiX-xfade_dur_psjA (1) = " + xfade_dur_psjA).postln;

		while({dur_morph_B >= 0},
			{
				{~ambix_gui_xfade_dur.string_((dur_morph_B).asInteger.asString)}.defer;
				{~ambix_gui_fl.value = flecha}.defer;
				flecha = flecha + 1;
				if(flecha >=6, {flecha = 0});
				dur_morph_B = dur_morph_B - 0.1;
				0.1.wait;
			};
		);
	});

		morph_m = 0;
		ch_xfade_m = false;

		//frag_psjB = rrand(60, psjB.duration - 1);      02-09-22

		//xfade_dur_psjA = rrand(60, frag_psjB);   ////02-09-22

//////////////////////////////// TERMINA EL MORPHING ---> B. REPRODUCE B //////////////////////////

		{~ambix_gui_btn_xfade.enabled_(true);
		~ambix_gui_btn_xfade.value_(0);
		}.defer;

////////// Aquí inicia el bucle


	100.do{
	"*************AmbiX-7**************".postln;
	("AmbiX - Ahora suena B = " + psjB).postln;
		{~ambix_gui_btn_A.value = 2;
		~ambix_gui_btn_B.value = 0;
		~ambix_gui_fl.value = 10;
		}.defer;

	("AmbiX - Duración total de paisaje B = " + psjB.duration).postln;
	("AmbiX- Fragmento del paisaje B = " + frag_psjB).postln;
	("AmbiX - Duración de transición al paisaje A = " + xfade_dur_psjA + "segundos").postln;
	"AmbiX- xfade -> A0".postln;


/////// Selecciona una categoría, subcategoría e índice para A.

		~f_selector_ambix.value;
			~cond_ambix_1.wait;
		//(0.2).wait;


		s.sync;

//// Carga el paisaje seleccionado y lo carga en los buffers para A



			psjA = ~ambix_paisaje;

			psA_W = Buffer.readChannel(s, psjA.path, channels:[0]);
			psA_Y = Buffer.readChannel(s, psjA.path, channels:[1]);
			psA_Z = Buffer.readChannel(s, psjA.path, channels:[2]);
			psA_X = Buffer.readChannel(s, psjA.path, channels:[3]);

			s.sync;

			("AmbiX - paisaje A = " + psjA).postln;

//// Vuelve a leer los Buffers de A en el synthdef
			~ambix_synth.set(
				\soundBufA_W,psA_W,
				\soundBufA_Y,psA_Y,
				\soundBufA_Z,psA_Z,
				\soundBufA_X,psA_X);

			s.sync;



//////////////////////////////// INICIA ESPERA PARA EL MORPHING ---> A ////////////////////////////

			contador_1 = frag_psjB - xfade_dur_psjA;
			//contador_2 = 0;
			//vent_final = frag_psjB - ~ambix_xfadeA_dur;
			//~ambix_xfade = 2;
			~ambix_xfade_A_B = false;
			~ambix_xfade_B_A = true;
			ch_xfade_m = false;
			//ambix_gui_btn_xfade_block = true;
			{~ambix_gui_btn_xfade.enabled_(true);
				~ambix_gui_btn_xfade.value_(0);
			}.defer;
			{
				~ambix_gui_btn_A.value = 2;
				~ambix_gui_btn_B.value = 0;
				~ambix_gui_fl.value = 11;
			}.defer;

//// Si quiero mantener un morphing a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario
		"AmbiX-while (2)".postln;

	while({trigger_xfade == false},{
		{~ambix_gui_tiempo_paisaje_txt.string_(contador_1.round(0.1).asString)}.defer;
				contador_1 = contador_1 - 0.1;
				if ((contador_1  <= 0),{
					trigger_xfade = true;
				});

				if(~ambix_btn_xfade_check == true,{
					{
						~ambix_gui_btn_A.value = 1;
						~ambix_gui_btn_B.value = 1;
						~ambix_gui_tiempo_paisaje_txt.string_("--");
					}.defer;
					"***AmbiX-Espero a f_ambix_xfade_manual".postln;
					~cond_ambix_xfade_manual.wait;
					ch_xfade_m = true;
					trigger_xfade = true;
					~ambix_btn_xfade_check = false;
				});
				(0.1).wait;
			});

		trigger_xfade = false;
		//ambix_fmorph = false;
		//~ambix_xfade = 2;


/////////////////////////////INICIA EL MORPHING ----> A ///////////////////////////////////


//// El morphing a A se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje A a 1
			"*************AmbiX-8 - XFade ---> A***********".postln;

		if(ch_xfade_m == false, {
			var dur_morph_A = xfade_dur_psjA, flecha = 6;
				("AmbiX-xfade_dur_psjA = " + xfade_dur_psjA).postln;
				{
					~ambix_gui_btn_xfade.enabled_(false);
					~ambix_gui_btn_xfade.value_(2);
				}.defer;
			~ambix_synth.set(\xfdur,xfade_dur_psjA, \xfade,0);
			//~ambix_synth.set(\volA, 1, \vol_fade, ~ambix_xfadeA_dur); modificado el 23-12-21
			//~ambix_synth.set(\volA, 1, \vol_A_lag, (~ambix_xfadeA_dur/4).round(0.1));

			{
			~ambix_gui_btn_A.value = 1;
			~ambix_gui_btn_B.value = 1;
			}.defer;

				//// Escoge al azar el tiempo que estará reproduciendo el paisaje A (debe incluir la duración del morphing, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones)


	    //~ambix_frag_psjA = rrand(10, ~ambix_psjA.duration - 1);  // versión para paisajes cortos
		//~ambix_frag_psjA = rrand(60, ~ambix_psjA.duration - 1);
				frag_psjA = rrand(60, psjA.duration - 1);
				("AmbiX-frag_psjA (2) = " + frag_psjA).postln;

		//// Escoge al azar la duración del morphing al paisaje B
		//xfade_dur_psjB = rrand(10,~ambix_frag_psjA - 10);   /// versión para paisajes cortos

				xfade_dur_psjB = rrand(60,frag_psjA);
				("AmbiX-xfade_dur_psjB (2) = " + xfade_dur_psjB).postln;

				"***AmbiX-Flechas XFade -> A ".postln;
			while({dur_morph_A >= 0},
			{
				dur_morph_A = dur_morph_A - 0.1;
				{~ambix_gui_xfade_dur.string_((dur_morph_A).asInteger.asString)}.defer;
				{~ambix_gui_fl.value = flecha}.defer;
				flecha = flecha + 1;
				if(flecha >=12, {flecha = 6});
				0.1.wait;
				});

		});

			morph_m = 0;
			ch_xfade_m = false;

			//frag_psjA = rrand(60, psjA.duration - 1);   02-09-22
			//("frag_psjA (2a) = " + frag_psjA).postln;

			//xfade_dur_psjB = rrand(60,frag_psjA);       02-09-22
			//("xfade_dur_psjB (2a) = " + xfade_dur_psjB).postln;

///////////////////////////// TERMINA MORPHING --> A. REPRODUCE A /////////////////////////////////
			{
				~ambix_gui_btn_xfade.enabled_(true);
				~ambix_gui_btn_xfade.value_(0);
			}.defer;
		"**********AmbiX-9**************".postln;
			("AmbiX- Ahora suena el paisaje A = " + psjA).postln;
			("AmbiX - Duración total de paisaje A = " + psjA.duration).postln;
			("AmbiX- Fragmento del paisaje A = " + frag_psjA).postln;
			("AmbiX - Duración de transición a paisaje B = " + xfade_dur_psjB + "segundos").postln;
			"AmbiX- xfade -> 1".postln;
		{
		~ambix_gui_btn_A.value =0;
		~ambix_gui_btn_B.value = 2;
		~ambix_gui_fl.value = 5;
		}.defer;
		("AmbiX- Tamaño de categorias = "+ ~categorias_ambi.size).postln;
		//("AmbiX- tamaño de la categoria "+ ~ambix_i_paisaje + "= " + ~ambix_s_cat.size).postln;

/////// Selecciona una categoría, subcategoría e índice para B.

			~f_selector_ambix.value;
			~cond_ambix_1.wait;

		"*******Ambix 10********".postln;


//// Selecciona un paisaje de la categoría seleccionada y lo carga a los buffers para B

			psjB = ~ambix_paisaje;

			//("AmbiX - tamaño de la categoria"+ ~ambix_i_paisaje + "= " + ~ambix_s_cat.size).postln;

			psB_W = Buffer.readChannel(s, psjB.path, channels:[0]);
			psB_Y = Buffer.readChannel(s, psjB.path, channels:[1]);
			psB_Z = Buffer.readChannel(s, psjB.path, channels:[2]);
			psB_X = Buffer.readChannel(s, psjB.path, channels:[3]);

		s.sync;


//// Vuelve a leer los Buffers de B en el synthdef
	~ambix_synth.set(
				\soundBufB_W,psB_W,
				\soundBufB_Y,psB_Y,
				\soundBufB_Z,psB_Z,
				\soundBufB_X,psB_X);



//////////////////////////////////// INICIA ESPERA PARA COMENZAR EL MORPHING ----> B //////////////////////////////

			contador_1 = frag_psjA - xfade_dur_psjB;
			//contador_2 = 1;
			//vent_final = ~ambix_frag_psjA - xfade_dur_psjB;
			//~ambix_xfade = 2; //el morphing parte de A
			~ambix_xfade_A_B = true;
			~ambix_xfade_B_A = false;
			ch_xfade_m = false;
			//ambix_gui_btn_xfade_block = true;
			{~ambix_gui_btn_xfade.enabled_(true);
				~ambix_gui_btn_xfade.value_(0);
			}.defer;
			{
				~ambix_gui_btn_A.value = 0;
				~ambix_gui_btn_B.value = 2;
				~ambix_gui_fl.value = 5;
				}.defer;

//// Si quiero mantener un morphing a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario
			"*** Punto 15".postln;

			while ({(trigger_xfade == false)},{
				{~ambix_gui_tiempo_paisaje_txt.string_((contador_1.round(0.1)).asString)}.defer;
				contador_1 = contador_1 - 0.1;
				if ((contador_1  <= 0),{
					trigger_xfade = true;
				});

				//// Si quiero mantener un morphing a la mitad(diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario hasta que haga el xfade manual a 1 (B)
				if(~ambix_btn_xfade_check == true,{
					"***Espero a f_ambix_xfade_manual".postln;
					{
						~ambix_gui_btn_A.value = 1;
						~ambix_gui_btn_B.value = 1;
						~ambix_gui_tiempo_paisaje_txt.string_("--");
					}.defer;
					~cond_ambix_xfade_manual.wait;
					ch_xfade_m = true;
					trigger_xfade = true;
					~ambix_btn_xfade_check = false;
				});
				(0.1).wait;
			});



			trigger_xfade = false;




////////////////////////// INICIA MORPHING ---> B///////////////////////////////////

		"AmbiX - salgo de la espera al morphing -> B".postln;
		("AmbiX- Inicia Morphing --> B = " + xfade_dur_psjB + "segundos").postln;
		"AmbiX- ~ambix_xfade -> 1".postln;


//// El morphing a B se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje B a 1


	if(ch_xfade_m == false, {
				var dur_morph_B = xfade_dur_psjB, flecha = 0;
				("xfade_dur_psjB (3) = " + xfade_dur_psjB).postln;
				{
					~ambix_gui_btn_xfade.enabled_(false);
					~ambix_gui_btn_xfade.value_(2);
				}.defer;
				~ambix_synth.set(\xfdur,xfade_dur_psjB.round(0.1), \xfade, 1);

			//~ambix_synth.set(\volB, 1, \vol_B_lag, (xfade_dur_psjB/4).round(0.1));
		{
		~ambix_gui_btn_A.value = 1;
		~ambix_gui_btn_B.value = 1;
		}.defer;
				//// Escoge al azar el tiempo que estará reproduciendo el paisaje B (debe incluir la duración del morphing, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones), o a que yo cambie ~wait_xfade_Front, lo que suceda primero. Inicia el morphing

	 	//frag_psjB = rrand(10, psjB.duration - 1);   // versión para paisajes cortos

		frag_psjB = rrand(60, psjB.duration - 1);

		//// Escoge una duración de morphing de regreso a A

		//~ambix_xfadeA_dur = rrand(10,frag_psjB - 10);  // versión para paisajes cortos

		xfade_dur_psjA = rrand(60, frag_psjB);



		while({dur_morph_B >= 0},
			{
						dur_morph_B = dur_morph_B - 0.1;	{~ambix_gui_xfade_dur.string_((dur_morph_B).asInteger.asString)}.defer;
						{~ambix_gui_fl.value = flecha}.defer;
						flecha = flecha + 1;
						if(flecha >=6, {flecha = 0});
						0.1.wait;
			};
		);

			});

//// Termina morphing a B. Reproduce B.


morph_m = 0;
ch_xfade_m = false;

			frag_psjB = rrand(60, psjB.duration - 1);
			("AmbiX - frag_psjB (3a) = " + frag_psjB).postln;

			xfade_dur_psjA = rrand(60, frag_psjB);
			("Ambix - xfade_dur_psjA (3a) = " + xfade_dur_psjA).postln;


			"***Fin del bucle".postln;
	}; ///Termina el bucle
}).play;

//Revisar esta variable
~gui.onClose = {~r_ambix.stop; Buffer.freeAll; s.freeAll };

};
