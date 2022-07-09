extends Line2D

const vertices: int = 64

func generate(radius: float):
	var new_vertices: Array = []
	for v in range(vertices):
		new_vertices.append(Vector2(radius, 0.0).rotated((float(v)/float(vertices)) * 2.0*PI))
	new_vertices.append(new_vertices[0])
	points = new_vertices
