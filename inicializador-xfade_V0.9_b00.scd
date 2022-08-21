(
Routine{




/// Buffers para las FFT de Frente

~fr_fft_bufA_L = Buffer.alloc(s,2048);
~fr_fft_bufA_R = Buffer.alloc(s,2048);
~fr_fft_bufB_L = Buffer.alloc(s,2048);
~fr_fft_bufB_R = Buffer.alloc(s,2048);

/// Buffers para las FFT de Izquierda 90°

~i90_fft_bufA_L = Buffer.alloc(s,2048);
~i90_fft_bufA_R = Buffer.alloc(s,2048);
~i90_fft_bufB_L = Buffer.alloc(s,2048);
~i90_fft_bufB_R = Buffer.alloc(s,2048);


/// Buffers para las FFT de Derecha 90°

~d90_fft_bufA_L = Buffer.alloc(s,2048);
~d90_fft_bufA_R = Buffer.alloc(s,2048);
~d90_fft_bufB_L = Buffer.alloc(s,2048);
~d90_fft_bufB_R = Buffer.alloc(s,2048);

/// Buffers para las FFT de AmbiX

~ambiX_fft_BufA_W = Buffer.alloc(s,2048);
~ambiX_fft_BufA_Y = Buffer.alloc(s,2048);
~ambiX_fft_BufA_Z = Buffer.alloc(s,2048);
~ambiX_fft_BufA_X = Buffer.alloc(s,2048);

~ambiX_fft_BufB_W = Buffer.alloc(s,2048);
~ambiX_fft_BufB_Y = Buffer.alloc(s,2048);
~ambiX_fft_BufB_Z = Buffer.alloc(s,2048);
~ambiX_fft_BufB_X = Buffer.alloc(s,2048);


//// Variables


~b_vol = Array.fill(8, {Bus.new(\control, 0, 1)});  //// Arreglo de Controles de volumen con lag
//~d90_vol_g = 1;
//~d90_vol_lag = 10;
~d90_morph_xfade = 0;
~d90_trigger_morph = false;


	"Buffers cargados...".postln;
1.wait;

// SynthDefs para codificadores y decodificadores

~order = 1; // set this to the order you want
~numChannels = ((~order + 1)**2).asInteger;

// binaural decoder (~numChannels -> 2) - reads from 'bus' and sums into 'out'
SynthDef.new(\binauralDecoder, { | bus, out = 0 |
    Out.ar(out, VSTPlugin.ar(In.ar(bus, ~numChannels), 2));
}).add;

// stereo encoder (2 -> ~numChannels) - replaces stereo signal with ambisonics signal
SynthDef.new(\stereoEncoder, { | bus = 0 |
    ReplaceOut.ar(bus, VSTPlugin.ar(In.ar(bus, 2), ~numChannels));
}).add;


//AmbiX throw

SynthDef.new(\ambiX_S,{| bus = 0|
	ReplaceOut.ar(bus,In.ar(bus, ~numChannels));
}).add;

SynthDef.new(\binauralDecoder_AmbiX, { | bus, out = 0 |
    Out.ar(out, VSTPlugin.ar(In.ar(bus, ~numChannels), 2));
}).add;



// ambisonics insert FX (replaces input with output)
SynthDef.new(\ambiFX, { | bus = 0, bypass |
    ReplaceOut.ar(bus, VSTPlugin.ar(In.ar(bus, 2), ~numChannels, bypass));
}).add;

// helper Synth (throws audio from ambi bus to ambi master bus)
SynthDef.new(\ambiThrow, { | from, to |
    Out.ar(to, In.ar(from, ~numChannels));
}).add;


// XFade estéreo

SynthDef('Morph_Stereo', { arg out=0, spec_buf1L=0, spec_buf1R=1,spec_buf2L=0, spec_buf2R=1, soundBuf1L=2, soundBuf1R=3, soundBuf2L, soundBuf2R, xfdur=5, morph=0, vol_A_lag=5, vol_B_lag, vol_g_lag=7, amp=1, amp_lag=5, b_vol=~b_vol[0];
    var inA_L, inA_R, chainA_L, chainA_R, inB_L, inB_R, chainB_L, chainB_R, xfadeL, xfadeR, vA, vB, rA, rB, vG, b2_vol;



	vA = \volA.kr(1,vol_A_lag);
    inA_L = PlayBuf.ar(1, soundBuf1L, BufRateScale.kr(soundBuf1L), loop: 1)*vA;
	chainA_L = FFT(spec_buf1L, inA_L);

	vA = \volA.kr(1,vol_A_lag);
	inA_R = PlayBuf.ar(1, soundBuf1R, BufRateScale.kr(soundBuf1R), loop: 1)*vA;
	chainA_R = FFT(spec_buf1R, inA_R);

	vB = \volB.kr(1,vol_B_lag);
	inB_L = PlayBuf.ar(1, soundBuf2L, BufRateScale.kr(soundBuf2L), loop: 1)* vB;
	chainB_L = FFT(spec_buf2L, inB_L);

	vB = \volB.kr(1,vol_B_lag);
	inB_R = PlayBuf.ar(1, soundBuf2R, BufRateScale.kr(soundBuf2R), loop: 1)* vB;
	chainB_R = FFT(spec_buf2R, inB_R);

	xfadeL = PV_XFade(chainA_L, chainB_L, VarLag.kr(morph, xfdur, 0, \lin));
	xfadeR = PV_XFade(chainA_R, chainB_R, VarLag.kr(morph, xfdur, 0, \lin));

		//xfadeL = PV_XFade(chainA_L, chainB_L, morph.varlag(xfdur, 0 ));
		//
		//

	rA = IFFT(xfadeL);
	rB = IFFT(xfadeR);

	//vG = \vol_general.kr(0, vol_g_lag);
	vG = VarLag.kr(amp, amp_lag,0,\lin );
	rA = rA * vG;
	rB = rB * vG;

	Out.ar(out, [rA, rB]);
	Out.kr(b_vol, vG);

}).add;



// XFade Ambisónico

SynthDef('XFade_AmbiX', {| out 0, buf 0, vol_lag_ambi 1, vol_A_lag 10, vol_B_lag 10, spec_bufA_W, spec_bufA_Y, spec_bufA_Z, spec_bufA_X, spec_bufB_W, spec_bufB_Y, spec_bufB_Z, spec_bufB_X, soundBufA_W, soundBufA_Y, soundBufA_Z, soundBufA_X, soundBufB_W, soundBufB_Y, soundBufB_Z, soundBufB_X, xfdur, xfade, amp 1, amp_lag 5  |
	var sig, vG, vA, vB, inA_W, inA_Y, inA_Z, inA_X, inB_W, inB_Y, inB_Z, inB_X, chain_A_W, chain_A_Y, chain_A_Z, chain_A_X, chain_B_W, chain_B_Y, chain_B_Z, chain_B_X, ifft_W, ifft_Y, ifft_Z, ifft_X, morph_W, morph_X, morph_Y, morph_Z;

	vA = \volA.kr(1, vol_A_lag);
	inA_W = PlayBuf.ar(1, soundBufA_W, BufRateScale.kr(soundBufA_W), loop:1)*vA;
	chain_A_W = FFT(spec_bufA_W, inA_W);

	inA_Y = PlayBuf.ar(1, soundBufA_Y, BufRateScale.kr(soundBufA_Y), loop:1)*vA;
	chain_A_Y = FFT(spec_bufA_Y, inA_Y);

	inA_Z = PlayBuf.ar(1, soundBufA_Z, BufRateScale.kr(soundBufA_Z), loop:1)*vA;
	chain_A_Z = FFT(spec_bufA_Z, inA_Z);

	inA_X = PlayBuf.ar(1, soundBufA_X, BufRateScale.kr(soundBufA_X), loop:1)*vA;
	chain_A_X = FFT(spec_bufA_X, inA_X);


	vB = \volB.kr(1, vol_B_lag);
	inB_W = PlayBuf.ar(1, soundBufB_W, BufRateScale.kr(soundBufB_W), loop:1)*vB;
	chain_B_W = FFT(spec_bufB_W, inB_W);

	inB_Y = PlayBuf.ar(1, soundBufB_Y, BufRateScale.kr(soundBufB_Y), loop:1)*vB;
	chain_B_Y = FFT(spec_bufB_Y, inB_Y);

	inB_Z = PlayBuf.ar(1, soundBufB_Z, BufRateScale.kr(soundBufB_Z), loop:1)*vB;
	chain_B_Z = FFT(spec_bufB_Z, inB_Z);

	inB_X = PlayBuf.ar(1, soundBufB_X, BufRateScale.kr(soundBufB_X), loop:1)*vB;
	chain_B_X = FFT(spec_bufB_X, inB_X);


	morph_W = PV_XFade(chain_A_W, chain_B_W, VarLag.kr(xfade, xfdur,0,\lin));
	morph_Y = PV_XFade(chain_A_Y, chain_B_Y, VarLag.kr(xfade, xfdur,0,\lin));
	morph_Z = PV_XFade(chain_A_Z, chain_B_Z, VarLag.kr(xfade, xfdur,0,\lin));
	morph_X = PV_XFade(chain_A_X, chain_B_X, VarLag.kr(xfade, xfdur,0,\lin));


	ifft_W = IFFT(morph_W);
	ifft_Y = IFFT(morph_Y);
	ifft_Z = IFFT(morph_Z);
	ifft_X = IFFT(morph_X);

		vG = VarLag.kr(amp, amp_lag,0,\lin );

	//vG = \vol_ambi.kr(0,vol_lag_ambi);

	ifft_W = ifft_W * vG;
	ifft_Y = ifft_Y * vG;
	ifft_Z = ifft_Z * vG;
	ifft_X = ifft_X * vG;



    Out.ar(out, [ifft_W, ifft_Y, ifft_Z, ifft_X]);

}).add;

	"SynthDefs cargados.".postln;
	"Cargando paisajes estéreo...".postln;

/// Construcción de listas de subcategorías con las grabaciones disponibles

(

//// NATURALEZA ////

		{
	var folder_s;
	~agua = List.new;

	folder_s = PathName(thisProcess.nowExecutingPath).pathOnly ++ "Stereo/Agua";
	folder_s = PathName.new(folder_s);

	folder_s.entries.do({
		arg path;
	~agua = ~agua.add(Buffer.read(s, path.fullPath));
});
}.value;

		{
	var folder_s;
	~aire = List.new;
	folder_s = PathName(thisProcess.nowExecutingPath).pathOnly ++ "Stereo/Aire";
	folder_s = PathName.new(folder_s);

	folder_s.entries.do({
		arg path;
	~aire = ~aire.add(Buffer.read(s, path.fullPath));
});
}.value;

		{
	var folder_s;
	~tierra = List.new;
	folder_s = PathName(thisProcess.nowExecutingPath).pathOnly ++ "Stereo/Tierra";
	folder_s = PathName.new(folder_s);

	folder_s.entries.do({
		arg path;
	~tierra = ~tierra.add(Buffer.read(s, path.fullPath));
});
}.value;

		{
	var folder_s;
	~fuego = List.new;
	folder_s = PathName(thisProcess.nowExecutingPath).pathOnly ++ "Stereo/Fuego";
	folder_s = PathName.new(folder_s);

	folder_s.entries.do({
		arg path;
	~fuego = ~fuego.add(Buffer.read(s, path.fullPath));
});
}.value;

		{
	var folder_s;
	~plantas = List.new;
	folder_s = PathName(thisProcess.nowExecutingPath).pathOnly ++ "Stereo/Plantas";
	folder_s = PathName.new(folder_s);

	folder_s.entries.do({
		arg path;
	~plantas = ~plantas.add(Buffer.read(s, path.fullPath));
});
}.value;

{
	var folder_s;
	~animales = List.new;
	folder_s = PathName(thisProcess.nowExecutingPath).pathOnly ++ "Stereo/Animales";
	folder_s = PathName.new(folder_s);

	folder_s.entries.do({
		arg path;
		~animales = ~animales.add(Buffer.read(s, path.fullPath));
});

}.value;

		{
	var folder_s;
	~ecosistemas = List.new;

	folder_s = PathName(thisProcess.nowExecutingPath).pathOnly ++ "Stereo/Ecosistemas";
	folder_s = PathName.new(folder_s);

	folder_s.entries.do({
		arg path;
	~ecosistemas = ~ecosistemas.add(Buffer.read(s, path.fullPath));
});
}.value;



	//// CUERPO HUMANO ////

		{~movimiento = List.new;}.value;

		{~boca = List.new;}.value;

		{~respiracion = List.new;}.value;

		{~internos = List.new;}.value;


//// SOCIEDAD HUMANA ////

		{~rurales = List.new;}.value;

		{
	var folder_s;
	~ciudad = List.new;
	folder_s = PathName(thisProcess.nowExecutingPath).pathOnly ++ "Stereo/Ciudad";
	folder_s = PathName.new(folder_s);

	folder_s.entries.do({
		arg path;
		~ciudad = ~ciudad.add(Buffer.read(s, path.fullPath));
});
}.value;


		{~puertos = List.new;}.value;

		{~domestico = List.new;}.value;

		{~oficinas = List.new;}.value;

		{~fabricas = List.new;}.value;

		{~trabajo = List.new;}.value;

		{~entretenimiento = List.new;}.value;

		{~muchedumbres = List.new;}.value;

		{~ceremonias = List.new;}.value;

		{~parques = List.new;}.value;

		{~indicadores = List.new;}.value;

{
	var folder_s;
	~puertos = List.new;

	folder_s = PathName(thisProcess.nowExecutingPath).pathOnly ++ "Stereo/Puertos";
	folder_s = PathName.new(folder_s);

	folder_s.entries.do({
		arg path;
	~puertos = ~puertos.add(Buffer.read(s, path.fullPath));
});
}.value;

{
	var folder_s;
	~muchedumbres = List.new;

	folder_s = PathName(thisProcess.nowExecutingPath).pathOnly ++ "Stereo/Crowds";
	folder_s = PathName.new(folder_s);

	folder_s.entries.do({
		arg path;
	~muchedumbres = ~muchedumbres.add(Buffer.read(s, path.fullPath));
});
}.value;

//// ARTILUGIOS MECÁNICOS ////

		{~mecanismos = List.new;}.value;

		{~industrial = List.new;}.value;

		{
			var folder_s;
			~transportes = List.new;

			folder_s = PathName(thisProcess.nowExecutingPath).pathOnly ++ "Stereo/Transportes";
			folder_s = PathName.new(folder_s);

			folder_s.entries.do({
				arg path;
				~transportes = ~transportes.add(Buffer.read(s, path.fullPath));
			});
		}.value;

		{~guerra = List.new;}.value;

		{~construccion = List.new;}.value;

		{~ventiladores = List.new;}.value;

		{~herramientas = List.new;}.value;

//// QUIETUD Y SILENCIO ////


		{~hum = List.new;};

{
	var folder_s;
	~vacio = List.new;

	folder_s = PathName(thisProcess.nowExecutingPath).pathOnly ++ "Stereo/Roomtones";
	folder_s = PathName.new(folder_s);

	folder_s.entries.do({
		arg path;
	~vacio = ~vacio.add(Buffer.read(s, path.fullPath));
});
}.value;






///////////////////// AMBISÓNICOS /////////////////////////


	//// NATURALEZA ////

		{
			var folder_S;
			~ambi_animales = List.new;
			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Naturaleza/Animales";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_animales = ~ambi_animales.add(Buffer.read(s, path.fullPath));
			});

		}.value;

		{
			var folder_S;
			~ambi_aire = List.new;

			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Naturaleza/Aire";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_aire = ~ambi_aire.add(Buffer.read(s, path.fullPath));
			});

		}.value;


		{
			var folder_S;
			~ambi_agua = List.new;

			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Naturaleza/Agua";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_agua = ~ambi_agua.add(Buffer.read(s, path.fullPath));
			});
		}.value;


		{~ambi_tierra = List.new;}.value;
		{~ambi_fuego = List.new;}.value;
		{~ambi_plantas = List.new;}.value;

		{
			var folder_S;
			~ambi_humanos = List.new;
			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Naturaleza/humanos";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_humanos = ~ambi_humanos.add(Buffer.read(s, path.fullPath));
			});
		}.value;

		{
			var folder_S;
			~ambi_ecosistemas = List.new;
			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Naturaleza/Ecosistemas";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_ecosistemas = ~ambi_ecosistemas.add(Buffer.read(s, path.fullPath));
			});
		}.value;


