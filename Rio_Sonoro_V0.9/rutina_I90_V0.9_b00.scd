//////////////////////////////////////////////////
///////////////RUTINA I-90°//////////////////////
//////////////////////////////////////////////////




///////////Variables

~cond_i90_xfade_manual = Condition.new(false);
~cond_i90_1 = Condition.new(false);
~i90_btn_xfade_check = false;



///////////////FUNCIONES/////////////////////



// selecciona categoría y subcategoría de acuerdo a la selección en la GUI
	~f_selector_i90 = {
	var cat_sel, key_subcat, i_paisaje;

	/// Detiene el proceso hasta que haya elegido una grabación
	~cond_i90_1.test = false;
 	~cond_i90_1.signal;

	///selecciona al azar una categoría
	~cat_sel_i90 = ~categorias_i90.keys.choose;
	"f_selector_i90 ****1****".postln;


	///Verifica si la categoría elegida tiene elementos o no. Si no tiene elige otra al azar.
	while({(~categorias_i90.at(~cat_sel_i90)).size <= 0}, {~cat_sel_i90 = ~categorias_i90.keys.choose; "f_selector_i90 ****while****".postln;});

	///selecciona al azar una subcategoría de la categoría seleccionada.
	key_subcat = ~categorias_i90.at(~cat_sel_i90).keys.choose;
	"f_selector_i90 ****2****".postln;

	switch(~cat_sel_i90.asString,
	"naturaleza", {
			"I-90°: Se eligió naturaleza".postln;
			("I-90°: key_subcat = " + key_subcat).postln;

		switch(key_subcat.asString,
				"agua",{
					i_paisaje = rrand(0, ~agua.size - 1);
					("I-90°: i_paisaje = " + i_paisaje).postln;
					~i90_paisaje = ~agua[i_paisaje];
					("I-90°: paisaje seleccionado de agua " + ~i90_paisaje).postln;

					///quita el paisaje de la lista correspondiente
					~agua.removeAt(i_paisaje);

					///revisa si esa subcategoría aún tiene archivos. Si no, la bloquea en la GUI y la quita del diccionario
			if((~agua.size <= 0),{
						"agua stereo vacío".postln;
						~f_stereo_bloq.value("naturaleza", false, 0);
						~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;

/// Si se vaciaron todas las subcategorías de esta categoría, quita la categoría de los diccionarios y
/// la bloquea en la GUI para todos los puntos stereo
						if(~c_st_bloq_naturaleza >= 8, {
							~f_stereo_bloq.value("naturaleza", true, nil);
						});
					});
		},
			"aire",{
					i_paisaje = rrand(0, ~aire.size - 1);
					~i90_paisaje = ~aire[i_paisaje];
					("I-90°: paisaje seleccionado de aire " + ~i90_paisaje).postln;

					///quita el paisaje de la lista correspondiente
					~aire.removeAt(i_paisaje);

///revisa si esa subcategoría aún tiene archivos. Si no, la bloquea en la GUI y la quita del diccionario
			if((~aire.size <= 0),{
						"Stereo: aire vacío".postln;
						~f_stereo_bloq.value("naturaleza", false, 1);
						~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
					});

					if(~c_st_bloq_naturaleza >= 8, {
							~f_stereo_bloq.value("naturaleza", true, nil);
					});
		},
				"tierra", {
					i_paisaje = rrand(0, ~tierra.size - 1);
					~i90_paisaje = ~tierra[i_paisaje];
					("I-90°: paisaje seleccionado de tierra" + ~i90_paisaje).postln;
					///quita el paisaje de la lista correspondiente
					~tierra.removeAt(i_paisaje);

					///revisa si esa subcategoría aún tiene archivos. Si no, la bloquea en la GUI
					if((~tierra.size <= 0),{
						"Stereo: tierra vacío".postln;
						~f_stereo_bloq.value("naturaleza", false, 2);
						~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
					});

					if(~c_st_bloq_naturaleza >= 8, {
							~f_stereo_bloq.value("naturaleza", true, nil);
					});
		},
				"fuego", {
					i_paisaje = rrand(0, ~fuego.size - 1);
					~i90_paisaje = ~fuego[i_paisaje];
					("I-90°: paisaje seleccionado de fuego" + ~i90_paisaje).postln;
					//quita el paisaje de la lista correspondiente
					~fuego.removeAt(i_paisaje);

					///revisa si esa subcategoría aún tiene archivos. Si no, la bloquea en la GUI
					if((~fuego.size <= 0),{
						"fuego stereo vacío".postln;
						~f_stereo_bloq.value("naturaleza", false, 3);
						~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
					});

					if(~c_st_bloq_naturaleza >= 8, {
							~f_stereo_bloq.value("naturaleza", true, nil);
					});
		},
				"plantas", {
					i_paisaje = rrand(0, ~plantas.size - 1);
					~i90_paisaje = ~plantas[i_paisaje];
					("I-90°: paisaje seleccionado de plantas " + ~i90_paisaje).postln;
					///quita el paisaje de la lista correspondiente
					~plantas.removeAt(i_paisaje);

					if((~plantas.size <= 0),{
						"plantas stereo vacío".postln;
						~f_stereo_bloq.value("naturaleza",false,4);
						~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
					});

					if(~c_st_bloq_naturaleza >= 8, {
							~f_stereo_bloq.value("naturaleza", true, nil);
					});
		},
			"animales", {
					i_paisaje = rrand(0, ~animales.size - 1);
					~i90_paisaje = ~animales[i_paisaje];
					("I-90°: paisaje seleccionado de animales" + ~i90_paisaje).postln;
					~animales.removeAt(i_paisaje);
					if((~animales.size <= 0),{
						"Stereo: animales vacío".postln;
						~f_stereo_bloq.value("naturaleza",false,5);
						~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
					});

					if(~c_st_bloq_naturaleza >= 8, {
							~f_stereo_bloq.value("naturaleza", true, nil);
					});
		},
					"humanos", {
					i_paisaje = rrand(0, ~humanos.size - 1);
						~i90_paisaje = ~humanos[i_paisaje];
						("I-90°: paisaje seleccionado de humanos" + ~i90_paisaje).postln;
						~humanos.removeAt(i_paisaje);
					if((~humanos.size <= 0),{
						"Stereo: humanos vacío".postln;
						~f_stereo_bloq.value("naturaleza",false,6);
						~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
					});

					if(~c_st_bloq_naturaleza >= 8, {
							~f_stereo_bloq.value("naturaleza", true, nil);
					});
					},
			"ecosistemas", {
					i_paisaje = rrand(0, ~ecosistemas.size - 1);
					~i90_paisaje = ~ecosistemas[i_paisaje];
					("I-90°: paisaje seleccionado de ecosistemas" + ~i90_paisaje).postln;
					~ecosistemas.removeAt(i_paisaje);
					if((~ecosistemas.size <= 0),{
						"Stereo: ecosistemas vacío".postln;
						~f_stereo_bloq.value("naturaleza",false,7);
						~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
					});

					if(~c_st_bloq_naturaleza >= 8, {
						~f_stereo_bloq.value("naturaleza", true, nil);
					});

				}
		)},

		"sociedad", {
			"I-90: Se eligió sociedad".postln;
			("I-90: key_subcat = " + key_subcat).postln;
			switch(key_subcat.asString,
				"rurales",{
					i_paisaje = rrand(0, ~rurales.size - 1);
					~i90_paisaje = ~rurales[i_paisaje];
					("I-90°: paisaje seleccionado de regiones rurales" + ~i90_paisaje).postln;
					~rurales.removeAt(i_paisaje);
					if((~rurales.size <= 0),{
						"Stereo: regiones rurales vacío".postln;
						~f_stereo_bloq.value("sociedad",false,0);
						~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
					});
					if(~c_st_bloq_sociedad >= 12, {
						~f_stereo_bloq.value("sociedad", true, nil);
					});
				},
					"ciudad", {
						i_paisaje = rrand(0, ~ciudad.size - 1);
						~i90_paisaje = ~ciudad[i_paisaje];
						("I-90°: paisaje seleccionado de ciudad" + ~i90_paisaje).postln;
						~ciudad.removeAt(i_paisaje);
						if((~ciudad.size <= 0),{
						"Stereo: ciudad vacío".postln;
						~f_stereo_bloq.value("sociedad",false,1);
						~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
					});
					if(~c_st_bloq_sociedad >= 12, {
						~f_stereo_bloq.value("sociedad", true, nil);
					});
					},
					"puertos", {
						i_paisaje = rrand(0, ~puertos.size - 1);
						~i90_paisaje = ~puertos[i_paisaje];
						("I-90°: paisaje seleccionado de puertos" + ~i90_paisaje).postln;
						~puertos.removeAt(i_paisaje);
					if((~puertos.size <= 0),{
						"Stereo: puertos vacío".postln;
						~f_stereo_bloq.value("sociedad",false,2);
						~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
					});
					if(~c_st_bloq_sociedad >= 12, {
						~f_stereo_bloq.value("sociedad", true, nil);
					});
					},
					"domestico", {
						i_paisaje = rrand(0, ~domestico.size - 1);
						~i90_paisaje = ~domestico[i_paisaje];
						("I-90: paisaje seleccionado de ámbito doméstico" + ~i90_paisaje).postln;
						~domestico.removeAt(i_paisaje);
						if((~domestico.size <= 0),{
						"Stereo: ámbito doméstico vacío".postln;
						~f_stereo_bloq.value("sociedad",false,3);
						~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
						});
					if(~c_st_bloq_sociedad >= 12, {
						~f_stereo_bloq.value("sociedad", true, nil);
					});
					},
					"oficinas", {
						i_paisaje = rrand(0, ~oficinas.size - 1);
						~i90_paisaje = ~oficinas[i_paisaje];
						("I-90°: paisaje seleccionado de oficinas" + ~i90_paisaje).postln;
						~oficinas.removeAt(i_paisaje);
						if((~oficinas.size <= 0),{
						"Stereo: oficinas vacío".postln;
						~f_stereo_bloq.value("sociedad",false,4);
						~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
						});
					if(~c_st_bloq_sociedad >= 12, {
						~f_stereo_bloq.value("sociedad", true, nil);
					});
					},
					"fabricas",{
						i_paisaje = rrand(0, ~fabricas.size - 1);
						~i90_paisaje = ~fabricas[i_paisaje];
						("I-90°: paisaje seleccionado de fábricas" + ~i90_paisaje).postln;
						~fabricas.removeAt(i_paisaje);
						if((~fabricas.size <= 0),{
						"Stereo: fábricas vacío".postln;
						~f_stereo_bloq.value("sociedad",false,5);
						~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
						});
					if(~c_st_bloq_sociedad >= 12, {
						~f_stereo_bloq.value("sociedad", true, nil);
					});
					},
					"trabajo",{
						i_paisaje = rrand(0, ~trabajo.size - 1);
						~i90_paisaje = ~trabajo[i_paisaje];
						("I-90°: paisaje seleccionado de otros lugares de trabajo" + ~i90_paisaje).postln;
						~trabajo.removeAt(i_paisaje);
						if((~trabajo.size <= 0),{
						"Stereo: otros lugares de trabajo vacío".postln;
						~f_stereo_bloq.value("sociedad",false,6);
						~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
						});
					if(~c_st_bloq_sociedad >= 12, {
						~f_stereo_bloq.value("sociedad", true, nil);
					});
					},
					"entretenimiento",{
						i_paisaje = rrand(0, ~entretenimiento.size - 1);
						~i90_paisaje = ~entretenimiento[i_paisaje];
						("I-90°: paisaje seleccionado de entretenimiento" + ~i90_paisaje).postln;
						~entretenimiento.removeAt(i_paisaje);
						if((~entretenimiento.size <= 0),{
						"Stereo: entretenimiento vacío".postln;
						~f_stereo_bloq.value("sociedad",false,7);
						~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
						});
					if(~c_st_bloq_sociedad >= 12, {
						~f_stereo_bloq.value("sociedad", true, nil);
					});
					},
					"muchedumbres", {
						i_paisaje = rrand(0, ~muchedumbres.size - 1);
						~i90_paisaje = ~muchedumbres[i_paisaje];
						("I-90°: paisaje seleccionado de muchedumbres" + ~i90_paisaje).postln;
						~muchedumbres.removeAt(i_paisaje);
						if((~muchedumbres.size <= 0),{
						"Stereo: muchedumbres vacío".postln;
						~f_stereo_bloq.value("sociedad",false,8);
						~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
						});
					if(~c_st_bloq_sociedad >= 12, {
						~f_stereo_bloq.value("sociedad", true, nil);
					});
					},
					"ceremonias",{
						i_paisaje = rrand(0, ~ceremonias.size - 1);
						~i90_paisaje = ~ceremonias[i_paisaje];
						("I-90°: paisaje seleccionado de ceremonias" + ~i90_paisaje).postln;
						~ceremonias.removeAt(i_paisaje);
						if((~ceremonias.size <= 0),{
						"Stereo: ceremonias vacío".postln;
						~f_stereo_bloq.value("sociedad",false,9);
						~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
						});
					if(~c_st_bloq_sociedad >= 12, {
						~f_stereo_bloq.value("sociedad", true, nil);
					});
					},
					"parques", {
						i_paisaje = rrand(0, ~parques.size - 1);
						~i90_paisaje = ~parques[i_paisaje];
						("I-90°: paisaje seleccionado de parques y jardines" + ~i90_paisaje).postln;
						~parques.removeAt(i_paisaje);
						if((~parques.size <= 0),{
						"Stereo: parques y jardines vacío".postln;
						~f_stereo_bloq.value("sociedad",false,10);
						~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
						});
					if(~c_st_bloq_sociedad >= 12, {
						~f_stereo_bloq.value("sociedad", true, nil);
					});
					},
					"indicadores",{
						i_paisaje = rrand(0, ~indicadores.size - 1);
						~i90_paisaje = ~indicadores[i_paisaje];
						("I-90°: paisaje seleccionado de indicadores sonoros" + ~i90_paisaje).postln;
						~indicadores.removeAt(i_paisaje);
						if((~indicadores.size <= 0),{
						"Stereo: indicadores sonoros vacío".postln;
						~f_stereo_bloq.value("sociedad",false,11);
						~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
						});
					if(~c_st_bloq_sociedad >= 12, {
						~f_stereo_bloq.value("sociedad", true, nil);
					});
					}
			)
		},
		"artilugios", {
			"I-90°: Se eligió artilugios mecánicos".postln;
			("I-90°: key_subcat = " + key_subcat).postln;
			switch(key_subcat.asString,
				"mecanismos", {
					i_paisaje = rrand(0, ~mecanismos.size - 1);
					~i90_paisaje = ~mecanismos[i_paisaje];
					("I-90°: paisaje seleccionado de mecanismos varios" + ~i90_paisaje).postln;
					~mecanismos.removeAt(i_paisaje);
					if((~mecanismos.size <= 0),{
						"Stereo: mecanismos varios vacío".postln;
						~f_stereo_bloq.value("artilugios",false,0);
						~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
					});
					if(~c_st_bloq_artilugios >= 7, {
						~f_stereo_bloq.value("artilugios", true, nil);
					});
				},
				"maquinaria", {
					i_paisaje = rrand(0, ~maquinaria.size - 1);
					~i90_paisaje = ~maquinaria[i_paisaje];
					("I-90°: paisaje seleccionado de maquinaria industrial" + ~i90_paisaje).postln;
					~maquinaria.removeAt(i_paisaje);
					if((~maquinaria.size <= 0),{
						"Stereo: maquinaria industrial vacío".postln;
						~f_stereo_bloq.value("artilugios",false,1);
						~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
					});
					if(~c_st_bloq_artilugios >= 7, {
						~f_stereo_bloq.value("artilugios", true, nil);
					});
				},
				"transportes", {
					i_paisaje = rrand(0, ~transportes.size - 1);
					~i90_paisaje = ~transportes[i_paisaje];
					("I-90°: paisaje seleccionado de transportes" + ~i90_paisaje).postln;
					~transportes.removeAt(i_paisaje);
					if((~transportes.size <= 0),{
						"Stereo: transportes vacío".postln;
						~f_stereo_bloq.value("artilugios",false,2);
						~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
					});
					if(~c_st_bloq_artilugios >= 7, {
						~f_stereo_bloq.value("artilugios", true, nil);
					});
				},
				"guerra", {
					i_paisaje = rrand(0, ~guerra.size - 1);
					~i90_paisaje = ~guerra[i_paisaje];
					("I-90°: paisaje seleccionado de máquinas de guerra" + ~i90_paisaje).postln;
					~guerra.removeAt(i_paisaje);
					if((~guerra.size <= 0),{
						"Stereo: máquinas de guerra vacío".postln;
						~f_stereo_bloq.value("artilugios",false,3);
						~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
					});
					if(~c_st_bloq_artilugios >= 7, {
						~f_stereo_bloq.value("artilugios", true, nil);
					});
				},
				"construccion", {
					i_paisaje = rrand(0, ~construccion.size - 1);
					~i90_paisaje = ~construccion[i_paisaje];
					("I-90°: paisaje seleccionado de maquinaria de construcción-demolición" + ~i90_paisaje).postln;
					~construccion.removeAt(i_paisaje);
					if((~construccion.size <= 0),{
						"Stereo: maquinaria de construcción-demolición vacío".postln;
						~f_stereo_bloq.value("artilugios",false,4);
						~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
					});
					if(~c_st_bloq_artilugios >= 7, {
						~f_stereo_bloq.value("artilugios", true, nil);
					});
				},
				"ventiladores", {
					i_paisaje = rrand(0, ~ventiladores.size - 1);
					~i90_paisaje = ~ventiladores[i_paisaje];
					("I-90°: paisaje seleccionado de ventiladores-aires acondicionados" + ~i90_paisaje).postln;
					~ventiladores.removeAt(i_paisaje);
					if((~ventiladores.size <= 0),{
						"Stereo: ventiladores-aires acondicionados vacío".postln;
						~f_stereo_bloq.value("artilugios",false,5);
						~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
					});
					if(~c_st_bloq_artilugios >= 7, {
						~f_stereo_bloq.value("artilugios", true, nil);
					});
				},

				"herramientas", {
					i_paisaje = rrand(0, ~herramientas.size - 1);
					~i90_paisaje = ~herramientas[i_paisaje];
					("I-90°: paisaje seleccionado de herramientas" + ~i90_paisaje).postln;
					~herramientas.removeAt(i_paisaje);

					if((~herramientas.size <= 0),{
						"Stereo: herramientas vacío".postln;
						~f_stereo_bloq.value("artilugios",false,6);
						~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
					});

					if(~c_st_bloq_artilugios >= 7, {
						~f_stereo_bloq.value("artilugios", true, nil);
					});
				}
			)

		},
		"quietud", {
			"I-90°: Se eligió quietud y silencio".postln;
			("I-90°: key_subcat = " + key_subcat).postln;
			switch(key_subcat.asString,
				"hum", {
					i_paisaje = rrand(0, ~hum.size - 1);
					~i90_paisaje = ~hum[i_paisaje];
					("I-90°: paisaje seleccionado de hum" + ~i90_paisaje).postln;
					~hum.removeAt(i_paisaje);

					if((~hum.size <= 0),{
						"Stereo: hum vacío".postln;
						~f_stereo_bloq.value("quietud",false,0);
						~c_st_bloq_quietud = ~c_st_bloq_quietud + 1;

						if(~c_st_bloq_quietud >= 2, {
							~f_stereo_bloq.value("quietud", true, nil);
						});
					});
				},

				"vacio", {
					i_paisaje = rrand(0, ~vacio.size - 1);
					~i90_paisaje = ~vacio[i_paisaje];
					("I-90°: paisaje seleccionado de espacio vacíos" + ~i90_paisaje).postln;
					~vacio.removeAt(i_paisaje);

					if((~vacio.size <= 0),{
						"Stereo: espacios vacíos vacío".postln;
						~f_stereo_bloq.value("quietud",false,1);
						~c_st_bloq_quietud = ~c_st_bloq_quietud + 1;

						if(~c_st_bloq_quietud >= 2, {
							~f_stereo_bloq.value("quietud", true, nil);
						});
					});
				}
			);
		}
	);

	~cond_i90_1.test = true;
 	~cond_i90_1.signal;
};

