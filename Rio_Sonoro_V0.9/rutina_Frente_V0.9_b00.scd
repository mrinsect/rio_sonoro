//////////////////////////////////////////////////
///////////////RUTINA FRENTE//////////////////////
//////////////////////////////////////////////////




///////////Variables

~cond_fr_xfade_manual = Condition.new(false);
~cond_fr_1 = Condition.new(false);
~fr_btn_xfade_check = false;



///////////////FUNCIONES/////////////////////



// selecciona categoría y subcategoría de acuerdo a la selección en la GUI
	~f_selector_fr = {
	var cat_sel, key_subcat, i_paisaje;

	/// Detiene el proceso hasta que haya elegido una grabación
	~cond_fr_1.test = false;
 	~cond_fr_1.signal;

	///selecciona al azar una categoría
	~cat_sel_fr = ~categorias_fr.keys.choose;
	"f_selector_fr ****1****".postln;


	///Verifica si la categoría elegida tiene elementos o no. Si no tiene elige otra al azar.
	while({(~categorias_fr.at(~cat_sel_fr)).size <= 0}, {~cat_sel_fr = ~categorias_fr.keys.choose; "f_selector_fr ****while****".postln;});

	///selecciona al azar una subcategoría de la categoría seleccionada.
	key_subcat = ~categorias_fr.at(~cat_sel_fr).keys.choose;
	"f_selector_fr ****2****".postln;

	switch(~cat_sel_fr.asString,
	"naturaleza", {
			"Frente: Se eligió naturaleza".postln;
			("Frente: key_subcat = " + key_subcat).postln;

		switch(key_subcat.asString,
				"agua",{
					i_paisaje = rrand(0, ~agua.size - 1);
					("Frente: i_paisaje = " + i_paisaje).postln;
					~fr_paisaje = ~agua[i_paisaje];
					("Frente: paisaje seleccionado de agua " + ~fr_paisaje).postln;

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
					~fr_paisaje = ~aire[i_paisaje];
					("Frente: paisaje seleccionado de aire " + ~fr_paisaje).postln;

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
					~fr_paisaje = ~tierra[i_paisaje];
					("Frente: paisaje seleccionado de tierra" + ~fr_paisaje).postln;
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
					~fr_paisaje = ~fuego[i_paisaje];
					("Frente: paisaje frente seleccionado de fuego" + ~fr_paisaje).postln;
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
					~fr_paisaje = ~plantas[i_paisaje];
					("Frente: paisaje seleccionado de plantas " + ~fr_paisaje).postln;
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
					~fr_paisaje = ~animales[i_paisaje];
					("Frente: paisaje seleccionado de animales" + ~fr_paisaje).postln;
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
						~fr_paisaje = ~humanos[i_paisaje];
						("Frente: paisaje seleccionado de humanos" + ~fr_paisaje).postln;
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
					~fr_paisaje = ~ecosistemas[i_paisaje];
					("Frente: paisaje seleccionado de ecosistemas" + ~fr_paisaje).postln;
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
			"Frente: Se eligió sociedad".postln;
			("Frente: key_subcat = " + key_subcat).postln;
			switch(key_subcat.asString,
				"rurales",{
					i_paisaje = rrand(0, ~rurales.size - 1);
					~fr_paisaje = ~rurales[i_paisaje];
					("Frente: paisaje seleccionado de regiones rurales" + ~fr_paisaje).postln;
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
						~fr_paisaje = ~ciudad[i_paisaje];
						("Frente: paisaje seleccionado de ciudad" + ~fr_paisaje).postln;
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
						~fr_paisaje = ~puertos[i_paisaje];
						("Frente: paisaje seleccionado de puertos" + ~fr_paisaje).postln;
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
						~fr_paisaje = ~domestico[i_paisaje];
						("Frente: paisaje seleccionado de ámbito doméstico" + ~fr_paisaje).postln;
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
						~fr_paisaje = ~oficinas[i_paisaje];
						("Frente: paisaje seleccionado de oficinas" + ~fr_paisaje).postln;
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
						~fr_paisaje = ~fabricas[i_paisaje];
						("Frente: paisaje seleccionado de fábricas" + ~fr_paisaje).postln;
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
						~fr_paisaje = ~trabajo[i_paisaje];
						("Frente: paisaje seleccionado de otros lugares de trabajo" + ~fr_paisaje).postln;
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
						~fr_paisaje = ~entretenimiento[i_paisaje];
						("Frente: paisaje seleccionado de entretenimiento" + ~fr_paisaje).postln;
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
						~fr_paisaje = ~muchedumbres[i_paisaje];
						("Frente: paisaje seleccionado de muchedumbres" + ~fr_paisaje).postln;
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
						~fr_paisaje = ~ceremonias[i_paisaje];
						("Frente: paisaje seleccionado de ceremonias" + ~fr_paisaje).postln;
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
						~fr_paisaje = ~parques[i_paisaje];
						("Frente: paisaje seleccionado de parques y jardines" + ~fr_paisaje).postln;
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
						~fr_paisaje = ~indicadores[i_paisaje];
						("Frente: paisaje seleccionado de indicadores sonoros" + ~fr_paisaje).postln;
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
			"Frente: Se eligió artilugios mecánicos".postln;
			("Frente: key_subcat = " + key_subcat).postln;
			switch(key_subcat.asString,
				"mecanismos", {
					i_paisaje = rrand(0, ~mecanismos.size - 1);
					~fr_paisaje = ~mecanismos[i_paisaje];
					("Frente: paisaje seleccionado de mecanismos varios" + ~fr_paisaje).postln;
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
					~fr_paisaje = ~maquinaria[i_paisaje];
					("Frente: paisaje seleccionado de maquinaria industrial" + ~fr_paisaje).postln;
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
					~fr_paisaje = ~transportes[i_paisaje];
					("Frente: paisaje seleccionado de transportes" + ~fr_paisaje).postln;
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
					~fr_paisaje = ~guerra[i_paisaje];
					("Frente: paisaje seleccionado de máquinas de guerra" + ~fr_paisaje).postln;
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
					~fr_paisaje = ~construccion[i_paisaje];
					("Frente: paisaje seleccionado de maquinaria de construcción-demolición" + ~fr_paisaje).postln;
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
					~fr_paisaje = ~ventiladores[i_paisaje];
					("Frente: paisaje seleccionado de ventiladores-aires acondicionados" + ~fr_paisaje).postln;
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
					~fr_paisaje = ~herramientas[i_paisaje];
					("Frente: paisaje seleccionado de herramientas" + ~fr_paisaje).postln;
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
			"Frente: Se eligió quietud y silencio".postln;
			("Frente: key_subcat = " + key_subcat).postln;
			switch(key_subcat.asString,
				"hum", {
					i_paisaje = rrand(0, ~hum.size - 1);
					~fr_paisaje = ~hum[i_paisaje];
					("Frente: paisaje seleccionado de hum" + ~fr_paisaje).postln;
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
					~fr_paisaje = ~vacio[i_paisaje];
					("Frente: paisaje seleccionado de espacio vacíos" + ~fr_paisaje).postln;
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

	~cond_fr_1.test = true;
 	~cond_fr_1.signal;
};

//// Función: toma el tiempo y valor de la transición y los pasa al synthdef

~f_fr_xfade = { arg xfdur, xfade;
~fr_synth.set(\xfdur,xfdur, \xfade,xfade);
};

//~fr_xfade_m_t = false;



/// Función a ejecutar cuando se presione botón de transición manual y no llegue a A ó B. Se llama en el botón ~fr_gui_btn_xfade

~f_fr_xfade_manual = { arg xfdur, xfade;
	var morph = xfdur, routine;
	~cond_fr_xfade_manual.test = false;
	{
		~fr_gui_btn_A.value = 1;
		~fr_gui_btn_B.value = 1;
		~fr_gui_tiempo_paisaje_txt.string_("--");
	}.defer;


		"***f_fr_xfade_manual_while".postln;
		~f_fr_xfade.value(xfdur, xfade);
	routine = Routine({
		while({morph > 0.1},{
			morph = morph - 0.1;
			{~fr_gui_xfade_dur.string_((morph).asInteger.asString);
			~fr_gui_btn_xfade.enabled_(false)}.defer;
			0.1.wait;
		});
		{
			~fr_gui_btn_xfade.enabled_(true);
			~fr_gui_btn_xfade.value_(0);
		}.defer;
		routine.stop;
});
	routine.play;
};


// Función si se hace un XFade con tiempo manual directo de A a B. //Llamada en el botón ~fr_gui_btn_xfade

~f_fr_xfade_A_B_1 = { arg xfdur, xfade;
	var morph = xfdur, flecha=0, routine;
	~cond_fr_xfade_manual.test = false;
	("Frente: condition A_B_1 inicial = " + ~cond_fr_xfade_manual.test).postln;
	{
		~fr_gui_btn_A.value = 1;
		~fr_gui_btn_B.value = 1;
		~fr_gui_tiempo_paisaje_txt.string_("--")
	}.defer;

	~f_fr_xfade.value(xfdur, xfade);
	"***f_fr_xfade_A_B_1".postln;
	routine = Routine({
	while({morph > 0.1},{
		{
			~fr_gui_xfade_dur.string_((morph).asInteger.asString);
			~fr_gui_btn_xfade.enabled_(false);
			~fr_gui_fl.value = flecha;
		}.defer;
			flecha = flecha + 1;
			if(flecha >= 6, {flecha = 0});
			morph = morph - 0.1;
			0.1.wait;
			//("morph A_B_1 = " + morph).postln;
	});
	{
		~fr_gui_btn_xfade.enabled_(true);
		~fr_gui_btn_xfade.value_(0);
	}.defer;
	~cond_fr_xfade_manual.test = true;
	"Frente: Condition A_B_1 = true".postln;
	~cond_fr_xfade_manual.signal;
		routine.stop;
	});
	routine.play;
};


/// Función si se hace un XFade con tiempo manual directo de B a A. Llamda en ~fr_gui_btn_xfade

~f_fr_xfade_B_A_0 = { arg xfdur, xfade;
	var morph = xfdur, flecha=12, routine;
	~cond_fr_xfade_manual.test = false;
	{
		~fr_gui_btn_A.value = 1;
		~fr_gui_btn_B.value = 1;
		~fr_gui_tiempo_paisaje_txt.string_("--")
	}.defer;

		~f_fr_xfade.value(xfdur, xfade);
		"***f_fr_xfade_B_A_0".postln;
	routine = Routine({
	while({morph > 0.1},{
		{
			~fr_gui_xfade_dur.string_((morph).asInteger.asString);
			~fr_gui_btn_xfade.enabled_(false);
			~fr_gui_fl.value = flecha;
		}.defer;

			flecha = flecha + 1;
			if(flecha >= 12, {flecha = 6});
			morph = morph - 0.1;
			0.1.wait;
		});
		{
			~fr_gui_btn_xfade.enabled_(true);
			~fr_gui_btn_xfade.value_(0);
		}.defer;
	~cond_fr_xfade_manual.test = true;
	~cond_fr_xfade_manual.signal;
		// probar con hang y unhang
		routine.stop;
	});
	routine.play;

};

/////////////////////////////FUNCIÓN GENERAL PARA LA RUTINA DE FRENTE ////////////////////////////////


//thisProcess.interpreter.executeFile(PathName(thisProcess.nowExecutingPath).pathOnly ++ "selector_generativo_D90_b00.scd");
//~d90_selector_cat = \todo;
~f_fr_r = {
~r_fr = Routine({
	var morph_m=0, contador_1 = 0, contador_2=1, frag_psjB, frag_psjA, vent_final,  xfade_dur_psjA, xfade_dur_psjB, psjA, psjB, psA_W, psA_L, psA_R, psB_L, psB_R, trigger_xfade=false, ch_xfade_m=false, cat, sub_cat, i_paisaje;



	// Selección del primer paisaje sonoro para Frente
		~f_selector_fr.value;

	//Espera a que la función eliga una grabación.
		~cond_fr_1.wait;


	"*****************Frente 1************************".postln;

		//Carga la grabación selecionada en el lado A del SynthDef con XFade espectral

		psjA = ~fr_paisaje;
			("Frente psjA = " + psjA).postln;
			(0.1).wait;

			psA_L = Buffer.readChannel(s, psjA.path, channels:[0]);
			psA_R = Buffer.readChannel(s, psjA.path, channels:[1]);

			s.sync;


	"*********Frente 2*************".postln;


		///Selección de Paisaje B

		~f_selector_fr.value;
		~cond_fr_1.wait;


	"*****************Frente 3************************".postln;

		//Carga la grabación selecionada en los buffers de B del SynthDef con XFade espectral

			psjB = ~fr_paisaje;


		("Paisaje B Frente = " + psjB).postln;
	(0.1).wait;

		psB_L = Buffer.readChannel(s, psjB.path, channels:[0]);
		psB_R = Buffer.readChannel(s, psjB.path, channels:[1]);

	s.sync;


	"************Frente 4**************".postln;



//// Escoge al azar el tiempo que estará reproduciendo el paisaje A (debe incluir la duración del XFade, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones).


		frag_psjA = rrand(60, psjA.duration - 1);


		xfade_dur_psjB = rrand(60, frag_psjA);

		////////////////////////////////// INICIA REPRODUCCIÓN DE PAISAJE A con Fade-in ////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////


		~fr_synth = Synth('XFade_Stereo', [
		\out,~ambiBus[0],
		\spec_bufA_L,~fr_fft_bufA_L,
		\spec_bufA_R,~fr_fft_bufA_R,

		\spec_bufB_L,~fr_fft_bufB_L,
		\spec_bufB_R,~fr_fft_bufB_R,

		\soundBufA_L,psA_L,
		\soundBufA_R,psA_R,

		\soundBufB_L,psB_L,
		\soundBufB_R,psB_R,

		\amp, 0,
		\amp_lag, 0.01,

			\b_vol, ~b_vol[0]      //////////REVISAR que sirva

	],~ambiGroup[0], addAction:\addToHead);

		(0.1).wait;

		{
			var amp=~fr_gui_vol_value_in.string.asInteger/100, lag=~fr_gui_vol_tiempo_in.string.asInteger;
			~fr_synth.set(\amp,amp, \amp_lag,lag);
			~f_fr_vol_gui.value(amp, lag)
		}.defer;

		("Frente - Ahora suena A = " + psjA).postln;
		("Frente - Duración total de paisaje A = " + psjA.duration).postln;
		("Frente - Fragmento del paisaje A = " + frag_psjA).postln;
		("Frente - Duracion de transición a B = " + xfade_dur_psjB).postln;
		"~Frente_xfade -> 1".postln;
		("Frente_Paisaje B = " + psjB).postln;

		{
			~fr_gui_btn_A.value = 0;
			~fr_gui_btn_B.value = 2;
		}.defer;


		/////////////////////////// INICIA ESPERA PARA EL XFade ---> B ////////////////////////////////

		contador_1 = frag_psjA - xfade_dur_psjB;
		~fr_xfade_A_B = true;
		~fr_xfade_B_A = false;
		ch_xfade_m = false;
		{~fr_gui_btn_xfade.enabled_(true);
			~fr_gui_btn_xfade.value_(0);
		}.defer;


	"******************Frente 5******************".postln;

		while ({(trigger_xfade == false)},{
			{~fr_gui_tiempo_paisaje_txt.string_((contador_1.round(0.1)).asString)}.defer;
			contador_1 = contador_1 - 0.1;
			{
				~fr_gui_btn_A.value = 0;
				~fr_gui_btn_B.value = 2;
				~fr_gui_fl.value = 5;
			}.defer;

			if ((contador_1  <= 0),{
				trigger_xfade = true;
			});

			//// Si quiero mantener un XFade a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario hasta que haga el xfade manual a 1 (B)
			if(~fr_btn_xfade_check == true,{
				{
					~fr_gui_btn_A.value = 1;
					~fr_gui_btn_B.value = 1;
					~fr_gui_tiempo_paisaje_txt.string_("--");
				}.defer;
					"***Espero a f_fr_xfade_manual".postln;
					~cond_fr_xfade_manual.wait;
					ch_xfade_m = true;
					trigger_xfade = true;
					~fr_btn_xfade_check = false;
				});
				(0.1).wait;
			});

			trigger_xfade = false;

		////////////////////////////// INICIA EL MORPHING ---> B ///////////////////////////////////////////


//// El morphing a B se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje B a 1


		"********Frente 6********".postln;

	if(ch_xfade_m == false,{
		var flecha = 0;
		var dur_morph_B = xfade_dur_psjB;
			("Frente - transición a paisaje B = " + xfade_dur_psjB).postln;
			{
				~fr_gui_btn_xfade.enabled_(false);
				~fr_gui_btn_xfade.value_(2);
			}.defer;

			~fr_synth.set(\xfdur,xfade_dur_psjB.round(0.1), \xfade, 1);

			{
			~fr_gui_btn_A.value = 1;
			~fr_gui_btn_B.value = 1;
			}.defer;

		"***Frente XFade -> B (1) ".postln;


			//// Escoge al azar el tiempo que estará reproduciendo el paisaje B (debe incluir la duración del xfade, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones)

			frag_psjB = rrand(60, psjB.duration - 1);

			("Frente frag_psjB (1)= " + frag_psjB).postln;

			//// Escoge una duración de xfade de regreso a A

			xfade_dur_psjA = rrand(60, frag_psjB);

			("Frente xfade_dur_psjA (1) = " + xfade_dur_psjA).postln;

		while({dur_morph_B >= 0},
			{
				{~fr_gui_xfade_dur.string_((dur_morph_B).asInteger.asString)}.defer;
				{~fr_gui_fl.value = flecha}.defer;
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

		{~fr_gui_btn_xfade.enabled_(true);
		~fr_gui_btn_xfade.value_(0);
		}.defer;

		////////// Aquí inicia el bucle

		100.do{
			"*************Frente 7**************".postln;
			("Frente - Ahora suena B = " + psjB).postln;
			{~fr_gui_btn_A.value = 2;
				~fr_gui_btn_B.value = 0;
				~fr_gui_fl.value = 10;
			}.defer;

			("Frente - Duración total de paisaje B = " + psjB.duration).postln;
			("Frente - Fragmento del paisaje B = " + frag_psjB).postln;
			("Frente - Duración de transición al paisaje A = " + xfade_dur_psjA + "segundos").postln;

			/////// Selecciona una categoría y subcategoría para A.

			~f_selector_fr.value;
			~cond_fr_1.wait;

			s.sync;

			//// Carga el paisaje seleccionado en los buffers para A



			psjA = ~fr_paisaje;

			psA_L = Buffer.readChannel(s, psjA.path, channels:[0]);
			psA_R = Buffer.readChannel(s, psjA.path, channels:[1]);

			s.sync;

			("Frente - paisaje A = " + psjA).postln;


			//// Carga los Buffers de A en el synthdef
			~fr_synth.set(
				\soundBufA_L,psA_L,
				\soundBufA_R,psA_R
			);

			s.sync;


			//////////////////////////////// INICIA ESPERA PARA EL MORPHING ---> A ////////////////////////////

			contador_1 = frag_psjB - xfade_dur_psjA;
			~fr_xfade_A_B = false;
			~fr_xfade_B_A = true;
			ch_xfade_m = false;

			{~fr_gui_btn_xfade.enabled_(true);
				~fr_gui_btn_xfade.value_(0);
			}.defer;
			{
				~fr_gui_btn_A.value = 2;
				~fr_gui_btn_B.value = 0;
				~fr_gui_fl.value = 11;
			}.defer;

			//// Si quiero mantener un morphing a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario
		"Frente while (2)".postln;

	while({trigger_xfade == false},{
		{~fr_gui_tiempo_paisaje_txt.string_(contador_1.round(0.1).asString)}.defer;
				contador_1 = contador_1 - 0.1;
				if ((contador_1  <= 0),{
					trigger_xfade = true;
				});

				if(~fr_btn_xfade_check == true,{
					{
						~fr_gui_btn_A.value = 1;
						~fr_gui_btn_B.value = 1;
						~fr_gui_tiempo_paisaje_txt.string_("--");
					}.defer;
					"*****Frente: Espero a f_fr_xfade_manual".postln;
					~cond_fr_xfade_manual.wait;
					ch_xfade_m = true;
					trigger_xfade = true;
					~fr_btn_xfade_check = false;
				});
				(0.1).wait;
			});

		trigger_xfade = false;


			/////////////////////////////INICIA EL MORPHING ----> A ///////////////////////////////////


//// El morphing a A se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje A a 1
			"*************Frente 8 - XFade ---> A***********".postln;

		if(ch_xfade_m == false, {
			var dur_morph_A = xfade_dur_psjA, flecha = 6;
				("Frente xfade_dur_psjA = " + xfade_dur_psjA).postln;
				{
					~fr_gui_btn_xfade.enabled_(false);
					~fr_gui_btn_xfade.value_(2);
				}.defer;
			~fr_synth.set(\xfdur,xfade_dur_psjA, \xfade,0);

			{
			~fr_gui_btn_A.value = 1;
			~fr_gui_btn_B.value = 1;
			}.defer;


				//// Escoge al azar el tiempo que estará reproduciendo el paisaje A (debe incluir la duración del morphing, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones)


				frag_psjA = rrand(60, psjA.duration - 1);
				("Frente frag_psjA (2) = " + frag_psjA).postln;


				xfade_dur_psjB = rrand(60,frag_psjA);
				("Frente xfade_dur_psjB (2) = " + xfade_dur_psjB).postln;

				"***Frente Flechas XFade -> A ".postln;
			while({dur_morph_A >= 0},
			{
				dur_morph_A = dur_morph_A - 0.1;
				{~fr_gui_xfade_dur.string_((dur_morph_A).asInteger.asString)}.defer;
				{~fr_gui_fl.value = flecha}.defer;
				flecha = flecha + 1;
				if(flecha >=12, {flecha = 6});
				0.1.wait;
				});

		});

			morph_m = 0;
			ch_xfade_m = false;


			///////////////////////////// TERMINA MORPHING --> A. REPRODUCE A /////////////////////////////////
			{
				~fr_gui_btn_xfade.enabled_(true);
				~fr_gui_btn_xfade.value_(0);
			}.defer;
		"**********Frente 9**************".postln;
			("Frente- Ahora suena el paisaje A = " + psjA).postln;
			("Frente - Duración total de paisaje A = " + psjA.duration).postln;
			("Frente - Fragmento del paisaje A = " + frag_psjA).postln;
			("Frente - Duración de transición a paisaje B = " + xfade_dur_psjB + "segundos").postln;
			"Frente - xfade -> 1".postln;
		{
		~fr_gui_btn_A.value =0;
		~fr_gui_btn_B.value = 2;
		~fr_gui_fl.value = 5;
		}.defer;

			//("Frente - Tamaño de categorias = "+ ~categorias_fr.size).postln;

			/////// Selecciona una categoría y subcategoría para B.

			~f_selector_fr.value;
			~cond_fr_1.wait;

		"*******Frente 10********".postln;

			//// Selecciona un paisaje de la subcategoría seleccionada y lo carga a los buffers para B

			psjB = ~fr_paisaje;

			psB_L = Buffer.readChannel(s, psjB.path, channels:[0]);
			psB_R = Buffer.readChannel(s, psjB.path, channels:[1]);

		s.sync;

			//// Carga los Buffers de B en el synthdef
			~fr_synth.set(
				\soundBufB_L,psB_L,
				\soundBufB_R,psB_R,
			);

			//////////////////////////////////// INICIA ESPERA PARA COMENZAR EL MORPHING ----> B //////////////////////////////

			contador_1 = frag_psjA - xfade_dur_psjB;

			~fr_xfade_A_B = true;
			~fr_xfade_B_A = false;
			ch_xfade_m = false;

			{
				~fr_gui_btn_xfade.enabled_(true);
				~fr_gui_btn_xfade.value_(0);
				~fr_gui_btn_A.value = 0;
				~fr_gui_btn_B.value = 2;
				~fr_gui_fl.value = 5;
			}.defer;


//// Si quiero mantener un morphing a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario
			"*** Punto 15".postln;

			while ({(trigger_xfade == false)},{
				{~fr_gui_tiempo_paisaje_txt.string_((contador_1.round(0.1)).asString)}.defer;
				contador_1 = contador_1 - 0.1;
				if ((contador_1  <= 0),{
					trigger_xfade = true;
				});

				//// Si quiero mantener un morphing a la mitad(diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario hasta que haga el xfade manual a 1 (B)
				if(~fr_btn_xfade_check == true,{
					"***Frente Espero a f_fr_xfade_manual".postln;
					{
						~fr_gui_btn_A.value = 1;
						~fr_gui_btn_B.value = 1;
						~fr_gui_tiempo_paisaje_txt.string_("--");
					}.defer;
					~cond_fr_xfade_manual.wait;
					ch_xfade_m = true;
					trigger_xfade = true;
					~fr_btn_xfade_check = false;
				});
				(0.1).wait;
			});

			trigger_xfade = false;

			////////////////////////// INICIA MORPHING ---> B///////////////////////////////////

		"Frente - salgo de la espera al morphing -> B".postln;
		("Frente - Inicia Morphing --> B = " + xfade_dur_psjB + "segundos").postln;



			//// El morphing a B se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje B a 1


	if(ch_xfade_m == false, {
				var dur_morph_B = xfade_dur_psjB, flecha = 0;
				("Frente xfade_dur_psjB (3) = " + xfade_dur_psjB).postln;
				{
					~fr_gui_btn_xfade.enabled_(false);
					~fr_gui_btn_xfade.value_(2);
				}.defer;
				~fr_synth.set(\xfdur,xfade_dur_psjB.round(0.1), \xfade, 1);

		{
		~fr_gui_btn_A.value = 1;
		~fr_gui_btn_B.value = 1;
		}.defer;


				//// Escoge al azar el tiempo que estará reproduciendo el paisaje B (debe incluir la duración del morphing, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones) Inicia el morphing


		frag_psjB = rrand(60, psjB.duration - 1);

		//// Escoge una duración de morphing de regreso a A

		xfade_dur_psjA = rrand(60, frag_psjB);

			while({dur_morph_B >= 0},
			{
						dur_morph_B = dur_morph_B - 0.1;
						{~fr_gui_xfade_dur.string_((dur_morph_B).asInteger.asString)}.defer;
						{~fr_gui_fl.value = flecha}.defer;
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
			("Frente - frag_psjB (3a) = " + frag_psjB).postln;

			xfade_dur_psjA = rrand(60, frag_psjB);
			("Frente - xfade_dur_psjA (3a) = " + xfade_dur_psjA).postln;


			"***Fin del bucle".postln;

		};


	}).play;
};







/*
	"*****************Prueba 1************************".postln;


/// Verifica si esa subcategoría ya no tiene archivos disponbles
	while ({~fr_s_cat.size <= 0},
	{
		//~categorias[~fr_cat].removeAt(~fr_sub_cat);
		/// si se vacía una subcategoría, bloquear ese checkbox del GUI
			"while 1".postln;

		~f_gui_g_subcat_bloq.value(~fr_cat,~fr_sub_cat);


		//~f_gui_fr_subcat_bloq ={}.value;

		~f_selector_fr.value(~selector);
		(0.5).wait;
		};
	);
"*****************Prueba 2************************".postln;

	///// Selecciona un paisaje sonoro de la categoría y subcategoría previamente seleccionada y lo carga en los buffers

	~fr_i_paisaje = rrand(0, ~fr_s_cat.size-1);
	~fr_psjA = ~categorias[~fr_cat][~fr_sub_cat][~fr_i_paisaje];
	(0.1).wait;
	~fr_psjA_L = Buffer.readChannel(s,~fr_psjA.path, channels: [0]);
	~fr_psjA_R = Buffer.readChannel(s,~fr_psjA.path, channels: [1]);

	s.sync;

		//// Quita de la lista el paisaje que ya está cargado en los buffers de A

	    ("Frente - Seleccionado paisaje A. Se remueve " + (~fr_psjA)).postln;

	~categorias[~fr_cat][~fr_sub_cat].removeAt(~fr_i_paisaje);

	"*****************Prueba 3************************".postln;

	///Paisaje B

	~f_selector_fr.value(~selector);

	"*****************Prueba 4************************".postln;

	/// Verifica si esa subcategoría ya no tiene archivos disponbles
	while ({~fr_s_cat.size <= 0},{
		//~categorias[~fr_cat].removeAt(~fr_sub_cat);
		/// si se vacía una subcategoría, bloquear ese checkbox del GUI
		"while prueba 4".postln;

		~f_gui_g_subcat_bloq.value(~fr_cat,~fr_sub_cat);
		~f_gui_fr_subcat_bloq ={}.value;
		~f_selector_fr.value(~selector);
		(0.1).wait;
		});

"*****************Prueba 5************************".postln;
	///// Selecciona un paisaje sonoro de la categoría y subcategoría previamente seleccionada y lo carga en los buffers

	~fr_i_paisaje = rrand(0, ~fr_s_cat.size-1);
	~fr_psjB = ~categorias[~fr_cat][~fr_sub_cat][~fr_i_paisaje];
	(0.1).wait;
	~fr_psjB_L = Buffer.readChannel(s,~fr_psjB.path, channels: [0]);
	~fr_psjB_R = Buffer.readChannel(s,~fr_psjB.path, channels: [1]);

	s.sync;

		//// Quita de la lista el paisaje que ya está cargado en los buffers de A

	    ("Frente - Seleccionado paisaje A. Se remueve " + (~fr_psjB)).postln;

	~categorias[~fr_cat][~fr_sub_cat].removeAt(~fr_i_paisaje);

	"************Prueba 6**************".postln;




~fr_synth = Synth('Morph_Stereo',[
	\out, ~ambiBus[0],
		\b_vol, ~b_vol[0],
		\amp, 0,
		\amp_lag, 0.01,
	\spec_buf1L, ~fr_fft_bufA_L.bufnum,
	\spec_buf1R, ~fr_fft_bufA_R.bufnum,
	\spec_buf2L, ~fr_fft_bufB_L.bufnum,
	\spec_buf2R, ~fr_fft_bufB_R.bufnum,

	\soundBuf1L, ~fr_psjA_L,
	\soundBuf1R, ~fr_psjA_R,
	\soundBuf2L, ~fr_psjB_L,
	\soundBuf2R, ~fr_psjB_R,

],~ambiGroup[0], addAction:\addToHead);

(0.1).wait;

{~f_fr_vol.value(~fr_reloj_vol_v_txt.string.asInteger/100, ~fr_reloj_vol_t_txt.string.asInteger)}.defer;





//~fr_synth.set(\amp,~fr_vol_g, \amp_lag,~fr_vol_lag);



////////////////////////////////// INICIA REPRODUCCIÓN DE PAISAJE A ////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//// Escoge al azar el tiempo que estará reproduciendo el paisaje A (debe incluir la duración del morphing, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones), o a que yo cambie ~wait_xfade_Front, lo que suceda primero. Inicia el morphing.


	//~fr_vent_psjA = rrand(10, ~fr_psjA.duration - 1);  // versión para paisajes cortos
	~fr_vent_psjA = rrand(60, ~fr_psjA.duration - 1);

	//// Escoge al azar la duración del morphing al paisaje B
   // ~fr_morphB_dur = rrand(10,~fr_vent_psjA - 10);  // versión para paisajes cortos
	~fr_morphB_dur = rrand(60, ~fr_vent_psjA);



	"************1***************".postln;
	"Frente - Ahora suena A".postln;
	{~fr_gui_btn_A.value = 0;
	~fr_gui_btn_B.value = 2;

	}.defer;
	("Frente - Duración total de paisaje A = " + ~fr_psjA.duration).postln;
	("Frente - Ventana del paisaje A = " + ~fr_vent_psjA).postln;
	("Frente - Duracion del Morphing a B = " + ~fr_morphB_dur).postln;
	"~fr_xfade -> 1".postln;

/////////////////////////// INICIA ESPERA PARA INICIAR EL MORPHING ---> B ////////////////////////////////

		~fr_contador_1 = 0;
		~fr_contador_2 = 1;
		~fr_vent_final = ~fr_vent_psjA - ~fr_morphB_dur;
		~fr_xfade = 2;
		~fr_xfade_A_B = true;
		~fr_xfade_B_A = false;
		~fr_gui_btn_xfade_block = true;
		{~fr_gui_btn_xfade.enabled_(true);
			~fr_gui_btn_xfade.value_(0);
		}.defer;


//// Si quiero mantener un morphing a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario
	"while2".postln;
	while ({(~fr_trigger_xfade == false)},{	{~fr_reloj_trigger.string_((~fr_contador_1).round(0.1).asString)}.defer;
			~fr_contador_1 = ~fr_vent_final - ~fr_contador_2  ;
			~fr_contador_2 = ~fr_contador_2 + 0.1;
			{
				~fr_gui_btn_A.value = 0;
				~fr_gui_btn_B.value = 2;
				~fr_gui_fl.value = 5;
			}.defer;

		if ((~fr_xfade < 1) && (~fr_xfade > 0), {
			"Frente- Morphing modo manual".postln;
				{~fr_gui_btn_A.value = 1;
					~fr_gui_btn_B.value = 1;
					~fr_reloj_trigger.string_("--");
					~fr_gui_btn_xfade.enabled_(false);
					~fr_gui_btn_xfade.value_(1)
				}.defer;
				~fr_gui_btn_xfade_block = false;

			while ({((~fr_xfade) < 1) && ((~fr_xfade) > 0)},{

				(0.1).wait;
				if (~fr_xfade_m_t == true,{
						{
							var morph = ~fr_xfdur.asFloat;

						"while 3".postln;

							while({morph > 0.1},{
							morph = morph - 0.1;
								{~fr_gui_xfade_dur.string_(morph.round(0.1).asString);
							~fr_gui_btn_xfade.enabled_(false);
							~fr_gui_btn_xfade.value_(1)}.defer;
							0.1.wait;
					});
						{~fr_gui_btn_xfade.enabled_(true);
						~fr_gui_btn_xfade.value_(0)}.defer;
						}.fork;
						~fr_xfade_m_t = false;
					});

		});


				if(~fr_gui_btn_xfade_block == false,{
					while({~fr_xfade == 0},{(0.1).wait});
				});

		});


		if( (~fr_xfade == 1) , {   // Ya no hago el morphing a B con duración original. Lo hago con nueva duración manual
				var dur_morph_B = ~fr_xfdur, flecha = 0;
				morph_m = 1;

				{
					~fr_gui_btn_A.value = 1;
					~fr_gui_btn_B.value = 1;
				    ~fr_reloj_trigger.string_("--")

				}.defer;

			"while 5".postln;

				while({dur_morph_B > 0.1},
					{
						{
						~fr_gui_xfade_dur.string_((dur_morph_B).round(0.1).asString);
						~fr_gui_fl.value = flecha}.defer;

						flecha = flecha + 1;
					if(flecha >= 6, {flecha = 0});

						dur_morph_B = dur_morph_B - 0.1;
						0.1.wait;
					};
				);
		});





		//reloj_reinicia = false;

		if(morph_m == 1 , {
			~fr_trigger_xfade = true;
		});

		if ((~fr_contador_2  >= ~fr_vent_final),{
			~fr_trigger_xfade = true;
		});

		(0.1).wait;

});

		~fr_trigger_xfade = false;
		~fr_fmorph = false;
		~fr_xfade = 2;


////////////////////////////// INICIA EL MORPHING ---> B ///////////////////////////////////////////


//// El morphing a B se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje B a 1

	//~fr_morphB_dur.wait;

	if(morph_m != 1,{
		var flecha = 0;
		var dur_morph_B = ~fr_morphB_dur;
		{~fr_gui_btn_xfade.enabled_(false);
				~fr_gui_btn_xfade.value_(2);
			}.defer;
		//~fr_synth.set(\xfdur,~fr_morphB_dur, \xfade, 1);
		~fr_synth.set(\xfdur,~fr_morphB_dur.round(0.1), \morph, 1);
		//~fr_synth.set(\volB, 1, \vol_fade, ~fr_morphB_dur);
		~fr_synth.set(\volB, 1, \vol_B_lag, (~fr_morphB_dur/4).round(0.1));   // modificado el 23-12-21
			{
			~fr_gui_btn_A.value = 1;
			~fr_gui_btn_B.value = 1;
			}.defer;

		"while 6".postln;

		while({dur_morph_B >= 0},
			{
				{~fr_gui_xfade_dur.string_((dur_morph_B).round(0.1).asString)}.defer;
				{~fr_gui_fl.value = flecha}.defer;
				flecha = flecha + 1;
				if(flecha >=6, {flecha = 0});
				dur_morph_B = dur_morph_B - 0.1;
				0.1.wait;
			};
		);
	});

morph_m = 0;

//////////////////////////////// TERMINA EL MORPHING ---> B. REPRODUCE B //////////////////////////
		{~fr_gui_btn_xfade.enabled_(true);
		~fr_gui_btn_xfade.value_(0);
		}.defer;

////////// Aquí inicia el bucle


	100.do{

		//// Escoge al azar el tiempo que estará reproduciendo el paisaje B (debe incluir la duración del morphing, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones), o a que yo cambie ~wait_xfade_Front, lo que suceda primero. Inicia el morphing

	 	//~fr_frag_psjB = rrand(10, ~fr_psjB.duration - 1);   // versión para paisajes cortos
		~fr_frag_psjB = rrand(60, ~fr_psjB.duration - 1);

		//// Escoge una duración de morphing de regreso a A

		//~fr_xfadeA_dur = rrand(10,~fr_frag_psjB - 10);  // versión para paisajes cortos
		~fr_xfadeA_dur = rrand(60, ~fr_frag_psjB);


	"*************2**************".postln;
	"Frente - Ahora suena B".postln;
		{~fr_gui_btn_A.value = 2;
		~fr_gui_btn_B.value = 0;
		~fr_gui_fl.value = 10;
		}.defer;
	("Frente - Duración total de paisaje B = " + ~fr_psjB.duration).postln;
	("Frente- Ventana del paisaje B TRight = " + ~fr_frag_psjB).postln;
	("Frente- Morph ---> A = " + ~fr_xfadeA_dur + "segundos").postln;
	"Frente- xfade -> 0".postln;


/////// Selecciona una categoría, revisa si esa categoría ya está vacía. Si lo está, elige otra. Si no, la utiliza

		~f_selector_fr.value(~selector);
		(0.2).wait;

		//("Frente- Tamaño de categorias = "+ ~categorias.size).postln;


		"while 7".postln;

		while ({(~fr_s_cat.size <= 0)},{
			//~categorias.removeAt(~fr_cat);
			//~fr_cat = rrand(0,~categorias.size-1); /////Sustituir por pesos o métodos algorítmicos
			//("Frente - Tamaño de categorias - "+ ~categorias.size).postln;
			//"Se está ejecutando el nuevo while".postln;
			//~fr_s_cat = ~categorias[~fr_cat];

			~f_gui_g_subcat_bloq.value(~fr_cat,~fr_sub_cat);
			//~f_gui_fr_subcat_bloq ={}.value;
			~f_selector_fr.value(~selector);
			(0.1).wait;
			});

		s.sync;

//// Selecciona un paisaje de la categoría seleccionada y lo carga a los buffers para A

		~fr_i_paisaje = rrand(0, ~fr_s_cat.size-1);
		~fr_psjA = ~categorias[~fr_cat][~fr_sub_cat][~fr_i_paisaje];
		//("Frente- tamaño de la categoria "+ ~fr_i_paisaje + "= " + ~fr_s_cat.size).postln;

		~fr_psjA_L = Buffer.readChannel(s,~fr_psjA.path, channels: [0]);
		~fr_psjA_R = Buffer.readChannel(s,~fr_psjA.path, channels: [1]);

		s.sync;

		(~fr_psjA).postln;

//// Quita de la lista el paisaje que ya está cargado en los Buffers de A
		//("Frente- Se remueve " + (~fr_psjA)).postln;
		~categorias[~fr_cat][~fr_sub_cat].removeAt(~fr_i_paisaje);


//// Vuelve a leer los Buffers de A en el synthdef
		~fr_synth.set(\soundBuf1L, ~fr_psjA_L, \soundBuf1R, ~fr_psjA_R);




//////////////////////////////// INICIA ESPERA PARA EL MORPHING ---> A ////////////////////////////
			~fr_contador_1 = 0;
			~fr_contador_2 = 1;
			~fr_vent_final = ~fr_frag_psjB - ~fr_xfadeA_dur;
			~fr_xfade = 2;
			~fr_xfade_A_B = false;
			~fr_xfade_B_A = true;
			~fr_gui_btn_xfade_block = true;
			{~fr_gui_btn_xfade.enabled_(true);
				~fr_gui_btn_xfade.value_(0);
			}.defer;
//// Si quiero mantener un morphing a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario

		"while 8".postln;

	while({~fr_trigger_xfade == false},{
		{~fr_reloj_trigger.string_((~fr_contador_1).round(0.1).asString)}.defer;
		~fr_contador_2 = ~fr_contador_2+0.1;
		~fr_contador_1 = ~fr_vent_final-~fr_contador_2;
		{
			~fr_gui_btn_A.value = 2;
			~fr_gui_btn_B.value = 0;
			~fr_gui_fl.value = 11;
				}.defer;


		if ((~fr_xfade < 1) && (~fr_xfade > 0), {
			"Frente- Morphing modo manual".postln;
					~fr_gui_btn_xfade_block = false;
			{~fr_gui_btn_A.value = 1;
			~fr_gui_btn_B.value = 1;
			~fr_reloj_trigger.string_("--")}.defer;

				"while 9".postln;

			while({(~fr_xfade < 1) && (~fr_xfade > 0)},{
				(0.1).wait;

					// loop para la cuenta regresiva en la GUI

					if (~fr_xfade_m_t == true,{
						{
							var morph = ~fr_xfdur.asFloat;


								"while 10".postln;
							while({morph > 0.1},{
							morph = morph - 0.1;
							{~fr_gui_xfade_dur.string_((morph).round(0.1).asString);
										~fr_gui_btn_xfade.enabled_(false)}.defer;
							0.1.wait;
					});

						{~fr_gui_btn_xfade.enabled_(true);
						~fr_gui_btn_xfade.value_(0)}.defer;
						}.fork;
						~fr_xfade_m_t = false;
					});
		});

				});




		if((~fr_xfade == 0), {   // Ya no hago el morphing a A con duración original. Lo hago con nueva duración manual
				var dur_morph_A = ~fr_xfdur, flecha = 6;
				morph_m = 1;
				{
					~fr_gui_btn_A.value = 1;
					~fr_gui_btn_B.value = 1;
				    ~fr_reloj_trigger.string_("--")

				}.defer;


					"while 12".postln;
				while({dur_morph_A > 0.1},
					{

						{
						~fr_gui_xfade_dur.string_((dur_morph_A).round(0.1).asString);
						~fr_gui_fl.value = flecha}.defer;

						flecha = flecha + 1;
					if(flecha >= 12, {flecha = 6});

						dur_morph_A = dur_morph_A - 0.1;
						0.1.wait;
					};
				);
		});


				if(~fr_gui_btn_xfade_block == false,{
					while({~fr_xfade == 1},{(0.1).wait});
				});



		//reloj_reinicia = false;

		if(morph_m == 1 , {
			~fr_trigger_xfade = true;
		});

		if ((~fr_contador_2 >= ~fr_vent_final),{
			~fr_trigger_xfade = true;
		});

		(0.1).wait;

});

		~fr_trigger_xfade = false;
		~fr_fmorph = false;
		~fr_xfade = 2;


/////////////////////////////INICIA EL MORPHING ----> A ///////////////////////////////////


//// El morphing a A se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje A a 1

		if(morph_m !=1) {
			var dur_morph_A = ~fr_xfadeA_dur, flecha = 6;
			{~fr_gui_btn_xfade.enabled_(false);
					~fr_gui_btn_xfade.value_(2);
				}.defer;
			~fr_synth.set(\xfdur,~fr_xfadeA_dur.round(0.1), \morph,0);
			//~fr_synth.set(\volA, 1, \vol_fade, ~fr_xfadeA_dur); modificado el 23-12-21
			~fr_synth.set(\volA, 1, \vol_A_lag, (~fr_xfadeA_dur/4).round(0.1));
			{
			~fr_gui_btn_A.value = 1;
			~fr_gui_btn_B.value = 1;
			}.defer;


				"while 13".postln;
			while({dur_morph_A >= 0},
			{

				dur_morph_A = dur_morph_A - 0.1;
				{~fr_gui_xfade_dur.string_((dur_morph_A).round(0.1).asString)}.defer;
				{~fr_gui_fl.value = flecha}.defer;
				flecha = flecha + 1;
				if(flecha >=12, {flecha = 6});
				0.1.wait;
			};
			);


		};
morph_m = 0;

///////////////////////////// TERMINA MORPHING --> A. REPRODUCE A /////////////////////////////////
		{~fr_gui_btn_xfade.enabled_(true);
				~fr_gui_btn_xfade.value_(0);
			}.defer;
		"**********3**************".postln;
		"Frente- Ahora suena el paisaje A".postln;
		{
		~fr_gui_btn_A.value =0;
		~fr_gui_btn_B.value = 2;
		~fr_gui_fl.value = 5;
		}.defer;
		("Frente- Tamaño de categorias = "+ ~categorias.size).postln;
		("Frente- tamaño de la categoria "+ ~fr_i_paisaje + "= " + ~fr_s_cat.size).postln;
		("Frente- Se remueve " + (~fr_psjA)).postln;


		//// Escoge al azar el tiempo que estará reproduciendo el paisaje A (debe incluir la duración del morphing, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones), o a que yo cambie ~wait_xfade_Front, lo que suceda primero. Inicia el morphing.


	    //~fr_vent_psjA = rrand(10, ~fr_psjA.duration - 1);  // versión para paisajes cortos
		~fr_vent_psjA = rrand(60, ~fr_psjA.duration - 1);

		//// Escoge al azar la duración del morphing al paisaje B
		//~fr_morphB_dur = rrand(10,~fr_vent_psjA - 10);   /// versión para paisajes cortos
		~fr_morphB_dur = rrand(60,~fr_vent_psjA);

		("Frente- Duración del paisaje A = " + ~fr_psjA.duration).postln;
	    ("Ventana del paisaje A TRight = " + ~fr_vent_psjA).postln;
		//("Frente- Morph ---> B = " + ~fr_morphB_dur + "segundos").postln;
	     "Frente- xfade -> 1".postln;



/////// Selecciona una categoría, revisa si esa categoría ya está vacía. Si lo está, elige otra. Si no, la utiliza
		//~fr_cat = rrand(0,~categorias.size-1); /////Sustituir por pesos o métodos algorítmicos
		//("Frente - Tamaño de categorias - "+ ~categorias.size).postln;
		~f_selector_fr.value(~selector);
		(0.2).wait;

		"while 14".postln;

		while ({~fr_s_cat.size <= 0},{
			//~categorias.removeAt(~fr_cat);
			//~fr_cat = rrand(0,~categorias.size-1); /////Sustituir por pesos o métodos algorítmicos
			//("Frente - Tamaño de categorias - "+ ~categorias.size).postln;
			//"Se está ejecutando el nuevo while".postln;
			//~fr_s_cat = ~categorias[~fr_cat];

		~f_gui_g_subcat_bloq.value(~fr_cat,~fr_sub_cat);
			//~f_gui_fr_subcat_bloq ={}.value;
			~f_selector_fr.value(~selector);
			(0.1).wait;

			});

		s.sync;

//// Selecciona un paisaje de la categoría seleccionada y lo carga a los buffers para B
		~fr_i_paisaje = rrand(0, ~fr_s_cat.size-1);/////Sustituir por pesos o métodos algorítmicos
		~fr_psjB = ~categorias[~fr_cat][~fr_sub_cat][~fr_i_paisaje];
		//("Frente - tamaño de la categoria"+ ~fr_i_paisaje + "= " + ~fr_s_cat.size).postln;

		~fr_psjB_L = Buffer.readChannel(s,~fr_psjB.path, channels: [0]);
		~fr_psjB_R = Buffer.readChannel(s,~fr_psjB.path, channels: [1]);
		s.sync;

//// Quita de la lista el paisaje que ya está cargado en los buffers de B

		~categorias[~fr_cat][~fr_sub_cat].removeAt(~fr_i_paisaje);


//// Vuelve a leer los Buffers de B en el synthdef
	~fr_synth.set(\soundBuf2L, ~fr_psjB_L, \soundBuf2R, ~fr_psjB_R);




//////////////////////////////////// INICIA ESPERA PARA COMENZAR EL MORPHING ----> B //////////////////////////////

			~fr_contador_1 = 0;
			~fr_contador_2 = 1;
			~fr_c = 1;
			~fr_vent_final = ~fr_vent_psjA - ~fr_morphB_dur;
			~fr_xfade = 2; //el morphing parte de A
			~fr_xfade_A_B = true;
			~fr_xfade_B_A = false;
			~fr_gui_btn_xfade_block = true;
			{~fr_gui_btn_xfade.enabled_(true);
				~fr_gui_btn_xfade.value_(0);
			}.defer;

//// Si quiero mantener un morphing a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario
			"while 15".postln;

	while ({(~fr_trigger_xfade == false)},{
		{~fr_reloj_trigger.string_((~fr_contador_1).round(0.1).asString)}.defer;
		~fr_contador_2 = ~fr_contador_2 + 0.1;
		~fr_contador_1 = ~fr_vent_final - ~fr_contador_2;
		{
			~fr_gui_btn_A.value = 0;
			~fr_gui_btn_B.value = 2;
			~fr_gui_fl.value = 5;
				}.defer;

		if ((~fr_xfade < 1) && (~fr_xfade > 0), {
			"Frente - Morphing modo manual".postln;
					~fr_gui_btn_xfade_block = false;
			{~fr_gui_btn_A.value = 1;
			~fr_gui_btn_B.value = 1;
			~fr_reloj_trigger.string_("--")}.defer;

					"while 16".postln;
			while ({(~fr_xfade < 1) && (~fr_xfade > 0)},{
				(0.1).wait;
					if (~fr_xfade_m_t == true,{
						{
							var morph = ~fr_xfdur;
								"while 17".postln;

							while({morph > 0.1},{
								morph = morph - 0.1;
								{~fr_gui_xfade_dur.string_((morph).round(0.1).asString);
								~fr_gui_btn_xfade.enabled_(false)}.defer;

								0.1.wait;
						});
						{~fr_gui_btn_xfade.enabled_(true);
						~fr_gui_btn_xfade.value_(0)}.defer

						}.fork;
						~fr_xfade_m_t = false;
						});

					});
				});





		if((~fr_xfade == 1) , {   // Ya no hago el morphing a B con duración original. Lo hago con nueva duración manual
				var dur_morph_B = ~fr_xfdur, flecha = 0;
				morph_m = 1;
				{
					~fr_gui_btn_A.value = 1;
					~fr_gui_btn_B.value = 1;
				    ~fr_reloj_trigger.string_("--")

				}.defer;

					"while 19".postln;
				while({dur_morph_B > 0.1},
					{
						{
						~fr_gui_xfade_dur.string_((dur_morph_B).round(0.1).asString);
						~fr_gui_fl.value = flecha}.defer;

						flecha = flecha + 1;
					if(flecha >= 6, {flecha = 0});

						dur_morph_B = dur_morph_B - 0.1;
						0.1.wait;
					};
				);
					~fr_xfade = 2;
		});


				if(~fr_gui_btn_xfade_block == false,{
				while({~fr_xfade == 0},{(0.1).wait});
				});



		//reloj_reinicia = false;

		if(morph_m == 1 , {
			~fr_trigger_xfade = true;
		});

		if ((~fr_contador_2 >= ~fr_vent_final),{
			~fr_trigger_xfade = true;
		});

		(0.1).wait;

});

			~fr_trigger_xfade = false;
			~fr_fmorph = false;
			~fr_xfade = 2;



////////////////////////// INICIA MORPHING ---> B. REPRODUCE B ///////////////////////////////////
		{~fr_gui_btn_xfade.enabled_(false);
				~fr_gui_btn_xfade.value_(2);
			}.defer;
		"Frente - salgo de la espera al morphing -> B".postln;
		("Frente- Inicia Morphing --> B = " + ~fr_morphB_dur + "segundos").postln;
		"Frente- ~fr_xfade -> 1".postln;


//// El morphing a B se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje B a 1


	if(morph_m != 1) {
		var dur_morph_B = ~fr_morphB_dur, flecha = 0;
		//~fr_synth.set(\xfdur,~fr_morphB_dur, \xfade, 1);
			~fr_synth.set(\xfdur,~fr_morphB_dur.round(0.1), \morph, 1);
		//~fr_synth.set(\volB, 1, \vol_fade, ~fr_morphB_dur);   modificado el 21-12-21
			~fr_synth.set(\volB, 1, \vol_B_lag, (~fr_morphB_dur/4).round(0.1));
		{
		~fr_gui_btn_A.value = 1;
		~fr_gui_btn_B.value = 1;
		}.defer;
		while({dur_morph_B >= 0},
			{			{~fr_gui_xfade_dur.string_((dur_morph_B).round(0.1).asString)}.defer;
						dur_morph_B = dur_morph_B - 0.1;
						{~fr_gui_fl.value = flecha}.defer;
						flecha = flecha + 1;
						if(flecha >=6, {flecha = 0});
						0.1.wait;
			};
		);

	};

morph_m = 0;



	}; ///Termina el bucle
}).play;


~relojes.onClose = {~r_fr.stop; ~b_vol_fr_r.stop; Buffer.freeAll; s.freeAll };

};
)
 */