//// SOCIEDAD HUMANA ////


		{
			var folder_S;
			~ambi_rurales = List.new;
			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Sociedad humana/Regiones rurales";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_rurales = ~ambi_rurales.add(Buffer.read(s, path.fullPath));
			});
		}.value;

		{
			var folder_S;
			~ambi_ciudad = List.new;

			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Sociedad humana/Ciudad";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_ciudad = ~ambi_ciudad.add(Buffer.read(s, path.fullPath));
			});

		}.value;

		{~ambi_puertos = List.new;}.value;



		{
			var folder_S;
			~ambi_domestico = List.new;

			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Sociedad humana/Ambito domestico";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_domestico = ~ambi_domestico.add(Buffer.read(s, path.fullPath));
			});

		}.value;

		{~ambi_oficinas = List.new;}.value;

		{~ambi_fabricas = List.new;}.value;

		{
			var folder_S;
			~ambi_trabajo = List.new;
		folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Sociedad humana/Otros lugares de trabajo";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_trabajo = ~ambi_trabajo.add(Buffer.read(s, path.fullPath));
			});
		}.value;


		{
			var folder_S;
			~ambi_entretenimiento = List.new;
			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Sociedad humana/Entretenimiento";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_entretenimiento = ~ambi_entretenimiento.add(Buffer.read(s, path.fullPath));
			});
		}.value;

		{
			var folder_S;
			~ambi_muchedumbres = List.new;
			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Sociedad humana/Muchedumbres";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_muchedumbres = ~ambi_muchedumbres.add(Buffer.read(s, path.fullPath));
			});
		}.value;

		{~ambi_ceremonias = List.new;}.value;

		{~ambi_parques = List.new;}.value;

		{
			var folder_S;
			~ambi_indicadores = List.new;
			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Sociedad humana/Indicadores";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_indicadores = ~ambi_indicadores.add(Buffer.read(s, path.fullPath));
			});
		}.value;


