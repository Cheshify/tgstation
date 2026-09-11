#ifndef MINIMAL_CENTCOM
#include "map_files\generic\CentCom.dmm"
#else
#include "map_files\generic\CentCom_minimal.dmm"
#endif

<<<<<<< HEAD
#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\debug\multiz.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\Deltastation\DeltaStation2.dmm"
		#include "map_files\IceBoxStation\IceBoxStation.dmm"
		#include "map_files\MetaStation\MetaStation.dmm"
		#include "map_files\Mining\Lavaland.dmm"
		#include "map_files\tramstation\tramstation.dmm"
		#include "map_files\CatwalkStation\CatwalkStation_2023.dmm"
		#include "map_files\NebulaStation\NebulaStation.dmm"
		#include "map_files\wawastation\wawastation.dmm"
		#include "map_files\pubbystation\pubbystation.dmm"

	#endif
	#ifdef ALL_TEMPLATES
		#include "templates.dm"
	#endif
=======
#ifdef ALL_MAPS
	#include "map_files\debug\multiz.dmm"
	#include "map_files\debug\runtimestation.dmm"
	#include "map_files\Deltastation\DeltaStation2.dmm"
	#include "map_files\IceBoxStation\IceBoxStation.dmm"
	#include "map_files\MetaStation\MetaStation.dmm"
	#include "map_files\Mining\Lavaland.dmm"
	#include "map_files\tramstation\tramstation.dmm"
	#include "map_files\CatwalkStation\CatwalkStation_2023.dmm"
	#include "map_files\NebulaStation\NebulaStation.dmm"
	#include "map_files\KiloStation\KiloStation.dmm"
#endif
#ifdef ALL_TEMPLATES
	#include "templates.dm"
>>>>>>> e7bc2fec00cb80b46430a38abca984960aa0da68
#endif
