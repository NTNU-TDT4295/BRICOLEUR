// Explanation and derivation of formulas used:
// https://docs.google.com/document/d/1bng-I3OrYp1IoY3vhtT-xtBhCldARYmhWZ4Pq9hrSdY/edit

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

// 2D line on the form y = ax + b
struct line {
    float a;
    float b;
};

typedef struct position2D Position2D;
typedef struct position3D Position3D;
typedef struct line Line;

void getPosition2D(Position2D *position, float r1, float r2);
void getPosition3D(Position3D *position, float r1, float r2, float r3);
void getLine(Line *line, Position2D positions[], int length);

void getPosition2D(Position2D *position, float r1, float r2) {
    position->x = (x2*x2 + r1*r1 - r2*r2) / (2 * x2);
    position->y = sqrtf(r1*r1 - position->x * position->x);
}

void getPosition3D(Position3D *position, float r1, float r2, float r3) {
    position->x = (x2*x2 + r1*r1 - r2*r2) / (2 * x2);
    position->y = (y3*y3 + r1*r1 - r3*r3) / (2 * y3);
    position->z = sqrtf(r1*r1 - position->x * position->x - position->y * position->y);
}

void getLine(Line *line, Position2D positions[], int length) {
    // Algorithm: Ordinary linear least squares method

    float x_avg = 0;
    float y_avg = 0;

    for (int i = 0; i < length; i++) {
        x_avg += positions[i].x;
        y_avg += positions[i].y;
    }

    x_avg /= length;
    y_avg /= length;

    float x_diff[length];
    float y_diff[length];

    for (int i = 0; i < length; i++) {
        x_diff[i] = positions[i].x - x_avg;
        y_diff[i] = positions[i].y - y_avg;
    }

    float S_xy = 0;
    float S_x2 = 0;

    for (int i = 0; i < length; i++) {
        S_xy += x_diff[i] * y_diff[i];
        S_x2 += x_diff[i] * x_diff[i];
    }

    // Normally we would divide both S_xy and S_x2 by n-1, but when we do
    // a = S_xy / S_x2, it cancels out

    line->a = S_xy / S_x2;
    line->b = y_avg - (line->a * x_avg);
}

int main() {
    Position2D pos;
    Position2D *position = &pos;

    getPosition2D(position, 5, sqrtf(65));
    // getPosition2D(position, 8.6, 9);

    printf("%f\n", position->x);
    printf("%f\n", position->y);

    Line line;
    Line *linePtr = &line;
    
    Position2D positions[2];
    positions[0].x = 1;
    positions[0].y = 5;
    positions[1].x = 2;
    positions[1].y = 7;

    getLine(linePtr, positions, 2);
    printf("y = %fx + %f\n", line.a, line.b);

    return 0;
}