//// ARTILUGIOS MECÁNICOS ////




		{
			var folder_S;
			~ambi_transportes = List.new;

			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Artilugios mecanicos/Transportes";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_transportes = ~ambi_transportes.add(Buffer.read(s, path.fullPath));
			});

		}.value;


		{
			var folder_S;
			~ambi_mecanismos = List.new;
			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Artilugios mecanicos/Mecanismos varios";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_mecanismos = ~ambi_mecanismos.add(Buffer.read(s, path.fullPath));
			});
		}.value;

		{~ambi_maquinaria = List.new;}.value;

		{~ambi_guerra = List.new;}.value;

		{~ambi_construccion = List.new;}.value;

		{~ambi_ventiladores = List.new;}.value;

		{~ambi_herramientas = List.new;}.value;




//// QUIETUD Y SILENCIO ////


		{
			var folder_S;
			~ambi_hum = List.new;
			folder_S = PathName(thisProcess.nowExecutingPath).pathOnly ++ "AmbiX/Quietud/Hum";
			folder_S = PathName.new(folder_S);
			folder_S.entries.do({
				arg path;
				~ambi_hum = ~ambi_hum.add(Buffer.read(s, path.fullPath));
			});
		}.value;


		{~ambi_vacio = List.new;}.value;

);
	"Paisajes estéreo cargados.".postln;
	"Cargando paisajes AmbiX...".postln;
	s.sync;








	/////////// DICCIONARIOS SUBCATEGORÍAS STEREO ///////////////

	~st_naturaleza = Dictionary.new;
		~st_naturaleza.add(\agua -> ~agua);
		~st_naturaleza.add(\aire -> ~aire);
		~st_naturaleza.add(\tierra -> ~tierra);
		~st_naturaleza.add(\fuego -> ~fuego);
		~st_naturaleza.add(\plantas -> ~plantas);
		~st_naturaleza.add(\animales -> ~animales);
		~st_naturaleza.add(\ecosistemas -> ~ecosistemas);

		~st_humano = Dictionary.new;
	~st_humano.add(\movimiento -> ~movimiento);
	~st_humano.add(\boca -> ~boca);
	~st_humano.add(\respiracion -> ~respiracion);
	~st_humano.add(\internos -> ~internos);



		~st_sociedad = Dictionary.new;
	~st_sociedad.add(\rurales -> ~rurales);
		~st_sociedad.add(\ciudad -> ~ciudad);
	~st_sociedad.add(\puertos -> ~puertos);
	~st_sociedad.add(\domestico -> ~domestico);
	~st_sociedad.add(\oficinas -> ~oficinas);
	~st_sociedad.add(\fabricas -> ~fabricas);
	~st_sociedad.add(\trabajo -> ~trabajo);
	~st_sociedad.add(\entretenimiento -> ~entretenimiento);
		~st_sociedad.add(\muchedumbres -> ~muchedumbres);
		~st_sociedad.add(\ceremonias -> ~ceremonias);
	~st_sociedad.add(\parques -> ~parques);
	~st_sociedad.add(\indicadores -> ~indicadores);


		~st_artilugios = Dictionary.new;
	~st_artilugios.add(\mecanismos -> ~mecanismos);
	~st_artilugios.add(\industrial -> ~industrial);
		~st_artilugios.add(\transportes -> ~transportes);
	~st_artilugios.add(\guerra -> ~guerra);
	~st_artilugios.add(\construccion -> ~construccion);
	~st_artilugios.add(\ventiladores -> ~ventiladores);
	~st_artilugios.add(\herramientas -> ~herramientas);


		~st_quietud = Dictionary.new;
		~st_quietud.add(\hum -> ~hum);
	~st_quietud.add(\vacio -> ~vacio);


	/////////// DICCIONARIOS CATEGORÍAS STEREO /////////////////////


