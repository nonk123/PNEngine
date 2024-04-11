global.shaders = ds_list_create()
global.uniforms_amount = 0

global.world_shader = new Shader(os_type == os_linux ? shWorldBlend : shWorld)
global.sky_shader = new Shader(shSky)
global.bloom_pass_shader = new Shader(shBloomPass)
global.bloom_up_shader = new Shader(shBloomUp)
global.bloom_down_shader = new Shader(shBloomDown)
global.curve_shader = new Shader(shCurve)
global.depth_shader = new Shader(shDepth)
global.dither_shader = new Shader(os_type == os_linux ? shDitherBlend : shDither)

global.u_ambient_color = new Uniform("u_ambient_color", UniformTypes.FLOAT)
global.u_animated = new Uniform("u_animated", UniformTypes.FLOAT)
global.u_bone_dq = new Uniform("u_bone_dq", UniformTypes.FLOAT_ARRAY)
global.u_color = new Uniform("u_color", UniformTypes.FLOAT)
global.u_fog_distance = new Uniform("u_fog_distance", UniformTypes.FLOAT)
global.u_fog_color = new Uniform("u_fog_color", UniformTypes.FLOAT)
global.u_light_data = new Uniform("u_light_data", UniformTypes.FLOAT_ARRAY)
global.u_material_alpha_test = new Uniform("u_material_alpha_test", UniformTypes.FLOAT)
global.u_material_bright = new Uniform("u_material_bright", UniformTypes.FLOAT)
global.u_material_color = new Uniform("u_material_color", UniformTypes.FLOAT)
global.u_material_scroll = new Uniform("u_material_scroll", UniformTypes.FLOAT)
global.u_material_specular = new Uniform("u_material_specular", UniformTypes.FLOAT)
global.u_material_wind = new Uniform("u_material_wind", UniformTypes.FLOAT)
global.u_time = new Uniform("u_time", UniformTypes.FLOAT)
global.u_uvs = new Uniform("u_uvs", UniformTypes.FLOAT)
global.u_wind = new Uniform("u_wind", UniformTypes.FLOAT)
global.u_threshold = new Uniform("u_threshold", UniformTypes.FLOAT)
global.u_intensity = new Uniform("u_intensity", UniformTypes.FLOAT)
global.u_texel = new Uniform("u_texel", UniformTypes.FLOAT)
global.u_curve = new Uniform("u_curve", UniformTypes.FLOAT)
global.u_material_can_blend = new Uniform("u_material_can_blend", UniformTypes.INTEGER)
global.u_material_blend = new Uniform("u_material_blend", UniformTypes.TEXTURE)
global.u_material_blend_uvs = new Uniform("u_material_blend_uvs", UniformTypes.FLOAT)