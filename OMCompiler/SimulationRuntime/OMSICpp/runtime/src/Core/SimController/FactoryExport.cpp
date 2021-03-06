/** @addtogroup coreSimcontroller
 *
 *  @{
 */
#include <Core/ModelicaDefine.h>
#include <Core/Modelica.h>

#if defined(OMC_BUILD) && !defined(RUNTIME_STATIC_LINKING)

#include <Core/SimController/ISimController.h>
#include <Core/SimController/SimController.h>

/*OMC factory*/
using boost::extensions::factory;
BOOST_EXTENSION_TYPE_MAP_FUNCTION {
 
types.get<std::map<std::string, factory<ISimController, PATH, PATH,bool> > >()
["SimController"].set<SimController>();
}

#elif defined(OMC_BUILD) && defined(RUNTIME_STATIC_LINKING)
#include <Core/SimController/ISimController.h>
#include <Core/SimController/SimController.h>

shared_ptr<ISimController> createSimController(PATH library_path, PATH modelicasystem_path, bool startZeroMQ = false)
{
    return shared_ptr<ISimController>(new SimController(library_path, modelicasystem_path, startZeroMQ));
}


#else
error
"operating system not supported"
#endif
/** @} */ // end of coreSimcontroller
