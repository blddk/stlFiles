nutDiameter = 19; // [6.0:0.1:100.1]
nutHeight = 30; // [20:100]
nutWall = 3; // [1:30]

nutOpening = nutDiameter-5;

handleThickness = 5; // [3:100]
handleLength = 50; // [50:200]
handleRadius = 5;


outsideRadius = (nutDiameter/2)/cos(30)+nutWall;
handleWidth = 20;

difference()
{
    union()
    {
        // Handle
        $fn=20;
        minkowski()
        {
            translate([0,(handleLength-(handleRadius*2))/2+outsideRadius+(handleRadius/2),-nutHeight/2])
                linear_extrude(height = handleThickness, center = true)
                    square([handleWidth-(handleRadius*2),(handleLength-(handleRadius*2))+outsideRadius], center=true);
                    cylinder(r=handleRadius,h=1);
        }

        // Outside radius of the nut
        linear_extrude(height = nutHeight+handleThickness, center = true)
            circle(r=outsideRadius, $fn=200);
    }
    
    union()
    {
        // Cutout in the nut
        translate([0,-outsideRadius/2,0])
            linear_extrude(height = nutHeight+handleThickness+2, center = true)
                square([nutOpening,outsideRadius], center=true);
        
        // Inside nut
        rotate(a=[0,0,30])
        {
            linear_extrude(height = nutHeight+handleThickness+2, center = true)
                circle(r=(nutDiameter/2)/cos(30), $fn=6);
        }
    }
}