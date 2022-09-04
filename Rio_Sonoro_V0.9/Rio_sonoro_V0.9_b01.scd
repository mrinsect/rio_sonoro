
VSTPlugin.search
s.boot;

Buffer.freeAll
s.freeAll

s.reboot;

Server.killAll



s.boot;


//Paso 1:

thisProcess.interpreter.executeFile(PathName(thisProcess.nowExecutingPath).pathOnly ++ "inicializador-xfade_V0.9_b04.scd");

//Paso 2:

thisProcess.interpreter.executeFile(PathName(thisProcess.nowExecutingPath).pathOnly ++ "GUI_V0.9_b09.scd");


//Paso 3:
thisProcess.interpreter.executeFile(PathName(thisProcess.nowExecutingPath).pathOnly ++ "rutina_AmbiX_V0.9_b09.scd");

thisProcess.interpreter.executeFile(PathName(thisProcess.nowExecutingPath).pathOnly ++ "rutina_Frente_V0.9_b00.scd");

thisProcess.interpreter.executeFile(PathName(thisProcess.nowExecutingPath).pathOnly ++ "rutina_I90_V0.9_b00.scd");

// Paso 4:


thisProcess.interpreter.executeFile(PathName(thisProcess.nowExecutingPath).pathOnly ++ "funciones_stereo_b01.scd");











// Último paso (6) - ejecutar lo que está entre paréntesis:
//////// DERECHA 90°


