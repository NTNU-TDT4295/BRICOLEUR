#include <stdio.h>
#include <math.h>

#define x2 4  // Distance along the x axis from origo to sensor 2
#define y3 4  // Distance along the y axis from origo to sensor 3

struct position2D {
    float x;
    float y;
};

struct position3D {
    float x;
    float y;
    float z;
};

typedef struct position2D Position2D;
typedef struct position3D Position3D;

void getPosition2D(Position2D *position, float r1, float r2);
void getPosition3D(Position3D *position, float r1, float r2, float r3);

void getPosition2D(Position2D *position, float r1, float r2) {
    position->x = (x2*x2 + r1*r1 - r2*r2) / (2 * x2);
    position->y = sqrtf(r1*r1 - position->x * position->x);
}

void getPosition3D(Position3D *position, float r1, float r2, float r3) {
    position->x = (x2*x2 + r1*r1 - r2*r2) / (2 * x2);
    position->y = (y3*y3 + r1*r1 - r3*r3) / (2 * y3);
    position->z = sqrtf(r1*r1 - position->x * position->x - position->y * position->y);
}

int main() {
    Position2D pos;
    Position2D *position = &pos;

    getPosition2D(position, 5, sqrtf(65));

    printf("%f\n", position->x);
    printf("%f\n", position->y);

    return 0;
}
