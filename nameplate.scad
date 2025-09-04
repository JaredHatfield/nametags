// Customizable Name Plate Generator
// Professional nameplate with embossed text for color swap printing
// Compatible with standard 3D printing conventions

// =============================================================================
// CONFIGURATION PARAMETERS
// =============================================================================

// Nameplate Dimensions (in inches, converted to mm)
plate_width = 10 * 25.4;        // 10 inches in mm
plate_height = 2 * 25.4;        // 2 inches in mm  
plate_thickness = 1/16 * 25.4;   // 1/16 inch in mm

// Text Configuration
name_text = "Your Name";        // The name to display
font_size = 24;                 // Font size in points
font_name = "Liberation Sans:style=Bold"; // Font family and style

// Emboss Configuration (for color swap)
emboss_depth = plate_thickness / 2; // Depth of text recess (1/2 of plate thickness)

// Corner Radius for professional appearance
corner_radius = 3;              // Rounded corner radius in mm

// =============================================================================
// HELPER MODULES
// =============================================================================

// Create rounded rectangle
module rounded_rect(width, height, thickness, radius) {
    hull() {
        translate([radius, radius, 0])
            cylinder(h=thickness, r=radius, $fn=32);
        translate([width-radius, radius, 0])
            cylinder(h=thickness, r=radius, $fn=32);
        translate([radius, height-radius, 0])
            cylinder(h=thickness, r=radius, $fn=32);
        translate([width-radius, height-radius, 0])
            cylinder(h=thickness, r=radius, $fn=32);
    }
}

// Create embossed (recessed) text
module embossed_text(text, size, font, depth) {
    translate([plate_width/2, plate_height/2, plate_thickness - depth])
        linear_extrude(height=depth + 0.1)  // +0.1 ensures complete subtraction
            text(text, 
                 size=size, 
                 font=font, 
                 halign="center", 
                 valign="center");
}

// =============================================================================
// MAIN NAMEPLATE ASSEMBLY
// =============================================================================

module nameplate() {
    difference() {
        // Base plate with rounded corners
        rounded_rect(plate_width, plate_height, plate_thickness, corner_radius);
        
        // Subtract text area to create embossed (recessed) text
        embossed_text(name_text, font_size, font_name, emboss_depth);
    }
}

// =============================================================================
// RENDERING
// =============================================================================

// Generate the nameplate
nameplate();

// =============================================================================
// PRINTING INSTRUCTIONS (Comments)
// =============================================================================

/*
PRINTING INSTRUCTIONS:

1. Print Settings:
   - Layer Height: 0.2mm recommended
   - Infill: 15-20% for base layer
   - Support: None required
   - Orientation: Print flat on build plate

2. Color Swap Instructions:
   - Print base color until layer height reaches (plate_thickness - emboss_depth)
   - Pause print and swap to contrasting color filament
   - Resume printing to fill the embossed text area
   - The swap should occur at approximately layer: (plate_thickness - emboss_depth) / layer_height

3. Recommended Materials:
   - PLA for office environment
   - PETG for more durability
   - Use contrasting colors for professional appearance

4. Post-Processing:
   - Light sanding of base if needed
   - No supports to remove

CUSTOMIZATION:
- Modify the configuration parameters at the top of this file
- Adjust font_name to use different fonts installed on your system
- Change dimensions as needed for different applications
- Emboss height is automatically calculated as 1/2 plate thickness

QUALITY NOTES:
- Corner radius provides professional appearance
- Emboss depth ensures proper color swap adhesion
- Text is automatically centered on the nameplate
- All dimensions are parameterized for easy customization
*/