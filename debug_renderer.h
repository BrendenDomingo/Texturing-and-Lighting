#pragma once

#include "math_types.h"

// Interface to the debug renderer
namespace end
{
	namespace debug_renderer
	{
		void add_line(float3 point_a, float3 point_b, float4 color_a,float2 UVA, float2 UVB,float3 norm1,float3 norm2);

		void clear_lines();

		const colored_vertex* get_line_verts();

		size_t get_line_vert_count();

		size_t get_line_vert_capacity();
	}
}