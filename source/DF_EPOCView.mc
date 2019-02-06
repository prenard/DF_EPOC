using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.FitContributor as Fit;

class DF_EPOCView extends Ui.DataField
{

	var Device_Type;
	var Max_HR;

	// History:
	//
	// 23/12/2018 - US = 0.10850 / DS = 0.1390
	// 30/12/2018 - US = 0.10850 / DS = 0.1200
	//

	// UpSlope
	
	/*
	var UpSlopeThreshold = 0.70;

	var UpSlopeOriginBelowThreshold = 0;
	var UpSlopePercentBelowThreshold = 0.10850;

	var UpSlopePercentAboveThreshold = 0.04859;
	var UpSlopeOriginAboveThreshold = 4.34086;
	*/
	
	var b1 = 0.1851;
	var b2 = 3.0;
	var b3 = 0.015;
	
	var p1 = 0.0;
	var p2 = 1.0;
	
	// DownSlope
	var c = 1.17;
	
	//var DownSlopePercent = 0.1200;
	//var DownSlopePerSec = 1 / Math.pow(c,1.0/60);
	
	var Use_Garmin_Training_Zones = false;
	
	// Layout Fields

    var DF_Title_Value = "EPOC";
	var DF_Title_x = 0;
	var DF_Title_y = 0;
	var DF_Title_font = Gfx.FONT_XTINY;

    var MaxHR_Title_Value = "Max HR:";
	var MaxHR_Title_x = 0;
	var MaxHR_Title_y = 0;
	var MaxHR_Title_font = Gfx.FONT_XTINY;

    var MaxHR_Value = 0;
	var MaxHR_Value_x = 0;
	var MaxHR_Value_y = 0;
	var MaxHR_Value_font = Gfx.FONT_XTINY;

    var EPOC_Value = 0;
	var EPOC_Value_x = 0;
	var EPOC_Value_y = 0;
	var EPOC_Value_font = Gfx.FONT_XTINY;

	var EPOC_Field;
	const EPOC_Field_id = 0;

    var MaxEPOC_Title_Value = "Max:";
	var MaxEPOC_Title_x = 0;
	var MaxEPOC_Title_y = 0;
	var MaxEPOC_Title_font = Gfx.FONT_XTINY;

    var MaxEPOC_Value = 0;
	var MaxEPOC_Value_x = 0;
	var MaxEPOC_Value_y = 0;
	var MaxEPOC_Value_font = Gfx.FONT_XTINY;


