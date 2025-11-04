vertical_pillar_cross_section_size = 77;
terrace_width = 2000;
inner_wall_height = 3500;
outer_wall_height = inner_wall_height - terrace_width; // I'm assuming 45°
angle = 45;

slope_length = terrace_width/sin(angle);

crossbeam_cross_section_size = 25;

pv_height = 1134;
pv_length = 1762; // seen from 2278 to 1762
pv_thickness = 35;

module arch() {
    cube([vertical_pillar_cross_section_size, vertical_pillar_cross_section_size, inner_wall_height]);
    translate([terrace_width, 0, 0])
        cube([vertical_pillar_cross_section_size, vertical_pillar_cross_section_size, outer_wall_height]);
    translate([vertical_pillar_cross_section_size * sin(angle), 0, inner_wall_height])
        rotate([0, 90 + angle, 0])
            cube([vertical_pillar_cross_section_size, vertical_pillar_cross_section_size, slope_length]);
}

module pv() {
    color("#000080")
    cube([pv_length, pv_height, pv_thickness]);
}

module row(arch_positions, overall_rotation, overall_translation) {
    rotate(overall_rotation)
    translate(overall_translation)
    {
        for (y = arch_positions) {
            translate([0, y, 0])
                arch();
        }
        
        translate([vertical_pillar_cross_section_size * sin(angle), 0,  inner_wall_height])
        rotate([-90, angle, 0])
        {
            for (i = [0, 0.5, 1]) {
                translate([i*slope_length, 0, 0])
                    cube([vertical_pillar_cross_section_size, vertical_pillar_cross_section_size, max(arch_positions)]);
            }
            rotate([0, 90, 0])
            for (i = [0: -250: -max(arch_positions)]) {
                translate([i, 0, 0])
                cube([crossbeam_cross_section_size, crossbeam_cross_section_size, slope_length]);
            }
            
            rotate([90, 0, 0])
            {
                baseline_displacement = min(arch_positions) + vertical_pillar_cross_section_size;
                for(i = [1:3]) {
                    translate([0, baseline_displacement + i*pv_length - vertical_pillar_cross_section_size, 0])
                    rotate([0, 0, -90])
                    pv();
                }
                for(i = [0:1]) {
                    translate([pv_height, baseline_displacement + i*pv_height - vertical_pillar_cross_section_size, 0])
                    pv();
                }
            }
        }
    }
}


module side() {
    row(arch_positions = [-vertical_pillar_cross_section_size, 2000, 5230-vertical_pillar_cross_section_size], overall_rotation = [0, 0, 0], overall_translation = [0, 0, 0]);
}

module front() {
    row(arch_positions = [0, 2000, 5250], overall_rotation = [0, 0, -90], overall_translation = [0, -5250, 0]);

}

color("#000000")
front();
side();

// Terrace
color("#ffffff")
{
translate([-5250, -2000, -100])
    cube([7250, 7253, 100]);
translate([-5250, -2400, 0])
    cube([7250, 800, 800]);
translate([1600, -2400, 0])
    cube([800, 7253+400, 800]);
}