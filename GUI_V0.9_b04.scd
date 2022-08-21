

			~subcat_check = {arg val,cat,subcat;
	"subcat_check".postln;
	switch(cat,
		0, {~switch_general_naturaleza.value(subcat, val.asBoolean)},
		1, {~switch_general_sociedad.value(subcat, val.asBoolean)},
		2, {~switch_general_artilugios.value(subcat, val.asBoolean)}
	);
};


//Función para bloquear una categoría estéreo en la GUI si todas sus subcategorías están vacías
~f_gui_cat_st_bloq = { arg cat;
	switch(cat,
		0, {

		}
	)

};


///Función para bloquear en la GUI subcategorías estéreo cuando estén vacías durante la presentación
~f_gui_g_subcat_bloq = { arg cat, subcat;
	switch (cat,
		0, {{~gui_array_subc_nature[subcat].enabled_(false).valueAction_(false)}.defer; "cat0".postln},
		1, {{~gui_array_subc_soc[subcat].enabled_(false).valueAction_(false)}.defer; "cat1".postln},
		2, {{~gui_array_subc_arti[subcat].enabled_(false).valueAction_(false)}.defer; "cat2".postln},
		3, {{~gui_array_subc_silencio[subcat].enabled_(false).valueAction_(false)}.defer;
			~f_gui_cat_bloq.value(cat);
			("quietud y silencio -> " + subcat + "bloqueada").postln}
)};







/// GUI de selector de categorías y subcategorías estéreo

~func_gui_cat_g = {
			var ww = 900, hw = 100, title, compv_cat, compv_natur, compv_human, compv_soc, compv_arti, compv_silencio, cat_natur_subcat, cat_human_subcat, cat_soc_subcat, cat_arti_subcat, cat_silencio_subcat, btn, chkb_todo, chkb_natur, chkb_human, chkb_soc, chkb_arti, chkb_silencio;
	if(~gui_cat_g != nil){
	~gui_cat_g.close};

				~gui_cat_g = Window.new("Categorías estéreo",Rect(ww,hw,960,490),false);
			~gui_cat_g.alwaysOnTop_(true);
			~gui_cat_g.alpha_(0.9);
			~gui_cat_g.front;
				title = StaticText.new(~gui_cat_g, Rect(((ww/2)-85),10,95,45)).string_("Categorías estéreo");
			title.font = Font("Times New Roman", 18, true);
				~gui_cat_g_hide = Button.new(~gui_cat_g,Rect(((ww/2)+55),10,45,25));
				~gui_cat_g_hide.states = ([
					["Hide", Color.black]
				]);
				~gui_cat_g_hide.action = {~gui_cat_g.visible_(false);
						~relojes_cat_gen_bt.valueAction_(0);
				};


				compv_cat = CompositeView(~gui_cat_g,Rect(20,105,920,400-30));
				compv_cat.background = Color.white.alpha_(0.8);
				compv_cat.decorator = FlowLayout(compv_cat.bounds,10@10,10@10);

				compv_natur = CompositeView(compv_cat, 148@260);
				compv_natur.decorator = FlowLayout(compv_natur.bounds,10@10,10@5);
				compv_natur.background = Color.green.alpha_(0.3);

				chkb_natur = CheckBox.new(compv_natur, 130@35, "Naturaleza");
				chkb_natur.font = Font("Times New Roman", 14, true);
				chkb_natur.value = true;

				cat_natur_subcat = ["Agua", "Aire", "Tierra", "Fuego", "Plantas", "Animales", "Ecosistemas"];
				~gui_array_subc_nature = Array.fill(7, {arg i; CheckBox.new(compv_natur, 130@20, cat_natur_subcat[i])});
	~gui_array_subc_nature.do({ arg item, index;
					item.value = true;

	});


	chkb_natur.action = {
		if(chkb_natur.value == true, {
			~gui_array_subc_nature.do({arg item;
				if(item.enabled == true, {
					item.value = true;
				});

			});
			~categorias_st.add(\naturaleza -> ~st_naturaleza);
		},{
			~gui_array_subc_nature.do({arg item;
				item.value = false;
			});
			~categorias_st.removeAt(\naturaleza);
		})
				};


				compv_human = CompositeView(compv_cat, 148@260);
				compv_human.decorator = FlowLayout(compv_human.bounds,10@10,10@5);
				compv_human.background = Color.yellow.alpha_(0.3);

	//////////revisar variable chkb_human y cambiarla por una global. Revisar también las variables de checkboxes de cada categoría

	chkb_human = CheckBox.new(compv_human, 130@35, "Cuerpo Humano");
				chkb_human.font = Font("Times New Roman", 14, true);
				chkb_human.value = true;
				cat_human_subcat = ["Movimiento corporal", "Boca/Voz", "Respiración", "Sonidos internos"];
				~gui_array_subc_human = Array.fill(4, {arg i; CheckBox.new(compv_human, 130@20, cat_human_subcat[i])});
				~gui_array_subc_human.do({ arg item, index;
					item.value = true;
					item.action = {
						if(item.value == true, {
							chkb_human.value = true;
						});
			~gui_array_ambix_subc_human[index].valueAction = item.value;
						~subcat_check.value(item.value, 1, index);
						index.postln;
						item.value.postln;
					};
					});
				chkb_human.action = {
		~chkb_ambi_human.valueAction = chkb_human.value;
		~gui_array_subc_human.do({ arg item, index;
						item.valueAction = chkb_human.value;
					});
		~gui_array_ambix_subc_human.do({ arg item, index;
						item.valueAction = chkb_human.value;
					});
		if(chkb_human.value == false,{
			~categorias_st.removeAt(\humano);
			//~categorias_ambi.removeAt(\humano);
		},{
			~categorias_st.add(\humano -> ~humano);
			//~categorias_ambi.add(\humano -> ~ambi_humano);
		});

				};


				compv_soc = CompositeView(compv_cat, 168@350);
				compv_soc.decorator = FlowLayout(compv_soc.bounds,10@10,10@5);
				compv_soc.background = Color.blue.alpha_(0.3);
				chkb_soc = CheckBox.new(compv_soc, 130@35, "Sociedad");
				chkb_soc.font = Font("Times New Roman", 14, true);
				chkb_soc.value = true;
				cat_soc_subcat = ["Regiones rurales", "Ciudad", "Puertos", "Ámbito doméstico", "Oficinas", "Fábricas", "Otros lugares de trabajo", "Entretenimiento", "Muchedumbres", "Ceremonias", "Parques y jardines", "Indicadores sonoros"];
				~gui_array_subc_soc = Array.fill(12, {arg i; CheckBox.new(compv_soc, 140@20, cat_soc_subcat[i])});
				~gui_array_subc_soc.do({ arg item, index;
					item.value = true;
					item.action = {
						if(item.value == true, {
							chkb_soc.value = true;
						});
			~gui_array_ambix_subc_soc[index].valueAction = item.value;
						~subcat_check.value(item.value, 2, index);
						index.postln;
						item.value.postln;
					};
					});
				chkb_soc.action = {
		~chkb_ambi_soc.valueAction = chkb_soc.value;
		~gui_array_subc_soc.do({ arg item, index;
			item.valueAction = chkb_soc.value;});
		~gui_array_ambix_subc_soc.do({ arg item, index;
			item.valueAction = chkb_soc.value});
		if(chkb_soc.value == false,{
			~categorias_st.removeAt(\sociedad);
			//~categorias_ambi.removeAt(\sociedad);
		},{
			~categorias_st.add(\sociedad -> ~sociedad);
			//~categorias_ambi.add(\sociedad -> ~ambi_sociedad);
		});
	};

				compv_arti = CompositeView(compv_cat, 228@260);
				compv_arti.decorator = FlowLayout(compv_arti.bounds,10@10,10@5);
				compv_arti.background = Color.black.alpha_(0.3);
				chkb_arti = CheckBox.new(compv_arti, 150@35, "Artilugios mecánicos");
				chkb_arti.font = Font("Times New Roman", 14, true);
				chkb_arti.value = true;
				cat_arti_subcat = ["Mecanismos varios", "Maquinaria industrial", "Transportes", "Máquinas de guerra", "Maquinaria de construcción/demolición", "Ventiladores/aires acondicionados", "Herramientas"];
				~gui_array_subc_arti = Array.fill(7, {arg i; CheckBox.new(compv_arti, 205@20, cat_arti_subcat[i])});
				~gui_array_subc_arti.do({ arg item, index;
					item.value = true;
					item.action = {
						if(item.value == true, {
							chkb_arti.value = true;
						});
			~gui_array_ambix_subc_arti[index].valueAction = item.value;
						~subcat_check.value(item.value, 3, index);
						index.postln;
						item.value.postln;
					};
					});
				chkb_arti.action = {
		~chkb_ambi_arti.valueAction = chkb_arti.value;
		~gui_array_subc_arti.do({ arg item, index;
						item.valueAction = chkb_arti.value});
		~gui_array_ambix_subc_arti.do({ arg item, index;
						item.valueAction = chkb_arti.value;
					});
		if(chkb_arti.value == false,{
			~categorias_st.removeAt(\artilugios);
			//~categorias_ambi.removeAt(\artilugios);
		},{
			~categorias_st.add(\artilugios -> ~artilugios);
			//~categorias_ambi.add(\artilugios -> ~ambi_artilugios);
		});
				};


				compv_silencio = CompositeView(compv_cat, 168@260);
				compv_silencio.decorator = FlowLayout(compv_silencio.bounds,10@10,10@5);
				compv_silencio.background = Color.fromHexString("#FF9305").alpha_(0.5);
				chkb_silencio = CheckBox.new(compv_silencio, 150@35, "Quietud y silencio");
				chkb_silencio.font = Font("Times New Roman", 14, true);
				chkb_silencio.value = true;
				cat_silencio_subcat = ["Hum", "Espacios vacíos"];
				~gui_array_subc_silencio = Array.fill(2, {arg i; CheckBox.new(compv_silencio, 205@20, cat_silencio_subcat[i])});
				~gui_array_subc_silencio.do({ arg item, index;
					item.value = true;
					item.action = {
						if(item.value == true, {
							chkb_silencio.value = true;
						});
			~gui_array_ambix_subc_silencio[index].valueAction = item.value;
						~subcat_check.value(item.value, 4, index);
						index.postln;
						item.value.postln;
					};
					});
				chkb_silencio.action = {
		~chkb_ambi_silencio.valueAction = chkb_silencio.value;
		~gui_array_subc_silencio.do({ arg item, index;
			item.valueAction = chkb_silencio.value});
		~gui_array_ambix_subc_silencio.do({ arg item, index;
			item.valueAction = chkb_silencio.value;
					});
		if(chkb_silencio.value == false, {
			~categorias_st.removeAt(\quietud);
			//~categorias_ambi.removeAt(\quietud);
	}, {
			~categorias_st.add(\quietud -> ~quietud);
			//~categorias_ambi.add(\quietud -> ~ambi_quietud);
					});
				};


				~gui_aceptar = Button.new(~gui_cat_g,Rect(((ww/2)-15),69,100,24));
				~gui_aceptar.states = ([
			["Aceptar", Color.black, Color.red.alpha_(0.5)]
		]);
	~gui_aceptar.font = Font("Times New Roman", 12, true);
	~gui_aceptar.action = {

		//Lee los checkboxes de categorías y quita o agrega los correspondientes al diccionario de categorías

		if(chkb_natur.value == false,{
			~categorias_st.removeAt(\naturaleza);
			//~categorias_ambi.removeAt(\naturaleza);
		},{
			~categorias_st.add(\naturaleza -> ~st_naturaleza);
			//~categorias_ambi.add(\naturaleza -> ~ambi_naturaleza);

			// Lee los checkboxes de subcategorías y quita o agrega los correspondientes a los diccionarios de subcategorías

			//~gui_array_subc_nature.do({ arg item, index;
			//	~switch_general_naturaleza.value(index, item.value);
		//|});
		});
};

};