//// Función: toma el tiempo y valor de la transición y los pasa al synthdef

~f_i90_xfade = { arg xfdur, xfade;
~i90_synth.set(\xfdur,xfdur, \xfade,xfade);
};

//~i90_xfade_m_t = false;



/// Función a ejecutar cuando se presione botón de transición manual y no llegue a A ó B. Se llama en el botón ~i90_gui_btn_xfade

~f_i90_xfade_manual = { arg xfdur, xfade;
	var morph = xfdur, routine;
	~cond_i90_xfade_manual.test = false;
	{
		~i90_gui_btn_A.value = 1;
		~i90_gui_btn_B.value = 1;
		~i90_gui_tiempo_paisaje_txt.string_("--");
	}.defer;


		"***f_i90_xfade_manual_while".postln;
		~f_i90_xfade.value(xfdur, xfade);
	routine = Routine({
		while({morph > 0.1},{
			morph = morph - 0.1;
			{~i90_gui_xfade_dur.string_((morph).asInteger.asString);
			~i90_gui_btn_xfade.enabled_(false)}.defer;
			0.1.wait;
		});
		{
			~i90_gui_btn_xfade.enabled_(true);
			~i90_gui_btn_xfade.value_(0);
		}.defer;
		routine.stop;
});
	routine.play;
};


