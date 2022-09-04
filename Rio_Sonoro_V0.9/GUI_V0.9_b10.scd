

			~subcat_check = {arg val,cat,subcat;
	"subcat_check".postln;
	switch(cat,
		0, {~switch_general_naturaleza.value(subcat, val.asBoolean)},
		1, {~switch_general_sociedad.value(subcat, val.asBoolean)},
		2, {~switch_general_artilugios.value(subcat, val.asBoolean)}
	);
};



/*
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

*/















////////////////////// INTERFAZ GUI COMPLETA////////////////////////
///////////////////////////////////////////////////////////////////

~gui_init = 0;
Window.closeAll;

~h = 900;
~w_size = 1000;
~gui = Window.new("Río sonoro", Rect(0,0,~w_size,~h), false);
~gui.alwaysOnTop_(true);
~gui.bounds_(Rect(500,0,~w_size,~h));
~gui.front;

~gui_comp_view = CompositeView(~gui.view, Rect(0,0,~w_size,~h));
~gui_comp_view.decorator = FlowLayout(~gui_comp_view.bounds,10@10, 60@30);
~gui_comp_view.background = Color.fromHexString("#FF9305").alpha_(0.6);





////Los controles están acomodados de acuerdo al flowlayout////



/////////////////////////CONTROLES IZQUIERDA 45°////////////////////////


{
	~gui_comp_view.decorator.left_(145);
	~i45_comp = CompositeView(~gui_comp_view, 200@215);
	~i45_comp.background = Color.yellow.alpha_(0.5);



}.value;




////////////////////////CONTROLES FRENTE////////////////////////////////

