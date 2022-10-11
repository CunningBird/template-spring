pluginManagement {
    repositories {
        repositories {
            maven {
                url = uri(System.getProperty("publicPluginsRepositoryUrl"))
            }
        }
    }
}

rootProject.name = "template-spring"

// TODO build slim jar
// TODO optimize image build
