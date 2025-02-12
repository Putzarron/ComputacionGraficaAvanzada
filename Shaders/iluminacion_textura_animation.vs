#version 330 core
const int MAX_BONES = 100;
layout (location = 0) in vec3 in_position;
layout (location = 2) in vec2 in_uv;
layout (location = 3) in vec3 in_normal;
layout (location = 4) in ivec4 boneIDs;
layout (location = 5) in vec4 weights;

out vec3 our_normal;
out vec3 fragPos;
out vec2 our_uv;

uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;

uniform mat4 bones[MAX_BONES];
uniform int numBones;

void main(){

	mat4 boneTransform;
	if(numBones > 0){
		boneTransform = bones[boneIDs[0]] * weights[0];
		boneTransform += bones[boneIDs[1]] * weights[1];
		boneTransform += bones[boneIDs[2]] * weights[2];
		boneTransform += bones[boneIDs[3]] * weights[3];
	}
	else
		boneTransform = mat4(1.0);
	gl_Position = projection * view * model * boneTransform * vec4(in_position, 1.0);
	fragPos = vec3(model * boneTransform * vec4(in_position, 1.0));
	our_normal = mat3(transpose(inverse(model * boneTransform))) * in_normal;
	our_uv = in_uv;
}