///// GUI de selector de categorías y subcategorías AmbiX

~f_gui_ambix_cat = {
			var ww = 900, hw = 100, title, compv_cat, compv_natur, compv_human, compv_soc, compv_arti, compv_silencio, cat_natur_subcat, cat_human_subcat, cat_soc_subcat, cat_arti_subcat, cat_silencio_subcat, btn, chkb_todo, chkb_natur, chkb_human, chkb_soc, chkb_arti, chkb_silencio,
	aceptar;
	if(~gui_cat_ambix != nil, {
		~gui_cat_ambix.close});

				~gui_cat_ambix = Window.new("Categorías - paisajes sonoros ambisónicos",Rect(ww,hw,800,490),false);
			~gui_cat_ambix.alwaysOnTop_(true);
			~gui_cat_ambix.alpha_(0.9);
			~gui_cat_ambix.front;
				title = StaticText.new(~gui_cat_ambix, Rect(((ww/2)-105),10,175,45)).string_("Categorías - Paisajes sonoros ambisónicos");
			title.font = Font("Times New Roman", 18, true);
				~gui_cat_ambix_hide = Button.new(~gui_cat_ambix,Rect(((ww/2)+155),10,55,25));
				~gui_cat_ambix_hide.states = ([
					["Ocultar", Color.black]
				]);
				~gui_cat_ambix_hide.action = {~gui_cat_ambix.visible_(false);
						~relojes_cat_ambix_bt.valueAction_(0);
				};



				compv_cat = CompositeView(~gui_cat_ambix,Rect(20,105,920,400));
				compv_cat.background = Color.white.alpha_(0.8);
				compv_cat.decorator = FlowLayout(compv_cat.bounds,10@10,10@10);

				compv_natur = CompositeView(compv_cat, 148@260);
				compv_natur.decorator = FlowLayout(compv_natur.bounds,10@10,10@5);
				compv_natur.background = Color.green.alpha_(0.3);


				~gui_ambix_chkb_natur = CheckBox.new(compv_natur, 130@35, "Naturaleza");
				~gui_ambix_chkb_natur.font = Font("Times New Roman", 14, true);
				~gui_ambix_chkb_natur.value = true;

	//Checkboxes de subcategorías de naturaleza
	cat_natur_subcat = ["Agua", "Aire", "Tierra", "Fuego", "Plantas", "Animales", "Humanos", "Ecosistemas"];
				~gui_array_ambix_subc_nature = Array.fill(8, {arg i; CheckBox.new(compv_natur, 130@20, cat_natur_subcat[i])});
	~gui_array_ambix_subc_nature.do({ arg item, index;
		item.value = true;
		item.action = {
			~switch_ambix_naturaleza.value(index, item.value);
			if(item.value == true && ~gui_ambix_chkb_natur.value == false, {
				~gui_ambix_chkb_natur.value = true;
				~categorias_ambi.add(\naturaleza -> ~ambi_naturaleza);
			});

			("~gui_array_ambix_subc_nature.do index" + index).postln;
			("~gui_array_ambix_subc_nature.do item" + item.value).postln;
		};
	});

	//Checkbox de categoría Naturaleza

	~gui_ambix_chkb_natur.action = {
		 if(~gui_ambix_chkb_natur.value == false, {
					~gui_array_ambix_subc_nature.do({ arg item, index;
						item.value = false;
				~switch_ambix_naturaleza.value(index, item.value);
					});
			~categorias_ambi.removeAt(\naturaleza);
				},
		{
			// Activa los checkboxes de subcategorías de naturaleza si no están deshabilitados

			~gui_array_ambix_subc_nature.do({ arg item, index;
				if(item.enabled == true, {
					item.value = true;
					~switch_ambix_naturaleza.value(index, item.value);

				});
				~categorias_ambi.add(\naturaleza -> ~ambi_naturaleza);
					});
				});
				};

// Sociedad

				compv_soc = CompositeView(compv_cat, 168@350);
				compv_soc.decorator = FlowLayout(compv_soc.bounds,10@10,10@5);
				compv_soc.background = Color.blue.alpha_(0.3);
				~chkb_ambi_soc = CheckBox.new(compv_soc, 130@35, "Sociedad");
				~chkb_ambi_soc.font = Font("Times New Roman", 14, true);
				~chkb_ambi_soc.value = true;
				cat_soc_subcat = ["Regiones rurales", "Ciudad", "Puertos", "Ámbito doméstico", "Oficinas", "Fábricas", "Otros lugares de trabajo", "Entretenimiento", "Muchedumbres", "Ceremonias", "Parques y jardines", "Indicadores sonoros"];
				~gui_array_ambix_subc_soc = Array.fill(12, {arg i; CheckBox.new(compv_soc, 140@20, cat_soc_subcat[i])});
	~gui_array_ambix_subc_soc.do({ arg item, index;
		item.value = true;
		item.action = {
			~switch_ambix_sociedad.value(index, item.value);
			if(item.value == true, {
				~chkb_ambi_soc.value = true;
				~categorias_ambi.add(\sociedad -> ~ambi_sociedad);
			});

			("~gui_array_ambix_subc_soc index" + index).postln;
			("~gui_array_ambix_subc_soc.do item" + item.value).postln;
		};
	});



	~chkb_ambi_soc.action = { var c_ambix_subc_soc = 0;
		if(~chkb_ambi_soc.value == false, {
			~gui_array_ambix_subc_soc.do({ arg item, index;
				item.value = false;
				~switch_ambix_sociedad.value(index, item.value);
			});
			~categorias_ambi.removeAt(\sociedad);
		},

		// Activa los checkboxes de subcategorías de sociedad si no están deshabilitados
		{
			~gui_array_ambix_subc_soc.do({ arg item, index;
				if(item.enabled == true, {
					item.value = true;
					~switch_ambix_sociedad.value(index, item.value);
					c_ambix_subc_soc = c_ambix_subc_soc + 1;
				});
				~categorias_ambi.add(\sociedad -> ~ambi_sociedad);
			});
	};
		);
	};

/// Artilugios Mecánicos

				compv_arti = CompositeView(compv_cat, 228@260);
				compv_arti.decorator = FlowLayout(compv_arti.bounds,10@10,10@5);
				compv_arti.background = Color.black.alpha_(0.3);
				~chkb_ambi_arti = CheckBox.new(compv_arti, 150@35, "Artilugios mecánicos");
				~chkb_ambi_arti.font = Font("Times New Roman", 14, true);
				~chkb_ambi_arti.value = true;
				cat_arti_subcat = ["Mecanismos varios", "Maquinaria industrial", "Transportes", "Máquinas de guerra", "Maquinaria de construcción/demolición", "Ventiladores/aires acondicionados", "Herramientas"];
				~gui_array_ambix_subc_arti = Array.fill(7, {arg i; CheckBox.new(compv_arti, 205@20, cat_arti_subcat[i])});

	// Checkboxes de subcategorías de Artilugios mecánicos

	~gui_array_ambix_subc_arti.do({ arg item, index;
		item.value = true;
		item.action = {
			~switch_ambix_artilugios.value(index, item.value);
			if(item.value == true && ~chkb_ambi_arti.value == false, {
				~chkb_ambi_arti.value = true;
				~categorias_ambi.add(\artilugios -> ~ambi_artilugios);
						});

			("~gui_array_ambix_subc_arti index" + index).postln;
			("~gui_array_ambix_subc_arti.do item" + item.value).postln;
		};
	});

	~chkb_ambi_arti.action = {var c_ambix_subc_arti = 0;
		"GUI - ~chkb_ambi_arti.action".postln;
		if(~chkb_ambi_arti.value == false, {
			~gui_array_ambix_subc_arti.do({ arg item, index;
				item.value = false;
				~switch_ambix_artilugios.value(index, item.value);
			});
			~categorias_ambi.removeAt(\artilugios);
		}, {
			~gui_array_ambix_subc_arti.do({ arg item, index;
				if(item.enabled == true, {
					item.value = true;
					~switch_ambix_artilugios.value(index, item.value);
					c_ambix_subc_arti = c_ambix_subc_arti + 1;
				});

			});
			~categorias_ambi.add(\artilugios -> ~ambi_artilugios);
				});
				};

/// Quietud y silencio

				compv_silencio = CompositeView(compv_cat, 168@260);
				compv_silencio.decorator = FlowLayout(compv_silencio.bounds,10@10,10@5);
				compv_silencio.background = Color.fromHexString("#FF9305").alpha_(0.5);
				~chkb_ambi_silencio = CheckBox.new(compv_silencio, 150@35, "Quietud y silencio");
				~chkb_ambi_silencio.font = Font("Times New Roman", 14, true);
				~chkb_ambi_silencio.value = true;
				cat_silencio_subcat = ["Hum", "Espacios vacíos"];
				~gui_array_ambix_subc_silencio = Array.fill(2, {arg i; CheckBox.new(compv_silencio, 205@20, cat_silencio_subcat[i])});

	//Botones de subcategorías de Quietud y silencio

	~gui_array_ambix_subc_silencio.do({ arg item, index;
		item.value = true;
		item.action = {
			~switch_ambix_quietud.value(index, item.value);
			if(item.value == true, {
				~chkb_ambi_silencio.value = true;
				~categorias_ambi.add(\quietud -> ~ambi_quietud);
			});
			("~gui_array_ambix_subc_quietud index" + index).postln;
			("~gui_array_ambix_subc_quietud.do item" + item.value).postln;

		};
	});


	//Botón de categoría quietud y silencio

	~chkb_ambi_silencio.action = {
		if(~chkb_ambi_silencio.value == false, {
			~gui_array_ambix_subc_silencio.do({ arg item, index;
				item.valueAction = false;
				~switch_ambix_quietud.value(index, item.value);
			});
			~categorias_ambi.removeAt(\quietud);
		}, {
			~gui_array_ambix_subc_silencio.do({ arg item, index;
				if(item.enabled == true, {
					item.value = true;
					~switch_ambix_quietud.value(index, item.value);
				});

			});
			~categorias_ambi.add(\quietud -> ~ambi_quietud);
		}
		);
	};


};