// Función si se hace un XFade con tiempo manual directo de A a B. //Llamada en el botón ~i90_gui_btn_xfade

~f_i90_xfade_A_B_1 = { arg xfdur, xfade;
	var morph = xfdur, flecha=0, routine;
	~cond_i90_xfade_manual.test = false;
	("I-90°: condition A_B_1 inicial = " + ~cond_i90_xfade_manual.test).postln;
	{
		~i90_gui_btn_A.value = 1;
		~i90_gui_btn_B.value = 1;
		~i90_gui_tiempo_paisaje_txt.string_("--")
	}.defer;

	~f_i90_xfade.value(xfdur, xfade);
	"***f_i90_xfade_A_B_1".postln;
	routine = Routine({
	while({morph > 0.1},{
		{
			~i90_gui_xfade_dur.string_((morph).asInteger.asString);
			~i90_gui_btn_xfade.enabled_(false);
			~i90_gui_fl.value = flecha;
		}.defer;
			flecha = flecha + 1;
			if(flecha >= 6, {flecha = 0});
			morph = morph - 0.1;
			0.1.wait;
			//("morph A_B_1 = " + morph).postln;
	});
	{
		~i90_gui_btn_xfade.enabled_(true);
		~i90_gui_btn_xfade.value_(0);
	}.defer;
	~cond_i90_xfade_manual.test = true;
	"I-90°: Condition A_B_1 = true".postln;
	~cond_i90_xfade_manual.signal;
		routine.stop;
	});
	routine.play;
};