~categorias_st = Dictionary.new;
~categorias_st.add(\naturaleza -> ~st_naturaleza);
~categorias_st.add(\humano -> ~st_humano);
~categorias_st.add(\sociedad -> ~st_sociedad);
~categorias_st.add(\artilugios -> ~st_artilugios);
~categorias_st.add(\quietud -> ~st_quietud);

//~categorias_st.keys
//	~categorias_ambi.keys
	//~st_humano.keys




	////////// DICCIONARIOS DE SUBCATEGORÍAS AMBIX ////////////


	//~categorias_ambi.keys
	//~ambi_sociedad.keys



	~ambi_naturaleza = Dictionary.new;
	~ambi_naturaleza.add(\agua -> ~ambi_agua);
	~ambi_naturaleza.add(\aire -> ~ambi_aire);
	~ambi_naturaleza.add(\tierra -> ~ambi_tierra);
	~ambi_naturaleza.add(\fuego -> ~ambi_fuego);
	~ambi_naturaleza.add(\plantas -> ~ambi_plantas);
	~ambi_naturaleza.add(\animales -> ~ambi_animales);
	~ambi_naturaleza.add(\ecosistemas -> ~ambi_ecosistemas);
	~ambi_naturaleza.add(\humanos -> ~ambi_humanos);



	~ambi_sociedad = Dictionary.new;
	~ambi_sociedad.add(\ciudad -> ~ambi_ciudad);
	~ambi_sociedad.add(\domestico -> ~ambi_domestico);
	~ambi_sociedad.add(\entretenimiento -> ~ambi_entretenimiento);
	~ambi_sociedad.add(\indicadores -> ~ambi_indicadores);
	~ambi_sociedad.add(\muchedumbres -> ~ambi_muchedumbres);
	~ambi_sociedad.add(\trabajo -> ~ambi_trabajo);
	~ambi_sociedad.add(\rurales -> ~ambi_rurales);
	~ambi_sociedad.add(\puertos -> ~ambi_puertos);
	~ambi_sociedad.add(\oficinas -> ~ambi_oficinas);
	~ambi_sociedad.add(\fabricas -> ~ambi_fabricas);
	~ambi_sociedad.add(\ceremonias -> ~ambi_ceremonias);
	~ambi_sociedad.add(\parques -> ~ambi_parques);



	~ambi_artilugios = Dictionary.new;
	~ambi_artilugios.add(\mecanismos -> ~ambi_mecanismos);
	~ambi_artilugios.add(\maquinaria -> ~ambi_maquinaria);
	~ambi_artilugios.add(\transportes -> ~ambi_transportes);
	~ambi_artilugios.add(\guerra -> ~ambi_guerra);
	~ambi_artilugios.add(\construccion -> ~ambi_construccion);
	~ambi_artilugios.add(\ventiladores -> ~ambi_ventiladores);
	~ambi_artilugios.add(\herramientas -> ~ambi_herramientas);


	~ambi_quietud = Dictionary.new;
	~ambi_quietud.add(\hum -> ~ambi_hum);
	~ambi_quietud.add(\vacio -> ~ambi_vacio);


	////////// DICCIONARIO DE CATEGORÍAS AMBIX ////////////