////////////////////// INTERFAZ GUI COMPLETA////////////////////////

~gui_init = 0;
Window.closeAll;

~h = 900;
~w_size = 1000;
~relojes = Window.new("Controles", Rect(0,0,~w_size,~h), false);
~relojes.alwaysOnTop_(true);
~relojes.bounds_(Rect(500,0,~w_size,~h));
~relojes.front;

~relojes_comp = CompositeView(~relojes.view, Rect(0,0,~w_size,~h));
~relojes_comp.decorator = FlowLayout(~relojes_comp.bounds,10@10, 60@30);
~relojes_comp.background = Color.fromHexString("#FF9305").alpha_(0.6);




~relojes_cat_gen_bt = Button.new(~relojes,Rect((~w_size/2)-75,750,150,60 ));
~relojes_cat_gen_bt.states = ([
	["Categorías generales", Color.black, Color.green],
	["Categorías generales", Color.black, Color.blue.alpha_(0.5)]
	     ]);
~relojes_cat_gen_bt.font = Font("Times New Roman", 16, true);
~relojes_cat_gen_bt.action = { arg value;
	if(value.value == 1 && ~gui_init == 1, {~gui_cat_g.visible_(true);});
	if(value.value == 1 && ~gui_init == 0, {~func_gui_cat_g.value; ~gui_init=1});
		};

