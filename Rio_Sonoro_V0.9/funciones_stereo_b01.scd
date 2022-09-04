
//////Verifica al inicio si hay categorías o subcategorías vacías, las bloquea y las quita de los diccionarios///////////

~c_st_bloq_naturaleza = 0;
~c_st_bloq_sociedad = 0;
~c_st_bloq_artilugios = 0;
~c_st_bloq_quietud = 0;

///Naturaleza
if(~agua.size <= 0,{
	~f_stereo_bloq_subcat.value("naturaleza", 0);
	~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
});
if(~aire.size <= 0,{
	~f_stereo_bloq_subcat.value("naturaleza", 1);
	~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
});
if(~tierra.size <= 0,{
	~f_stereo_bloq_subcat.value("naturaleza", 2);
	~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
});
if(~fuego.size <= 0,{
	~f_stereo_bloq_subcat.value("naturaleza", 3);
	~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
});
if(~plantas.size <= 0,{
	~f_stereo_bloq_subcat.value("naturaleza", 4);
	~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
});
if(~animales.size <= 0,{
	~f_stereo_bloq_subcat.value("naturaleza", 5);
	~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
});
if(~humanos.size <= 0,{
	~f_stereo_bloq_subcat.value("naturaleza", 6);
	~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
});
if(~ecosistemas.size <= 0,{
	~f_stereo_bloq_subcat.value("naturaleza", 7);
	~c_st_bloq_naturaleza = ~c_st_bloq_naturaleza + 1;
});
if(~c_st_bloq_naturaleza >= 8, {
	~f_stereo_bloq.value("naturaleza", true, nil);
});

///Sociedad
if(~rurales.size <= 0,{
	~f_stereo_bloq_subcat.value("sociedad", 0);
	~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
});
if(~ciudad.size <= 0,{
	~f_stereo_bloq_subcat.value("sociedad", 1);
	~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
});
if(~puertos.size <= 0,{
	~f_stereo_bloq_subcat.value("sociedad", 2);
	~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
});
if(~domestico.size <= 0,{
	~f_stereo_bloq_subcat.value("sociedad", 3);
	~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
});
if(~oficinas.size <= 0,{
	~f_stereo_bloq_subcat.value("sociedad", 4);
	~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
});
if(~fabricas.size <= 0,{
	~f_stereo_bloq_subcat.value("sociedad", 5);
	~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
});
if(~trabajo.size <= 0,{
	~f_stereo_bloq_subcat.value("sociedad", 6);
	~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
});
if(~entretenimiento.size <= 0,{
	~f_stereo_bloq_subcat.value("sociedad", 7);
	~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
});
if(~muchedumbres.size <= 0,{
	~f_stereo_bloq_subcat.value("sociedad", 8);
	~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
});
if(~ceremonias.size <= 0,{
	~f_stereo_bloq_subcat.value("sociedad", 9);
	~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
});
if(~parques.size <= 0,{
	~f_stereo_bloq_subcat.value("sociedad", 10);
	~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
});
if(~indicadores.size <= 0,{
	~f_stereo_bloq_subcat.value("sociedad", 11);
	~c_st_bloq_sociedad = ~c_st_bloq_sociedad + 1;
});
if(~c_st_bloq_sociedad >= 12, {
	~f_stereo_bloq.value("sociedad", true, nil);
});



///Artilugios
if(~mecanismos.size <= 0,{
	~f_stereo_bloq_subcat.value("artilugios", 0);
	~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
});
if(~industrial.size <= 0,{
	~f_stereo_bloq_subcat.value("artilugios", 1);
	~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
});
if(~transportes.size <= 0,{
	~f_stereo_bloq_subcat.value("artilugios", 2);
	~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
});
if(~guerra.size <= 0,{
	~f_stereo_bloq_subcat.value("artilugios", 3);
	~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
});
if(~construccion.size <= 0,{
	~f_stereo_bloq_subcat.value("artilugios", 4);
	~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
});
if(~ventiladores.size <= 0,{
	~f_stereo_bloq_subcat.value("artilugios", 5);
	~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
});
if(~herramientas.size <= 0,{
	~f_stereo_bloq_subcat.value("artilugios", 6);
	~c_st_bloq_artilugios = ~c_st_bloq_artilugios + 1;
});
if(~c_st_bloq_artilugios >= 7, {
	~f_stereo_bloq.value("artilugios", true, nil);
});


