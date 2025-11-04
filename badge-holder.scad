module half_cylinder(d=15, h=5, hole_r=2.5) {
    r = d / 2;
    extra = 1;
    
    difference() {
        cylinder(h=h, r=r, $fn = 100);
        translate([-r, -r, -extra/2])
            cube([d, r, h + extra]);
        translate([0, hole_r, -extra/2])
            cylinder(h=h+extra, r=hole_r, $fn = 100);
    }
}

module entire_badge(overall_thickness, photo_slot_thickness) {
	// Dimensions
	main_x = 80;
	main_y = 95;
	main_z = overall_thickness;
	
	cut_x = 60;
	cut_y = 60;
	cut_z = overall_thickness/2 + photo_slot_thickness/2;
	
	cut_margin = 0.1;
	
	badge_x = 72;
	badge_y = 88;
	badge_z = 0.5;
	
	// Main block
	difference() {
		cube([main_x, main_y, main_z]);
	
		translate([
			(main_x - cut_x)/2,           // Centered on X
			main_y - 10 - cut_y,          // 10mm from top (Y)
			main_z - cut_z + cut_margin // Flush with top surface (Z)
		])
		cube([cut_x, cut_y, cut_z + cut_margin]);
		
		translate([
			(main_x/2) - badge_x/2,
			main_y - badge_y - 3,     
			(main_z - badge_z)/2 
		])
		cube([main_x, badge_y, badge_z]);
	}
	
	lanyard_d = 15;
	lanyard_h = main_z;
	
	translate([lanyard_d/2, main_y, 0])
		half_cylinder(d = lanyard_d, h = lanyard_h);
	
	translate([main_x - lanyard_d/2, main_y, 0])
		half_cylinder(d = lanyard_d, h = lanyard_h);
}

overall_thickness = 3;
photo_slot_thickness = 0.5;
infintesimal = 0.1;
cube_size = 110;
difference() {
    entire_badge(overall_thickness, photo_slot_thickness);
    translate([-infintesimal, -infintesimal, overall_thickness/2-infintesimal])
        cube(cube_size);
}

translate([100, 0, 0])
intersection() {
    entire_badge(overall_thickness, photo_slot_thickness);
    translate([-infintesimal, -infintesimal, overall_thickness/2-infintesimal])
        cube(cube_size);
}