~relojes_cat_ambix_bt = Button.new(~relojes,Rect((~w_size/2)-75,825,170,60 ));
~relojes_cat_ambix_bt.states = ([
	["Categorías ambisónicas", Color.black, Color.green],
	["Categorías ambisónicas", Color.black, Color.blue.alpha_(0.5)]
	     ]);
~relojes_cat_ambix_bt.font = Font("Times New Roman", 16, true);
~relojes_cat_ambix_bt.action = { arg value;
	if(value.value == 1 && ~gui_init == 1, {~gui_cat_ambix.visible_(true);});
	if(value.value == 1 && ~gui_init == 0, {~f_gui_ambix_cat.value; ~gui_init=1});
		};

if (~gui_init == 0, {
	~func_gui_cat_g.value;
	~relojes_cat_gen_bt.valueAction_(1);
	~f_gui_ambix_cat.value;
	~relojes_cat_ambix_bt.valueAction_(1);
	(0.5).wait;
	{~gui_cat_g_hide.valueAction_(1);
		~gui_cat_ambix_hide.valueAction_(1);
	}.defer;
}.fork);



/////////////////////////CONTROLES IZQUIERDA 45°////////////////////////


{
	~relojes_comp.decorator.left_(145);
	~i45_comp = CompositeView(~relojes_comp, 200@215);
	~i45_comp.background = Color.yellow.alpha_(0.5);



}.value;




////////////////////////CONTROLES FRENTE////////////////////////////////