{
	var comp_view, gui_vol_txt, vol_control_btn, vol_tiempo_txt, vol_btn, btn_selector, window_selector_cat, btn_hide, iniciar_btn, xfade_tiempo_in, xfade_value_in, selector_init=0;



	comp_view = CompositeView(~gui_comp_view, 200@215);
	comp_view.background = Color.fromHexString("#F0CB11");
	comp_view.decorator_(FlowLayout(comp_view.bounds, 5@10, 3@7));

	btn_selector = Button.new(comp_view, 68@22);
	btn_selector.font = Font("Times New Roman", 16, true);
	btn_selector.states = ([
		["Frente", Color.black, Color.green],
		["Frente", Color.black, Color.blue.alpha_(0.5)]
	]);
	btn_selector.action = { arg value;
	if(value.value == 1 && selector_init == 1, {window_selector_cat.visible_(true);});
	if(value.value == 1 && selector_init == 0, {~f_gui_fr_cat.value; selector_init=1});
		};




iniciar_btn = Button.new(comp_view, 85@22).states_(
	[
		["Iniciar", Color.white, Color.red],
		["Reproduciendo", Color.black, Color.green],

]);

iniciar_btn.action = {
		var lag = ~fr_gui_vol_tiempo_in.string.asInteger;
		var vol = ~fr_gui_vol_value_in.string.asInteger/100;
		~fr_gui_btn_xfade.enabled_(true);
		~fr_gui_btn_xfade.value = 0;
		comp_view.background_(Color.green.alpha_(0.5));
		~fr_gui_xfade_dur.string = "-";
		~fr_gui_tiempo_paisaje_txt.string = "-";
		"ambix_gui_start".postln;
		~f_fr_r.value;
		iniciar_btn.enabled = false;
};


comp_view.decorator.nextLine;

~fr_gui_btn_A = Button.new(comp_view, 35@20).states_(
	[
		["A0", Color.black, Color.green],
		["A0", Color.black, Color.yellow],
		["A0", Color.black, Color.red]
]);
~fr_gui_btn_A.enabled = false;

~fr_gui_fl = Button.new(comp_view, 30@20).states_(
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


~fr_gui_btn_B = Button.new(comp_view, 35@20).states_(
	[
		["B1", Color.black, Color.green],
		["B1", Color.black, Color.yellow],
		["B1", Color.black, Color.red]
]);



comp_view.decorator.nextLine;
StaticText.new(comp_view,70@22).string_("Volumen = ").font_(Font("Times New Roman", 14, true));
gui_vol_txt = StaticText.new(comp_view,40@22);
gui_vol_txt.string = "0";
gui_vol_txt.font_(Font("Times New Roman", 14, true));
~fr_gui_vol_tiempo_in = TextField.new(comp_view,25@20);
~fr_gui_vol_value_in = TextField.new(comp_view,25@20);

comp_view.decorator.nextLine;

StaticText.new(comp_view,85@22).string_("Tiempo de fade = ").font_(Font("Times New Roman", 9, true));
vol_tiempo_txt = StaticText.new(comp_view,22@22);
vol_tiempo_txt.string = "0";
vol_tiempo_txt.font_(Font("Times New Roman", 12, true));

vol_control_btn = Button.new(comp_view, 66@20).states_(
	[
		["T(s)    V(%)", Color.black, Color.green],
		["T(s)    V(%)", Color.black, Color.yellow],

]);

vol_control_btn.action = {
	if((iniciar_btn.value == 0), //Quiere decir que arranca un fade-in
		{
			iniciar_btn.enabled_(true);
			"Fade-in frente".postln;
		},{
				var amp=~fr_gui_vol_value_in.string.asInteger/100, lag=~fr_gui_vol_tiempo_in.string.asInteger;
			//~f_ambix_vol.value(amp, lag);
				~fr_synth.set(\amp,amp, \amp_lag,lag);
				~f_fr_vol_gui.value(amp, lag);
	});
	};




	comp_view.decorator.nextLine;
	StaticText.new(comp_view,135@25).string_("Tiempo restante del paisaje = ").font_(Font("Times New Roman", 10, true));
	~fr_gui_tiempo_paisaje_txt = StaticText.new(comp_view,25@22);
	~fr_gui_tiempo_paisaje_txt.string = "0";
	~fr_gui_tiempo_paisaje_txt.font_(Font("Times New Roman", 12, true));

	comp_view.decorator.nextLine;

	StaticText.new(comp_view,92@18).string_("Tiempo de transición = ").font_(Font("Times New Roman", 9, true));
	~fr_gui_xfade_dur = StaticText.new(comp_view,21@18);
	~fr_gui_xfade_dur.string = "0";
	~fr_gui_xfade_dur.font_(Font("Times New Roman", 11, true));
	xfade_tiempo_in = TextField.new(comp_view,25@20);
	xfade_value_in = TextField.new(comp_view,25@20);

	comp_view.decorator.nextLine;

	comp_view.decorator.left_(120);

	~fr_gui_btn_xfade = Button.new(comp_view, 70@20).states_(
		[
			["T(s)    XF(%)", Color.black, Color.green],
			["T(s)    XF(%)", Color.black, Color.yellow],
			["T(s)    XF(%)", Color.black, Color.red],


	]);


	~fr_gui_btn_xfade.action = {

		~fr_xfdur = xfade_tiempo_in.string.asInteger;
		~fr_xfade = xfade_value_in.string.asInteger/100;

		if(~fr_xfade_A_B == true,{
			if((~fr_xfade < 1) && (~fr_xfade > 0),{ //var hang=true;
				~fr_btn_xfade_check = true;
				~f_fr_xfade_manual.value(~fr_xfdur, ~fr_xfade);
				~fr_gui_btn_xfade.value = 1;
				//~ambix_xfade_m_t = true;
				//"fr_xfade != 0 A_B".postln;
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
				"GUI - ~fr_xfade == 0 A_B".postln;
			});
			if(~fr_xfade == 1,{ //hang=false;
				~fr_btn_xfade_check = true;
				~f_fr_xfade_A_B_1.value(~fr_xfdur, ~fr_xfade);

			})
		});
		if(~fr_xfade_B_A == true,{
			if((~fr_xfade < 1) && (~fr_xfade > 0),{
				~fr_btn_xfade_check = true;
				~f_fr_xfade_manual.value(~fr_xfdur, ~fr_xfade);
				~fr_gui_btn_xfade.value = 1;
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
			if(~fr_xfade == 0,{ //hang=false;
				~fr_btn_xfade_check = true;
				~f_fr_xfade_B_A_0.value(~fr_xfdur, ~fr_xfade);
			})
		});
	};



	///Inicializador de estados de botones
	iniciar_btn.enabled = false;
	~fr_gui_btn_A.enabled = false;
	~fr_gui_btn_A.value = 2;
	~fr_gui_fl.enabled = false;
	~fr_gui_fl.value = 12;
	~fr_gui_btn_B.enabled = false;
	~fr_gui_btn_B.value = 2;
	~fr_gui_btn_xfade.enabled = false;
	~fr_gui_btn_xfade.value = 2;



///// Selector de categorías y subcategorías Frente/////

	 ~f_gui_fr_cat = {
	 	var ww = 900, hw = 100, title, compv_cat, compv_natur, compv_human, compv_soc, compv_arti, compv_silencio, cat_natur_subcat, cat_human_subcat, cat_soc_subcat, cat_arti_subcat, cat_silencio_subcat, btn, chkb_todo, chkb_natur, chkb_human, chkb_soc, chkb_arti, chkb_silencio;
	 	if(window_selector_cat != nil,{
			window_selector_cat.close});

	 	window_selector_cat = Window.new("Categorías estéreo",Rect(ww,hw,960,490),false);

	 	window_selector_cat.alwaysOnTop_(true);
	 	window_selector_cat.alpha_(0.9);
	 	window_selector_cat.front;
	 	title = StaticText.new(window_selector_cat, Rect(((ww/2)-85),10,120,45)).string_("Categorías y subcategorías estéreo");
	 	title.font = Font("Times New Roman", 18, true);
	 	btn_hide = Button.new(window_selector_cat,Rect(((ww/2)+155),10,75,45));
	 	btn_hide.states = ([
	 		["Ocultar", Color.black]
	 	]);
		btn_hide.font = Font("Times Nes Roman", 14, true);
	 	btn_hide.action = {window_selector_cat.visible_(false);
	 		btn_selector.valueAction_(0);
	 	};


	 	compv_cat = CompositeView(window_selector_cat,Rect(20,105,920,400-30));
	 	compv_cat.background = Color.white.alpha_(0.8);
	 	compv_cat.decorator = FlowLayout(compv_cat.bounds,10@10,10@10);

	 	compv_natur = CompositeView(compv_cat, 148@260);
	 	compv_natur.decorator = FlowLayout(compv_natur.bounds,10@10,10@5);
	 	compv_natur.background = Color.green.alpha_(0.3);

		~gui_fr_chkb_natur = CheckBox.new(compv_natur, 130@35, "Naturaleza");
		~gui_fr_chkb_natur.font = Font("Times New Roman", 14, true);
		~gui_fr_chkb_natur.value = true;

	//Checkboxes de subcategorías de naturaleza
	cat_natur_subcat = ["Agua", "Aire", "Tierra", "Fuego", "Plantas", "Animales", "Humanos", "Ecosistemas"];
				~gui_array_fr_subc_nature = Array.fill(8, {arg i; CheckBox.new(compv_natur, 130@20, cat_natur_subcat[i])});
	~gui_array_fr_subc_nature.do({ arg item, index;
		item.value = true;
		item.action = {
				~switch_stereo.value("frente", "naturaleza", index, item.value);
			if(item.value == true && ~gui_fr_chkb_natur.value == false, {
				~gui_fr_chkb_natur.value = true;
				~categorias_fr.add(\naturaleza -> ~fr_naturaleza);
			});

			("~gui_array_fr_subc_nature.do index" + index).postln;
			("~gui_array_fr_subc_nature.do item" + item.value).postln;
		};
	});

	//Checkbox de categoría Naturaleza

	~gui_fr_chkb_natur.action = {
		 if(~gui_fr_chkb_natur.value == false, {
				~gui_array_fr_subc_nature.do({ arg item, index;
					item.value = false;
					~switch_stereo.value("frente", "naturaleza", index, item.value);
				});
				~categorias_fr.removeAt(\naturaleza);
			},
			{
			// Activa los checkboxes de subcategorías de naturaleza si no están deshabilitados

			~gui_array_fr_subc_nature.do({ arg item, index;
				if(item.enabled == true, {
					item.value = true;
					~switch_stereo.value("frente", "naturaleza", index, item.value);

				});
				~categorias_fr.add(\naturaleza -> ~fr_naturaleza);
					});
				});
				};

// Sociedad

				compv_soc = CompositeView(compv_cat, 168@350);
				compv_soc.decorator = FlowLayout(compv_soc.bounds,10@10,10@5);
				compv_soc.background = Color.blue.alpha_(0.3);
				~gui_fr_chkb_soc = CheckBox.new(compv_soc, 130@35, "Sociedad");
				~gui_fr_chkb_soc.font = Font("Times New Roman", 14, true);
				~gui_fr_chkb_soc.value = true;
				cat_soc_subcat = ["Regiones rurales", "Ciudad", "Puertos", "Ámbito doméstico", "Oficinas", "Fábricas", "Otros lugares de trabajo", "Entretenimiento", "Muchedumbres", "Ceremonias", "Parques y jardines", "Indicadores sonoros"];
				~gui_array_fr_subc_soc = Array.fill(12, {arg i; CheckBox.new(compv_soc, 140@20, cat_soc_subcat[i])});
	~gui_array_fr_subc_soc.do({ arg item, index;
		item.value = true;
		item.action = {
			~switch_stereo.value("frente", "sociedad", index, item.value);
			if(item.value == true, {
				~gui_fr_chkb_soc.value = true;
				~categorias_fr.add(\sociedad -> ~fr_sociedad);
			});

			("~gui_array_fr_subc_soc index" + index).postln;
			("~gui_array_fr_subc_soc.do item" + item.value).postln;
		};
	});



	~gui_fr_chkb_soc.action = { var c_subc_soc = 0;
		if(~gui_fr_chkb_soc.value == false, {
			~gui_array_fr_subc_soc.do({ arg item, index;
				item.value = false;
				~switch_stereo.value("frente", "sociedad", index, item.value);
			});
			~categorias_fr.removeAt(\sociedad);
		},

		// Activa los checkboxes de subcategorías de sociedad si no están deshabilitados
		{
			~gui_array_fr_subc_soc.do({ arg item, index;
				if(item.enabled == true, {
					item.value = true;
					~switch_stereo.value("frente", "sociedad", index, item.value);
					c_subc_soc = c_subc_soc + 1;
				});
				~categorias_fr.add(\sociedad -> ~fr_sociedad);
			});
	};
		);
	};

/// Artilugios Mecánicos

				compv_arti = CompositeView(compv_cat, 228@260);
				compv_arti.decorator = FlowLayout(compv_arti.bounds,10@10,10@5);
				compv_arti.background = Color.black.alpha_(0.3);
				~gui_fr_chkb_arti = CheckBox.new(compv_arti, 150@35, "Artilugios mecánicos");
				~gui_fr_chkb_arti.font = Font("Times New Roman", 14, true);
				~gui_fr_chkb_arti.value = true;
				cat_arti_subcat = ["Mecanismos varios", "Maquinaria industrial", "Transportes", "Máquinas de guerra", "Maquinaria de construcción/demolición", "Ventiladores/aires acondicionados", "Herramientas"];
				~gui_array_fr_subc_arti = Array.fill(7, {arg i; CheckBox.new(compv_arti, 205@20, cat_arti_subcat[i])});

	// Checkboxes de subcategorías de Artilugios mecánicos

	~gui_array_fr_subc_arti.do({ arg item, index;
		item.value = true;
		item.action = {
			~switch_stereo.value("frente", "artilugios", index, item.value);
			if(item.value == true && ~gui_fr_chkb_arti.value == false, {
				~gui_fr_chkb_arti.value = true;
				~categorias_fr.add(\artilugios -> ~fr_artilugios);
						});

			("~gui_array_fr_subc_arti index" + index).postln;
			("~gui_array_fr_subc_arti.do item" + item.value).postln;
		};
	});

	~gui_fr_chkb_arti.action = {var c_subc_arti = 0;
		"GUI - ~gui_fr_chkb_arti.action".postln;
		if(~gui_fr_chkb_arti.value == false, {
			~gui_array_fr_subc_arti.do({ arg item, index;
				item.value = false;
				~switch_stereo.value("frente", "artilugios", index, item.value);
			});
			~categorias_fr.removeAt(\artilugios);
		}, {
			~gui_array_fr_subc_arti.do({ arg item, index;
				if(item.enabled == true, {
					item.value = true;
					~switch_stereo.value("frente", "artilugios", index, item.value);
					c_subc_arti = c_subc_arti + 1;
				});

			});
			~categorias_fr.add(\artilugios -> ~fr_artilugios);
				});
				};

/// Quietud y silencio

				compv_silencio = CompositeView(compv_cat, 168@260);
				compv_silencio.decorator = FlowLayout(compv_silencio.bounds,10@10,10@5);
				compv_silencio.background = Color.fromHexString("#FF9305").alpha_(0.5);
				~gui_fr_chkb_silencio = CheckBox.new(compv_silencio, 150@35, "Quietud y silencio");
				~gui_fr_chkb_silencio.font = Font("Times New Roman", 14, true);
				~gui_fr_chkb_silencio.value = true;
				cat_silencio_subcat = ["Hum", "Espacios vacíos"];
				~gui_array_fr_subc_silencio = Array.fill(2, {arg i; CheckBox.new(compv_silencio, 205@20, cat_silencio_subcat[i])});

	//Botones de subcategorías de Quietud y silencio

	~gui_array_fr_subc_silencio.do({ arg item, index;
		item.value = true;
		item.action = {
			~switch_stereo.value("frente", "quietud", index, item.value);
			if(item.value == true, {
				~gui_fr_chkb_silencio.value = true;
				~categorias_fr.add(\quietud -> ~fr_quietud);

			});
			("~gui_array_fr_subc_quietud index" + index).postln;
			("~gui_array_fr_subc_quietud.do item" + item.value).postln;
		};
	});


	//Botón de categoría quietud y silencio

	~gui_fr_chkb_silencio.action = {
		if(~gui_fr_chkb_silencio.value == false, {
			~gui_array_fr_subc_silencio.do({ arg item, index;
				item.valueAction = false;
				~switch_stereo.value("frente", "quietud", index, item.value);
			});
			~categorias_fr.removeAt(\quietud);
		}, {
			~gui_array_fr_subc_silencio.do({ arg item, index;
				if(item.enabled == true, {
					item.value = true;
					~switch_stereo.value("frente", "quietud", index, item.value);
				});

			});
			~categorias_fr.add(\quietud -> ~fr_quietud);
		}
		);
	};


};

	// Función para indicar cambios de volumen en la gui
	~f_fr_vol_gui = { arg amp, lag;
	var r_vol;
	r_vol = Routine{
	{lag >= 0}.while({
			{gui_vol_txt.string_("-->");
			vol_control_btn.value = 1;
			vol_tiempo_txt.string = lag}.defer;
			(0.1).wait;
			lag = lag.round(0.1) - 0.1;
		});
		{vol_control_btn.value = 0;
		gui_vol_txt.string_(amp)}.defer;
		if(amp == 0,{
			"fade-out frente".postln;
			{iniciar_btn.value = 0;
			comp_view.background_(Color.yellow.alpha_(0.5));
			}.defer;
			~r_fr.stop;
			~fr_synth.free;
			"rutina Frente detenida".postln;
				{iniciar_btn.enabled = true}.defer;
		});

		r_vol.stop;

		};
	r_vol.play;
};

	if (selector_init == 0, {
	~f_gui_fr_cat.value;
	btn_selector.valueAction_(1);
	(0.5).wait;
	{
		btn_hide.valueAction_(1);
	}.defer;
}.fork);

}.value;








////////////////////////CONTROLES DERECHA 45°////////////////////////////////

{
	~d45_comp = CompositeView(~gui_comp_view, 200@215);
	~d45_comp.background = Color.yellow.alpha_(0.5);

	~gui_comp_view.decorator.nextLine;
}.value;





///////////////////////// CONTROLES I90////////////////////////////

{
	var comp_view, gui_vol_txt, vol_control_btn, vol_tiempo_txt, vol_btn, btn_selector, window_selector_cat, btn_hide, iniciar_btn, xfade_tiempo_in, xfade_value_in, selector_init=0;



	comp_view = CompositeView(~gui_comp_view, 200@215);
	comp_view.background = Color.fromHexString("#F0CB11");
	comp_view.decorator_(FlowLayout(comp_view.bounds, 5@10, 3@7));

	btn_selector = Button.new(comp_view, 68@22);
	btn_selector.font = Font("Times New Roman", 16, true);
	btn_selector.states = ([
		["I-90°", Color.black, Color.green],
		["I-90°", Color.black, Color.blue.alpha_(0.5)]
	]);
	btn_selector.action = { arg value;
	if(value.value == 1 && selector_init == 1, {window_selector_cat.visible_(true);});
	if(value.value == 1 && selector_init == 0, {~f_gui_i90_cat.value; selector_init=1});
		};




iniciar_btn = Button.new(comp_view, 85@22).states_(
	[
		["Iniciar", Color.black, Color.yellow],
		["Reproduciendo", Color.black, Color.green],

]);

iniciar_btn.action = {
		var lag = ~i90_gui_vol_tiempo_in.string.asInteger;
		var vol = ~i90_gui_vol_value_in.string.asInteger/100;
		~i90_gui_btn_xfade.enabled_(true);
		~i90_gui_btn_xfade.value = 0;
		comp_view.background_(Color.green.alpha_(0.5));
		~i90_gui_xfade_dur.string = "-";
		~i90_gui_tiempo_paisaje_txt.string = "-";
		"ambix_gui_start".postln;
		~f_i90_r.value;
		iniciar_btn.enabled = false;
};


comp_view.decorator.nextLine;

~i90_gui_btn_A = Button.new(comp_view, 35@20).states_(
	[
		["A0", Color.black, Color.green],
		["A0", Color.black, Color.yellow],
		["A0", Color.black, Color.red]
]);
~i90_gui_btn_A.enabled = false;

~i90_gui_fl = Button.new(comp_view, 30@20).states_(
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


~i90_gui_btn_B = Button.new(comp_view, 35@20).states_(
	[
		["B1", Color.black, Color.green],
		["B1", Color.black, Color.yellow],
		["B1", Color.black, Color.red]
]);



comp_view.decorator.nextLine;
StaticText.new(comp_view,70@22).string_("Volumen = ").font_(Font("Times New Roman", 14, true));
gui_vol_txt = StaticText.new(comp_view,40@22);
gui_vol_txt.string = "0";
gui_vol_txt.font_(Font("Times New Roman", 14, true));
~i90_gui_vol_tiempo_in = TextField.new(comp_view,25@20);
~i90_gui_vol_value_in = TextField.new(comp_view,25@20);

comp_view.decorator.nextLine;

StaticText.new(comp_view,85@22).string_("Tiempo de fade = ").font_(Font("Times New Roman", 9, true));
vol_tiempo_txt = StaticText.new(comp_view,22@22);
vol_tiempo_txt.string = "0";
vol_tiempo_txt.font_(Font("Times New Roman", 12, true));

vol_control_btn = Button.new(comp_view, 66@20).states_(
	[
		["T(s)    V(%)", Color.black, Color.green],
		["T(s)    V(%)", Color.black, Color.yellow],

]);

vol_control_btn.action = {
	if((iniciar_btn.value == 0), //Quiere decir que arranca un fade-in
		{
			iniciar_btn.enabled_(true);
			"Fade-in I90".postln;
		},{
				var amp=~i90_gui_vol_value_in.string.asInteger/100, lag=~i90_gui_vol_tiempo_in.string.asInteger;
			//~f_ambix_vol.value(amp, lag);
				~i90_synth.set(\amp,amp, \amp_lag,lag);
				~f_i90_vol_gui.value(amp, lag);
	});
	};




	comp_view.decorator.nextLine;
	StaticText.new(comp_view,135@25).string_("Tiempo restante del paisaje = ").font_(Font("Times New Roman", 10, true));
	~i90_gui_tiempo_paisaje_txt = StaticText.new(comp_view,25@22);
	~i90_gui_tiempo_paisaje_txt.string = "0";
	~i90_gui_tiempo_paisaje_txt.font_(Font("Times New Roman", 12, true));

	comp_view.decorator.nextLine;

	StaticText.new(comp_view,92@18).string_("Tiempo de transición = ").font_(Font("Times New Roman", 9, true));
	~i90_gui_xfade_dur = StaticText.new(comp_view,21@18);
	~i90_gui_xfade_dur.string = "0";
	~i90_gui_xfade_dur.font_(Font("Times New Roman", 11, true));
	xfade_tiempo_in = TextField.new(comp_view,25@20);
	xfade_value_in = TextField.new(comp_view,25@20);

	comp_view.decorator.nextLine;

	comp_view.decorator.left_(120);

	~i90_gui_btn_xfade = Button.new(comp_view, 70@20).states_(
		[
			["T(s)    XF(%)", Color.black, Color.green],
			["T(s)    XF(%)", Color.black, Color.yellow],
			["T(s)    XF(%)", Color.black, Color.red],


	]);


	~i90_gui_btn_xfade.action = {

		~i90_xfdur = xfade_tiempo_in.string.asInteger;
		~i90_xfade = xfade_value_in.string.asInteger/100;

		if(~i90_xfade_A_B == true,{
			if((~i90_xfade < 1) && (~i90_xfade > 0),{ //var hang=true;
				~i90_btn_xfade_check = true;
				~f_i90_xfade_manual.value(~i90_xfdur, ~i90_xfade);
				~i90_gui_btn_xfade.value = 1;
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
				"GUI - ~i90_xfade == 0 A_B".postln;
			});
			if(~i90_xfade == 1,{
				~i90_btn_xfade_check = true;
				~f_i90_xfade_A_B_1.value(~i90_xfdur, ~i90_xfade);

			})
		});
		if(~i90_xfade_B_A == true,{
			if((~i90_xfade < 1) && (~i90_xfade > 0),{
				~i90_btn_xfade_check = true;
				~f_i90_xfade_manual.value(~i90_xfdur, ~i90_xfade);
				~i90_gui_btn_xfade.value = 1;
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
			if(~i90_xfade == 0,{ //hang=false;
				~i90_btn_xfade_check = true;
				~f_i90_xfade_B_A_0.value(~i90_xfdur, ~i90_xfade);
			})
		});
	};



	///Inicializador de estados de botones
	iniciar_btn.enabled = false;
	~i90_gui_btn_A.enabled = false;
	~i90_gui_btn_A.value = 2;
	~i90_gui_fl.enabled = false;
	~i90_gui_fl.value = 12;
	~i90_gui_btn_B.enabled = false;
	~i90_gui_btn_B.value = 2;
	~i90_gui_btn_xfade.enabled = false;
	~i90_gui_btn_xfade.value = 2;



///// Selector de categorías y subcategorías Izquierda 90°/////

	 ~f_gui_i90_cat = {
	 	var ww = 900, hw = 100, title, compv_cat, compv_natur, compv_human, compv_soc, compv_arti, compv_silencio, cat_natur_subcat, cat_human_subcat, cat_soc_subcat, cat_arti_subcat, cat_silencio_subcat, btn, chkb_todo, chkb_natur, chkb_human, chkb_soc, chkb_arti, chkb_silencio;
	 	if(window_selector_cat != nil,{
			window_selector_cat.close});

	 	window_selector_cat = Window.new("Categorías estéreo",Rect(ww,hw,960,490),false);

	 	window_selector_cat.alwaysOnTop_(true);
	 	window_selector_cat.alpha_(0.9);
	 	window_selector_cat.front;
	 	title = StaticText.new(window_selector_cat, Rect(((ww/2)-150),5,250,100)).string_("Categorías y subcategorías I-90°");
	 	title.font = Font("Times New Roman", 24, true);
	 	btn_hide = Button.new(window_selector_cat,Rect(((ww/2)+155),10,75,45));
	 	btn_hide.states = ([
	 		["Ocultar", Color.black]
	 	]);
		btn_hide.font = Font("Times Nes Roman", 14, true);
	 	btn_hide.action = {window_selector_cat.visible_(false);
	 		btn_selector.valueAction_(0);
	 	};


	 	compv_cat = CompositeView(window_selector_cat,Rect(20,105,920,400-30));
	 	compv_cat.background = Color.white.alpha_(0.8);
	 	compv_cat.decorator = FlowLayout(compv_cat.bounds,10@10,10@10);

	 	compv_natur = CompositeView(compv_cat, 148@260);
	 	compv_natur.decorator = FlowLayout(compv_natur.bounds,10@10,10@5);
	 	compv_natur.background = Color.green.alpha_(0.3);

		~gui_i90_chkb_natur = CheckBox.new(compv_natur, 130@35, "Naturaleza");
		~gui_i90_chkb_natur.font = Font("Times New Roman", 14, true);
		~gui_i90_chkb_natur.value = true;

	//Checkboxes de subcategorías de naturaleza
	cat_natur_subcat = ["Agua", "Aire", "Tierra", "Fuego", "Plantas", "Animales", "Humanos", "Ecosistemas"];
				~gui_array_i90_subc_nature = Array.fill(8, {arg i; CheckBox.new(compv_natur, 130@20, cat_natur_subcat[i])});
	~gui_array_i90_subc_nature.do({ arg item, index;
		item.value = true;
		item.action = {
				~switch_stereo.value("i90", "naturaleza", index, item.value);
			if(item.value == true && ~gui_i90_chkb_natur.value == false, {
				~gui_i90_chkb_natur.value = true;
				~categorias_i90.add(\naturaleza -> ~i90_naturaleza);
			});

			("~gui_array_i90_subc_nature.do index" + index).postln;
			("~gui_array_i90_subc_nature.do item" + item.value).postln;
		};
	});

	//Checkbox de categoría Naturaleza

	~gui_i90_chkb_natur.action = {
		 if(~gui_i90_chkb_natur.value == false, {
				~gui_array_i90_subc_nature.do({ arg item, index;
					item.value = false;
					~switch_stereo.value("i90", "naturaleza", index, item.value);
				});
				~categorias_i90.removeAt(\naturaleza);
			},
			{
			// Activa los checkboxes de subcategorías de naturaleza si no están deshabilitados

			~gui_array_i90_subc_nature.do({ arg item, index;
				if(item.enabled == true, {
					item.value = true;
					~switch_stereo.value("i90", "naturaleza", index, item.value);

				});
				~categorias_i90.add(\naturaleza -> ~i90_naturaleza);
					});
				});
				};

// Sociedad

				compv_soc = CompositeView(compv_cat, 168@350);
				compv_soc.decorator = FlowLayout(compv_soc.bounds,10@10,10@5);
				compv_soc.background = Color.blue.alpha_(0.3);
				~gui_i90_chkb_soc = CheckBox.new(compv_soc, 130@35, "Sociedad");
				~gui_i90_chkb_soc.font = Font("Times New Roman", 14, true);
				~gui_i90_chkb_soc.value = true;
				cat_soc_subcat = ["Regiones rurales", "Ciudad", "Puertos", "Ámbito doméstico", "Oficinas", "Fábricas", "Otros lugares de trabajo", "Entretenimiento", "Muchedumbres", "Ceremonias", "Parques y jardines", "Indicadores sonoros"];
				~gui_array_i90_subc_soc = Array.fill(12, {arg i; CheckBox.new(compv_soc, 140@20, cat_soc_subcat[i])});
	~gui_array_i90_subc_soc.do({ arg item, index;
		item.value = true;
		item.action = {
			~switch_stereo.value("i90", "sociedad", index, item.value);
			if(item.value == true, {
				~gui_i90_chkb_soc.value = true;
				~categorias_i90.add(\sociedad -> ~i90_sociedad);
			});

			("~gui_array_i90_subc_soc index" + index).postln;
			("~gui_array_i90_subc_soc.do item" + item.value).postln;
		};
	});



	~gui_i90_chkb_soc.action = { var c_subc_soc = 0;
		if(~gui_i90_chkb_soc.value == false, {
			~gui_array_i90_subc_soc.do({ arg item, index;
				item.value = false;
				~switch_stereo.value("i90", "sociedad", index, item.value);
			});
			~categorias_i90.removeAt(\sociedad);
		},

		// Activa los checkboxes de subcategorías de sociedad si no están deshabilitados
		{
			~gui_array_i90_subc_soc.do({ arg item, index;
				if(item.enabled == true, {
					item.value = true;
					~switch_stereo.value("i90", "sociedad", index, item.value);
					c_subc_soc = c_subc_soc + 1;
				});
				~categorias_i90.add(\sociedad -> ~i90_sociedad);
			});
	};
		);
	};

/// Artilugios Mecánicos

				compv_arti = CompositeView(compv_cat, 228@260);
				compv_arti.decorator = FlowLayout(compv_arti.bounds,10@10,10@5);
				compv_arti.background = Color.black.alpha_(0.3);
				~gui_i90_chkb_arti = CheckBox.new(compv_arti, 150@35, "Artilugios mecánicos");
				~gui_i90_chkb_arti.font = Font("Times New Roman", 14, true);
				~gui_i90_chkb_arti.value = true;
				cat_arti_subcat = ["Mecanismos varios", "Maquinaria industrial", "Transportes", "Máquinas de guerra", "Maquinaria de construcción/demolición", "Ventiladores/aires acondicionados", "Herramientas"];
				~gui_array_i90_subc_arti = Array.fill(7, {arg i; CheckBox.new(compv_arti, 205@20, cat_arti_subcat[i])});

	// Checkboxes de subcategorías de Artilugios mecánicos

	~gui_array_i90_subc_arti.do({ arg item, index;
		item.value = true;
		item.action = {
			~switch_stereo.value("i90", "artilugios", index, item.value);
			if(item.value == true && ~gui_i90_chkb_arti.value == false, {
				~gui_i90_chkb_arti.value = true;
				~categorias_i90.add(\artilugios -> ~i90_artilugios);
						});

			("~gui_array_i90_subc_arti index" + index).postln;
				("~gui_array_i90_subc_arti.do" + item + " " + item.value).postln;
		};
	});

	~gui_i90_chkb_arti.action = {var c_subc_arti = 0;
		"GUI - ~gui_i90_chkb_arti.action".postln;
		if(~gui_i90_chkb_arti.value == false, {
			~gui_array_i90_subc_arti.do({ arg item, index;
				item.value = false;
				~switch_stereo.value("i90", "artilugios", index, item.value);
			});
			~categorias_i90.removeAt(\artilugios);
		}, {
			~gui_array_i90_subc_arti.do({ arg item, index;
				if(item.enabled == true, {
					item.value = true;
					~switch_stereo.value("i90", "artilugios", index, item.value);
					c_subc_arti = c_subc_arti + 1;
				});

			});
			~categorias_i90.add(\artilugios -> ~i90_artilugios);
				});
				};

/// Quietud y silencio

				compv_silencio = CompositeView(compv_cat, 168@260);
				compv_silencio.decorator = FlowLayout(compv_silencio.bounds,10@10,10@5);
				compv_silencio.background = Color.fromHexString("#FF9305").alpha_(0.5);
				~gui_i90_chkb_silencio = CheckBox.new(compv_silencio, 150@35, "Quietud y silencio");
				~gui_i90_chkb_silencio.font = Font("Times New Roman", 14, true);
				~gui_i90_chkb_silencio.value = true;
				cat_silencio_subcat = ["Hum", "Espacios vacíos"];
				~gui_array_i90_subc_silencio = Array.fill(2, {arg i; CheckBox.new(compv_silencio, 205@20, cat_silencio_subcat[i])});

	//Botones de subcategorías de Quietud y silencio

	~gui_array_i90_subc_silencio.do({ arg item, index;
		item.value = true;
		item.action = {
			~switch_stereo.value("i90", "quietud", index, item.value);
			if(item.value == true, {
				~gui_i90_chkb_silencio.value = true;
				~categorias_i90.add(\quietud -> ~i90_quietud);

			});
			("~gui_array_i90_subc_quietud index" + index).postln;
			("~gui_array_i90_subc_quietud.do item" + item.value).postln;
		};
	});


	//Botón de categoría quietud y silencio

	~gui_i90_chkb_silencio.action = {
		if(~gui_i90_chkb_silencio.value == false, {
			~gui_array_i90_subc_silencio.do({ arg item, index;
				item.valueAction = false;
				~switch_stereo.value("i90", "quietud", index, item.value);
			});
			~categorias_i90.removeAt(\quietud);
		}, {
			~gui_array_i90_subc_silencio.do({ arg item, index;
				if(item.enabled == true, {
					item.value = true;
					~switch_stereo.value("i90", "quietud", index, item.value);
				});

			});
			~categorias_i90.add(\quietud -> ~i90_quietud);
		}
		);
	};


};

	// Función para indicar cambios de volumen en la gui
	~f_i90_vol_gui = { arg amp, lag;
	var r_vol;
	r_vol = Routine{
	{lag >= 0}.while({
			{gui_vol_txt.string_("-->");
			vol_control_btn.value = 1;
			vol_tiempo_txt.string = lag}.defer;
			(0.1).wait;
			lag = lag.round(0.1) - 0.1;
		});
		{vol_control_btn.value = 0;
		gui_vol_txt.string_(amp)}.defer;
		if(amp == 0,{
			"fade-out i90".postln;
			{iniciar_btn.value = 0;
			comp_view.background_(Color.yellow.alpha_(0.5));
			}.defer;
			~r_i90.stop;
			~i90_synth.free;
			"rutina i90 detenida".postln;
				{iniciar_btn.enabled = true}.defer;
		});

		r_vol.stop;

		};
	r_vol.play;
};

	if (selector_init == 0, {
	~f_gui_i90_cat.value;
	btn_selector.valueAction_(1);
	(0.5).wait;
	{
		btn_hide.valueAction_(1);
	}.defer;
}.fork);

}.value;



/////////////////////////CONTROLES AMBIX//////////////////////////////



{ var comp_view, gui_vol_txt, vol_control_btn, vol_tiempo_txt, vol_btn, btn_selector, window_selector_cat, window_selector_cat_hide, iniciar_btn, xfade_tiempo_in, xfade_value_in, selector_init=0;



	comp_view = CompositeView(~gui_comp_view, 200@215);
	comp_view.background = Color.fromHexString("#F0CB11");
	comp_view.decorator_(FlowLayout(comp_view.bounds, 5@10, 3@7));

	btn_selector = Button.new(comp_view, 68@22);
	btn_selector.font = Font("Times New Roman", 16, true);
	btn_selector.states = ([
		["AmbiX", Color.black, Color.green],
		["AmbiX", Color.black, Color.blue.alpha_(0.5)]
	]);
	btn_selector.action = { arg value;
	if(value.value == 1 && selector_init == 1, {window_selector_cat.visible_(true)});
	if(value.value == 1 && selector_init == 0, {~f_gui_ambix_cat.value; selector_init=1});
		};




iniciar_btn = Button.new(comp_view, 85@22).states_(
	[
		["Iniciar", Color.white, Color.red],
		["Reproduciendo", Color.black, Color.green],

]);

iniciar_btn.action = {
		var lag = ~ambix_gui_vol_tiempo_in.string.asInteger;
		var vol = ~ambix_gui_vol_value_in.string.asInteger/100;
		~ambix_gui_btn_xfade.enabled_(true);
		~ambix_gui_btn_xfade.value = 0;
		comp_view.background_(Color.green.alpha_(0.5));
		~ambix_gui_xfade_dur.string = "-";
		~ambix_gui_tiempo_paisaje_txt.string = "-";
		"ambix_gui_start".postln;
		~f_ambix_r.value;
		iniciar_btn.enabled = false;
};


comp_view.decorator.nextLine;

~ambix_gui_btn_A = Button.new(comp_view, 35@20).states_(
	[
		["A0", Color.black, Color.green],
		["A0", Color.black, Color.yellow],
		["A0", Color.black, Color.red]
]);
~ambix_gui_btn_A.enabled = false;

~ambix_gui_fl = Button.new(comp_view, 30@20).states_(
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


~ambix_gui_btn_B = Button.new(comp_view, 35@20).states_(
	[
		["B1", Color.black, Color.green],
		["B1", Color.black, Color.yellow],
		["B1", Color.black, Color.red]
]);



comp_view.decorator.nextLine;
StaticText.new(comp_view,70@22).string_("Volumen = ").font_(Font("Times New Roman", 14, true));
gui_vol_txt = StaticText.new(comp_view,40@22);
gui_vol_txt.string = "0";
gui_vol_txt.font_(Font("Times New Roman", 14, true));
~ambix_gui_vol_tiempo_in = TextField.new(comp_view,25@20);
~ambix_gui_vol_value_in = TextField.new(comp_view,25@20);

comp_view.decorator.nextLine;

StaticText.new(comp_view,85@22).string_("Tiempo de fade = ").font_(Font("Times New Roman", 9, true));
vol_tiempo_txt = StaticText.new(comp_view,22@22);
vol_tiempo_txt.string = "0";
vol_tiempo_txt.font_(Font("Times New Roman", 12, true));

vol_control_btn = Button.new(comp_view, 66@20).states_(
	[
		["T(s)    V(%)", Color.black, Color.green],
		["T(s)    V(%)", Color.black, Color.yellow],

]);

vol_control_btn.action = {
	if((iniciar_btn.value == 0), //Quiere decir que arranca un fade-in
		{
			iniciar_btn.enabled_(true);
			"Fade-in ambiX".postln;
		},{
				var amp=~ambix_gui_vol_value_in.string.asInteger/100, lag=~ambix_gui_vol_tiempo_in.string.asInteger;
			//~f_ambix_vol.value(amp, lag);
				~ambix_synth.set(\amp,amp, \amp_lag,lag);
				~f_ambix_vol_gui.value(amp, lag);
	});
	};




	comp_view.decorator.nextLine;
	StaticText.new(comp_view,135@25).string_("Tiempo restante del paisaje = ").font_(Font("Times New Roman", 10, true));
	~ambix_gui_tiempo_paisaje_txt = StaticText.new(comp_view,25@22);
	~ambix_gui_tiempo_paisaje_txt.string = "0";
	~ambix_gui_tiempo_paisaje_txt.font_(Font("Times New Roman", 12, true));

	comp_view.decorator.nextLine;

	StaticText.new(comp_view,92@18).string_("Tiempo de transición = ").font_(Font("Times New Roman", 9, true));
	~ambix_gui_xfade_dur = StaticText.new(comp_view,21@18);
	~ambix_gui_xfade_dur.string = "0";
	~ambix_gui_xfade_dur.font_(Font("Times New Roman", 11, true));
	xfade_tiempo_in = TextField.new(comp_view,25@20);
	xfade_value_in = TextField.new(comp_view,25@20);

	comp_view.decorator.nextLine;

	comp_view.decorator.left_(120);

	~ambix_gui_btn_xfade = Button.new(comp_view, 70@20).states_(
		[
			["T(s)    XF(%)", Color.black, Color.green],
			["T(s)    XF(%)", Color.black, Color.yellow],
			["T(s)    XF(%)", Color.black, Color.red],


	]);


	~ambix_gui_btn_xfade.action = {

		~ambix_xfdur = xfade_tiempo_in.string.asInteger;
		~ambix_xfade = xfade_value_in.string.asInteger/100;

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



	///Inicializador de estados de botones
	iniciar_btn.enabled = false;
	~ambix_gui_btn_A.enabled = false;
	~ambix_gui_btn_A.value = 2;
	~ambix_gui_fl.enabled = false;
	~ambix_gui_fl.value = 12;
	~ambix_gui_btn_B.enabled = false;
	~ambix_gui_btn_B.value = 2;
	~ambix_gui_btn_xfade.enabled = false;
	~ambix_gui_btn_xfade.value = 2;




///// GUI de selector de categorías y subcategorías AmbiX

~f_gui_ambix_cat = {
			var ww = 900, hw = 100, title, compv_cat, compv_natur, compv_human, compv_soc, compv_arti, compv_silencio, cat_natur_subcat, cat_human_subcat, cat_soc_subcat, cat_arti_subcat, cat_silencio_subcat, btn, chkb_todo, chkb_natur, chkb_human, chkb_soc, chkb_arti, chkb_silencio, aceptar;

		if(window_selector_cat != nil, {
		window_selector_cat.close});

		window_selector_cat = Window.new("Categorías - paisajes sonoros ambisónicos",Rect(ww,hw,800,490),false);
		window_selector_cat.alwaysOnTop_(true);
		window_selector_cat.alpha_(0.9);
		window_selector_cat.front;



				title = StaticText.new(window_selector_cat, Rect(((ww/2)-105),10,175,45)).string_("Categorías - Paisajes sonoros ambisónicos");
			title.font = Font("Times New Roman", 18, true);
				window_selector_cat_hide = Button.new(window_selector_cat,Rect(((ww/2)+155),10,75,45));
				window_selector_cat_hide.states = ([
					["Ocultar", Color.black]
				]);
	window_selector_cat_hide.font = Font("Times Nes Roman", 14, true);
				window_selector_cat_hide.action = {window_selector_cat.visible_(false);
						btn_selector.valueAction_(0);
				};



				compv_cat = CompositeView(window_selector_cat,Rect(20,80,780,400));
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

	// Función para indicar cambios de volumen en la gui
	~f_ambix_vol_gui = { arg amp, lag;
	var r_vol;
	r_vol = Routine{
	{lag >= 0}.while({
			{gui_vol_txt.string_("-->");
			vol_control_btn.value = 1;
			vol_tiempo_txt.string = lag}.defer;
			(0.1).wait;
			lag = lag.round(0.1) - 0.1;
		});
		{vol_control_btn.value = 0;
		gui_vol_txt.string_(amp)}.defer;
		if(amp == 0,{
			"fade-out ambix".postln;
			{iniciar_btn.value = 0;
			comp_view.background_(Color.yellow.alpha_(0.5));
			}.defer;
			~r_ambix.stop;
			~ambix_synth.free;
			"rutina AmbiX detenida".postln;
				{iniciar_btn.enabled = true}.defer;
		});

		r_vol.stop;

		};
	r_vol.play;
};

	if (~gui_init == 0, {
	~f_gui_ambix_cat.value;
	btn_selector.valueAction_(1);
	(0.5).wait;
	{
		window_selector_cat_hide.valueAction_(1);
	}.defer;
}.fork);

}.value;








////////////////////////CONTROLES ARRIBA ///////////////////////////////////


{
	~arri_comp = CompositeView(~gui_comp_view, 200@215);
	~arri_comp.background = Color.yellow.alpha_(0.5);


}.value;





///////////////////// CONTROLES D90////////////////////////////

~d90_comp = CompositeView(~gui_comp_view, 200@215);
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
~gui_comp_view.decorator.nextLine;







/////////////////////////CONTROLES IZQUIERDA 135°////////////////////////


{
	~gui_comp_view.decorator.left_(145);

	~i135_comp = CompositeView(~gui_comp_view, 200@215);
	~i135_comp.background = Color.yellow.alpha_(0.5);



}.value;








/////////////////////////CONTROLES ATRÁS////////////////////////


{

	~back_comp = CompositeView(~gui_comp_view, 200@215);
	~back_comp.background = Color.yellow.alpha_(0.5);



}.value;





/////////////////////////CONTROLES DERECHA 135°////////////////////////


{

	~d135_comp = CompositeView(~gui_comp_view, 200@215);
	~d135_comp.background = Color.yellow.alpha_(0.5);



}.value;




////////ESTADOS INICIALES ////////////////


// ~fr_gui_start.enabled_(false);
// ~fr_gui_btn_A.enabled = false;
// ~fr_gui_btn_A.value = 2;
// ~fr_gui_fl.enabled = false;
// ~fr_gui_fl.value = 12;
// ~fr_gui_btn_B.enabled = false;
// ~fr_gui_btn_B.value = 2;
// ~fr_gui_btn_xfade.enabled = false;
// ~fr_gui_btn_xfade.value = 2;


~d90_gui_start.enabled_(false);
~d90_gui_btn_A.enabled = false;
~d90_gui_btn_A.value = 2;
~d90_gui_btn_B.enabled = false;
~d90_gui_btn_B.value = 2;
~d90_gui_btn_xfade.enabled_(false);
~d90_gui_btn_xfade.value = 2;




/*~gui_btn_selector_inicio.enabled = false;
~ambix_gui_btn_A.enabled = false;
~ambix_gui_btn_A.value = 2;
~ambix_gui_fl.enabled = false;
~ambix_gui_fl.value = 12;
~ambix_gui_btn_B.enabled = false;
~ambix_gui_btn_B.value = 2;
~ambix_gui_btn_xfade.enabled = false;
~ambix_gui_btn_xfade.value = 2;*/



