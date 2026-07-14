import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// flutter_avif_android 3.1.0 ships duplicate Java and Kotlin implementations
// of FlutterAvifPlugin, and does not align the generated Kotlin task with its
// Java 11 target. Keep the Java implementation and normalize the Kotlin task.
project(":flutter_avif_android").tasks.withType<KotlinCompile>().configureEach {
    exclude("**/FlutterAvifPlugin.kt")
    compilerOptions.jvmTarget.set(JvmTarget.JVM_11)
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
