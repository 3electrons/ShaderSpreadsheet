pragma Singleton
import QtQuick 2.3
import QtGraphicalEffects 1.0

QtObject 
{
  property int id: 1000 ; 
  property string layout: "layout1"
  

  signal save();

  function nameId() 
  {
     var name = "Name" + id++; 
     return name; 
  }


}
