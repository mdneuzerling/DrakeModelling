devtools::load_all()
package_name <- basename(here::here())
drake::expose_imports(package_name, character_only = TRUE)
drake::make(model_training_plan())
