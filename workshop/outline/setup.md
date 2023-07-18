# Setup for the workshop

There are three ways how you can follow this workshop:

1. Full installation (recommended): Full workshop experience, interactive, with all software dependencies.
2. Partial installation (ok if the only possible options): Almost full workshop experience, interactive, with only some contents as "just watch".
3. No installation/passive (not recommended): Semi workshop experience and not interactive, with all content being "just watch".

While the 2nd option is nice and easy to follow in an interactive manner and the thrid option might work for a quick overview, we don't recommended either of them as getting `Docker`, `git`, etc. to work reliably on your machine is going to be very beneficial. This holds true for the workshop and especially beyond. Via installing these tools, you will be equipped to basically continue right away and start using them with a focus on reproducible neuroimaging in your everyday research workflow. Having that in mind and integrating other tools/resources focusing open and reproducible (neuro-/data) science, we
generated a rather comprehensive set of install instructions below. While not all of them might be totally necessary for the workshop, they all will help you a great deal going further.

Don't worry, you got this!

## General things

There are a few computing requirements for the course that are absolutely necessary (beyond the few software packages we would like you to install, described below):

1. You must have `administrator access` to your computer (i.e., you must be able to install things yourself without requesting IT approval).
1. You must have `at least 20 GB` of free disk space on your computer (but we would recommend more, to be safe).
1. If you are using `Windows` you must be using `Windows 10`; Windows 7 and 8 will not be sufficient for this course.

If you foresee any of these being a problem please reach out to one of the instructors for what steps you can take to ensure you are ready for the course start.

## Required software

To get the most out of our course, we ask that you arrive with the following software already installed:

| Software           | Why do I need this?                                                                        |
|--------------------|--------------------------------------------------------------------------------------------|
| A modern browser   | We will work with jupyter-lab which allows you to write code within a browser.             |
| Bash               | This is needed to download content for this workshop and to later check your installation. |
| Docker             | This is needed for the nipype workshop

### Notes on instructions

1. In the following section, Select the tab that corresponds to your operating system and follow the instructions therein.
2. There is no difference between `Enter` and `Return` in these instructions, so just press whatever the equivalent on your keyboard is whenever one is stated
2. If the instructions aren't working and you have spent more than 15-20 minutes troubleshooting on your own, reach out with the exact problems you're having. One of the instructors will try and get back to you quickly to help resolve the situation.`
3. If you already have some (or all) of these things installed on your computer already that should (theoretically) be okay. However, you need to make sure that you are able to complete the steps described in [checking your install](#checking-your-install) without issue. For example, having multiple different `Python` installations on your computer can lead to incredibly frustrating issues that are very difficult to debug. As such, if you have already installed `Python` via some other application (not `Miniconda`/`Anaconda`), we strongly encourage you to uninstall it before following the instructions below. You _must_ have `Python` installed via `Miniconda` for this course.

#### OS-specific installation instructions

````{tab-set}
```{tab-item} Windows

***Modern Web Browser***
Install Firefox or Chrome (Safari will also work). Microsoft Edge is not modern, despite what Microsoft might try and otherwise tell you.

**Bash shell**

