module linear_bracket(length, width, thickness, hole_diameter, countersink_head_diameter, hole_count_lengthwise, hole_count_widthwise, stagger_rows_horizontally_by) {
    
    difference() {
    //union() {
        // Main solid bracket
        cube([length, width, thickness]);
    
        // Create hole grid
        epsilon = 0.1;
        for (row = [0 : hole_count_lengthwise - 1]) {
            row_y_stagger = (row % 2 == 1) ? stagger_rows_horizontally_by : -stagger_rows_horizontally_by;
            for (column = [0 : hole_count_widthwise - 1]) {
                x_offset = (row + 0.5) * length / hole_count_lengthwise;
                y_offset = (column + 0.5) * width / hole_count_widthwise;
                
                translate([x_offset,
                           y_offset + row_y_stagger,
                           -epsilon/2])
                    cylinder(h = thickness+epsilon, d1 = hole_diameter, d2 = countersink_head_diameter, $fn = 50);
            }
        }
    }
}

/*linear_bracket(length = 80, width = 40, thickness = 4,
    hole_diameter = 3.5, countersink_head_diameter = 7,
    hole_count_lengthwise = 4, hole_count_widthwise = 2, stagger_rows_horizontally_by = 3);*/

translate([0, -40, 0])
    
linear_bracket(length = 48*2, width = 30, thickness = 4,
    hole_diameter = 3.5, countersink_head_diameter = 7,
    hole_count_lengthwise = 4, hole_count_widthwise = 1, stagger_rows_horizontally_by = 0);