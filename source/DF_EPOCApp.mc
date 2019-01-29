// Dev UID = 90ef9ba1-31f5-4163-b2f5-f2e618c60eb1
// Prod UID = 5439b99b-e586-406d-b663-a5ae3484670e

using Toybox.Application;

class DF_EPOCApp extends Application.AppBase
{

    function initialize()
    {
        AppBase.initialize();
   		System.println("Application Start - Total Memory = " + System.getSystemStats().totalMemory + " / Used Memory = " + System.getSystemStats().usedMemory);
    }

    // onStart() is called on application start up
    function onStart(state)
    {
    }

    // onStop() is called when your application is exiting
    function onStop(state)
    {
    }

    //! Return the initial view of your application here
    function getInitialView()
    {
		var Args = new [2];

		Args[0] = Application.Properties.getValue("Use_Garmin_Training_Zones");
		Args[1]	= readPropertyKeyInt("Max_HR",180);

        return [ new DF_EPOCView(Args) ];
    }

	function readPropertyKeyInt(key,thisDefault)
	{
		//var value = getProperty(key);
		var value = Application.Properties.getValue(key);
		
        if(value == null || !(value instanceof Number))
        {
        	if(value != null)
        	{
            	value = value.toNumber();
        	}
        	else
        	{
                value = thisDefault;
        	}
		}
		return value;
	}

}