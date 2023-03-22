export const point_ =
{
  "type": "Point",
  "coordinates": [0, 0]
}

export const point3d_ =
{
  "type": "Point",
  "coordinates": [-110, 45, 100]
}

export const pointbbox_ =
{
  "type": "Point",
  "coordinates": [0, 0],
  "bbox": [0, 0, 0, 0]
}

export const pointext_ =
{
  "type": "Point",
  "coordinates": [0, 0],
  "title": "Null Island"
}



export const multipoint3d_ =
{
  "type": "MultiPoint",
  "coordinates": [
    [100, 0, 1],
    [101, 1, -1]
  ]
}

export const multipoint_ =
{
  "type": "MultiPoint",
  "coordinates": [
    [100, 0],
    [101, 1]
  ]
}

export const multipointbbox_ =
{
  "type": "MultiPoint",
  "coordinates": [
    [100, 0],
    [101, 1]
  ],
  "bbox": [100, 0, 101, 1]
}


export const linestring3d_ =
{
  "type": "LineString",
  "coordinates": [[-110, 45, 100], [110, -45, 200]]
}

export const linestring_ =
{
  "type": "LineString",
  "coordinates": [[-110, 45], [110, -45]]
}

export const linestringbbox_ =
{
  "type": "LineString",
  "coordinates": [[-110, 45], [110, -45]],
  "bbox": [-110, -45, 110, 45]
}


export const multilinestring3d_ =
{
  "type": "MultiLineString",
  "coordinates": [
    [[-111, 45, 10], [111, -45, 20]],
    [[-111, -45, 30], [111, 45, 40]]
  ]
}

export const multilinestring_ =
{
  "type": "MultiLineString",
  "coordinates": [
    [[-111, 45], [111, -45]],
    [[-111, -45], [111, 45]]
  ]
}

export const multilinestringbbox_ =
{
  "type": "MultiLineString",
  "bbox": [-111, -45, 111, 45],
  "coordinates": [
    [[-111, 45], [111, -45]],
    [[-111, -45], [111, 45]]
  ]
}


export const polygon3d_ =
{
  "type": "Polygon",
  "coordinates": [
    [
      [100.0, 0.0, 10],
      [101.0, 0.0, 10],
      [101.0, 1.0, 10],
      [100.0, 1.0, 10],
      [100.0, 0.0, 10]
    ],
    [
      [100.8, 0.8, 10],
      [100.8, 0.2, 10],
      [100.2, 0.2, 10],
      [100.2, 0.8, 10],
      [100.8, 0.8, 10]
    ]
  ]
}

export const polygon_ =
{
  "type": "Polygon",
  "coordinates": [
    [
      [100.0, 0.0],
      [101.0, 0.0],
      [101.0, 1.0],
      [100.0, 1.0],
      [100.0, 0.0]
    ],
    [
      [100.8, 0.8],
      [100.8, 0.2],
      [100.2, 0.2],
      [100.2, 0.8],
      [100.8, 0.8]
    ]
  ]
}

export const polygonbbox_ =
{
  "type": "Polygon",
  "coordinates": [
    [
      [100.0, 0.0],
      [101.0, 0.0],
      [101.0, 1.0],
      [100.0, 1.0],
      [100.0, 0.0]
    ],
    [
      [100.8, 0.8],
      [100.8, 0.2],
      [100.2, 0.2],
      [100.2, 0.8],
      [100.8, 0.8]
    ]
  ],
  "bbox": [100, 0, 101, 1]
}

export const polygonext_ =
{
  "title": "Titled Polygon",
  "type": "Polygon",
  "coordinates": [
    [
      [100.0, 0.0],
      [101.0, 0.0],
      [101.0, 1.0],
      [100.0, 1.0],
      [100.0, 0.0]
    ],
    [
      [100.8, 0.8],
      [100.8, 0.2],
      [100.2, 0.2],
      [100.2, 0.8],
      [100.8, 0.8]
    ]
  ]
}


export const multipolygon3d_ =
{
  "type": "MultiPolygon",
  "coordinates": [
    [
      [
        [102.0, 2.0, 10],
        [103.0, 2.0, 10],
        [103.0, 3.0, 10],
        [102.0, 3.0, 10],
        [102.0, 2.0, 10]
      ]
    ],
    [
      [
        [100.0, 0.0, 20],
        [101.0, 0.0, 20],
        [101.0, 1.0, 20],
        [100.0, 1.0, 20],
        [100.0, 0.0, 20]
      ],
      [
        [100.2, 0.2, 30],
        [100.8, 0.2, 30],
        [100.8, 0.8, 30],
        [100.2, 0.8, 30],
        [100.2, 0.2, 30]
      ]
    ]
  ]
}