/// Función si se hace un XFade con tiempo manual directo de B a A. Llamda en ~i90_gui_btn_xfade

~f_i90_xfade_B_A_0 = { arg xfdur, xfade;
	var morph = xfdur, flecha=12, routine;
	~cond_i90_xfade_manual.test = false;
	{
		~i90_gui_btn_A.value = 1;
		~i90_gui_btn_B.value = 1;
		~i90_gui_tiempo_paisaje_txt.string_("--")
	}.defer;

		~f_i90_xfade.value(xfdur, xfade);
		"***f_i90_xfade_B_A_0".postln;
	routine = Routine({
	while({morph > 0.1},{
		{
			~i90_gui_xfade_dur.string_((morph).asInteger.asString);
			~i90_gui_btn_xfade.enabled_(false);
			~i90_gui_fl.value = flecha;
		}.defer;

			flecha = flecha + 1;
			if(flecha >= 12, {flecha = 6});
			morph = morph - 0.1;
			0.1.wait;
		});
		{
			~i90_gui_btn_xfade.enabled_(true);
			~i90_gui_btn_xfade.value_(0);
		}.defer;
	~cond_i90_xfade_manual.test = true;
	~cond_i90_xfade_manual.signal;
		routine.stop;
	});
	routine.play;

};

/////////////////////////////FUNCIÓN GENERAL PARA LA RUTINA DE I-90° ////////////////////////////////