~categorias_ambi = Dictionary.new;
~categorias_ambi.add(\naturaleza -> ~ambi_naturaleza);
~categorias_ambi.add(\sociedad -> ~ambi_sociedad);
~categorias_ambi.add(\humano -> ~ambi_humano);
~categorias_ambi.add(\artilugios -> ~ambi_artilugios);
~categorias_ambi.add(\quietud -> ~ambi_quietud);

"Paisajes AmbiX cargados.".postln;



	/////FUNCIONES PARA MANEJO DE DICCIONARIOS/////

	~switch_general_naturaleza = {
		arg subcat, val;
		"switch naturaleza".postln;
		subcat.postln;
		val.postln;
		if(val == true,{
			"switch con val true".postln;
			switch(subcat,
				0, {
				~st_naturaleza.add(\agua -> ~agua);
				//~ambi_naturaleza.add(\agua -> ~ambi_agua);
			},
				1, {
				~st_naturaleza.add(\aire -> ~aire);
				//~ambi_naturaleza.add(\aire -> ~ambi_aire)
			},
				2, {
				~st_naturaleza.add(\tierra -> ~tierra);
				//~ambi_naturaleza.add(\tierra -> ~ambi_tierra)
			},
				3, {
				~st_naturaleza.add(\fuego -> ~fuego);
				//~ambi_naturaleza.add(\fuego -> ~ambi_fuego)
			},
				4, {
				~st_naturaleza.add(\plantas -> ~plantas);
				//~ambi_naturaleza.add(\plantas -> ~ambi_plantas)
			},
				5, {
				~st_naturaleza.add(\animales -> ~animales);
				//~ambi_naturaleza.add(\animales -> ~ambi_animales)
			},
				6, {
				~st_naturaleza.add(\ecosistemas -> ~ecosistemas);
				//~ambi_naturaleza.add(\ecosistemas -> ~ambi_ecosistemas)
			},
			);
		},{
			"switch con val falso".postln;
			switch(subcat,
				0, {
				~st_naturaleza.removeAt(\agua);
				//~ambi_naturaleza.removeAt(\agua);
			},
				1, {
				~st_naturaleza.removeAt(\aire);
				//~ambi_naturaleza.removeAt(\aire);
			},
				2, {
				~st_naturaleza.removeAt(\tierra);
				//~ambi_naturaleza.removeAt(\tierra);
			},
				3, {
				~st_naturaleza.removeAt(\fuego);
				//~ambi_naturaleza.removeAt(\fuego);
			},
				4, {
				~st_naturaleza.removeAt(\plantas);
				//~ambi_naturaleza.removeAt(\plantas);
			},
				5, {
				~st_naturaleza.removeAt(\animales);
				//~ambi_naturaleza.removeAt(\animales);
			},
				6, {
				~st_naturaleza.removeAt(\ecosistemas);
				//~ambi_naturaleza.removeAt(\ecosistemas);
			},
			);
		})

	};