{
	~fr_comp = CompositeView(~relojes_comp, 200@215);
	~fr_comp.background = Color.yellow.alpha_(0.5);
	~fr_comp.decorator_(FlowLayout(~fr_comp.bounds, 10@10, 5@7));

~fr_gui_extras = Button.new(~fr_comp, 68@22);
~fr_gui_extras.font = Font("Times New Roman", 16, true);
~fr_gui_extras.states = ([
	["Frente", Color.black, Color.green],
		["Frente", Color.black, Color.blue.alpha_(0.5)],
]);
~fr_gui_extras.action = { arg value;
	if(value.value == 0) {~f_gui_cat_fr.value;
	};

};
//StaticText(~fr_comp, 65@20).string_("D90°-1").font_(Font("Times New Roman", 18));
~fr_gui_start = Button.new(~fr_comp, 50@20).states_(
	[
		["Iniciar", Color.white, Color.red],
		["Reproduciendo", Color.black, Color.green],

]);

~fr_gui_start.action = {
	var lag = ~fr_reloj_vol_t_txt.string.asInteger;
	var vol = ~fr_reloj_vol_v_txt.string.asInteger/100;
	~fr_gui_btn_xfade.enabled_(true);
	~fr_gui_btn_xfade.value = 0;
	~fr_comp.background_(Color.green.alpha_(0.5));
		~fr_gui_xfade_dur.string = "-";
		~fr_reloj_trigger.string = "-";
	//~f_fr_vol.value(vol, lag);
	/// Valores iniciales de rutina
	//~d90_fmorph = false;
	~fr_xfade = 0;
	~fr_trigger_xfade = false;
	~f_fr_r.value;
};


~fr_comp.decorator.nextLine;

~fr_gui_btn_A = Button.new(~fr_comp, 35@20).states_(
	[
		["A0", Color.black, Color.green],
		["A0", Color.black, Color.yellow],
		["A0", Color.black, Color.red]
]);


~fr_gui_fl = Button.new(~fr_comp, 30@20).states_(
	[
		["-"],
		["-"],
		["--"],
		["--"],
		["-->"],
		["-->"],
		["-"],
		["-"],
		["--"],
		["--"],
		["<--"],
		["<--"],
		[""]
]);

~fr_gui_btn_B = Button.new(~fr_comp, 35@20).states_(
	[
		["B1", Color.black, Color.green],
		["B1", Color.black, Color.yellow],
		["B1", Color.black, Color.red]
]);


~fr_gui_fl.value = 12;


~fr_comp.decorator.nextLine;

StaticText.new(~fr_comp,70@22).string_("Volumen = ").font_(Font("Times New Roman", 14, true));
~fr_reloj_vol = StaticText.new(~fr_comp,20@22);
~fr_reloj_vol.string = "0";
~fr_reloj_vol.font_(Font("Times New Roman", 14, true));
~fr_reloj_vol_t_txt = TextField.new(~fr_comp,25@20);
~fr_reloj_vol_v_txt = TextField.new(~fr_comp,25@20);

~fr_comp.decorator.nextLine;

StaticText.new(~fr_comp,60@22).string_("Tiempo de fade = ").font_(Font("Times New Roman", 10, true));
~fr_reloj_vol_dur = StaticText.new(~fr_comp,22@22);
~fr_reloj_vol_dur.string = "0";
~fr_reloj_vol_dur.font_(Font("Times New Roman", 10, true));

//~fr_comp.decorator.left_(110);
~fr_reloj_vol_g_t = Button.new(~fr_comp, 66@20).states_(
	[
		["T(s)    V(%)", Color.black, Color.green],
		["T(s)    V(%)", Color.black, Color.yellow],

]);

~fr_reloj_vol_g_t.action = {
	if((~fr_gui_start.value == 0), //Quiere decir que arranca un fade-in
		{
			~fr_gui_init == false;
			~fr_gui_start.enabled_(true);
			"Fade-in".postln;
		},{
			var amp=~fr_reloj_vol_v_txt.string.asInteger/100, lag=~fr_reloj_vol_t_txt.string.asInteger;
			~f_fr_vol.value(amp, lag);
	});
	};




	~fr_comp.decorator.nextLine;

	StaticText.new(~fr_comp,130@25).string_("Tiempo restante del paisaje = ").font_(Font("Times New Roman", 10, true));
	~fr_reloj_trigger = StaticText.new(~fr_comp,15@22);
	~fr_reloj_trigger.string = "0";
	~fr_reloj_trigger.font_(Font("Times New Roman", 14, true));

	~fr_comp.decorator.nextLine;

	StaticText.new(~fr_comp,92@18).string_("Tiempo de transición = ").font_(Font("Times New Roman", 9, true));
	~fr_gui_xfade_dur = StaticText.new(~fr_comp,15@18);
	~fr_gui_xfade_dur.string = "0";
	~fr_gui_xfade_dur.font_(Font("Times New Roman", 11, true));
	~fr_reloj_xfade_t_txt = TextField.new(~fr_comp,25@20);

	~fr_reloj_xfade_v_txt = TextField.new(~fr_comp,25@20);

	~fr_comp.decorator.nextLine;

	~fr_comp.decorator.left_(120);

	~fr_gui_btn_xfade = Button.new(~fr_comp, 70@20).states_(
		[
			["T(s)    XF(%)", Color.black, Color.green],
			["T(s)    XF(%)", Color.black, Color.yellow],
			["T(s)    XF(%)", Color.black, Color.red],


	]);


	~fr_gui_btn_xfade.action = {

		~fr_xfdur = ~fr_reloj_xfade_t_txt.string.asInteger;
		~fr_xfade = ~fr_reloj_xfade_v_txt.string.asInteger;
		~fr_xfade = ~fr_xfade/100;

		if(~fr_xfade_A_B == true,{
			if(~fr_xfade != 0,{
				~f_fr_reloj_xfade.value;
				~fr_gui_btn_xfade.value = 1;
				~fr_xfade_m_t = true;
				"fr_xfade != 0 A_B".postln;
			});
			if(~fr_xfade == 0,{
				{{~fr_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~fr_gui_btn_xfade.value = 0}.defer;
				(0.2).wait;
				{~fr_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~fr_gui_btn_xfade.value = 0}.defer;
			}.fork;
				"~fr_xfade == 0 A_B".postln;
			});
		});
		if(~fr_xfade_B_A == true,{
			if(~fr_xfade != 1,{
				~f_fr_reloj_xfade.value;
				~fr_gui_btn_xfade.value = 1;
				~fr_xfade_m_t = true;
				"~fr_xfade != 1 B_A".postln;
			});
			if(~fr_xfade == 1,{
				{{~fr_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~fr_gui_btn_xfade.value = 0}.defer;
				(0.2).wait;
				{~fr_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~fr_gui_btn_xfade.value = 0}.defer;
			}.fork;
				"~fr_xfade == 1 B_A".postln;
			});
		});
	};




	//~fr_comp.decorator.left_(124);




}.value;
////////////////////////CONTROLES DERECHA 45°////////////////////////////////

{
	~d45_comp = CompositeView(~relojes_comp, 200@215);
	~d45_comp.background = Color.yellow.alpha_(0.5);

	~relojes_comp.decorator.nextLine;
}.value;


///////////////////////// CONTROLES I90////////////////////////////

