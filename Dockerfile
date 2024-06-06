FROM jenkins/jenkins:latest-jdk17

WORKDIR /var/jenkins_home
USER jenkins

# evitar que el Wizard para la instalación asistida de Jenkins se lance al iniciar el
# contenedor, porque la configuración la aplicamos con JCasC
ENV JAVA_OPTS='-Djenkins.install.runSetupWizard=false'

# archivo con el listado de plugins a instalar automáticamente, entre ellos, el de Prometheus
COPY plugins.txt /var/home_jenkins/plugins.txt
RUN jenkins-plugin-cli --plugin-file /var/home_jenkins/plugins.txt

# indicar la ubicacion del archivo de configuracion para Jenkins
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/jenkins-casc/jenkins-casc.yaml
RUN mkdir /var/jenkins_home/jenkins-casc 

COPY jenkins-casc.yaml ./jenkins-casc/