///Quietud
if(~hum.size <= 0,{
	~f_stereo_bloq_subcat.value("quietud", 0);
	~c_st_bloq_quietud = ~c_st_bloq_quietud + 1
});
if(~vacio.size <= 0,{
	~f_stereo_bloq_subcat.value("quietud", 1);
	~c_st_bloq_quietud = ~c_st_bloq_quietud + 1
});
if(~c_st_bloq_quietud >= 2, {
	~f_stereo_bloq.value("quietud", true, nil);
});






///////////Función de bloqueo general para bloquear en lag GUI y quitar del diccionario cuando se vacíe una categoría o subcategoría//////////////////////



~f_stereo_bloq = {
	arg cat, cat_bloq, subcat;
	"f_stereo_bloq on".postln;
	if(cat_bloq == true, {
		//// Si se vacía una categoría stereo, la bloquea en todos los puntos stereo

		"bloqueando una categoría stereo".postln;
		switch(cat,
					"naturaleza", {
						{
					~gui_fr_chkb_natur.value = false;
					~gui_fr_chkb_natur.enabled = false;

				/*~chkb_d45_naturaleza.value = false;
				~chkb_d45_naturaleza.enabled = false;

				~chkb_d90_naturaleza.value = false;
				~chkb_d90_naturaleza.enabled = false;

				~chkb_d135_naturaleza.value = false;
				~chkb_d135_naturaleza.enabled = false;

				~chkb_180_naturaleza.value = false;
				~chkb_180_naturaleza.enabled = false;

				~chkb_i135_naturaleza.value = false;
				~chkb_i135_naturaleza.enabled = false;
					*/

					~gui_i90_chkb_natur.value = false;
					~gui_i90_chkb_natur.enabled = false;

					/*

				~chkb_i45_naturaleza.value = false;
				~chkb_i45_naturaleza.enabled = false;

				~chkb_arriba_naturaleza.value = false;
				~chkb_arriba_naturaleza.enabled = false;
				*/}.defer;
				~categorias_fr.removeAt(\naturaleza);
				/*~categorias_d45.removeAt(\naturaleza);
				~categorias_d90.removeAt(\naturaleza);
				~categorias_d135.removeAt(\naturaleza);
				~categorias_180.removeAt(\naturaleza);
				~categorias_i135.removeAt(\naturaleza);
				*/
				~categorias_i90.removeAt(\naturaleza);
				/*
				~categorias_i45.removeAt(\naturaleza);
				~categorias_arriba.removeAt(\naturaleza);*/
				"bloqueada naturaleza stereo".postln;
					},
					"sociedad",{
						{
					~gui_fr_chkb_soc.value = false;
					~gui_fr_chkb_soc.enabled = false;

				/*~chkb_d45_sociedad.value = false;
				~chkb_d45_sociedad.enabled = false;

				~chkb_d90_sociedad.value = false;
				~chkb_d90_sociedad.enabled = false;

				~chkb_d135_sociedad.value = false;
				~chkb_d135_sociedad.enabled = false;

				~chkb_180_sociedad.value = false;
				~chkb_180_sociedad.enabled = false;

				~chkb_i135_sociedad.value = false;
				~chkb_i135_sociedad.enabled = false;

				*/

					~gui_i90_chkb_soc.value = false;
					~gui_i90_chkb_soc.enabled = false;

					/*

				~chkb_i45_sociedad.value = false;
				~chkb_i45_sociedad.enabled = false;

				~chkb_arriba_sociedad.value = false;
				~chkb_arriba_sociedad.enabled = false;
					*/
				"bloqueada sociedad stereo".postln;}.defer;
				~categorias_fr.removeAt(\sociedad);
				/*~categorias_d45.removeAt(\sociedad);
				~categorias_d90.removeAt(\sociedad);
				~categorias_d135.removeAt(\sociedad);
				~categorias_180.removeAt(\sociedad);
				~categorias_i135.removeAt(\sociedad);
				*/
				~categorias_i90.removeAt(\sociedad);
				/*
				~categorias_i45.removeAt(\sociedad);
				~categorias_arriba.removeAt(\sociedad);*/
					},
					"artilugios",{
				{
					~gui_fr_chkb_arti.value = false;
					~gui_fr_chkb_arti.enabled = false;

				/*~chkb_d45_artilugios.value = false;
				~chkb_d45_artilugios.enabled = false;

				~chkb_d90_artilugios.value = false;
				~chkb_d90_artilugios.enabled = false;

				~chkb_d135_artilugios.value = false;
				~chkb_d135_artilugios.enabled = false;

				~chkb_180_artilugios.value = false;
				~chkb_180_artilugios.enabled = false;

				~chkb_i135_artilugios.value = false;
				~chkb_i135_artilugios.enabled = false;

				*/

					~gui_i90_chkb_arti.value = false;
					~gui_i90_chkb_arti.enabled = false;

					/*

				~chkb_i45_artilugios.value = false;
				~chkb_i45_artilugios.enabled = false;

				~chkb_arriba_artilugios.value = false;
				~chkb_arriba_artilugios.enabled = false;
					*/
				"bloqueada artilugios stereo".postln;}.defer;
				~categorias_fr.removeAt(\artilugios);
				/*~categorias_d45.removeAt(\artilugios);
				~categorias_d90.removeAt(\artilugios);
				~categorias_d135.removeAt(\artilugios);
				~categorias_180.removeAt(\artilugios);
				~categorias_i135.removeAt(\artilugios);
				*/
				~categorias_i90.removeAt(\artilugios);
				/*
				~categorias_i45.removeAt(\artilugios);
				~categorias_arriba.removeAt(\artilugios);*/
					},
					"quietud", {
					{
					~gui_fr_chkb_silencio.value = false;
					~gui_fr_chkb_silencio.enabled = false;

				/*~chkb_d45_silencio.value = false;
				~chkb_d45_silencio.enabled = false;

				~chkb_d90_silencio.value = false;
				~chkb_d90_silencio.enabled = false;

				~chkb_d135_silencio.value = false;
				~chkb_d135_silencio.enabled = false;

				~chkb_180_silencio.value = false;
				~chkb_180_silencio.enabled = false;

				~chkb_i135_silencio.value = false;
				~chkb_i135_silencio.enabled = false;

				*/

					~gui_i90_chkb_silencio.value = false;
					~gui_i90_chkb_silencio.enabled = false;

					/*

				~chkb_i45_silencio.value = false;
				~chkb_i45_silencio.enabled = false;

				~chkb_arriba_silencio.value = false;
				~chkb_arriba_silencio.enabled = false;
					*/
				"bloqueada quietud stereo".postln;}.defer;
				~categorias_fr.removeAt(\quietud);
				/*~categorias_d45.removeAt(\quietud);
				~categorias_d90.removeAt(\quietud);
				~categorias_d135.removeAt(\quietud);
				~categorias_180.removeAt(\quietud);
				~categorias_i135.removeAt(\quietud);
				*/
				~categorias_i90.removeAt(\quietud);
				/*
				~categorias_i45.removeAt(\quietud);
				~categorias_arriba.removeAt(\quietud);*/
					}
				)



	},{ ///solo bloquea subcategorías
		~f_stereo_bloq_subcat.value(cat, subcat);
	}
)
};