(
////FUNCIONES

// selecciona categoría y subcategoría de acuerdo a la selección en la GUI
	~d90_selector_f = { arg selector;
		var cat, subcat;
		cat = rrand(0, selector.size-1);
		subcat = rrand(0, selector[cat].size-1);
		{selector[cat][subcat] == nil}.while({
			cat = rrand(0, selector.size-1);
			subcat = rrand(0, selector[cat].size-1);
		});
		~d90_cat = cat;
		~d90_sub_cat = subcat;
		("Categoría: " + ~d90_cat).postln;
		("Subcategoría: " + ~d90_sub_cat).postln;
		~d90_s_cat = ~categorias[~d90_cat][~d90_sub_cat];
	};



// Toma el tiempo y valor de la transición y los pasa al synthdef
~f_d90_xfade = {
~d90_synth.set(\xfdur,~d90_morph_dur, \morph,~d90_morph_xfade);
};

~d90_morph_m_t = false;

////////// Definición de funciones para D90 y GUI //////////////

//Control de volumen general (incluido Fade-in)
~f_d90_vol = {arg amp, lag;
	var r_vol, c_lag=lag, s_amp;
	~d90_synth.set(\amp,amp, \amp_lag,lag);
	r_vol = Routine{
	{c_lag >= 0}.while({
			{~d90_reloj_vol.string_("-->");
			~d90_reloj_vol_g_t.value = 1;
			~reloj_d90_vol_dur.string = c_lag}.defer;
			(0.1).wait;
			c_lag = c_lag.round(0.1) - 0.1;
		});
		{~d90_reloj_vol_g_t.value = 0;
		~d90_reloj_vol.string_(amp)}.defer;
		if(amp == 0,{
			"fade-out".postln;
			{~d90_gui_start.value = 0;
			~d90_comp.background_(Color.yellow.alpha_(0.5));
			}.defer;
			~r_D90.stop;
			~d90_synth.free;
			"rutina_d90 detenida".postln;
		});

		r_vol.stop;

		};

	r_vol.play;
};







/////////////////////////////



~f_r_D90 = {
~r_D90 = Routine({
	var morph_m=0;
	// Selección del primer paisaje sonoro para Total Right

	///Paisaje A

	///Prueba con nuevo GUI
	// al presionar el botón aceptar pasa el valor del array de los checkboxes a la variable ~selector

	~d90_selector_f.value(~selector);
	"*****************Prueba 1************************".postln;


/// Verifica si esa subcategoría ya no tiene archivos disponbles
	while ({~d90_s_cat.size <= 0},
	{
		/// si se vacía una subcategoría, bloquear ese checkbox del GUI
			"while 1".postln;

		~f_gui_g_subcat_bloq.value(~d90_cat,~d90_sub_cat);


		//~f_gui_d90_subcat_bloq ={}.value;

		~d90_selector_f.value(~selector);
		(0.5).wait;
		};
	);
"*****************Prueba 2************************".postln;

	///// Selecciona un paisaje sonoro de la categoría y subcategoría previamente seleccionada y lo carga en los buffers

	~d90_i_paisaje = rrand(0, ~d90_s_cat.size-1);
	~d90_psjA = ~categorias[~d90_cat][~d90_sub_cat][~d90_i_paisaje];
	(0.1).wait;
	~d90_psjA_L = Buffer.readChannel(s,~d90_psjA.path, channels: [0]);
	~d90_psjA_R = Buffer.readChannel(s,~d90_psjA.path, channels: [1]);

	s.sync;

		//// Quita de la lista el paisaje que ya está cargado en los buffers de A

	    ("D90° - Seleccionado paisaje A. Se remueve " + (~d90_psjA)).postln;

	~categorias[~d90_cat][~d90_sub_cat].removeAt(~d90_i_paisaje);

	"*****************Prueba 3************************".postln;

	///Paisaje B

	~d90_selector_f.value(~selector);

	"*****************Prueba 4************************".postln;

	/// Verifica si esa subcategoría ya no tiene archivos disponbles
	while ({~d90_s_cat.size <= 0},{
		/// si se vacía una subcategoría, bloquear ese checkbox del GUI
		"while prueba 4".postln;

		~f_gui_g_subcat_bloq.value(~d90_cat,~d90_sub_cat);
		~f_gui_d90_subcat_bloq ={}.value;
		~d90_selector_f.value(~selector);
		(0.1).wait;
		});

"*****************Prueba 5************************".postln;
	///// Selecciona un paisaje sonoro de la categoría y subcategoría previamente seleccionada y lo carga en los buffers

	~d90_i_paisaje = rrand(0, ~d90_s_cat.size-1);
	~d90_psjB = ~categorias[~d90_cat][~d90_sub_cat][~d90_i_paisaje];
	(0.1).wait;
	~d90_psjB_L = Buffer.readChannel(s,~d90_psjB.path, channels: [0]);
	~d90_psjB_R = Buffer.readChannel(s,~d90_psjB.path, channels: [1]);

	s.sync;

		//// Quita de la lista el paisaje que ya está cargado en los buffers de A

	    ("D90° - Seleccionado paisaje A. Se remueve " + (~d90_psjB)).postln;

	~categorias[~d90_cat][~d90_sub_cat].removeAt(~d90_i_paisaje);

	"************Prueba 6**************".postln;





~d90_synth = Synth('Morph_Stereo',[
	\out, ~ambiBus[2],
		\b_vol, ~b_vol[2],
		\amp, 0,
		\amp_lag, 0.01,
	\spec_buf1L, ~d90_fft_bufA_L.bufnum,
	\spec_buf1R, ~d90_fft_bufA_R.bufnum,
	\spec_buf2L, ~d90_fft_bufB_L.bufnum,
	\spec_buf2R, ~d90_fft_bufB_R.bufnum,

	\soundBuf1L, ~d90_psjA_L,
	\soundBuf1R, ~d90_psjA_R,
	\soundBuf2L, ~d90_psjB_L,
	\soundBuf2R, ~d90_psjB_R,

],~ambiGroup[2], addAction:\addToHead);



(0.1).wait;
//~d90_synth.set(\amp,~d90_vol_g, \amp_lag,~d90_vol_lag);

{~f_d90_vol.value(~reloj_d90_1_vol_v_txt.string.asInteger/100, ~reloj_d90_vol_dur_txt.string.asInteger)}.defer;




////////////////////////////////// INICIA REPRODUCCIÓN DE PAISAJE A ////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//// Escoge al azar el tiempo que estará reproduciendo el paisaje A (debe incluir la duración del morphing, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones), o a que yo cambie ~wait_xfade_Front, lo que suceda primero. Inicia el morphing.


	//~d90_vent_psjA = rrand(10, ~d90_psjA.duration - 1);  // versión para paisajes cortos
	~d90_vent_psjA = rrand(60, ~d90_psjA.duration - 1);

	//// Escoge al azar la duración del morphing al paisaje B
   // ~d90_morphB_dur = rrand(10,~d90_vent_psjA - 10);  // versión para paisajes cortos
	~d90_morphB_dur = rrand(60, ~d90_vent_psjA);



	"************1***************".postln;
	"D90° - Ahora suena A".postln;
	{~d90_gui_btn_A.value = 0;
	~d90_gui_btn_B.value = 2;
	}.defer;
	("D90° - Duración total de paisaje A = " + ~d90_psjA.duration).postln;
	("D90° - Ventana del paisaje A = " + ~d90_vent_psjA).postln;
	("D90° - Duracion del Morphing a B = " + ~d90_morphB_dur).postln;
	"~d90_morph_xfade -> 1".postln;

/////////////////////////// INICIA ESPERA PARA INICIAR EL MORPHING ---> B ////////////////////////////////

		~d90_contador_1 = 0;
		~d90_contador_2 = 1;
		~d90_vent_final = ~d90_vent_psjA - ~d90_morphB_dur;
		~d90_morph_xfade = 2;
		~d90_xfade_A_B = true;
		~d90_xfade_B_A = false;
		~d90_gui_btn_xfade_block = true;
		{~d90_gui_btn_xfade.enabled_(true);
			~d90_gui_btn_xfade.value_(0);
		}.defer;

//// Si quiero mantener un morphing a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario
	"while2".postln;
	while ({(~d90_trigger_morph == false)},{
			{~reloj_d90_1_trigger.string_((~d90_contador_1).round(0.1).asString)}.defer;
			~d90_contador_1 = ~d90_vent_final - ~d90_contador_2;
			~d90_contador_2 = ~d90_contador_2 + 0.1;
			{
				~d90_gui_btn_A.value = 0;
				~d90_gui_btn_B.value = 2;
				~d90_gui_btn_fl.value = 5;
			}.defer;

		if ((~d90_morph_xfade < 1) && (~d90_morph_xfade > 0), {
			"D90°- Morphing modo manual".postln;
				{~d90_gui_btn_A.value = 1;
					~d90_gui_btn_B.value = 1;
					~reloj_d90_1_trigger.string_("--");
					~d90_gui_btn_xfade.enabled_(false);
					~d90_gui_btn_xfade.value_(1)
				}.defer;
				~d90_gui_btn_xfade_block = false;

				while ({((~d90_morph_xfade) < 1) && ((~d90_morph_xfade) > 0)},{
					(0.1).wait;
					if (~d90_morph_m_t == true,{
						{
							var morph = ~d90_morph_dur.asFloat;

						"while 3".postln;

							while({morph > 0.1},{
							morph = morph - 0.1;
							{~reloj_d90_1_morph_t_txt.string_(morph.round(0.1).asString);
							~d90_gui_btn_xfade.enabled_(false);
							~d90_gui_btn_xfade.value_(1)}.defer;
							0.1.wait;
					});
						{~d90_gui_btn_xfade.enabled_(true);
						~d90_gui_btn_xfade.value_(0)}.defer;
						}.fork;
						~d90_morph_m_t = false;
					});

				});

			if(~d90_gui_btn_xfade_block == false,{
				while({~d90_morph_xfade == 0},{(0.1).wait});
			});

		});


		if((~d90_morph_xfade == 1) , {   // Ya no hago el morphing a B con duración original. Lo hago con nueva duración manual
				var dur_morph_B = ~d90_morph_dur, flecha = 0;
				morph_m = 1;
				{
					~d90_gui_btn_A.value = 1;
					~d90_gui_btn_B.value = 1;
				    ~reloj_d90_1_trigger.string_("--")

				}.defer;

			"while 5".postln;

				while({dur_morph_B > 0.1},
					{
						{
						~reloj_d90_1_morph.string_((dur_morph_B).round(0.1).asString);
						~d90_gui_btn_fl.value = flecha}.defer;

						flecha = flecha + 1;
					if(flecha >= 6, {flecha = 0});

						dur_morph_B = dur_morph_B - 0.1;
						0.1.wait;
					};
				);
			});


			if(morph_m == 1 , {
				~d90_trigger_morph = true;
			});

			if ((~d90_contador_2 >= ~d90_vent_final),{
				~d90_trigger_morph = true;
			});

			(0.1).wait;

		});

	//	~d90_trigger_morph = false;
		~d90_fmorph = false;
		~d90_morph_xfade = 2;


////////////////////////////// INICIA EL MORPHING ---> B ///////////////////////////////////////////


//// El morphing a B se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje B a 1


	if(morph_m != 1,{
		var flecha = 0;
		var dur_morph_B = ~d90_morphB_dur;
		{~d90_gui_btn_xfade.enabled_(false);
				~d90_gui_btn_xfade.value_(2);
			}.defer;
		~d90_synth.set(\xfdur,~d90_morphB_dur.round(0.1), \morph, 1);
		~d90_synth.set(\volB, 1, \vol_B_lag, (~d90_morphB_dur/4).round(0.1));   // modificado el 23-12-21
			{
			~d90_gui_btn_A.value = 1;
			~d90_gui_btn_B.value = 1;
			}.defer;

		"while 6".postln;

		while({dur_morph_B >= 0},
			{
					{~reloj_d90_1_morph.string_((dur_morph_B).round(0.1).asString)}.defer;

					{~d90_gui_btn_fl.value = flecha}.defer;
					flecha = flecha + 1;
					if(flecha >=6, {flecha = 0});
					dur_morph_B = dur_morph_B - 0.1;
					0.1.wait;
			};
		);

	});

morph_m = 0;

//////////////////////////////// TERMINA EL MORPHING ---> B. REPRODUCE B //////////////////////////
		{~d90_gui_btn_xfade.enabled_(true);
		~d90_gui_btn_xfade.value_(0);
		}.defer;

////////// Aquí inicia el bucle

		"inicia bucle".postln;
	100.do{

		//// Escoge al azar el tiempo que estará reproduciendo el paisaje B (debe incluir la duración del morphing, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones), o a que yo cambie ~wait_xfade_Front, lo que suceda primero. Inicia el morphing


		~d90_vent_psjB = rrand(60, ~d90_psjB.duration - 1);

		//// Escoge una duración de morphing de regreso a A


		~d90_morphA_dur = rrand(60, ~d90_vent_psjB);


	"*************2**************".postln;
	"D90° - Ahora suena B".postln;
		{~d90_gui_btn_A.value = 2;
		~d90_gui_btn_B.value = 0;
		~d90_gui_btn_fl.value = 10;
		}.defer;
	("D90° - Duración total de paisaje B = " + ~d90_psjB.duration).postln;
	("D90°- Ventana del paisaje B TRight = " + ~d90_vent_psjB).postln;
	("D90°- Morph ---> A = " + ~d90_morphA_dur + "segundos").postln;
	"D90°- xfade -> 0".postln;


/////// Selecciona una categoría, revisa si esa categoría ya está vacía. Si lo está, elige otra. Si no, la utiliza

		~d90_selector_f.value(~selector);
		(0.2).wait;

		//("D90°- Tamaño de categorias = "+ ~categorias.size).postln;


		"while 7".postln;

		while ({(~d90_s_cat.size <= 0)},{

			~f_gui_g_subcat_bloq.value(~d90_cat,~d90_sub_cat);
			//~f_gui_d90_subcat_bloq ={}.value;
			~d90_selector_f.value(~selector);
			(0.1).wait;
			});

		s.sync;

//// Selecciona un paisaje de la categoría seleccionada y lo carga a los buffers para A

		~d90_i_paisaje = rrand(0, ~d90_s_cat.size-1);
		~d90_psjA = ~categorias[~d90_cat][~d90_sub_cat][~d90_i_paisaje];
		//("D90°- tamaño de la categoria "+ ~d90_i_paisaje + "= " + ~d90_s_cat.size).postln;

		~d90_psjA_L = Buffer.readChannel(s,~d90_psjA.path, channels: [0]);
		~d90_psjA_R = Buffer.readChannel(s,~d90_psjA.path, channels: [1]);

		s.sync;

		(~d90_psjA).postln;

//// Quita de la lista el paisaje que ya está cargado en los Buffers de A
		//("D90°- Se remueve " + (~d90_psjA)).postln;
		~categorias[~d90_cat][~d90_sub_cat].removeAt(~d90_i_paisaje);


//// Vuelve a leer los Buffers de A en el synthdef
		~d90_synth.set(\soundBuf1L, ~d90_psjA_L, \soundBuf1R, ~d90_psjA_R);




//////////////////////////////// INICIA ESPERA PARA EL MORPHING ---> A ////////////////////////////

			~d90_contador_1 = 0;
			~d90_contador_2 = 1;
			~d90_vent_final = ~d90_vent_psjB - ~d90_morphA_dur;
			~d90_morph_xfade = 2;
			~d90_xfade_A_B = false;
			~d90_xfade_B_A = true;
			~d90_gui_btn_xfade_block = true;
			{~d90_gui_btn_xfade.enabled_(true);
				~d90_gui_btn_xfade.value_(0);
			}.defer;

//// Si quiero mantener un morphing a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario

		"while 8".postln;

	while({(~d90_trigger_morph == false)},{
		{~reloj_d90_1_trigger.string_((~d90_contador_1).round(0.1).asString)}.defer;
		~d90_contador_2 = ~d90_contador_2 + 0.1;
		~d90_contador_1 = ~d90_vent_final - ~d90_contador_2;
		{
			~d90_gui_btn_A.value = 2;
			~d90_gui_btn_B.value = 0;
			~d90_gui_btn_fl.value = 11;
				}.defer;

		if ((~d90_morph_xfade < 1) && (~d90_morph_xfade > 0), {
			"D90°- Morphing modo manual".postln;
					~d90_gui_btn_xfade_block = false;
					{~d90_gui_btn_A.value = 1;
						~d90_gui_btn_B.value = 1;
						~reloj_d90_1_trigger.string_("--")
					}.defer;

					"while 9".postln;

			while({(~d90_morph_xfade < 1) && (~d90_morph_xfade > 0)},{
				(0.1).wait;

					// loop para la cuenta regresiva en la GUI

						if (~d90_morph_m_t == true,{
							{
								var morph = ~d90_morph_dur.asFloat;

								"while 10".postln;

								while({morph > 0.1},{
									morph = morph - 0.1;
									{~reloj_d90_1_morph_t_txt.string_((morph).round(0.1).asString);
										~d90_gui_btn_xfade.enabled_(false)
									}.defer;
									0.1.wait;
								});

								{~d90_gui_btn_xfade.enabled_(true);
									~d90_gui_btn_xfade.value_(0)}.defer
							}.fork;
							~d90_morph_m_t = false;
						});
					});
				});


		if( (~d90_morph_xfade == 0), {   // Ya no hago el morphing a A con duración original. Lo hago con nueva duración manual
				var dur_morph_A = ~d90_morph_dur, flecha = 6;
				morph_m = 1;
				{
					~d90_gui_btn_A.value = 1;
					~d90_gui_btn_B.value = 1;
				    ~reloj_d90_1_trigger.string_("--")

				}.defer;

				"while 12".postln;

				while({dur_morph_A > 0.1},
					{
						{
						~reloj_d90_1_morph.string_((dur_morph_A).round(0.1).asString);
						~d90_gui_btn_fl.value = flecha}.defer;

						flecha = flecha + 1;
					if(flecha >= 12, {flecha = 6});

						dur_morph_A = dur_morph_A - 0.1;
						0.1.wait;
					};
				);
		});

				if(~d90_gui_btn_xfade_block == false,{
					while({~d90_morph_xfade == 1},{(0.1).wait});
				});



		//reloj_reinicia = false;

		if(morph_m == 1 , {
			~d90_trigger_morph = true;
		});

		if ((~d90_contador_2 >= ~d90_vent_final),{
			~d90_trigger_morph = true;
		});

		(0.1).wait;

});

		~d90_trigger_morph = false;
		~d90_fmorph = false;
			~d90_morph_xfade = 2;


/////////////////////////////INICIA EL MORPHING ----> A ///////////////////////////////////


//// El morphing a A se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje A a 1

		if(morph_m !=1) {
			var dur_morph_A = ~d90_morphA_dur, flecha = 6;
			{~d90_gui_btn_xfade.enabled_(false);
				~d90_gui_btn_xfade.value_(2);
				}.defer;
			~d90_synth.set(\xfdur,~d90_morphA_dur.round(0.1), \morph,0);
			~d90_synth.set(\volA, 1, \vol_A_lag, (~d90_morphA_dur/4).round(0.1));
			{
			~d90_gui_btn_A.value = 1;
			~d90_gui_btn_B.value = 1;
			}.defer;

			"while 13".postln;

			while({dur_morph_A >= 0},
			{
				dur_morph_A = dur_morph_A - 0.1;
				{~reloj_d90_1_morph.string_((dur_morph_A).round(0.1).asString)}.defer;
				{~d90_gui_btn_fl.value = flecha}.defer;
				flecha = flecha + 1;
				if(flecha >=12, {flecha = 6});
				0.1.wait;
			};
			);

		};
morph_m = 0;

///////////////////////////// TERMINA MORPHING --> A. REPRODUCE A /////////////////////////////////
		{~d90_gui_btn_xfade.enabled_(true);
				~d90_gui_btn_xfade.value_(0);
			}.defer;
		"**********3**************".postln;
		"D90°- Ahora suena el paisaje A".postln;
		{
		~d90_gui_btn_A.value =0;
		~d90_gui_btn_B.value = 2;
		~d90_gui_btn_fl.value = 5;
		}.defer;
		("D90°- Tamaño de categorias = "+ ~categorias.size).postln;
		("D90°- tamaño de la categoria "+ ~d90_i_paisaje + "= " + ~d90_s_cat.size).postln;
		("D90°- Se remueve " + (~d90_psjA)).postln;


		//// Escoge al azar el tiempo que estará reproduciendo el paisaje A (debe incluir la duración del morphing, y máximo debe ser la duración total del paisaje sonoro para evitar repeticiones), o a que yo cambie ~wait_xfade_Front, lo que suceda primero. Inicia el morphing.


	    //~d90_vent_psjA = rrand(10, ~d90_psjA.duration - 1);  // versión para paisajes cortos
		~d90_vent_psjA = rrand(60, ~d90_psjA.duration - 1);

		//// Escoge al azar la duración del morphing al paisaje B
		//~d90_morphB_dur = rrand(10,~d90_vent_psjA - 10);   /// versión para paisajes cortos
		~d90_morphB_dur = rrand(60,~d90_vent_psjA);

		("D90°- Duración del paisaje A = " + ~d90_psjA.duration).postln;
	    ("Ventana del paisaje A TRight = " + ~d90_vent_psjA).postln;
		//("D90°- Morph ---> B = " + ~d90_morphB_dur + "segundos").postln;
	     "D90°- xfade -> 1".postln;



/////// Selecciona una categoría, revisa si esa categoría ya está vacía. Si lo está, elige otra. Si no, la utiliza
		//~d90_cat = rrand(0,~categorias.size-1); /////Sustituir por pesos o métodos algorítmicos
		//("D90° - Tamaño de categorias - "+ ~categorias.size).postln;
		~d90_selector_f.value(~selector);
		(0.2).wait;

		"while 14".postln;

		while ({(~d90_s_cat.size <= 0)},{


		~f_gui_g_subcat_bloq.value(~d90_cat,~d90_sub_cat);
			//~f_gui_d90_subcat_bloq ={}.value;
			~d90_selector_f.value(~selector);
			(0.1).wait;

			});

		s.sync;

//// Selecciona un paisaje de la categoría seleccionada y lo carga a los buffers para B
		~d90_i_paisaje = rrand(0, ~d90_s_cat.size-1);/////Sustituir por pesos o métodos algorítmicos
		~d90_psjB = ~categorias[~d90_cat][~d90_sub_cat][~d90_i_paisaje];
		//("D90° - tamaño de la categoria"+ ~d90_i_paisaje + "= " + ~d90_s_cat.size).postln;

		~d90_psjB_L = Buffer.readChannel(s,~d90_psjB.path, channels: [0]);
		~d90_psjB_R = Buffer.readChannel(s,~d90_psjB.path, channels: [1]);
		s.sync;

//// Quita de la lista el paisaje que ya está cargado en los buffers de B
		//("D90° - Se remueve " + (~d90_psjB)).postln;
		~categorias[~d90_cat][~d90_sub_cat].removeAt(~d90_i_paisaje);


//// Vuelve a leer los Buffers de B en el synthdef
	~d90_synth.set(\soundBuf2L, ~d90_psjB_L, \soundBuf2R, ~d90_psjB_R);




//////////////////////////////////// INICIA ESPERA PARA COMENZAR EL MORPHING ----> B //////////////////////////////

			~d90_contador_1 = 0;
			~d90_contador_2 = 1;
			~d90_vent_final = ~d90_vent_psjB - ~d90_morphA_dur;
			~d90_morph_xfade = 2;
			~d90_xfade_A_B = true;
			~d90_xfade_B_A = false;
			~d90_gui_btn_xfade_block = true;
			{~d90_gui_btn_xfade.enabled_(true);
				~d90_gui_btn_xfade.value_(0);
			}.defer;


//// Si quiero mantener un morphing a la mitad(0.5, diferente de 0 ó 1), la rutina se espera y loopea los paisajes sonoros el tiempo necesario

	while ({(~d90_trigger_morph == false)},{
		{~reloj_d90_1_trigger.string_((~d90_contador_1).round(0.1).asString)}.defer;
		~d90_contador_2 = ~d90_contador_2 + 0.1;
		~d90_contador_1 = ~d90_vent_final - ~d90_contador_2;
		{
			~d90_gui_btn_A.value = 0;
			~d90_gui_btn_B.value = 2;
			~d90_gui_btn_fl.value = 5;
				}.defer;

		if ((~d90_morph_xfade < 1) && (~d90_morph_xfade > 0), {
					"D90°- Morphing modo manual".postln;
					~d90_gui_btn_xfade_block = false;
					{~d90_gui_btn_A.value = 1;
						~d90_gui_btn_B.value = 1;
						~reloj_d90_1_trigger.string_("--")
					}.defer;

			while ({((~d90_morph_xfade) < 1) && ((~d90_morph_xfade) > 0)},{
				(0.1).wait;
					if (~d90_morph_m_t == true,{
						{
								var morph = ~d90_morph_dur;
								while({morph > 0.1},{
									morph = morph - 0.1;
									{~reloj_d90_1_morph.string_((morph).round(0.1).asString);
										~d90_gui_btn_xfade.enabled_(false)
									}.defer;

								0.1.wait;

						});
								{~d90_gui_btn_xfade.enabled_(true);
									~d90_gui_btn_xfade.value_(0)
								}.defer
							}.fork;
							~d90_morph_m_t = false;
						});
					});

				});

		if( (~d90_morph_xfade == 1) , {   // Ya no hago el morphing a B con duración original. Lo hago con nueva duración manual
				var dur_morph_B = ~d90_morph_dur, flecha = 0;
				morph_m = 1;
				{
					~d90_gui_btn_A.value = 1;
					~d90_gui_btn_B.value = 1;
				    ~reloj_d90_1_trigger.string_("--")
				}.defer;

				while({dur_morph_B > 0.1},
					{
							{
								~reloj_d90_1_morph.string_((dur_morph_B).round(0.1).asString);
								~d90_gui_btn_fl.value = flecha
							}.defer;
							flecha = flecha + 1;
							if(flecha >= 6, {flecha = 0});
							dur_morph_B = dur_morph_B - 0.1;
							0.1.wait;
						};
					);
					~d90_morph_xfade = 2;
				});

				if(~d90_gui_btn_xfade_block == false,{
					while({~d90_morph_xfade == 0},{(0.1).wait});
				});



		//reloj_reinicia = false;

		if(morph_m == 1 , {
			~d90_trigger_morph = true;
		});

		if ((~d90_contador_2 >= ~d90_vent_final),{
			~d90_trigger_morph = true;
		});

		(0.1).wait;

});

			~d90_trigger_morph = false;
			~d90_fmorph = false;
			~d90_morph_xfade = 2;



////////////////////////// INICIA MORPHING ---> B. REPRODUCE B ///////////////////////////////////
		{~d90_gui_btn_xfade.enabled_(false);
				~d90_gui_btn_xfade.value_(2);
			}.defer;
		"D90° - salgo de la espera al morphing -> B".postln;
		("D90°- Inicia Morphing --> B = " + ~d90_morphB_dur + "segundos").postln;
		"D90°- ~d90_morph_xfade -> 1".postln;


//// El morphing a B se hace con normalidad en el tiempo ya seleccionado.
//// Regresa el volumen del nuevo paisaje B a 1


			if(morph_m != 1) {
				var dur_morph_B = ~d90_morphB_dur, flecha = 0;
				~d90_synth.set(\xfdur,~d90_morphB_dur.round(0.1), \morph, 1);
				~d90_synth.set(\volB, 1, \vol_B_lag, ~d90_morphB_dur.round(0.1)); //Tal vez no sea necesario
				{
					~d90_gui_btn_A.value = 1;
					~d90_gui_btn_B.value = 1;
				}.defer;
				while({dur_morph_B >= 0},
					{
						{~reloj_d90_1_morph.string_((dur_morph_B).round(0.1).asString)}.defer;
						dur_morph_B = dur_morph_B - 0.1;
						{~d90_gui_btn_fl.value = flecha}.defer;
						flecha = flecha + 1;
						if(flecha >=6, {flecha = 0});
						0.1.wait;
					};
				);
			};

morph_m = 0;


	};  ///Termina el bucle
}).play;

//Revisar esta variable
~gui.onClose = {~r_D90.stop; ~b_vol_d90_r.stop; Buffer.freeAll; s.freeAll };

};
)




