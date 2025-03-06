rm(list = ls())

library(PhotosynQ)
library(dplyr)

# Função para limpar as informações de "locations"
lista_sem_location <- function(lista) {
  lapply(lista, function(x) {
    if (is.list(x) && "location" %in% names(x)) {
      x <- x[!names(x) %in% "location"]
    }
    if (is.list(x)) {
      x <- lapply(x, function(y) {
        if (is.list(y) && "location" %in% names(y)) {
          y <- y[!names(y) %in% "location"]
        }
        y
      })
    }
    x
  })
}

# Login
PhotosynQ::login(email = "juscimarsolos@yahoo.com.br")
ID <- 26637

# Get data
info <- getProjectInfo(projectID = ID)
data <- getProjectData(projectID = ID)

data <- lista_sem_location(data)

df <- PhotosynQ::createDataframe(project_info = info, project_data = data)

# Logout
PhotosynQ::logout()

# Filter data
dados_filtrados <- filter(
  df$`Photosynthesis RIDES 2.0`,
  status == "submitted"
) |>
  dplyr::select(
    "Qual.a.repetição.",
    "Qual.o.tratamento.",
    "leaf.angle",
    "ECSt.mAU",
    "ECS_tau",
    "Fs",
    "FoPrime",
    "LEF",
    "Phi2",
    "PhiNPQ",
    "SPAD",
    "LEAF_temp",
    "PhiNO",
    "qL",
    "vH.",
    "gH.",
    "NPQt",
    "FvP_over_FmP",
    "FmPrime",
    "Light.Intensity..PAR.",
    "Leaf.Temperature",
    "leaf_thickness"
  )
# View data structure
glimpse(dados_filtrados)

write.csv2(x = dados_filtrados, file = "C:\\Users\\jarde\\Downloads\\vigna.csv")