~f_i90_r = {
~r_i90 = Routine({
	var morph_m=0, contador_1 = 0, contador_2=1, frag_psjB, frag_psjA, vent_final,  xfade_dur_psjA, xfade_dur_psjB, psjA, psjB, psA_W, psA_L, psA_R, psB_L, psB_R, trigger_xfade=false, ch_xfade_m=false, cat, sub_cat, i_paisaje;



	// Selección del primer paisaje sonoro para I-90°
		~f_selector_i90.value;

	//Espera a que la función eliga una grabación.
		~cond_i90_1.wait;


	"*****************I-90° 1************************".postln;

		//Carga la grabación selecionada en el lado A del SynthDef con XFade espectral

		psjA = ~i90_paisaje;
			("I-90° psjA = " + psjA).postln;
			(0.1).wait;

			psA_L = Buffer.readChannel(s, psjA.path, channels:[0]);
			psA_R = Buffer.readChannel(s, psjA.path, channels:[1]);

			s.sync;


	"*********I-90° 2*************".postln;


		///Selección de Paisaje B

		~f_selector_i90.value;
		~cond_i90_1.wait;


	"*****************I-90° 3************************".postln;

		//Carga la grabación selecionada en los buffers de B del SynthDef con XFade espectral

			psjB = ~i90_paisaje;


		("Paisaje B I-90° = " + psjB).postln;
	(0.1).wait;

		psB_L = Buffer.readChannel(s, psjB.path, channels:[0]);
		psB_R = Buffer.readChannel(s, psjB.path, channels:[1]);

	s.sync;


	"************I-90° 4**************".postln;



//// Escoge al azar el tiempo que estará reproduciendo el paisaje A (debe incluir la duración del XFade, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones).


		frag_psjA = rrand(60, psjA.duration - 1);


		xfade_dur_psjB = rrand(60, frag_psjA);

		////////////////////////////////// INICIA REPRODUCCIÓN DE PAISAJE A con Fade-in ////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////


		~i90_synth = Synth('XFade_Stereo', [
		\out,~ambiBus[6],
		\spec_bufA_L,~i90_fft_bufA_L,
		\spec_bufA_R,~i90_fft_bufA_R,

		\spec_bufB_L,~i90_fft_bufB_L,
		\spec_bufB_R,~i90_fft_bufB_R,

		\soundBufA_L,psA_L,
		\soundBufA_R,psA_R,

		\soundBufB_L,psB_L,
		\soundBufB_R,psB_R,

		\amp, 0,
		\amp_lag, 0.01,

			\b_vol, ~b_vol[6]      //////////REVISAR que sirva

	],~ambiGroup[6], addAction:\addToHead);

		(0.1).wait;

		{
			var amp=~i90_gui_vol_value_in.string.asInteger/100, lag=~i90_gui_vol_tiempo_in.string.asInteger;
			~i90_synth.set(\amp,amp, \amp_lag,lag);
			~f_i90_vol_gui.value(amp, lag)
		}.defer;

		("I-90° - Ahora suena A = " + psjA).postln;
		("I-90° - Duración total de paisaje A = " + psjA.duration).postln;
		("I-90° - Fragmento del paisaje A = " + frag_psjA).postln;
		("I-90° - Duracion de transición a B = " + xfade_dur_psjB).postln;
		"~I-90°_xfade -> 1".postln;
		("I-90°_Paisaje B = " + psjB).postln;

		{
			~i90_gui_btn_A.value = 0;
			~i90_gui_btn_B.value = 2;
		}.defer;


		/////////////////////////// INICIA ESPERA PARA EL XFade ---> B ////////////////////////////////

		contador_1 = frag_psjA - xfade_dur_psjB;
		~i90_xfade_A_B = true;
		~i90_xfade_B_A = false;
		ch_xfade_m = false;
		{~i90_gui_btn_xfade.enabled_(true);
			~i90_gui_btn_xfade.value_(0);
		}.defer;


	"******************I-90° 5******************".postln;

		while ({(trigger_xfade == false)},{
			{~i90_gui_tiempo_paisaje_txt.string_((contador_1.round(0.1)).asString)}.defer;
			contador_1 = contador_1 - 0.1;
			{
				~i90_gui_btn_A.value = 0;
				~i90_gui_btn_B.value = 2;
				~i90_gui_fl.value = 5;
			}.defer;

			if ((contador_1  <= 0),{
				trigger_xfade = true;
			});

			//// Si quiero mantener un XFade a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario hasta que haga el xfade manual a 1 (B)
			if(~i90_btn_xfade_check == true,{
				{
					~i90_gui_btn_A.value = 1;
					~i90_gui_btn_B.value = 1;
					~i90_gui_tiempo_paisaje_txt.string_("--");
				}.defer;
					"***Espero a f_i90_xfade_manual".postln;
					~cond_i90_xfade_manual.wait;
					ch_xfade_m = true;
					trigger_xfade = true;
					~i90_btn_xfade_check = false;
				});
				(0.1).wait;
			});

			trigger_xfade = false;

		////////////////////////////// INICIA EL MORPHING ---> B ///////////////////////////////////////////


//// El morphing a B se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje B a 1


		"********I-90° 6********".postln;

	if(ch_xfade_m == false,{
		var flecha = 0;
		var dur_morph_B = xfade_dur_psjB;
			("I-90° - transición a paisaje B = " + xfade_dur_psjB).postln;
			{
				~i90_gui_btn_xfade.enabled_(false);
				~i90_gui_btn_xfade.value_(2);
			}.defer;

			~i90_synth.set(\xfdur,xfade_dur_psjB.round(0.1), \xfade, 1);

			{
			~i90_gui_btn_A.value = 1;
			~i90_gui_btn_B.value = 1;
			}.defer;

		"***I-90° XFade -> B (1) ".postln;


			//// Escoge al azar el tiempo que estará reproduciendo el paisaje B (debe incluir la duración del xfade, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones)

			frag_psjB = rrand(60, psjB.duration - 1);

			("I-90° frag_psjB (1)= " + frag_psjB).postln;

			//// Escoge una duración de xfade de regreso a A

			xfade_dur_psjA = rrand(60, frag_psjB);

			("I-90° xfade_dur_psjA (1) = " + xfade_dur_psjA).postln;

		while({dur_morph_B >= 0},
			{
				{~i90_gui_xfade_dur.string_((dur_morph_B).asInteger.asString)}.defer;
				{~i90_gui_fl.value = flecha}.defer;
				flecha = flecha + 1;
				if(flecha >=6, {flecha = 0});
				dur_morph_B = dur_morph_B - 0.1;
				0.1.wait;
			};
		);
	});

		morph_m = 0;
		ch_xfade_m = false;

		//////////////////////////////// TERMINA EL MORPHING ---> B. REPRODUCE B //////////////////////////

		{~i90_gui_btn_xfade.enabled_(true);
		~i90_gui_btn_xfade.value_(0);
		}.defer;

		////////// Aquí inicia el bucle

		100.do{
			"*************I-90° 7**************".postln;
			("I-90° - Ahora suena B = " + psjB).postln;
			{~i90_gui_btn_A.value = 2;
				~i90_gui_btn_B.value = 0;
				~i90_gui_fl.value = 10;
			}.defer;

			("I-90° - Duración total de paisaje B = " + psjB.duration).postln;
			("I-90° - Fragmento del paisaje B = " + frag_psjB).postln;
			("I-90° - Duración de transición al paisaje A = " + xfade_dur_psjA + "segundos").postln;

			/////// Selecciona una categoría y subcategoría para A.

			~f_selector_i90.value;
			~cond_i90_1.wait;

			s.sync;

			//// Carga el paisaje seleccionado en los buffers para A



			psjA = ~i90_paisaje;

			psA_L = Buffer.readChannel(s, psjA.path, channels:[0]);
			psA_R = Buffer.readChannel(s, psjA.path, channels:[1]);

			s.sync;

			("I-90° - paisaje A = " + psjA).postln;


			//// Carga los Buffers de A en el synthdef
			~i90_synth.set(
				\soundBufA_L,psA_L,
				\soundBufA_R,psA_R
			);

			s.sync;


			//////////////////////////////// INICIA ESPERA PARA EL MORPHING ---> A ////////////////////////////

			contador_1 = frag_psjB - xfade_dur_psjA;
			~i90_xfade_A_B = false;
			~i90_xfade_B_A = true;
			ch_xfade_m = false;

			{~i90_gui_btn_xfade.enabled_(true);
				~i90_gui_btn_xfade.value_(0);
			}.defer;
			{
				~i90_gui_btn_A.value = 2;
				~i90_gui_btn_B.value = 0;
				~i90_gui_fl.value = 11;
			}.defer;

			//// Si quiero mantener un morphing a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario
		"I-90° while (2)".postln;

	while({trigger_xfade == false},{
		{~i90_gui_tiempo_paisaje_txt.string_(contador_1.round(0.1).asString)}.defer;
				contador_1 = contador_1 - 0.1;
				if ((contador_1  <= 0),{
					trigger_xfade = true;
				});

				if(~i90_btn_xfade_check == true,{
					{
						~i90_gui_btn_A.value = 1;
						~i90_gui_btn_B.value = 1;
						~i90_gui_tiempo_paisaje_txt.string_("--");
					}.defer;
					"*****I-90°: Espero a f_i90_xfade_manual".postln;
					~cond_i90_xfade_manual.wait;
					ch_xfade_m = true;
					trigger_xfade = true;
					~i90_btn_xfade_check = false;
				});
				(0.1).wait;
			});

		trigger_xfade = false;


			/////////////////////////////INICIA EL MORPHING ----> A ///////////////////////////////////


//// El morphing a A se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje A a 1
			"*************I-90° 8 - XFade ---> A***********".postln;

		if(ch_xfade_m == false, {
			var dur_morph_A = xfade_dur_psjA, flecha = 6;
				("I-90° xfade_dur_psjA = " + xfade_dur_psjA).postln;
				{
					~i90_gui_btn_xfade.enabled_(false);
					~i90_gui_btn_xfade.value_(2);
				}.defer;
			~i90_synth.set(\xfdur,xfade_dur_psjA, \xfade,0);

			{
			~i90_gui_btn_A.value = 1;
			~i90_gui_btn_B.value = 1;
			}.defer;


				//// Escoge al azar el tiempo que estará reproduciendo el paisaje A (debe incluir la duración del morphing, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones)


				frag_psjA = rrand(60, psjA.duration - 1);
				("I-90° frag_psjA (2) = " + frag_psjA).postln;


				xfade_dur_psjB = rrand(60,frag_psjA);
				("I-90° xfade_dur_psjB (2) = " + xfade_dur_psjB).postln;

				"***I-90° Flechas XFade -> A ".postln;
			while({dur_morph_A >= 0},
			{
				dur_morph_A = dur_morph_A - 0.1;
				{~i90_gui_xfade_dur.string_((dur_morph_A).asInteger.asString)}.defer;
				{~i90_gui_fl.value = flecha}.defer;
				flecha = flecha + 1;
				if(flecha >=12, {flecha = 6});
				0.1.wait;
				});

		});

			morph_m = 0;
			ch_xfade_m = false;


			///////////////////////////// TERMINA MORPHING --> A. REPRODUCE A /////////////////////////////////
			{
				~i90_gui_btn_xfade.enabled_(true);
				~i90_gui_btn_xfade.value_(0);
			}.defer;
		"**********I-90° 9**************".postln;
			("I-90°- Ahora suena el paisaje A = " + psjA).postln;
			("I-90° - Duración total de paisaje A = " + psjA.duration).postln;
			("I-90° - Fragmento del paisaje A = " + frag_psjA).postln;
			("I-90° - Duración de transición a paisaje B = " + xfade_dur_psjB + "segundos").postln;
			"I-90° - xfade -> 1".postln;
		{
		~i90_gui_btn_A.value =0;
		~i90_gui_btn_B.value = 2;
		~i90_gui_fl.value = 5;
		}.defer;

			//("I-90° - Tamaño de categorias = "+ ~categorias_fr.size).postln;

			/////// Selecciona una categoría y subcategoría para B.

			~f_selector_i90.value;
			~cond_i90_1.wait;

		"*******I-90° 10********".postln;

			//// Selecciona un paisaje de la subcategoría seleccionada y lo carga a los buffers para B

			psjB = ~i90_paisaje;

			psB_L = Buffer.readChannel(s, psjB.path, channels:[0]);
			psB_R = Buffer.readChannel(s, psjB.path, channels:[1]);

		s.sync;

			//// Carga los Buffers de B en el synthdef
			~i90_synth.set(
				\soundBufB_L,psB_L,
				\soundBufB_R,psB_R,
			);

			//////////////////////////////////// INICIA ESPERA PARA COMENZAR EL MORPHING ----> B //////////////////////////////

			contador_1 = frag_psjA - xfade_dur_psjB;

			~i90_xfade_A_B = true;
			~i90_xfade_B_A = false;
			ch_xfade_m = false;

			{
				~i90_gui_btn_xfade.enabled_(true);
				~i90_gui_btn_xfade.value_(0);
				~i90_gui_btn_A.value = 0;
				~i90_gui_btn_B.value = 2;
				~i90_gui_fl.value = 5;
			}.defer;


//// Si quiero mantener un morphing a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario
			"*** Punto 15".postln;

			while ({(trigger_xfade == false)},{
				{~i90_gui_tiempo_paisaje_txt.string_((contador_1.round(0.1)).asString)}.defer;
				contador_1 = contador_1 - 0.1;
				if ((contador_1  <= 0),{
					trigger_xfade = true;
				});

				//// Si quiero mantener un morphing a la mitad(diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario hasta que haga el xfade manual a 1 (B)
				if(~i90_btn_xfade_check == true,{
					"***I-90° Espero a f_i90_xfade_manual".postln;
					{
						~i90_gui_btn_A.value = 1;
						~i90_gui_btn_B.value = 1;
						~i90_gui_tiempo_paisaje_txt.string_("--");
					}.defer;
					~cond_i90_xfade_manual.wait;
					ch_xfade_m = true;
					trigger_xfade = true;
					~i90_btn_xfade_check = false;
				});
				(0.1).wait;
			});

			trigger_xfade = false;

			////////////////////////// INICIA MORPHING ---> B///////////////////////////////////

		"I-90° - salgo de la espera al morphing -> B".postln;
		("I-90° - Inicia Morphing --> B = " + xfade_dur_psjB + "segundos").postln;



			//// El morphing a B se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje B a 1


	if(ch_xfade_m == false, {
				var dur_morph_B = xfade_dur_psjB, flecha = 0;
				("I-90° xfade_dur_psjB (3) = " + xfade_dur_psjB).postln;
				{
					~i90_gui_btn_xfade.enabled_(false);
					~i90_gui_btn_xfade.value_(2);
				}.defer;
				~i90_synth.set(\xfdur,xfade_dur_psjB.round(0.1), \xfade, 1);

		{
		~i90_gui_btn_A.value = 1;
		~i90_gui_btn_B.value = 1;
		}.defer;


				//// Escoge al azar el tiempo que estará reproduciendo el paisaje B (debe incluir la duración del morphing, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones) Inicia el morphing


		frag_psjB = rrand(60, psjB.duration - 1);

		//// Escoge una duración de morphing de regreso a A

		xfade_dur_psjA = rrand(60, frag_psjB);

			while({dur_morph_B >= 0},
			{
						dur_morph_B = dur_morph_B - 0.1;
						{~i90_gui_xfade_dur.string_((dur_morph_B).asInteger.asString)}.defer;
						{~i90_gui_fl.value = flecha}.defer;
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
			("I-90° - frag_psjB (3a) = " + frag_psjB).postln;

			xfade_dur_psjA = rrand(60, frag_psjB);
			("I-90° - xfade_dur_psjA (3a) = " + xfade_dur_psjA).postln;


			"***I-90° Fin del bucle".postln;

		};


	}).play;
};