{
	~i90_gui_comp = CompositeView(~relojes_comp, 200@215);
	~i90_gui_comp.background = Color.yellow.alpha_(0.5);
	~i90_gui_comp.decorator_(FlowLayout(~i90_gui_comp.bounds, 10@10, 5@7));

~i90_gui_extras = Button.new(~i90_gui_comp, 68@22);
~i90_gui_extras.font = Font("Times New Roman", 16, true);
~i90_gui_extras.states = ([
	["I90°", Color.black, Color.green]
]);
~i90_gui_extras.action = { arg value;

	if(value.value == 0) {~f_gui_cat_i90.value;
	};
};
//StaticText(~i90_gui_comp, 65@20).string_("D90°-1").font_(Font("Times New Roman", 18));
~i90_gui_start = Button.new(~i90_gui_comp, 50@20).states_(
	[
		["Start", Color.white, Color.red],
		["Running", Color.black, Color.green],

]);

~i90_gui_start.action = {
	var lag = ~i90_reloj_vol_t_txt.string.asInteger;
	var vol = ~i90_reloj_vol_v_txt.string.asInteger/100;
	~i90_gui_btn_xfade.enabled_(true);
	~i90_gui_btn_xfade.value = 0;
	~i90_gui_comp.background_(Color.green.alpha_(0.5));
		~i90_gui_xfade_dur.string = "-";
		~i90_reloj_trigger.string = "-";
	//~f_i90_vol.value(vol, lag);
	/// Valores iniciales de rutina
	//~d90_fmorph = false;
	~i90_xfade = 0;
	~i90_trigger_xfade = false;
	~f_i90_r.value;
};


~i90_gui_comp.decorator.nextLine;

~i90_gui_btn_A = Button.new(~i90_gui_comp, 35@20).states_(
	[
		["A0", Color.black, Color.green],
		["A0", Color.black, Color.yellow],
		["A0", Color.black, Color.red]
]);
~i90_gui_btn_A.enabled = false;

~i90_gui_fl = Button.new(~i90_gui_comp, 30@20).states_(
	[
		["-"],
		["-"],
		["--"],
		["--"],
		["-->"],
		["-->"],
		["-"],
		["-"],
		["--"],
		["--"],
		["<--"],
		["<--"],
		[""]
]);


~i90_gui_btn_B = Button.new(~i90_gui_comp, 35@20).states_(
	[
		["B1", Color.black, Color.green],
		["B1", Color.black, Color.yellow],
		["B1", Color.black, Color.red]
]);



~i90_gui_comp.decorator.nextLine;
StaticText.new(~i90_gui_comp,70@22).string_("Volumen = ").font_(Font("Times New Roman", 14, true));

~i90_reloj_vol = StaticText.new(~i90_gui_comp,20@22);
~i90_reloj_vol.string = "0";
~i90_reloj_vol.font_(Font("Times New Roman", 14, true));
~i90_reloj_vol_t_txt = TextField.new(~i90_gui_comp,25@20);
~i90_reloj_vol_v_txt = TextField.new(~i90_gui_comp,25@20);

~i90_gui_comp.decorator.nextLine;

StaticText.new(~i90_gui_comp,60@22).string_("Tiempo = ").font_(Font("Times New Roman", 14, true));
~i90_reloj_vol_dur = StaticText.new(~i90_gui_comp,22@22);
~i90_reloj_vol_dur.string = "0";
~i90_reloj_vol_dur.font_(Font("Times New Roman", 14, true));

//~i90_gui_comp.decorator.left_(110);
~i90_reloj_vol_g_t = Button.new(~i90_gui_comp, 66@20).states_(
	[
		["T(s)    V(%)", Color.black, Color.green],
		["T(s)    V(%)", Color.black, Color.yellow],

]);

~i90_reloj_vol_g_t.action = {
	if((~i90_gui_start.value == 0), //Quiere decir que arranca un fade-in
		{
			~i90_gui_init == false;
			~i90_gui_start.enabled_(true);
			"Fade-in".postln;
		},{
			var amp=~i90_reloj_vol_v_txt.string.asInteger/100, lag=~i90_reloj_vol_t_txt.string.asInteger;
			~f_i90_vol.value(amp, lag);
	});
	};




	~i90_gui_comp.decorator.nextLine;
	StaticText.new(~i90_gui_comp,135@25).string_("Ventana del paisaje = ").font_(Font("Times New Roman", 14, true));
	~i90_reloj_trigger = StaticText.new(~i90_gui_comp,25@22);
	~i90_reloj_trigger.string = "0";
	~i90_reloj_trigger.font_(Font("Times New Roman", 14, true));

	~i90_gui_comp.decorator.nextLine;

	StaticText.new(~i90_gui_comp,75@18).string_("Transición = ").font_(Font("Times New Roman", 14, true));
	~i90_gui_xfade_dur = StaticText.new(~i90_gui_comp,25@18);
	~i90_gui_xfade_dur.string = "0";
	~i90_gui_xfade_dur.font_(Font("Times New Roman", 14, true));
	~i90_reloj_xfade_t_txt = TextField.new(~i90_gui_comp,25@20);

	~i90_reloj_xfade_v_txt = TextField.new(~i90_gui_comp,25@20);

	~i90_gui_comp.decorator.nextLine;

	~i90_gui_comp.decorator.left_(120);

	~i90_gui_btn_xfade = Button.new(~i90_gui_comp, 70@20).states_(
		[
			["T(s)    XF(%)", Color.black, Color.green],
			["T(s)    XF(%)", Color.black, Color.yellow],
			["T(s)    XF(%)", Color.black, Color.red],


	]);


	~i90_gui_btn_xfade.action = {

		~i90_xfdur = ~i90_reloj_xfade_t_txt.string.asInteger;
		~i90_xfade = ~i90_reloj_xfade_v_txt.string.asInteger;
		~i90_xfade = ~i90_xfade/100;

		if(~i90_xfade_A_B == true,{
			if(~i90_xfade != 0,{
				~f_i90_reloj_xfade.value;
				~i90_gui_btn_xfade.value = 1;
				~i90_xfade_m_t = true;
				"fr_xfade != 0 A_B".postln;
			});
			if(~i90_xfade == 0,{
				{{~i90_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~i90_gui_btn_xfade.value = 0}.defer;
				(0.2).wait;
				{~i90_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~i90_gui_btn_xfade.value = 0}.defer;
			}.fork;
				"~i90_xfade == 0 A_B".postln;
			});
		});
		if(~i90_xfade_B_A == true,{
			if(~i90_xfade != 1,{
				~f_i90_reloj_xfade.value;
				~i90_gui_btn_xfade.value = 1;
				~i90_xfade_m_t = true;
				"~i90_xfade != 1 B_A".postln;
			});
			if(~i90_xfade == 1,{
				{{~i90_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~i90_gui_btn_xfade.value = 0}.defer;
				(0.2).wait;
				{~i90_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~i90_gui_btn_xfade.value = 0}.defer;
			}.fork;
				"~i90_xfade == 1 B_A".postln;
			});
		});
	};




}.value;




/////////////////////////CONTROLES AMBIX//////////////////////////////