Install Git Bash on your system. Follow [these instructions](https://git-scm.com/downloads).

**Note**:  From this point on whenever the instructions specify to “open a terminal” please assume you are supposed to open the Git Bash terminal.

**Docker**

Unfortunately, `Docker` for `Windows` is a bit of a mess.
The recommended version of `Docker` to install varies dramatically depending not only on which version of `Windows` you have installed (e.g., `Windows 10 Home` versus `Professional`/`Enterprise`/`Education`), but also which _build_ of `Windows` you have.
As such, developing a comprehensive set of instructions for installing `Docker` is rather difficult.

For this course, you will need to install either [Docker Toolbox for Windows](https://docs.docker.com/toolbox/toolbox_install_windows/) or [Docker for Windows Desktop](https://docs.docker.com/docker-for-windows/install/).
Which you install will depend on your OS.
**PLEASE NOTE** that installing `Docker for Windows Desktop` will disable `VirtualBox` on your computer.
If you actively use `VirtualBox` we recommend you install `Docker Toolbox`.

(**Note**: the below instructions assume you are installing `Docker Toolbox`.
Because there are fewer requirements for `Docker Toolbox`, it is likely that you will be able to install this more easily.)

1. Download the latest [Docker Toolbox installer](https://github.com/docker/toolbox/releases/download/v19.03.1/DockerToolbox-19.03.1.exe) (note: that link will automatically download the file)
1. Run the downloaded `.exe` file and leave all the defaults during the installation procedure.
   Click `Yes`on the prompt that appears asking if the application can make changes to your computer.
1. Search for and open the newly-installed "Docker Quickstart" application.
   Again, click `Yes`on the prompt that appears asking if the application can make changes to your computer.
   The application will do a number of things to finish installing and setting up Docker.
1. Once you see a `$` prompt type `docker run hello-world`.
   A brief introductory message should be printed to the screen.
1. Close the "Docker Quickstart" application and open a terminal (i.e., the Ubuntu application).
1. Copy-paste the following commands.
   You will be prompted to enter your password once.

        # Update the apt package list.
        sudo apt-get update -y
        # Install Docker's package dependencies.
        sudo apt-get install -y \
            apt-transport-https \
            ca-certificates \
            curl \
            software-properties-common
        # Download and add Docker's official public PGP key.
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        # Verify the fingerprint.
        sudo apt-key fingerprint 0EBFCD88
        # Add the `stable` channel's Docker upstream repository.
        sudo add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) \
            stable"
        # Update the apt package list (for the new apt repo).
        sudo apt-get update -y
        # Install the latest version of Docker CE.
        sudo apt-get install -y docker-ce
        # Allow your user to access the Docker CLI without needing root access.
        sudo usermod -aG docker $USER

1. Close and re-open the terminal.
1. Type `pip install docker-compose`.
1. Type `powershell.exe "docker-machine config"`.
   You should get output similar to the following:

        --tlsverify
        --tlscacert="C:\\Users\\<YOUR_USERNAME>\\.docker\\machine\\machines\\default\\ca.pem"
        --tlscert="C:\\Users\\<YOUR_USERNAME>\\.docker\\machine\\machines\\default\\cert.pem"
        --tlskey="C:\\Users\\<YOUR_USERNAME>\\.docker\\machine\\machines\\default\\key.pem"
        -H=tcp://xxx.xxx.xx.xxx:xxxx


   where `<YOUR_USERNAME>` will have an actual value (likely your Windows username), and `tcp=xxx.xxx.xx.xxx:xxx` will be a series of numbers.
   If you don't get this output then something has gone wrong.
   Please make sure you were able to run the `docker run hello-world` command, above.
   If you were and you still don't receive this output, please contact one of the instructors.

1. You will use the the outputs of the above command to modify the commands below before running them in the terminal.
   First, take the numbers printed in place of the `x`s on the output of the line `-H=tcp://xxx.xxx.xx.xxx:xxxx` from above and replace the placeholder `xxx.xxx.xx.xxx:xxxx` on the first command below (`export DOCKER_HOST`).
   Second, take whatever value is printed in place of `<YOUR_USERNAME>` above and replace the `<YOUR_USERNAME>` placeholder on the second command below (`export DOCKER_CERT_PATH`).
   Once you have updated the commands appropriately, copy and paste them into the terminal:

        echo "export DOCKER_HOST=tcp://xxx.xxx.xx.xxx:xxxx" >> $HOME/.bashrc
        echo "export DOCKER_CERT_PATH=/mnt/c/Users/<YOUR_USERNAME>/.docker/machine/certs" >> $HOME/.bashrc
        echo "export DOCKER_TLS_VERIFY=1" >> $HOME/.bashrc


1. Close and re-open a terminal (i.e., the Ubuntu application).
   Type `docker run hello-world`.
   The same brief introductory message you saw before should be printed to the screen.

**Note**: If you restart your computer (or somehow otherwise shut down the Docker VM) you will need to re-open the "Docker Quickstart" application and wait until you see the `$` prompt again before your `docker` commands will work again!
If you are having problems running `docker` commands in the terminal, try re-opening the "Docker Quickstart" application.

(The above step-by-step instructions are distilled from [here](https://docs.docker.com/toolbox/toolbox_install_windows/) and [here](https://medium.com/@joaoh82/setting-up-docker-toolbox-for-windows-home-10-and-wsl-to-work-perfectly-2fd34ed41d51).
If you have questions during the installation procedure please check those links for potential answers!)
```

```{tab-item} Linux
***Modern Web Browser***
Install Firefox or Chrome (Safari will also work). Microsoft Edge is not modern, despite what Microsoft might try and otherwise tell you.

**Bash shell**

You already have it!
Depending on which version of `Linux` you’re running you may need to type `bash` inside the `terminal` to access it.
To check whether this is necessary, follow these steps:

1. Open a `terminal` and type `echo $SHELL`.
   If it reads `/bin/bash` then you are all set!
   If not, whenever the instructions read "open a terminal," please assume you are to open a terminal, type `bash`, and the proceed with the instructions as specified.

**Note**:  From this point on whenever the instructions specify to “open a terminal” please assume you are supposed to open the Bash terminal.

**Docker**

1. You will be following different instructions depending on your distro ([Ubuntu](https://docs.docker.com/engine/install/ubuntu/), [Debian](https://docs.docker.com/engine/install/debian/), [Fedora](https://docs.docker.com/engine/install/fedora/), [CentOS](https://docs.docker.com/engine/install/centos/)).
   Make sure to follow the “Install using the repository” method!
1. Once you’ve installed Docker make sure to follow the [post-install instructions](https://docs.docker.com/engine/install/linux-postinstall/) as well.
   You only need to do the “Manage Docker as a non-root user” and “Configure Docker to start on boot” steps.
1. Open a new terminal and type `docker run hello-world`.
   A brief introductory message should be printed to the screen.
```

```{tab-item} MacOs
***Modern Web Browser***
Install Firefox or Chrome (Safari will also work). Microsoft Edge is not modern, despite what Microsoft might try and otherwise tell you.
**Bash shell**

You already have it!
Depending on which version of Mac OS you’re running you may need to type `bash` inside the `terminal` to access it.
To check whether this is necessary, follow these steps:

1. Open a terminal and type `echo $SHELL`.
   If it reads `/bin/bash` then you are all set!

Note: If you are using `Mac Catalina (10.15.X)` then it is possible your default `shell` is NOT CORRECT.
To set the default to `bash`, type `chsh -s /bin/bash` in the `terminal`, enter your password when prompted, and then close + re-open the `terminal`.

**Note**:  From this point on whenever the instructions specify to “open a terminal” please assume you are supposed to open the Bash terminal.

**Docker**

1. Go to https://hub.docker.com/editions/community/docker-ce-desktop-mac/ and press “Get Docker”.
1. Open the “Docker.dmg” file that is downloaded and drag and drop the icon to the Applications folder
1. Open the Docker application and enter your password.
   An icon will appear in the status bar in the top-left of the screen.
   Wait until it reads “Docker Desktop is now up and running!”
1. Open a new terminal and type `docker run hello-world`.
   A brief introductory message should be printed to the screen.

(The above step-by-step Docker instructions are distilled from [here](https://docs.docker.com/docker-for-mac/install/).
If you have questions during the installation procedure please check that link for potential answers!)
```
````

## Checking your install

Now that you've installed everything it's time to check that everything works as expected! Type the following into your terminal:

    bash <( curl -s https://raw.githubusercontent.com/JohannesWiesner/workshop_cimh/master/check_install.sh)


If you installed everything correctly you should see a message informing you as such. If any problems were detected you should receive some brief instructions on what is wrong with potential suggestions on how to remedy it.
If you followed these instructions step-by-step and cannot resolve the issue please contact one of the course instructors for more help.

## Download the workshop material

Now that you got everything installed correctly, it's time to download the course material for this workshop. In your terminal navigate to a folder of your choice where you want to place the course material. Then paste and execute this command:

    bash <( curl -s https://raw.githubusercontent.com/JohannesWiesner/workshop_cimh/master/download_courses.sh)

This will download all the data (and the docker image) for this workshop.
