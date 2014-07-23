// TODO
// Measure front leg mortise offset
// Get length of backrest and aprons, check mortise size
// Do seat
// Make front legs dxf have extra line

BACK_ANGLE = 6;
SEAT_HEIGHT = 17.5;
BACK_HEIGHT = 22.5;

// Derived constants
TAPERED_LEG_HEIGHT = SEAT_HEIGHT - 3/4 - 3.5;

module back_leg() {
	// Top part of back leg
	translate([1/4, 7/8, 0]) {
		scale([0.001, 0.001, 0.001]) {
			cylinder(h=1000, r=250);
		}
	}

	difference() {
		linear_extrude(height=1) {
			polygon(points=[[0, 0], [0, 7/8], [1/4-0.01, 1+1/8], [BACK_HEIGHT, 1+3/4+tan(BACK_ANGLE)*BACK_HEIGHT], [BACK_HEIGHT, tan(BACK_ANGLE)*BACK_HEIGHT]], paths=[[0, 1, 2, 3, 4]]);

		}

		// Align with front
		rotate([0, 0, BACK_ANGLE+atan(5/8/BACK_HEIGHT)]) {
			translate([0, 1+1/8, 0]) {

				// Backrest mortises
				translate([BACK_HEIGHT-19.5, -7/8, 1/2]) {
					cube([3+1/2, 3/8, 1/2+0.001]);
				}

				translate([BACK_HEIGHT-14.5, -7/8, 1/2]) {
					cube([3+1/2, 3/8, 1/2+0.001]);
				}
			}
		}
	}

	translate([BACK_HEIGHT, tan(BACK_ANGLE)*BACK_HEIGHT, 0]) {
		difference() {
			cube([4+1/4, 1+3/4, 1]);

			// Apron mortise
			translate([3/4, 1/2, 1/2]) {
				cube([3+1/2, 3/8, 1/2+0.001]);
			}

			// 90 degree apron mortise
			translate([3/4, 1+1/4, 3/8]) {
				cube([3+1/2, 1/2+0.001, 3/8]);
			}
		}

		// Bottom of back leg
		translate([4+1/4, 0]) {
			linear_extrude(height=1) {
				polygon(points=[[0, 0], [0, 1+3/4], [TAPERED_LEG_HEIGHT, 1+1/8-(tan(5)*TAPERED_LEG_HEIGHT)], [TAPERED_LEG_HEIGHT, -tan(5)*TAPERED_LEG_HEIGHT]], paths=[[0, 1, 2, 3]]);
			}
		} 
	}
}

module front_leg() {
	difference() {
		cube([3+1/2, 1+3/4, 1]);

		// Mortise
		translate([-0.001, 1/2, 1/2]) {
			cube([3+1/2+0.002, 3/8, 1/2+0.001]);
		}

		// 90 degree mortise
		translate([-0.001, 1+1/4, 3/8]) {
			cube([3+1/2+0.002, 1/2+0.001, 3/8]);
		}
	}

	translate([3+1/2, 0, 0]) {
		linear_extrude(height=1) {
			polygon(points=[[0, 0], [0, 1+3/4], [TAPERED_LEG_HEIGHT, 1+1/8], [TAPERED_LEG_HEIGHT, 0]], paths=[[0, 1, 2, 3]]);
		}
	}
}

module _tenon() {
	translate([0, 0, 3/16]) {
		cube([3/8, 3+1/2, 3/8]);
	}
}

module backrest_and_apron() {
	_tenon();

	translate([3/8, 0, 0]) {
		cube([17, 3+1/2, 3/4]);
		translate([17, 0, 0]) {
			_tenon();
		}
	}
}

module side_apron() {
	_tenon();

	translate([3/8, 0, 0]) {
		cube([16, 3+1/2, 3/4]);
		translate([16, 0, 0]) {
			_tenon();
		}
	}
}

module layout() {
	translate([0, 0, -1]) {
		back_leg();
	}
	translate([19, -1/2, -1]) {
		front_leg();
	}

	translate([82, 0, -1]) {
		mirror([1, 0, 0]) {
			back_leg();
			translate([19, -1/2, 0]) {
				front_leg();
			}
		}
	}

	for(i=[0:1:3]) {
		translate([i*19, 6, -3/8]) {
			backrest_and_apron();
		}
	}

	for(i=[0:1]) {
		translate([i*18, 12, -3/8]) {
			side_apron();
		}
	}
}

module model() {
	// Rotate model so it is easier to export to png
	rotate([0, 90, -90]) {
		back_leg();

		mirror([0, 0, 1]) {
			translate([0, 0, -18-7/8]) {
				back_leg();
			}
		}

		// Backrests
		rotate([0, 0, BACK_ANGLE+atan(5/8/BACK_HEIGHT)]) {
			translate([0, 1+1/8, 0]) {
				translate([BACK_HEIGHT-16, -3/8, 5/8]) {
					rotate([0, -90, 90]) {
						backrest_and_apron();
					}
				}

				translate([BACK_HEIGHT-11, -3/8, 5/8]) {
					rotate([0, -90, 90]) {
						backrest_and_apron();
					}
				}
			}
		}

		translate([BACK_HEIGHT, tan(BACK_ANGLE)*BACK_HEIGHT, 0]) {
			translate([4+1/4, 1+1/16, 1/2]) {
				rotate([0, -90, 90]) {
					backrest_and_apron();
				}
			}

			translate([4+1/4, 1+1/4, 3/16]) {
				rotate([0, 0, 90]) {
					side_apron();
					translate([0, 0, 17+7/8]) {
						side_apron();
					}
				}
			}
		}

		translate([BACK_HEIGHT+3/4, 16+3+3/8+tan(BACK_ANGLE)*BACK_HEIGHT, 0]) {
			mirror([0, 0, 1]) {
				rotate([180, 0, 0]) {
					front_leg();
				}
			}

			translate([0, 0, 19]) {
				rotate([180, 0, 0]) {
					front_leg();
				}
			}
		}

		translate([BACK_HEIGHT+4+1/4, 16+3+1/16+tan(BACK_ANGLE)*BACK_HEIGHT, 5/8]) {
			rotate([0, -90, 90]) {
				backrest_and_apron();
			}
		}
	}
}

if(MODE == "model") {
	model();

} else if(MODE == "layout") {
	layout();

} else {
	projection(cut=true) {
			layout();
	}
}