~switch_general_humano = {
		arg subcat, val;
		"switch humano".postln;
		subcat.postln;
		val.postln;
		if(val == true,{
			"switch con val true".postln;
			switch(subcat,
				0, {
				~st_humano.add(\movimiento -> ~movimiento);
				~ambi_humano.add(\movimiento -> ~movimiento);
			},
				1, {
				~st_humano.add(\boca -> ~boca);
				~ambi_humano.add(\boca -> ~boca)
			},
				2, {
				~st_humano.add(\respiracion -> ~respiracion);
				~ambi_humano.add(\respiracion -> ~respiracion)
			},
				3, {
				~st_humano.add(\internos -> ~internos);
				~ambi_humano.add(\internos -> ~internos);
			}
			);
		},{
			"switch con val falso".postln;
			switch(subcat,
				0, {
				~st_humano.removeAt(\movimiento);
				~ambi_humano.removeAt(\movimiento);
			},
				1, {
				~st_humano.removeAt(\boca);
				~ambi_humano.removeAt(\boca);
			},
				2, {
				~st_humano.removeAt(\respiracion);
				~ambi_humano.removeAt(\respiracion);
			},
				3, {
				~st_humano.removeAt(\internos);
				~ambi_humano.removeAt(\internos);
			}
			);
		})

	};



	~switch_general_sociedad = {
		arg subcat, val;
		"switch sociedad".postln;
		subcat.postln;
		val.postln;
		if(val == true,{
			"switch sociedad con val true".postln;
			switch(subcat,
				0, {~st_sociedad.add(\rurales -> ~rurales);
				},
				1, {~st_sociedad.add(\ciudad -> ~ciudad);
					~ambi_sociedad.add(\ciudad -> ~ambi_ciudad);
				},
				2, {~st_sociedad.add(\puertos -> ~puertos);
				},
				3, {~st_sociedad.add(\domestico -> ~domestico);
					~ambi_sociedad.add(\domestico -> ~ambi_domestico);

				},
				4, {~st_sociedad.add(\oficinas -> ~oficinas);
				},
				5, {~st_sociedad.add(\fabricas -> ~fabricas);
				},
				6, {~st_sociedad.add(\trabajo -> ~trabajo);
				},
				7, {~st_sociedad.add(\entretenimiento -> ~entretenimiento);
				},
				8, {~st_sociedad.add(\muchedumbres -> ~muchedumbres);
				},
				9, {~st_sociedad.add(\ceremonias -> ~ceremonias);
				},
				10, {~st_sociedad.add(\parques -> ~parques);
				},
				11, {~st_sociedad.add(\indicadores -> ~indicadores);
				}
		)},{
			"switch sociedad con val false".postln;
			switch(subcat,
				0, {~st_sociedad.removeAt(\rurales);
				},
				1, {~st_sociedad.removeAt(\ciudad);
					~ambi_sociedad.removeAt(\ciudad);
				},
				2, {~st_sociedad.removeAt(\puertos);
					~d45_sociedad.removeAt(\puertos);

				},
				3, {~st_sociedad.removeAt(\domestico);
					~ambi_sociedad.removeAt(\domestico);
				},
				4, {~st_sociedad.removeAt(\oficinas);

				},
				5, {~st_sociedad.removeAt(\fabricas);

				},
				6, {~st_sociedad.removeAt(\trabajo);

				},
				7, {~st_sociedad.removeAt(\entretenimiento);

				},
				8, {~st_sociedad.removeAt(\muchedumbres);

				},
				9, {~st_sociedad.removeAt(\ceremonias);

				},
				10, {~st_sociedad.removeAt(\parques);

				},
				11, {~st_sociedad.removeAt(\indicadores);
				}
		)
		};
		);
	};


	~switch_general_artilugios = {
		arg subcat, val;
		"switch sociedad".postln;
		subcat.postln;
		val.postln;
		if(val == true,{
			"switch sociedad con val true".postln;
			switch(subcat,
				0, {~st_artilugios.add(\mecanismos -> ~mecanismos);
				},
				1, {~st_artilugios.add(\industrial -> ~industrial);
				},
				2, {~st_artilugios.add(\transportes -> ~transportes);
					~ambi_artilugios.add(\transportes -> ~ambi_transportes);
				},
				3, {~st_artilugios.add(\guerra -> ~guerra);
				},
				4, {~st_artilugios.add(\construccion -> ~construccion);
				},
				5, {~st_artilugios.add(\ventiladores -> ~ventiladores);
				},
				6, {~st_artilugios.add(\herramientas -> ~herramientas);
				}
		)},{
			"switch sociedad con val false".postln;
			switch(subcat,
				0, {~st_artilugios.removeAt(\mecanismos);

				},
				1, {~st_artilugios.removeAt(\industrial);
				},
				2, {~st_artilugios.removeAt(\transportes);
					~ambi_artilugios.removeAt(\transportes);

				},
				3, {~st_artilugios.removeAt(\guerra);

				},
				4, {~st_artilugios.removeAt(\construccion);

				},
				5, {~st_artilugios.removeAt(\ventiladores);

				},
				6, {~st_artilugios.removeAt(\herramientas);

				}
		)};
		);
	};




	~switch_general_quietud = {
		arg subcat, val;
		"switch sociedad".postln;
		subcat.postln;
		val.postln;
		if(val == true,{
			"switch sociedad con val true".postln;
			switch(subcat,
				0, {~st_quietud.add(\hum -> ~hum);

				},
				1, {~st_quietud.add(\vacio -> ~vacio);
				}
		)},{
		"switch sociedad con val true".postln;
			switch(subcat,
				0, {~st_quietud.removeAt(\hum);
				},
				1, {~st_quietud.removeAt(\vacio);

				}
		)
		};
		);
	};


	//Funciones para quitar o agregar subcategorías a los diccionarios de acuerdo a la GUI

	~switch_ambix_naturaleza = {
		arg subcat, val;
		if(val == true, {
	"switch ambix naturaleza con val true".postln;
			switch(subcat,
				0, {
				~ambi_naturaleza.add(\agua -> ~ambi_agua);
			},
				1, {
				~ambi_naturaleza.add(\aire -> ~ambi_aire)
			},
				2, {
				~ambi_naturaleza.add(\tierra -> ~ambi_tierra)
			},
				3, {
				~ambi_naturaleza.add(\fuego -> ~ambi_fuego)
			},
				4, {
				~ambi_naturaleza.add(\plantas -> ~ambi_plantas)
			},
				5, {
				~ambi_naturaleza.add(\animales -> ~ambi_animales)
			},
				6, {
				~ambi_naturaleza.add(\humanos -> ~ambi_humanos)
			},
				7, {
					~ambi_naturaleza.add(\ecosistemas -> ~ambi_ecosistemas)
				}
			);
			}, {
		"switch ambix naturaleza con val false".postln;
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
			 )
		})
		};

	~switch_ambix_sociedad = {
		arg subcat, val;
		if(val == true, {
			"switch ambix sociedad con val true".postln;
			switch(subcat,
				0, {
					~ambi_sociedad.add(\rurales -> ~ambi_rurales);
				},
				1, {
					~ambi_sociedad.add(\ciudad -> ~ambi_ciudad);
				},
				2, {
					~ambi_sociedad.add(\puertos -> ~ambi_puertos);
				},
				3, {
					~ambi_sociedad.add(\domestico -> ~ambi_domestico);
				},
				4, {
					~ambi_sociedad.add(\oficinas -> ~ambi_oficinas);
				},
				5, {
					~ambi_sociedad.add(\fabricas -> ~ambi_fabricas);
				},
				6, {
					~ambi_sociedad.add(\trabajo -> ~ambi_trabajo);
				},
				7, {
					~ambi_sociedad.add(\entretenimiento -> ~ambi_entretenimiento);
				},
				8, {
					~ambi_sociedad.add(\muchedumbres -> ~ambi_muchedumbres);
				},
				9, {
					~ambi_sociedad.add(\ceremonias -> ~ambi_ceremonias);
				},
				10, {
						~ambi_sociedad.add(\parques -> ~ambi_parques);
				},
				11, {
						~ambi_sociedad.add(\indicadores -> ~ambi_indicadores);
			});

		}, {
			"switch ambix sociedad con val false".postln;
			switch(subcat,
				0, {
					~ambi_sociedad.removeAt(\rurales);
				},
				1, {
					~ambi_sociedad.removeAt(\ciudad);
				},
				2, {
					~ambi_sociedad.removeAt(\puertos);
				},
				3, {
					~ambi_sociedad.removeAt(\domestico);
				},
				4, {
					~ambi_sociedad.removeAt(\oficinas);
				},
				5, {
					~ambi_sociedad.removeAt(\fabricas);
				},
				6, {
					~ambi_sociedad.removeAt(\trabajo);
				},
				7, {
					~ambi_sociedad.removeAt(\entretenimiento);
				},
				8, {
					~ambi_sociedad.removeAt(\muchedumbres);
				},
				9, {
					~ambi_sociedad.removeAt(\ceremonias);
				},
				10, {
					~ambi_sociedad.removeAt(\parques);
				},
				11, {
					~ambi_sociedad.removeAt(\indicadores);
			});
		}
		)
	};

	~switch_ambix_artilugios = {
		arg subcat, val;
		if(val == true, {
	"switch ambix artilugios con val true".postln;
			switch(subcat,
				0, {
				~ambi_artilugios.add(\mecanismos -> ~ambi_mecanismos);
			},
				1, {
				~ambi_artilugios.add(\maquinaria -> ~ambi_maquinaria);
			},
				2, {
				~ambi_artilugios.add(\transportes -> ~ambi_transportes);
			},
				3, {
				~ambi_artilugios.add(\guerra -> ~ambi_guerra);
			},
				4, {
				~ambi_artilugios.add(\construccion -> ~ambi_construccion);
			},
				5, {
				~ambi_artilugios.add(\ventiladores -> ~ambi_ventiladores);
			},
				6, {
				~ambi_artilugios.add(\herramientas -> ~ambi_herramientas);
			}
			);
			}, {
		"switch ambix artilugios con val falso".postln;
			switch(subcat,
				0, {
				~ambi_artilugios.removeAt(\mecanismos);
			},
				1, {
				~ambi_artilugios.removeAt(\maquinaria);
			},
				2, {
				~ambi_artilugios.removeAt(\transportes);
			},
				3, {
				~ambi_artilugios.removeAt(\guerra);
			},
				4, {
				~ambi_artilugios.removeAt(\construccion);
			},
				5, {
				~ambi_artilugios.removeAt(\ventiladores);
			},
				6, {
				~ambi_artilugios.removeAt(\herramientas);
			}
			 )
		})
	};

	~switch_ambix_quietud = {
		arg subcat, val;
		if(val == true, {
	"switch ambix quietud y silencio con val true".postln;
			switch(subcat,
				0, {
					~ambi_quietud.add(\hum -> ~ambi_hum);
				},
				1, {
					~ambi_quietud.add(\vacio -> ~ambi_vacio);
				}
			);
		}, {
			"switch ambix quietud y silencio con val false".postln;
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

	"Diccionarios completados...".postln;


	s.sync;

"Creando buses y grupos...".postln;




// N ambisonic busses (1st order) with stereo encoder. add ambi groups *before* master group!
~numBus = 11; // change this if you want
~ambiBus = Array.newClear(~numBus);
~ambiGroup = Array.newClear(~numBus);
~encoder = Array.newClear(~numBus);


// create ambisonic master section

// bus + group
~ambiMasterBus = Bus.audio(s, ~numChannels);
~ambiMasterGroup = Group.new;
~ambiX_binaural_bus = Bus.audio(s, ~numChannels);


// binaural decoder (writes to master output)
~decoder = VSTPluginController(Synth(\binauralDecoder, [\bus, ~ambiMasterBus, \out, 0],
    target: ~ambiMasterGroup, addAction: \addToTail)).open("BinauralDecoder_x64");


	"cargando buses y grupos..".postln;
s.sync;


// a group for ambisonic master effects
~ambiMasterFXGroup = Group.before(~decoder.synth);




///////// Revisar numeración y órden de Buses, sobra uno (bottom)

//// Fente
~ambiBus[0] = Bus.audio(s, ~numChannels);
~ambiGroup[0] = Group.before(~ambiMasterGroup);

//// Izquierda 90°
~ambiBus[1] = Bus.audio(s, ~numChannels);
~ambiGroup[1] = Group.before(~ambiMasterGroup);

///// Derecha 90°
~ambiBus[2] = Bus.audio(s, ~numChannels);
~ambiGroup[2] = Group.before(~ambiMasterGroup);

//// Atrás 180°
~ambiBus[3] = Bus.audio(s, ~numChannels);
~ambiGroup[3] = Group.before(~ambiMasterGroup);

//// Izquierda 45°
~ambiBus[4] = Bus.audio(s, ~numChannels);
~ambiGroup[4] = Group.before(~ambiMasterGroup);

///// Derecha 45°
~ambiBus[5] = Bus.audio(s, ~numChannels);
~ambiGroup[5] = Group.before(~ambiMasterGroup);

////// Izquierda 135°
~ambiBus[6] = Bus.audio(s, ~numChannels);
~ambiGroup[6] = Group.before(~ambiMasterGroup);

//// Derecha 135°
~ambiBus[7] = Bus.audio(s, ~numChannels);
~ambiGroup[7] = Group.before(~ambiMasterGroup);

//// Bottom
~ambiBus[8] = Bus.audio(s, ~numChannels);
~ambiGroup[8] = Group.before(~ambiMasterGroup);

///// Arriba
~ambiBus[9] = Bus.audio(s, ~numChannels);
~ambiGroup[9] = Group.before(~ambiMasterGroup);

/////AmbiX
~ambiBus[10] = Bus.audio(s, ~numChannels);
~ambiGroup[10] = Group.before(~ambiMasterGroup);

	"cargando codificadores...".postln;
1.wait;

/////AmbiX


~ambiX_binaural_decoder = VSTPluginController(Synth(\binauralDecoder_AmbiX, [\bus,~ambiX_binaural_bus , \out, 0],
    target: ~ambiGroup[10], addAction: \addToTail)).open("BinauralDecoder_x64");


//~ambiX_binaural_bus


/// ENCODERS


////Frente
~encoder[0] = VSTPluginController(Synth(\stereoEncoder, [\bus, ~ambiBus[0]],
        target: ~ambiGroup[0], addAction: \addToTail));
    // open plugin
    ~encoder[0].open("StereoEncoder_x64", action: { |self| self.set(6, 0.5); self.set(9, 0.57) }); // 6 -> azimuth
    // throw to master section (after encoder)
    Synth(\ambiThrow, [\from, ~ambiBus[0], \to, ~ambiMasterBus], target: ~ambiGroup[0], addAction: \addToTail);


/////Izquierda 90°
    // encoder (after sound source)
    ~encoder[1] = VSTPluginController(Synth(\stereoEncoder, [\bus, ~ambiBus[1]],
        target: ~ambiGroup[1], addAction: \addToTail));
    // open plugin and randomize azimuth
    ~encoder[1].open("StereoEncoder_x64", action: { |self| self.set(6, 0.75); self.set(9, 0.57) }); // 6 -> azimuth
    // throw to master section (after encoder)
    Synth(\ambiThrow, [\from, ~ambiBus[1], \to, ~ambiMasterBus], target: ~ambiGroup[1], addAction: \addToTail);



/////Derecha 90°
// encoder (after sound source)
    ~encoder[2] = VSTPluginController(Synth(\stereoEncoder, [\bus, ~ambiBus[2]],
        target: ~ambiGroup[2], addAction: \addToTail));
    // open plugin and randomize azimuth
    ~encoder[2].open("StereoEncoder_x64", action: { |self| self.set(6, 0.25); self.set(9, 0.57) }); // 6 -> azimuth
    // throw to master section (after encoder)
	Synth(\ambiThrow, [\from, ~ambiBus[2], \to, ~ambiMasterBus], target: ~ambiGroup[2], addAction: \addToTail);



////////////////
//////////////////
/////////Faltan los demás encoders ///////////////////


Synth(\ambiThrow, [\from, ~ambiBus[10], \to, ~ambi_binaural_bus], target: ~ambiGroup[10], addAction: \addToHead);








1.wait;
	"Carga terminada".postln;


	}.play;

);


//////////// Visualizador de plugins
//~encoder[2].do(_.editor);
