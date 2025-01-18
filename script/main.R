library(rgee)
library(terra)
library(mapedit)

ee_Initialize(drive = TRUE)

# 1. Lectura de datos -----------------------------------
img <- ee$Image("users/gistin/fog_oasis/fo_class2021")
Map$addLayer(img)

# 2. Selección del área de estudio ----------------------
area <- drawFeatures()
area_ee <- area |> sf_as_ee()

# 3. Corte del área de estudio --------------------------
img_clip <- img$clip(area_ee)

# 4. Descarga de img ------------------------------------
ee_as_rast(
  image = img_clip,
  region = area_ee$geometry(),
  dsn = 'moat_lomas_coteras.tif')