{
	~ambix_gui_comp = CompositeView(~relojes_comp, 200@215);
	~ambix_gui_comp.background = Color.fromHexString("#F0CB11");
	~ambix_gui_comp.decorator_(FlowLayout(~ambix_gui_comp.bounds, 5@10, 3@7));

~ambix_gui_extras = Button.new(~ambix_gui_comp, 68@22);
~ambix_gui_extras.font = Font("Times New Roman", 16, true);
~ambix_gui_extras.states = ([
	["AmbiX", Color.black, Color.green(0.75, 1)]
]);



~ambix_gui_start = Button.new(~ambix_gui_comp, 85@22).states_(
	[
		["Iniciar", Color.white, Color.red],
		["Reproduciendo", Color.black, Color.green],

]);

~ambix_gui_start.action = {
		var lag = ~ambix_gui_vol_t_txt.string.asInteger;
		var vol = ~ambix_gui_vol_v_txt.string.asInteger/100;
		~ambix_gui_btn_xfade.enabled_(true);
		~ambix_gui_btn_xfade.value = 0;
		~ambix_gui_comp.background_(Color.green.alpha_(0.5));
		~ambix_gui_xfade_dur.string = "-";
		~ambix_reloj_trigger.string = "-";
		"ambix_gui_start".postln;
		~f_ambix_r.value;
};


~ambix_gui_comp.decorator.nextLine;

~ambix_gui_btn_A = Button.new(~ambix_gui_comp, 35@20).states_(
	[
		["A0", Color.black, Color.green],
		["A0", Color.black, Color.yellow],
		["A0", Color.black, Color.red]
]);
~ambix_gui_btn_A.enabled = false;

~ambix_gui_fl = Button.new(~ambix_gui_comp, 30@20).states_(
	[
		["-"],
		["-"],
		["--"],
		["--"],
		["-->"],
		["-->"],
		["-"],
		["-"],
		["--"],
		["--"],
		["<--"],
		["<--"],
		[""]
]);


~ambix_gui_btn_B = Button.new(~ambix_gui_comp, 35@20).states_(
	[
		["B1", Color.black, Color.green],
		["B1", Color.black, Color.yellow],
		["B1", Color.black, Color.red]
]);



~ambix_gui_comp.decorator.nextLine;
StaticText.new(~ambix_gui_comp,70@22).string_("Volumen = ").font_(Font("Times New Roman", 14, true));
~ambix_gui_vol = StaticText.new(~ambix_gui_comp,40@22);
~ambix_gui_vol.string = "0";
~ambix_gui_vol.font_(Font("Times New Roman", 14, true));
~ambix_gui_vol_t_txt = TextField.new(~ambix_gui_comp,25@20);
~ambix_gui_vol_v_txt = TextField.new(~ambix_gui_comp,25@20);

~ambix_gui_comp.decorator.nextLine;

StaticText.new(~ambix_gui_comp,85@22).string_("Tiempo de fade = ").font_(Font("Times New Roman", 9, true));
~ambix_gui_vol_dur = StaticText.new(~ambix_gui_comp,22@22);
~ambix_gui_vol_dur.string = "0";
~ambix_gui_vol_dur.font_(Font("Times New Roman", 12, true));

~ambix_gui_vol_g_t = Button.new(~ambix_gui_comp, 66@20).states_(
	[
		["T(s)    V(%)", Color.black, Color.green],
		["T(s)    V(%)", Color.black, Color.yellow],

]);

~ambix_gui_vol_g_t.action = {
	if((~ambix_gui_start.value == 0), //Quiere decir que arranca un fade-in
		{

			~ambix_gui_start.enabled_(true);
			"Fade-in".postln;
		},{
			var amp=~ambix_gui_vol_v_txt.string.asInteger/100, lag=~ambix_gui_vol_t_txt.string.asInteger;
			~f_ambix_vol.value(amp, lag);
	});
	};




	~ambix_gui_comp.decorator.nextLine;
	StaticText.new(~ambix_gui_comp,135@25).string_("Tiempo restante del paisaje = ").font_(Font("Times New Roman", 10, true));
	~ambix_reloj_trigger = StaticText.new(~ambix_gui_comp,25@22);
	~ambix_reloj_trigger.string = "0";
	~ambix_reloj_trigger.font_(Font("Times New Roman", 12, true));

	~ambix_gui_comp.decorator.nextLine;

	StaticText.new(~ambix_gui_comp,92@18).string_("Tiempo de transición = ").font_(Font("Times New Roman", 9, true));
	~ambix_gui_xfade_dur = StaticText.new(~ambix_gui_comp,21@18);
	~ambix_gui_xfade_dur.string = "0";
	~ambix_gui_xfade_dur.font_(Font("Times New Roman", 11, true));
	~ambix_reloj_xfade_t_txt = TextField.new(~ambix_gui_comp,25@20);
	~ambix_reloj_xfade_v_txt = TextField.new(~ambix_gui_comp,25@20);

	~ambix_gui_comp.decorator.nextLine;

	~ambix_gui_comp.decorator.left_(120);

	~ambix_gui_btn_xfade = Button.new(~ambix_gui_comp, 70@20).states_(
		[
			["T(s)    XF(%)", Color.black, Color.green],
			["T(s)    XF(%)", Color.black, Color.yellow],
			["T(s)    XF(%)", Color.black, Color.red],


	]);

	~ambix_gui_btn_xfade.action = {

		~ambix_xfdur = ~ambix_reloj_xfade_t_txt.string.asInteger;
		~ambix_xfade = ~ambix_reloj_xfade_v_txt.string.asInteger/100;

		if(~ambix_xfade_A_B == true,{
			if((~ambix_xfade < 1) && (~ambix_xfade > 0),{ //var hang=true;
				~ambix_btn_xfade_check = true;
				~f_ambix_xfade_manual.value(~ambix_xfdur, ~ambix_xfade);
				~ambix_gui_btn_xfade.value = 1;
				//~ambix_xfade_m_t = true;
				//"fr_xfade != 0 A_B".postln;
			});
			if(~ambix_xfade == 0,{
				{{~ambix_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~ambix_gui_btn_xfade.value = 0}.defer;
				(0.2).wait;
				{~ambix_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~ambix_gui_btn_xfade.value = 0}.defer;
			}.fork;
				"GUI - ~ambix_xfade == 0 A_B".postln;
			});
			if(~ambix_xfade == 1,{ //hang=false;
				~ambix_btn_xfade_check = true;
				~f_ambix_xfade_A_B_1.value(~ambix_xfdur, ~ambix_xfade);

			})
		});
		if(~ambix_xfade_B_A == true,{
			if((~ambix_xfade < 1) && (~ambix_xfade > 0),{
				~ambix_btn_xfade_check = true;
				~f_ambix_xfade_manual.value(~ambix_xfdur, ~ambix_xfade);
				~ambix_gui_btn_xfade.value = 1;
				"~ambix_xfade != 1 B_A".postln;
			});
			if(~ambix_xfade == 1,{
				{{~ambix_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~ambix_gui_btn_xfade.value = 0}.defer;
				(0.2).wait;
				{~ambix_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~ambix_gui_btn_xfade.value = 0}.defer;
			}.fork;
				"~ambix_xfade == 1 B_A".postln;
			});
			if(~ambix_xfade == 0,{ //hang=false;
				~ambix_btn_xfade_check = true;
				~f_ambix_xfade_B_A_0.value(~ambix_xfdur, ~ambix_xfade);
			})
		});
	};




}.value;




////////////////////////CONTROLES ARRIBA ///////////////////////////////////


{
	~arri_comp = CompositeView(~relojes_comp, 200@215);
	~arri_comp.background = Color.yellow.alpha_(0.5);


}.value;










///////////////////// CONTROLES D90////////////////////////////

~d90_comp = CompositeView(~relojes_comp, 200@215);
~d90_comp.background = Color.yellow.alpha_(0.5);
~d90_comp.decorator_(FlowLayout(~d90_comp.bounds, 10@10, 5@7));



		~reloj_d90_1_extras = Button.new(~d90_comp, 68@22);
		~reloj_d90_1_extras.font = Font("Times New Roman", 16, true);
		~reloj_d90_1_extras.states = ([
			["D90°", Color.black, Color.green]
		]);
		~reloj_d90_1_extras.action = { arg value;
			if(value.value == 0) {~f_gui_cat_d90.value;
			};
		};
		~d90_gui_start = Button.new(~d90_comp, 50@20).states_(
		[
			["Start", Color.white, Color.red],
			["Running", Color.black, Color.green],

	]);

~d90_gui_start.action = {
	var lag = ~reloj_d90_vol_dur_txt.string.asInteger;
	var vol = ~reloj_d90_1_vol_v_txt.string.asInteger/100;
	~d90_gui_btn_xfade.enabled_(true);
	~d90_gui_btn_xfade.value = 0;
	~d90_comp.background_(Color.green.alpha_(0.5));
	~reloj_d90_1_morph.string = "-";
	~reloj_d90_1_trigger.string = "-";
	/// Valores iniciales de rutina
	~d90_morph_xfade = 0;
	~d90_trigger_morph = false;
	~f_r_D90.value;
};


		~d90_comp.decorator.nextLine;

		~d90_gui_btn_A = Button.new(~d90_comp, 35@20).states_(
		[
			["A0", Color.black, Color.green],
			["A0", Color.black, Color.yellow],
			["A0", Color.black, Color.red]
	]);
		~d90_gui_btn_A.enabled = false;

	~d90_gui_btn_fl = Button.new(~d90_comp, 30@20).states_(
		[
			["-"],
			["-"],
			["--"],
			["--"],
			["-->"],
			["-->"],
			["-"],
			["-"],
			["--"],
			["--"],
			["<--"],
			["<--"],
			[""]
	     ]);
			~d90_gui_btn_fl.enabled = false;

	~d90_gui_btn_B = Button.new(~d90_comp, 35@20).states_(
		[
			["B1", Color.black, Color.green],
			["B1", Color.black, Color.yellow],
			["B1", Color.black, Color.red]
	     ]);
			~d90_gui_btn_B.enabled = false;

