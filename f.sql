DROP TABLE IF EXISTS matrices;
CREATE TABLE matrices (
  matrix_id int NOT NULL, -- unique identifier for each matrix
  i int NOT NULL,         -- row number
  j int NOT NULL,         -- column number
  val decimal NOT NULL,   -- the value in this cell
  PRIMARY KEY (matrix_id, i, j)
);

-- insert sparse representation of
/* [[0,  4,  5],
    [-1, 1,  2],
    [0,  0, -3]] */
INSERT INTO matrices
VALUES
  (1, 0, 1, 4 ),
  (1, 0, 2, 5 ),
  (1, 1, 0, -1),
  (1, 1, 1, 1 ),
  (1, 1, 2, 2 ),
  (1, 2, 2, -3);

-- insert sparse representation of
/* [[0,  1,  0],
    [-2, 1,  0],
    [0,  2, -1]] */
INSERT INTO matrices
VALUES
  (2, 0, 1, 1 ),
  (2, 1, 0, -2),
  (2, 1, 1, 1 ),
  (2, 2, 1, 2 ),
  (2, 2, 2, -1);

-- query for the multiplication product
SELECT
  matrix_1.i,
  matrix_2.j,
  sum(matrix_1.val * matrix_2.val) AS val
FROM (SELECT * FROM matrices WHERE matrix_id = 1) matrix_1
JOIN (SELECT * FROM matrices WHERE matrix_id = 2) matrix_2
  ON matrix_1.j = matrix_2.i
GROUP BY matrix_1.i, matrix_2.j;

/*
 i | j | val
---+---+-----
 0 | 0 |  -8
 0 | 1 |  14
 0 | 2 |  -5
 1 | 0 |  -2
 1 | 1 |   4
 1 | 2 |  -2
 2 | 1 |  -6
 2 | 2 |   3
(8 rows)
*/