    function initialize(Args)
    {
        DataField.initialize();

		Use_Garmin_Training_Zones = Args[0];
        Max_HR = Args[1];
        		
	    Device_Type = Ui.loadResource(Rez.Strings.Device);
		System.println("Device_Type = " + Device_Type);

        var Sport = UserProfile.getCurrentSport();
        var Profile = UserProfile.getProfile();
		var Garmin_HR_Zones_Array = UserProfile.getHeartRateZones(Sport);
		
		System.println("Sport = " + Sport);
		System.println("activityClass = " + Profile.activityClass);
        System.println("HeartRateZones = " + Garmin_HR_Zones_Array);

		if (Use_Garmin_Training_Zones)
		{
        	Max_HR = Garmin_HR_Zones_Array[Garmin_HR_Zones_Array.size()-1];
		}
        
        System.println("Max_HR = " + Max_HR);


		MaxHR_Value = Max_HR;

		switch (Device_Type)
		{
			case "edge_820":

				DF_Title_x = 1;
				DF_Title_y = 0;
				DF_Title_font = Gfx.FONT_XTINY;

				MaxHR_Title_x = 40;
				MaxHR_Title_y = 0;
				MaxHR_Title_font = Gfx.FONT_XTINY;

				MaxHR_Value_x = 97;
				MaxHR_Value_y = 0;
				MaxHR_Value_font = Gfx.FONT_XTINY;
 
				MaxEPOC_Title_x = 25;
				MaxEPOC_Title_y = 9;
				MaxEPOC_Title_font = Gfx.FONT_XTINY;

				MaxEPOC_Value_x = 97;
				MaxEPOC_Value_y = 9;
				//MaxEPOC_Value_font = Gfx.FONT_NUMBER_MILD;
				MaxEPOC_Value_font = Gfx.FONT_SMALL;
				
				EPOC_Value_x = 97;
				EPOC_Value_y = 24;
				//EPOC_Value_font = Gfx.FONT_NUMBER_THAI_HOT;
				//EPOC_Value_font = Gfx.FONT_NUMBER_HOT;
				//EPOC_Value_font = Gfx.FONT_NUMBER_MEDIUM;
				EPOC_Value_font = Gfx.FONT_LARGE;

				break;

			case "edge_1030":

				DF_Title_x = 1;
				DF_Title_y = 1;
				DF_Title_font = Gfx.FONT_XTINY;

				MaxHR_Title_x = 40;
				MaxHR_Title_y = 1;
				MaxHR_Title_font = Gfx.FONT_XTINY;

				MaxHR_Value_x = 110;
				MaxHR_Value_y = 1;
				MaxHR_Value_font = Gfx.FONT_XTINY;
 
				MaxEPOC_Title_x = 25;
				MaxEPOC_Title_y = 15;
				MaxEPOC_Title_font = Gfx.FONT_XTINY;

				MaxEPOC_Value_x = 140;
				MaxEPOC_Value_y = 15;
				MaxEPOC_Value_font = Gfx.FONT_NUMBER_MILD;

				EPOC_Value_x = 140;
				EPOC_Value_y = 52;
				//EPOC_Value_font = Gfx.FONT_NUMBER_THAI_HOT;
				//EPOC_Value_font = Gfx.FONT_NUMBER_HOT;
				EPOC_Value_font = Gfx.FONT_NUMBER_MEDIUM;
				
				break;

			case "fr935":

				DF_Title_x = 100;
				DF_Title_y = 1;
				DF_Title_font = Gfx.FONT_XTINY;

				MaxHR_Title_x = 15;
				MaxHR_Title_y = 60;
				MaxHR_Title_font = Gfx.FONT_XTINY;

				MaxHR_Value_x = 40;
				MaxHR_Value_y = 80;
				MaxHR_Value_font = Gfx.FONT_XTINY;
 
				MaxEPOC_Title_x = 90;
				MaxEPOC_Title_y = 22;
				MaxEPOC_Title_font = Gfx.FONT_XTINY;

				MaxEPOC_Value_x = 190;
				MaxEPOC_Value_y = 27;
				MaxEPOC_Value_font = Gfx.FONT_NUMBER_MILD;

				EPOC_Value_x = 220;
				EPOC_Value_y = 60;
				//EPOC_Value_font = Gfx.FONT_NUMBER_THAI_HOT;
				//EPOC_Value_font = Gfx.FONT_NUMBER_HOT;
				EPOC_Value_font = Gfx.FONT_NUMBER_MEDIUM;
				
				break;

			default:
				break;
		}

		EPOC_Field = createField("EPOC", EPOC_Field_id, FitContributor.DATA_TYPE_FLOAT, { :mesgType=>Fit.MESG_TYPE_RECORD, :units=>"ml/kg" });
    }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc)
    {

		//
		// To get screen size
		//
    	//System.println("DC Height  = " + dc.getHeight());
      	//System.println("DC Width  = " + dc.getWidth());
        
        View.setLayout(Rez.Layouts.MainLayout(dc));
        return true;
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info)
    {
		if (info.currentHeartRate != null)
		{
			var heartrate = info.currentHeartRate;
			var intensity = Intensity(heartrate);
			var deltaEPOCperSec = deltaEPOCperSec(intensity, EPOC_Value);
			EPOC_Value += deltaEPOCperSec;
			if (EPOC_Value > MaxEPOC_Value)
			{
				MaxEPOC_Value = EPOC_Value;
			}
			EPOC_Field.setData(EPOC_Value.toFloat());
			System.println("heartrate = " + heartrate + " - intensity = " + intensity + " - deltaEPOCperSec = " + deltaEPOCperSec + " - EPOC_Value = " + EPOC_Value);
		}
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc)
    {
        // Set the background color
        View.findDrawableById("Background").setColor(getBackgroundColor());

		var FontDisplayColor = Gfx.COLOR_BLACK;

        if (getBackgroundColor() == Gfx.COLOR_BLACK)
        {
            FontDisplayColor = Gfx.COLOR_WHITE;
        }
        else
        {
            FontDisplayColor = Gfx.COLOR_BLACK;
        }


        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);

		textL(dc, DF_Title_x, DF_Title_y, DF_Title_font, FontDisplayColor, DF_Title_Value);
		textL(dc, MaxHR_Title_x, MaxHR_Title_y, MaxHR_Title_font, FontDisplayColor, MaxHR_Title_Value);
		textR(dc, MaxHR_Value_x, MaxHR_Value_y, MaxHR_Value_font, FontDisplayColor, MaxHR_Value);

		textR(dc, MaxEPOC_Title_x, MaxEPOC_Title_y, MaxEPOC_Title_font, FontDisplayColor, MaxEPOC_Title_Value);
		textR(dc, MaxEPOC_Value_x, MaxEPOC_Value_y, MaxEPOC_Value_font, FontDisplayColor, MaxEPOC_Value.format("%.2f").toString());
		
		textR(dc, EPOC_Value_x, EPOC_Value_y, EPOC_Value_font, FontDisplayColor, EPOC_Value.format("%.2f").toString());
		
    }

	function textR(dc, x, y, font, color, s)
	{
		if (s != null)
		{
			dc.setColor(color, Gfx.COLOR_TRANSPARENT);
			//dc.drawText(x, y, font, s, Graphics.TEXT_JUSTIFY_RIGHT|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(x, y, font, s, Graphics.TEXT_JUSTIFY_RIGHT);
		}
	}

	function textL(dc, x, y, font, color, s)
	{
		if (s != null)
		{
			dc.setColor(color, Gfx.COLOR_TRANSPARENT);
			//dc.drawText(x, y, font, s, Graphics.TEXT_JUSTIFY_LEFT|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(x, y, font, s, Graphics.TEXT_JUSTIFY_LEFT);
		}
	}

	function Intensity(HR)
	{
		var pHR =  HR.toFloat() / Max_HR;
		var pVO2 = pVO2(pHR);
		return (pVO2);
	}
	

	function pVO2(pHR)
	{
		System.println("pHR = " + pHR);
		var pVO2 = 1.459 * pHR * pHR - 0.49 * pHR + 0.04;
		if (pVO2 < 0)
		{
			pVO2 = 0;
		}
		System.println("pVO2 = " + pVO2);
		return (pVO2);
	}

	function zmf(intensity)
	{
		var zmf = 0;
		if (intensity <= p1)
		{
			zmf = 1;
		}
		else
		if ((intensity > p1) && (intensity <= (p2 + p1)/2))
		{
			zmf = 1 - 2 * Math.pow((intensity - p1)/(p1 -p2),2);
		}
		else
		{
			zmf = 2 * Math.pow((p2 - intensity)/(p2 - p1), 2);
		}
		System.println("zmf = " + zmf);
		return (zmf);
	}

	function EPOC_DownSlopePercent(time)
	{
		var DownSlopePercent = - (1 - 1 / Math.pow(c,time.toFloat()/60));
		System.println("DownSlopePercent - time = " + time + " - " + DownSlopePercent);
		return (DownSlopePercent);
	}

	function EPOC_UpSlope(time,intensity,oldEPOC)
	{
		var UpSlope = y(intensity, time + y_reverse(intensity,oldEPOC)) / 60;

		System.println("UpSlope - time = " + time + " - " + UpSlope);

		return (UpSlope);
	}


	   function y1(time, intensity, oldEPOC)
	   {
		   //var newEPOC = - EPOC_DownSlopePercent(intensity) * oldEPOC;
		   var y1 = EPOC_DownSlopePercent(time) * oldEPOC;
		   System.println("y1 = " + y1);
		   return(y1);
	   }	   

	   function y2(time, intensity, oldEPOC)
	   {
		   var newEPOC = (1 - zmf(intensity)) * EPOC_UpSlope(time, intensity,oldEPOC) + zmf(intensity) * y1(time, intensity,oldEPOC);
		   var y2 = newEPOC;
		   System.println("y2 = " + y2);
		   return(y2);
	   }	   

	function deltaEPOCperSec(intensity, oldEPOC)
	{
		   var deltaEPOCperSec;
		   var y1 = y1(1, intensity, oldEPOC);
		   var y2 = y2(1, intensity, oldEPOC);
		   if (y1 > y2)
		   {
		   		deltaEPOCperSec = y1;
		   }
		   else
		   {
		   		deltaEPOCperSec = y2;
		   }
		   System.println("deltaEPOCperSec = " + deltaEPOCperSec);
		   return(deltaEPOCperSec);
	}

	function y(intensity, oldEPOC)
	{
		var y = 0;
		
		var c1 = b1 * intensity;
		var c2 = b2 * intensity;
		var c3 = c1 + b3 * intensity;
		
		if (oldEPOC >= c1 * c2 / (c3 - c1) + c2)
		{
			y = (oldEPOC - c2) / c1;
		}
		else
		{
			y = oldEPOC / c3;
		}
		return(y);
	}

	function y_reverse(intensity, oldEPOC)
	{
		var y_reverse = 0;
		if (y(intensity, oldEPOC) == 0)
		{
			y_reverse = 0;
		}
		else
		{
			y_reverse = oldEPOC / y(intensity,oldEPOC);
		}
		return(y_reverse);
	}

}