//////// Función para bloquear las subcategorías stereo que se vacíen y quitarlas de los diccionarios de cada punto////////////


~f_stereo_bloq_subcat = {
	arg cat, subcat;
	switch(cat,
			"naturaleza", {
				{
				~gui_array_fr_subc_nature[subcat].enabled_(false).valueAction_(false);
				/*~gui_array_d45_subc_nature[subcat].enabled_(false).valueAction_(false);
				~gui_array_d90_subc_nature[subcat].enabled_(false).valueAction_(false);
				~gui_array_d135_subc_nature[subcat].enabled_(false).valueAction_(false);
				~gui_array_180_subc_nature[subcat].enabled_(false).valueAction_(false);
				~gui_array_i135_subc_nature[subcat].enabled_(false).valueAction_(false);
				*/
				~gui_array_i90_subc_nature[subcat].enabled_(false).valueAction_(false);
				/*
				~gui_array_i45_subc_nature[subcat].enabled_(false).valueAction_(false);
				~gui_array_arriba_subc_nature[subcat].enabled_(false).valueAction_(false);*/
			}.defer;

			("naturaleza stereo " + subcat + " bloqueada").postln;
			},
		"sociedad", {
			{
				~gui_array_fr_subc_soc[subcat].enabled_(false).valueAction_(false);
				/*~gui_array_d45_subc_soc[subcat].enabled_(false).valueAction_(false);
				~gui_array_d90_subc_soc[subcat].enabled_(false).valueAction_(false);
				~gui_array_d135_subc_soc[subcat].enabled_(false).valueAction_(false);
				~gui_array_180_subc_soc[subcat].enabled_(false).valueAction_(false);
				~gui_array_i135_subc_soc[subcat].enabled_(false).valueAction_(false);
				*/
				~gui_array_i90_subc_soc[subcat].enabled_(false).valueAction_(false);
				/*
				~gui_array_i45_subc_soc[subcat].enabled_(false).valueAction_(false);
				~gui_array_arriba_subc_soc[subcat].enabled_(false).valueAction_(false);*/
			}.defer;

			("sociedad stereo " + subcat + " bloqueada").postln;
		},
		"artilugios", {
			{
				~gui_array_fr_subc_arti[subcat].enabled_(false).valueAction_(false);
				/*~gui_array_d45_subc_arti[subcat].enabled_(false).valueAction_(false);
				~gui_array_d90_subc_arti[subcat].enabled_(false).valueAction_(false);
				~gui_array_d135_subc_arti[subcat].enabled_(false).valueAction_(false);
				~gui_array_180_subc_arti[subcat].enabled_(false).valueAction_(false);
				~gui_array_i135_subc_arti[subcat].enabled_(false).valueAction_(false);
				*/
				~gui_array_i90_subc_arti[subcat].enabled_(false).valueAction_(false);
				/*
				~gui_array_i45_subc_arti[subcat].enabled_(false).valueAction_(false);
				~gui_array_arriba_subc_arti[subcat].enabled_(false).valueAction_(false);*/
			}.defer;

			("artilugios stereo " + subcat + " bloqueada").postln;
		},
		"quietud", {
			{
				~gui_array_fr_subc_silencio[subcat].enabled_(false).valueAction_(false);
				/*~gui_array_d45_subc_silencio[subcat].enabled_(false).valueAction_(false);
				~gui_array_d90_subc_silencio[subcat].enabled_(false).valueAction_(false);
				~gui_array_d135_subc_silencio[subcat].enabled_(false).valueAction_(false);
				~gui_array_180_subc_silencio[subcat].enabled_(false).valueAction_(false);
				~gui_array_i135_subc_silencio[subcat].enabled_(false).valueAction_(false);
				*/
				~gui_array_i90_subc_silencio[subcat].enabled_(false).valueAction_(false);
				/*
				~gui_array_i45_subc_silencio[subcat].enabled_(false).valueAction_(false);
				~gui_array_arriba_subc_silencio[subcat].enabled_(false).valueAction_(false);*/
			}.defer;

			("quietud stereo " + subcat + " bloqueada").postln;
		}
		)
};



