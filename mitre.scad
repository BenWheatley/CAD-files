module mitre(inner_width, inner_length, inner_height, wall_thickness, gap_width, angles) {
    difference() {
        cube([inner_width+(2*wall_thickness), inner_length, inner_height+wall_thickness]);
        
        translate([wall_thickness, -wall_thickness, wall_thickness])
            cube([inner_width, inner_length+(2*wall_thickness), inner_height+wall_thickness]);
        
        for (angle = angles) {
            excess_margin = 1;
            translate([wall_thickness + inner_width/2, inner_length/2, wall_thickness + (excess_margin/2) + inner_height/2])
                rotate([0, 0, angle])
                    cube([inner_width*3, gap_width, inner_height+excess_margin], center = true);
        }
    }
}

mitre(inner_width=24, inner_length=70, inner_height=24, wall_thickness=2, gap_width=2, angles=[0, 30, 45, 60]);