~d90_gui_btn_fl.value = 12;


		~d90_comp.decorator.nextLine;
StaticText.new(~d90_comp,70@22).string_("Volumen = ").font_(Font("Times New Roman", 14, true));

		~d90_reloj_vol = StaticText.new(~d90_comp,20@22);
		~d90_reloj_vol.string = "0";
		~d90_reloj_vol.font_(Font("Times New Roman", 14, true));
		~reloj_d90_vol_dur_txt = TextField.new(~d90_comp,25@20);
		~reloj_d90_1_vol_v_txt = TextField.new(~d90_comp,25@20);

		~d90_comp.decorator.nextLine;

StaticText.new(~d90_comp,60@22).string_("Tiempo = ").font_(Font("Times New Roman", 14, true));
~reloj_d90_vol_dur = StaticText.new(~d90_comp,22@22);
~reloj_d90_vol_dur.string = "0";
~reloj_d90_vol_dur.font_(Font("Times New Roman", 14, true));

		//~d90_comp.decorator.left_(110);
		~d90_reloj_vol_g_t = Button.new(~d90_comp, 66@20).states_(
		[
			["T(s)    V(%)", Color.black, Color.green],
			["T(s)    V(%)", Color.black, Color.yellow],

	]);

~d90_reloj_vol_g_t.action = {
	if((~d90_gui_start.value == 0), //Quiere decir que arranca un fade-in
	{
		~gui_d90_init == false;
		~d90_gui_start.enabled_(true);
		"Fade-in".postln;
	},{
		var amp=~reloj_d90_1_vol_v_txt.string.asInteger/100, lag=~reloj_d90_vol_dur_txt.string.asInteger;
		~f_d90_vol.value(amp, lag);
	});

};

		~d90_comp.decorator.nextLine;
StaticText.new(~d90_comp,135@25).string_("Ventana del paisaje = ").font_(Font("Times New Roman", 14, true));
		~reloj_d90_1_trigger = StaticText.new(~d90_comp,25@22);
		~reloj_d90_1_trigger.string = "0";
		~reloj_d90_1_trigger.font_(Font("Times New Roman", 14, true));

		~d90_comp.decorator.nextLine;

StaticText.new(~d90_comp,75@18).string_("Transición = ").font_(Font("Times New Roman", 14, true));
		~reloj_d90_1_morph = StaticText.new(~d90_comp,25@18);
		~reloj_d90_1_morph.string = "0";
		~reloj_d90_1_morph.font_(Font("Times New Roman", 14, true));
		~reloj_d90_1_morph_t_txt = TextField.new(~d90_comp,25@20);
		~reloj_d90_1_morph_v_txt = TextField.new(~d90_comp,25@20);

		~d90_comp.decorator.nextLine;

		~d90_comp.decorator.left_(120);

		~d90_gui_btn_xfade = Button.new(~d90_comp, 60@20).states_(
		[
			["T(s)    M(%)", Color.black, Color.green],
			["T(s)    M(%)", Color.black, Color.yellow],
			["T(s)    M(%)", Color.black, Color.red],


	]);

~d90_gui_btn_xfade.action = {
	~d90_morph_dur = ~reloj_d90_1_morph_t_txt.string.asInteger;
	~d90_morph_xfade = ~reloj_d90_1_morph_v_txt.string.asInteger;
	~d90_morph_xfade = ~d90_morph_xfade/100;

	if(~d90_xfade_A_B == true,{
		if(~d90_morph_xfade != 0,{
			~f_d90_xfade.value;
			~d90_gui_btn_xfade.value = 1;
			~d90_morph_m_t = false;
			"~d90_morph_xfade != 0".postln;
		});
		if(~d90_morph_xfade == 0,{
			{{~d90_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~d90_gui_btn_xfade = 0}.defer;
				(0.2).wait;
				{~d90_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~d90_gui_btn_xfade.value = 0}.defer;
			}.fork;
				"~d90_morph_xfade == 0 A_B".postln;
		});
	});
	if(~d90_xfade_B_A == true,{
		if(~d90_morph_xfade != 1,{
			~f_d90_xfade.value;
			~d90_gui_btn_xfade.value = 1;
			~d90_morph_m_t = false;
			"~d90_morph_xfade != 1 B_A".postln;
		});
		if(~d90_morph_xfade == 1,{
			{{~d90_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~d90_gui_btn_xfade = 0}.defer;
				(0.2).wait;
				{~d90_gui_btn_xfade.value = 2}.defer;
				(0.2).wait;
				{~d90_gui_btn_xfade.value = 0}.defer;
			}.fork;
			"~d90_morph_xfade == 1 B_A".postln;
		});
	});

};

//~d90_comp.decorator.left_(124);
~relojes_comp.decorator.nextLine;






/////////////////////////CONTROLES IZQUIERDA 135°////////////////////////


{
	~relojes_comp.decorator.left_(145);

	~i135_comp = CompositeView(~relojes_comp, 200@215);
	~i135_comp.background = Color.yellow.alpha_(0.5);



}.value;



/////////////////////////CONTROLES ATRÁS////////////////////////


{

	~back_comp = CompositeView(~relojes_comp, 200@215);
	~back_comp.background = Color.yellow.alpha_(0.5);



}.value;


/////////////////////////CONTROLES DERECHA 135°////////////////////////


{

	~d135_comp = CompositeView(~relojes_comp, 200@215);
	~d135_comp.background = Color.yellow.alpha_(0.5);



}.value;






////////ESTADOS INICIALES ////////////////


~fr_gui_start.enabled_(false);
~fr_gui_btn_A.enabled = false;
~fr_gui_btn_A.value = 2;
~fr_gui_fl.enabled = false;
~fr_gui_fl.value = 12;
~fr_gui_btn_B.enabled = false;
~fr_gui_btn_B.value = 2;
~fr_gui_btn_xfade.enabled = false;
~fr_gui_btn_xfade.value = 2;


~d90_gui_start.enabled_(false);
~d90_gui_btn_A.enabled = false;
~d90_gui_btn_A.value = 2;
~d90_gui_btn_B.enabled = false;
~d90_gui_btn_B.value = 2;
~d90_gui_btn_xfade.enabled_(false);
~d90_gui_btn_xfade.value = 2;


~i90_gui_start.enabled = false;
~i90_gui_btn_A.enabled = false;
~i90_gui_btn_A.value = 2;
~i90_gui_btn_B.enabled = false;
~i90_gui_btn_B.value = 2;
~i90_gui_fl.enabled = false;
~i90_gui_fl.value = 12;
~i90_gui_btn_xfade.enabled_(false);
~i90_gui_btn_xfade.value_(2);

~ambix_gui_start.enabled = false;
~ambix_gui_btn_A.enabled = false;
~ambix_gui_btn_A.value = 2;
~ambix_gui_fl.enabled = false;
~ambix_gui_fl.value = 12;
~ambix_gui_btn_B.enabled = false;
~ambix_gui_btn_B.value = 2;
~ambix_gui_btn_xfade.enabled = false;
~ambix_gui_btn_xfade.value = 2;



