#include <stdio.h>
#include <math.h>

#define x2 4

struct position2D {
    float x;
    float y;
};

typedef struct position2D Position2D;

void getPosition2D(Position2D *position, float r1, float r2);

void getPosition2D(Position2D *position, float r1, float r2) {
    position->x = (x2*x2 + r1*r1 - r2*r2) / (2 * x2);
    position->y = sqrtf(r1*r1 - position->x * position->x);
}

int main() {
    Position2D pos;
    Position2D *position = &pos;

    getPosition2D(position, 5, sqrtf(65));

    printf("%f\n", position->x);
    printf("%f\n", position->y);

    return 0;
}
