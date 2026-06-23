allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    val configureProject = {
        if (project.extensions.findByName("android") != null) {
            val android = project.extensions.getByName("android")
            try {
                val getNamespace = android.javaClass.getMethod("getNamespace")
                val ns = getNamespace.invoke(android)
                if (ns == null) {
                    val setNamespace = android.javaClass.getMethod("setNamespace", String::class.java)
                    setNamespace.invoke(android, "com.musharraf.jobhunter.${project.name.replace("-", "_").replace(".", "_")}")
                }
            } catch (e: Exception) {
                // Fallback or ignore
            }
        }

        // Clean manifest package attribute to prevent AGP 8+ build errors
        val manifestFile = project.file("src/main/AndroidManifest.xml")
        if (manifestFile.exists()) {
            try {
                var content = manifestFile.readText()
                if (content.contains("package=\"")) {
                    content = content.replace(Regex("package=\"[^\"]*\""), "")
                    manifestFile.writeText(content)
                }
            } catch (e: Exception) {
                // Ignore permission or file-lock issues
            }
        }
    }

    if (project.state.executed) {
        configureProject()
    } else {
        project.afterEvaluate {
            configureProject()
        }
    }
}