export const multipolygon_ =
{
  "type": "MultiPolygon",
  "coordinates": [
    [
      [
        [102.0, 2.0],
        [103.0, 2.0],
        [103.0, 3.0],
        [102.0, 3.0],
        [102.0, 2.0]
      ]
    ],
    [
      [
        [100.0, 0.0],
        [101.0, 0.0],
        [101.0, 1.0],
        [100.0, 1.0],
        [100.0, 0.0]
      ],
      [
        [100.2, 0.2],
        [100.8, 0.2],
        [100.8, 0.8],
        [100.2, 0.8],
        [100.2, 0.2]
      ]
    ]
  ]
}

export const multipolygonbbox_ =
{
  "type": "MultiPolygon",
  "bbox": [100, 0, 103, 3],
  "coordinates": [
    [
      [
        [102.0, 2.0],
        [103.0, 2.0],
        [103.0, 3.0],
        [102.0, 3.0],
        [102.0, 2.0]
      ]
    ],
    [
      [
        [100.0, 0.0],
        [101.0, 0.0],
        [101.0, 1.0],
        [100.0, 1.0],
        [100.0, 0.0]
      ],
      [
        [100.2, 0.2],
        [100.8, 0.2],
        [100.8, 0.8],
        [100.2, 0.8],
        [100.2, 0.2]
      ]
    ]
  ]
}

export const feature_ =
{
  "type": "Feature",
  "id": "1",
  "geometry": {
    "type": "Point",
    "coordinates": [0, 0]
  },
  "properties": {
    "name": "basic"
  }
}

export const featureEmpty_ =
{
  "id": "ABC",
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Polygon",
    "coordinates": []
  }
}

export const featureNull_ =
{
  "type": "Feature",
  "id": "1",
  "geometry": null,
  "properties": {
    "name": "null geometry"
  }
}

export const featureNumberId_ =
{
  "type": "Feature",
  "id": 42,
  "geometry": {
    "type": "Point",
    "coordinates": [0, 0]
  },
  "properties": {
    "name": "basic"
  }
}

export const featureStringId_ =
{
  "type": "Feature",
  "id": "feature.1",
  "geometry": {
    "type": "Point",
    "coordinates": [0, 0]
  },
  "properties": {
    "name": "basic"
  }
}


export const featureCollection_ =
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "id": "1",
      "geometry": {
        "type": "Point",
        "coordinates": [0, 0]
      },
      "properties": {
        "name": "basic"
      }
    }
  ]
}

export const featureCollectionEmpty_ =
{
  "type": "FeatureCollection",
  "features": []
}



export const geometryCollection3d_ =
{
  "type": "GeometryCollection",
  "geometries": [
    {
      "type": "Point",
      "coordinates": [0, 0, 10]
    },
    {
      "type": "LineString",
      "coordinates": [[-110, 45], [110, -45]]
    },
    {
      "type": "Polygon",
      "coordinates": [
        [
          [100.0, 0.0],
          [101.0, 0.0],
          [101.0, 1.0],
          [100.0, 1.0],
          [100.0, 0.0]
        ],
        [
          [100.8, 0.8],
          [100.8, 0.2],
          [100.2, 0.2],
          [100.2, 0.8],
          [100.8, 0.8]
        ]
      ]
    }
  ]
}


export const geometryCollection_ =
{
  "type": "GeometryCollection",
  "geometries": [
    {
      "type": "Point",
      "coordinates": [0, 0]
    },
    {
      "type": "LineString",
      "coordinates": [[-110, 45], [110, -45]]
    },
    {
      "type": "Polygon",
      "coordinates": [
        [
          [100.0, 0.0],
          [101.0, 0.0],
          [101.0, 1.0],
          [100.0, 1.0],
          [100.0, 0.0]
        ],
        [
          [100.8, 0.8],
          [100.8, 0.2],
          [100.2, 0.2],
          [100.2, 0.8],
          [100.8, 0.8]
        ]
      ]
    }
  ]
}


export const geometryCollectionbbox_ =
{
  "type": "GeometryCollection",
  "bbox": [-110, -45, 110, 45],
  "geometries": [
    {
      "type": "Point",
      "coordinates": [0, 0]
    },
    {
      "type": "LineString",
      "coordinates": [[-110, 45], [110, -45]]
    },
    {
      "type": "Polygon",
      "coordinates": [
        [
          [100.0, 0.0],
          [101.0, 0.0],
          [101.0, 1.0],
          [100.0, 1.0],
          [100.0, 0.0]
        ],
        [
          [100.8, 0.8],
          [100.8, 0.2],
          [100.2, 0.2],
          [100.2, 0.8],
          [100.8, 0.8]
        ]
      ]
    }
  ]
}