/// //Funciones para quitar o agregar subcategorías de acuerdo a lo seleccionado en la GUI - Stereo


	~switch_stereo = {
		arg punto, cat, subcat, value;

	if(value == false, {
		("switch stereo " + punto + "se remueve de " + cat + " " + subcat).postln;
		switch(punto,
			"frente", {
				switch(cat,
					"naturaleza",{
						switch(subcat,
							0, {
								~fr_naturaleza.removeAt(\agua);
							},
							1, {
								~fr_naturaleza.removeAt(\aire);
							},
							2, {
								~fr_naturaleza.removeAt(\tierra);
							},
							3, {
								~fr_naturaleza.removeAt(\fuego);
							},
							4, {
								~fr_naturaleza.removeAt(\plantas);
							},
							5, {
								~fr_naturaleza.removeAt(\animales);
							},
							6, {
								~fr_naturaleza.removeAt(\humanos);
							},
							7,{
								~fr_naturaleza.removeAt(\ecosistemas);
							}
						)
					},
					"sociedad",{
						switch(subcat,
							0, {
								~fr_sociedad.removeAt(\rurales);
							},
							1, {
								~fr_sociedad.removeAt(\ciudad);

							},
							2, {
								~fr_sociedad.removeAt(\puertos);

							},
							3, {
								~fr_sociedad.removeAt(\domestico);
							},
							4, {
								~fr_sociedad.removeAt(\oficinas);

							},
							5, {
								~fr_sociedad.removeAt(\fabricas);

							},
							6, {
								~fr_sociedad.removeAt(\trabajo);

							},
							7, {
								~fr_sociedad.removeAt(\entretenimiento);

							},
							8, {
								~fr_sociedad.removeAt(\muchedumbres);

							},
							9, {
								~fr_sociedad.removeAt(\ceremonias);

							},
							10, {
								~fr_sociedad.removeAt(\parques);

							},
							11, {
								~fr_sociedad.removeAt(\indicadores);
							}
						)
					},
					"artilugios",{
						switch(subcat,
							0, {~fr_artilugios.removeAt(\mecanismos);

							},
							1, {~fr_artilugios.removeAt(\industrial);
							},
							2, {~fr_artilugios.removeAt(\transportes);


							},
							3, {~fr_artilugios.removeAt(\guerra);

							},
							4, {~fr_artilugios.removeAt(\construccion);

							},
							5, {~fr_artilugios.removeAt(\ventiladores);

							},
							6, {~fr_artilugios.removeAt(\herramientas);}

						)
					},
					"quietud",{
						switch(subcat,
							0, {~fr_quietud.removeAt(\hum);
							},
							1, {~fr_quietud.removeAt(\vacio);

							}
						)
					}
				)

			},
			"d45", {
				switch(subcat,
				0, {
				//~d45_naturaleza.removeAt(\agua);
			},
				1, {
				//~d45_naturaleza.removeAt(\aire);
			},
				2, {
				//~d45_naturaleza.removeAt(\tierra);
			},
				3, {
				//~d45_naturaleza.removeAt(\fuego);
			},
				4, {
				//~d45_naturaleza.removeAt(\plantas);
			},
				5, {
				//~d45_naturaleza.removeAt(\animales);
			},
				6, {
				//~d45_naturaleza.removeAt(\humanos);
			},
				7,{
					//~d45_naturaleza.removeAt(\ecosistemas);
				}
			 )
			},
			"d90",{
				switch(subcat,
				0, {
				//~d90_naturaleza.removeAt(\agua);
			},
				1, {
				//~d90_naturaleza.removeAt(\aire);
			},
				2, {
				//~d90_naturaleza.removeAt(\tierra);
			},
				3, {
				//~d90_naturaleza.removeAt(\fuego);
			},
				4, {
				//~d90_naturaleza.removeAt(\plantas);
			},
				5, {
				//~d90_naturaleza.removeAt(\animales);
			},
				6, {
				//~d90_naturaleza.removeAt(\humanos);
			},
				7,{
					//~d90_naturaleza.removeAt(\ecosistemas);
				}
			 )
			},
			"d135",{
				switch(subcat,
				0, {
				//~d135_naturaleza.removeAt(\agua);
			},
				1, {
				//~d135_naturaleza.removeAt(\aire);
			},
				2, {
				//~d135_naturaleza.removeAt(\tierra);
			},
				3, {
				//~d135_naturaleza.removeAt(\fuego);
			},
				4, {
				//~d135_naturaleza.removeAt(\plantas);
			},
				5, {
				//~d135_naturaleza.removeAt(\animales);
			},
				6, {
				//~d135_naturaleza.removeAt(\humanos);
			},
				7,{
					//~d135_naturaleza.removeAt(\ecosistemas);
				}
			 )
			},
			"180",{
				switch(subcat,
				0, {
				//~180_naturaleza.removeAt(\agua);
			},
				1, {
				//~d180_naturaleza.removeAt(\aire);
			},
				2, {
				//~d180_naturaleza.removeAt(\tierra);
			},
				3, {
				//~d180_naturaleza.removeAt(\fuego);
			},
				4, {
				//~d180_naturaleza.removeAt(\plantas);
			},
				5, {
				//~d180_naturaleza.removeAt(\animales);
			},
				6, {
				//~d180_naturaleza.removeAt(\humanos);
			},
				7,{
					//~d180_naturaleza.removeAt(\ecosistemas);
				}
			 )
			},
			"i135",{
				switch(subcat,
				0, {
				//~i135_naturaleza.removeAt(\agua);
			},
				1, {
				//~i135_naturaleza.removeAt(\aire);
			},
				2, {
				//~i135_naturaleza.removeAt(\tierra);
			},
				3, {
				//~i135_naturaleza.removeAt(\fuego);
			},
				4, {
				//~i135_naturaleza.removeAt(\plantas);
			},
				5, {
				//~i135_naturaleza.removeAt(\animales);
			},
				6, {
				//~i135_naturaleza.removeAt(\humanos);
			},
				7,{
					//~i135_naturaleza.removeAt(\ecosistemas);
				}
			 )
			},
			"i90",{
				switch(cat,
					"naturaleza",{
						switch(subcat,
							0, {
								~i90_naturaleza.removeAt(\agua);
							},
							1, {
								~i90_naturaleza.removeAt(\aire);
							},
							2, {
								~i90_naturaleza.removeAt(\tierra);
							},
							3, {
								~i90_naturaleza.removeAt(\fuego);
							},
							4, {
								~i90_naturaleza.removeAt(\plantas);
							},
							5, {
								~i90_naturaleza.removeAt(\animales);
							},
							6, {
								~i90_naturaleza.removeAt(\humanos);
							},
							7,{
								~i90_naturaleza.removeAt(\ecosistemas);
							}
						)
					},
					"sociedad",{
						switch(subcat,
							0, {
								~i90_sociedad.removeAt(\rurales);
							},
							1, {
								~i90_sociedad.removeAt(\ciudad);

							},
							2, {
								~i90_sociedad.removeAt(\puertos);

							},
							3, {
								~i90_sociedad.removeAt(\domestico);
							},
							4, {
								~i90_sociedad.removeAt(\oficinas);

							},
							5, {
								~i90_sociedad.removeAt(\fabricas);

							},
							6, {
								~i90_sociedad.removeAt(\trabajo);

							},
							7, {
								~i90_sociedad.removeAt(\entretenimiento);

							},
							8, {
								~i90_sociedad.removeAt(\muchedumbres);

							},
							9, {
								~i90_sociedad.removeAt(\ceremonias);

							},
							10, {
								~i90_sociedad.removeAt(\parques);

							},
							11, {
								~i90_sociedad.removeAt(\indicadores);
							}
						)
					},
					"artilugios",{
						switch(subcat,
							0, {~i90_artilugios.removeAt(\mecanismos);

							},
							1, {~i90_artilugios.removeAt(\industrial);
							},
							2, {~i90_artilugios.removeAt(\transportes);


							},
							3, {~i90_artilugios.removeAt(\guerra);

							},
							4, {~i90_artilugios.removeAt(\construccion);

							},
							5, {~i90_artilugios.removeAt(\ventiladores);

							},
							6, {~i90_artilugios.removeAt(\herramientas);}

						)
					},
					"quietud",{
						switch(subcat,
							0, {~i90_quietud.removeAt(\hum);
							},
							1, {~i90_quietud.removeAt(\vacio);
							}
						)
					}
				)

			},
			"arriba",{

			}
		)

	}, {
		("switch stereo " + punto + "se añade a naturaleza - " + subcat).postln;
		switch(punto,
			"frente", {
				switch(cat,
					"naturaleza",{
						switch(subcat,
							0, {
								~fr_naturaleza.add(\agua -> ~agua);
							},
							1, {
								~fr_naturaleza.add(\aire -> ~aire);
							},
							2, {
								~fr_naturaleza.add(\tierra -> ~tierra);
							},
							3, {
								~fr_naturaleza.add(\fuego -> ~fuego);
							},
							4, {
								~fr_naturaleza.add(\plantas -> ~plantas);
							},
							5, {
								~fr_naturaleza.add(\animales -> ~animales);
							},
							6, {
								~fr_naturaleza.add(\humanos -> ~humanos);
							},
							7,{
								~fr_naturaleza.add(\ecosistemas -> ~ecosistemas);
							}
						)
					},
					"sociedad",{
						switch(subcat,
							0, {
								~fr_sociedad.add(\rurales -> ~rurales);
							},
							1, {
								~fr_sociedad.add(\ciudad -> ~ciudad);
							},
							2, {
								~fr_sociedad.add(\puertos -> ~puertos);
							},
							3, {
								~fr_sociedad.add(\domestico -> ~domestico);
							},
							4, {
								~fr_sociedad.add(\oficinas -> ~oficinas);

							},
							5, {
								~fr_sociedad.add(\fabricas -> ~fabricas);

							},
							6, {
								~fr_sociedad.add(\trabajo -> ~trabajo);

							},
							7, {
								~fr_sociedad.add(\entretenimiento -> ~entretenimiento);

							},
							8, {
								~fr_sociedad.add(\muchedumbres -> ~muchedumbres);

							},
							9, {
								~fr_sociedad.add(\ceremonias -> ~ceremonias);

							},
							10, {
								~fr_sociedad.add(\parques -> ~parques);

							},
							11, {
								~fr_sociedad.add(\indicadores -> ~indicadores);
							}
						)
					},
					"artilugios",{
						switch(subcat,
							0, {
								~fr_artilugios.add(\mecanismos -> ~mecanismos);
							},
							1, {
								~fr_artilugios.add(\industrial -> ~industrial);
							},
							2, {
								~fr_artilugios.add(\transportes -> ~transportes);
							},
							3, {
								~fr_artilugios.add(\guerra -> ~guerra);
							},
							4, {
								~fr_artilugios.add(\construccion -> ~construccion);
							},
							5, {
								~fr_artilugios.add(\ventiladores -> ~ventiladores);
							},
							6, {
								~fr_artilugios.add(\herramientas -> ~herramientas);
							}
						)
					},
					"quietud",{
						switch(subcat,
							0, {
								~fr_quietud.add(\hum -> ~hum);
							},
							1, {
								~fr_quietud.add(\vacio -> ~vacio);

							}
						)
					}
				)

			},
			"d45", {
				switch(subcat,
				0, {
				//~d45_naturaleza.removeAt(\agua);
			},
				1, {
				//~d45_naturaleza.removeAt(\aire);
			},
				2, {
				//~d45_naturaleza.removeAt(\tierra);
			},
				3, {
				//~d45_naturaleza.removeAt(\fuego);
			},
				4, {
				//~d45_naturaleza.removeAt(\plantas);
			},
				5, {
				//~d45_naturaleza.removeAt(\animales);
			},
				6, {
				//~d45_naturaleza.removeAt(\humanos);
			},
				7,{
					//~d45_naturaleza.removeAt(\ecosistemas);
				}
			 )
			},
			"d90",{
				switch(subcat,
				0, {
				//~d90_naturaleza.removeAt(\agua);
			},
				1, {
				//~d90_naturaleza.removeAt(\aire);
			},
				2, {
				//~d90_naturaleza.removeAt(\tierra);
			},
				3, {
				//~d90_naturaleza.removeAt(\fuego);
			},
				4, {
				//~d90_naturaleza.removeAt(\plantas);
			},
				5, {
				//~d90_naturaleza.removeAt(\animales);
			},
				6, {
				//~d90_naturaleza.removeAt(\humanos);
			},
				7,{
					//~d90_naturaleza.removeAt(\ecosistemas);
				}
			 )
			},
			"d135",{
				switch(subcat,
				0, {
				//~d135_naturaleza.removeAt(\agua);
			},
				1, {
				//~d135_naturaleza.removeAt(\aire);
			},
				2, {
				//~d135_naturaleza.removeAt(\tierra);
			},
				3, {
				//~d135_naturaleza.removeAt(\fuego);
			},
				4, {
				//~d135_naturaleza.removeAt(\plantas);
			},
				5, {
				//~d135_naturaleza.removeAt(\animales);
			},
				6, {
				//~d135_naturaleza.removeAt(\humanos);
			},
				7,{
					//~d135_naturaleza.removeAt(\ecosistemas);
				}
			 )
			},
			"180",{
				switch(subcat,
				0, {
				//~180_naturaleza.removeAt(\agua);
			},
				1, {
				//~d180_naturaleza.removeAt(\aire);
			},
				2, {
				//~d180_naturaleza.removeAt(\tierra);
			},
				3, {
				//~d180_naturaleza.removeAt(\fuego);
			},
				4, {
				//~d180_naturaleza.removeAt(\plantas);
			},
				5, {
				//~d180_naturaleza.removeAt(\animales);
			},
				6, {
				//~d180_naturaleza.removeAt(\humanos);
			},
				7,{
					//~d180_naturaleza.removeAt(\ecosistemas);
				}
			 )
			},
			"i135",{
				switch(subcat,
				0, {
				//~i135_naturaleza.removeAt(\agua);
			},
				1, {
				//~i135_naturaleza.removeAt(\aire);
			},
				2, {
				//~i135_naturaleza.removeAt(\tierra);
			},
				3, {
				//~i135_naturaleza.removeAt(\fuego);
			},
				4, {
				//~i135_naturaleza.removeAt(\plantas);
			},
				5, {
				//~i135_naturaleza.removeAt(\animales);
			},
				6, {
				//~i135_naturaleza.removeAt(\humanos);
			},
				7,{
					//~i135_naturaleza.removeAt(\ecosistemas);
				}
			 )
			},
			"i90",{
				switch(cat,
					"naturaleza",{
						switch(subcat,
							0, {
								~i90_naturaleza.add(\agua -> ~agua);
							},
							1, {
								~i90_naturaleza.add(\aire -> ~aire);
							},
							2, {
								~i90_naturaleza.add(\tierra -> ~tierra);
							},
							3, {
								~i90_naturaleza.add(\fuego -> ~fuego);
							},
							4, {
								~i90_naturaleza.add(\plantas -> ~plantas);
							},
							5, {
								~i90_naturaleza.add(\animales -> ~animales);
							},
							6, {
								~i90_naturaleza.add(\humanos -> ~humanos);
							},
							7,{
								~i90_naturaleza.add(\ecosistemas -> ~ecosistemas);
							}
						)
					},
					"sociedad",{
						switch(subcat,
							0, {
								~i90_sociedad.add(\rurales -> ~rurales);
							},
							1, {
								~i90_sociedad.add(\ciudad -> ~ciudad);
							},
							2, {
								~i90_sociedad.add(\puertos -> ~puertos);
							},
							3, {
								~i90_sociedad.add(\domestico -> ~domestico);
							},
							4, {
								~i90_sociedad.add(\oficinas -> ~oficinas);

							},
							5, {
								~i90_sociedad.add(\fabricas -> ~fabricas);

							},
							6, {
								~i90_sociedad.add(\trabajo -> ~trabajo);

							},
							7, {
								~i90_sociedad.add(\entretenimiento -> ~entretenimiento);

							},
							8, {
								~i90_sociedad.add(\muchedumbres -> ~muchedumbres);

							},
							9, {
								~i90_sociedad.add(\ceremonias -> ~ceremonias);

							},
							10, {
								~i90_sociedad.add(\parques -> ~parques);

							},
							11, {
								~i90_sociedad.add(\indicadores -> ~indicadores);
							}
						)
					},
					"artilugios",{
						switch(subcat,
							0, {
								~i90_artilugios.add(\mecanismos -> ~mecanismos);
							},
							1, {
								~i90_artilugios.add(\industrial -> ~industrial);
							},
							2, {
								~i90_artilugios.add(\transportes -> ~transportes);
							},
							3, {
								~i90_artilugios.add(\guerra -> ~guerra);
							},
							4, {
								~i90_artilugios.add(\construccion -> ~construccion);
							},
							5, {
								~i90_artilugios.add(\ventiladores -> ~ventiladores);
							},
							6, {
								~i90_artilugios.add(\herramientas -> ~herramientas);
							}
						)
					},
					"quietud",{
						switch(subcat,
							0, {
								~i90_quietud.add(\hum -> ~hum);
							},
							1, {
								~i90_quietud.add(\vacio -> ~vacio);

							}
						)
					}
				)

			},
			"i45",{

			},
			"arriba",{

			}
		)
	})
	};

	/*~switch_general_naturaleza = {
		arg subcat, val;
		"switch naturaleza".postln;
		subcat.postln;
		val.postln;
		if(val == true,{
			"switch con val true".postln;
			switch(subcat,
				0, {
				~fr_naturaleza.add(\agua -> ~agua);
				//~ambi_naturaleza.add(\agua -> ~ambi_agua);
			},
				1, {
				~fr_naturaleza.add(\aire -> ~aire);
				//~ambi_naturaleza.add(\aire -> ~ambi_aire)
			},
				2, {
				~fr_naturaleza.add(\tierra -> ~tierra);
				//~ambi_naturaleza.add(\tierra -> ~ambi_tierra)
			},
				3, {
				~fr_naturaleza.add(\fuego -> ~fuego);
				//~ambi_naturaleza.add(\fuego -> ~ambi_fuego)
			},
				4, {
				~fr_naturaleza.add(\plantas -> ~plantas);
				//~ambi_naturaleza.add(\plantas -> ~ambi_plantas)
			},
				5, {
				~fr_naturaleza.add(\animales -> ~animales);
				//~ambi_naturaleza.add(\animales -> ~ambi_animales)
			},
				6, {
				~fr_naturaleza.add(\ecosistemas -> ~ecosistemas);
				//~ambi_naturaleza.add(\ecosistemas -> ~ambi_ecosistemas)
			},
			);
		},{
			"switch con val falso".postln;
			switch(subcat,
				0, {
				~fr_naturaleza.removeAt(\agua);
				//~ambi_naturaleza.removeAt(\agua);
			},
				1, {
				~fr_naturaleza.removeAt(\aire);
				//~ambi_naturaleza.removeAt(\aire);
			},
				2, {
				~fr_naturaleza.removeAt(\tierra);
				//~ambi_naturaleza.removeAt(\tierra);
			},
				3, {
				~fr_naturaleza.removeAt(\fuego);
				//~ambi_naturaleza.removeAt(\fuego);
			},
				4, {
				~fr_naturaleza.removeAt(\plantas);
				//~ambi_naturaleza.removeAt(\plantas);
			},
				5, {
				~fr_naturaleza.removeAt(\animales);
				//~ambi_naturaleza.removeAt(\animales);
			},
				6, {
				~fr_naturaleza.removeAt(\ecosistemas);
				//~ambi_naturaleza.removeAt(\ecosistemas);
			},
			);
		})

	};*/