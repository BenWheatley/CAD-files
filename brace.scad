module brace(inner_length, inner_width, inner_height, wall_thickness) {
    difference() {
        cube([inner_length + wall_thickness*2, inner_width + wall_thickness*2, inner_height + wall_thickness]);
        
        translate([wall_thickness, wall_thickness, wall_thickness])
            cube([inner_length, inner_width, inner_height+1]);
        
        translate([inner_length*0.25 + wall_thickness, inner_width*0.25 + wall_thickness, -1])
            cylinder(h = wall_thickness+2, r1 = 2, r2=3);
                translate([inner_length*0.75 + wall_thickness, inner_width*0.75 + wall_thickness, -1])
            cylinder(h = wall_thickness+2, r1 = 2, r2=3);
    };
}

brace(20.5, 30.5, 20, 3);