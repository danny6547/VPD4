SELECT *, Start_Direction + LEAST(360 - ABS(End_Direction - Start_Direction), ABS(End_Direction - Start_Direction))/2 AS BinCentres FROM WindCoefficientDirection;