////////////////////////////////////
//////////////EXTRAS////////////////
///////////////////////////////////

~encoder[0].do(_.editor);



// randomize source positions
~encoder.do(_.set(6, rand(1.0))) // 6 -> azimuth


//Colocar azimuths de forma manual:
// parámetro 6, 0.25 = total right|| 0.0 = Back || 0.12 = SR || 0.375 = Right (45°) || 0.5 = Center || 0.75 = TL
// 0.625 = Left (45°) || 0.875 = SL ||(7, 0.75) = Top || (7,0.25) = Bottom
~encoder[0].set(6,0.625)
);
//Colocar width ---> 0.57 = 50.4°

~encoder[0].set(9, 0.57)

// Colocar Elevation:
~encoder[0].set(7, 0.5)


// Azimuths para MultiEncoder
p0 -> 1er orden
p7 -> 1 = 0.627
p12 -> 2 = 0.375
p17 -> 3 =
p22 -> 4


// move around manually with the SC GUI:
~encoder.do(_.gui);
// move around with the VST editor:
~encoder.do(_.editor);





// modulate azimuth values with random LFOs:
(
~lfoGroup = Group.new;
~lfoBus = ~numBus.collect { Bus.control };
~lfo = ~numBus.collect { |i| { | rate = 0.5 | LFNoise1.kr(rate, 0.5, 0.5) }.play(~lfoGroup, ~lfoBus[i]) };
~encoder.do { | enc, i | enc.map(6, ~lfoBus[i]) }; // map azimuth parameter (nr. 6) to control bus
)

~lfoGroup.set(\rate, exprand(0.1, 4.0));  // change LFO rates
~encoder.do(_.unmap(6)); // unmap

// add an ambisonic master FX
(
~ambiReverb = VSTPluginController(Synth(\ambiFX, [\bus, ~ambiMasterBus, \out, 0],
    target: ~ambiMasterFXGroup)).open("FdnReverb_x64");
)
~ambiReverb.set(0, rand(1.0)); // vary room size
~ambiReverb.set(1, rand(1.0); // vary reverb time
// bypass it:
~ambiReverb.synth.set(\bypass, 1); // bypass
~ambiReverb.synth.set(\bypass, 0); // process

~ambiReverb.do(_.editor);




// add an ambisonic energy visualizer - Problema: me marca bus muy pequeño, no hace la visualización en primer orden
(
~ambiMeter = VSTPluginController(Synth(\ambiFX, [\bus, ~ambiMasterBus, \out, 0],
    target: ~ambiMasterFXGroup)).open("EnergyVisualizer_x64");
)

// bypass it:
~ambiMeter.synth.set(\bypass, 1); // bypass
~ambiMeter.synth.set(\bypass, 0); // process

~ambiMeter.do(_.editor);