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
| Git Bash (When using Windows)     | This is needed to execute bash code on a Windows Computer that will download content for this workshop, check your installation and start your docker containers. |
| WSL (when using Windows)                 | This is the backend for Docker let's you run Linux on an Windows Computer |
| Docker             | This is needed for the nipype workshop |

### Notes on instructions

1. In the following section, Select the tab that corresponds to your operating system and follow the instructions therein.
2. There is no difference between `Enter` and `Return` in these instructions, so just press whatever the equivalent on your keyboard is whenever one is stated
2. If the instructions aren't working and you have spent more than 15-20 minutes troubleshooting on your own, reach out with the exact problems you're having. One of the instructors will try and get back to you quickly to help resolve the situation.`
3. If you already have some (or all) of these things installed on your computer already that should (theoretically) be okay. However, you need to make sure that you are able to complete the steps described in [checking your install](#checking-your-install) without issue. For example, having multiple different `Python` installations on your computer can lead to incredibly frustrating issues that are very difficult to debug. As such, if you have already installed `Python` via some other application (not `Miniconda`/`Anaconda`), we strongly encourage you to uninstall it before following the instructions below. You _must_ have `Python` installed via `Miniconda` for this course.

#### OS-specific installation instructions

````{tab-set}
```{tab-item} Windows
**Modern Web Browser**
Install Firefox or Chrome (Safari will also work). Microsoft Edge is not modern, despite what Microsoft might try and otherwise tell you.

**Powershell**

If you haven't Powershell already installed on your machine (check by searching for Powershell in the navigation bar), follow [these instructions](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.3#installing-the-msi-package) and install it (you most certainly have a 64 bit machine so download the `x64.msi` file).

**WSL**

Open the Powershell as Administrator and run `wsl --install -d ubuntu`. This will install WSL with a Ubuntu terminal environment on your Windows machine which is needed for Docker.
More on that [here](https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-10#1-overview).

**Bash shell**

Install Git Bash on your system. Follow [these instructions](https://git-scm.com/downloads). When installing it, you will be asked
a lot of configuration questions. Just leave the defaults as they are.

**Docker**

Download the installation file and then follow [these instructions](https://docs.docker.com/desktop/install/windows-install/#install-docker-desktop-on-windows) to install Docker Desktop on your machine. The download
button can be found at the top of the page. After installing Docker Desktop, please start it and leave it running while proceeding with the next steps.

```

```{tab-item} Linux
**Modern Web Browser**
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
**Modern Web Browser**
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

**Note for Windows Users: From this point on whenever the instructions specify to “open a terminal” please assume you are supposed to open the Git Bash terminal.**

Now that you've installed everything it's time to check that everything works as expected! Type the following into your terminal (User tip: You can use the middle click on your mouse for effortless pasting):

    bash <( curl -s https://raw.githubusercontent.com/JohannesWiesner/workshop_cimh/master/check_install.sh)

If you installed everything correctly you should see a message informing you as such. If any problems were detected you should receive some brief instructions on what is wrong with potential suggestions on how to remedy it.
If you followed these instructions step-by-step and cannot resolve the issue please contact one of the course instructors for more help.

## Download the workshop material

Now that you got everything installed correctly, it's time to download the course material for this workshop. In your terminal navigate to a folder of your choice where you want to place the course material and execute this command:

    bash <( curl -s https://raw.githubusercontent.com/JohannesWiesner/workshop_cimh/master/download_courses.sh)

This will download all the data (and pull the docker image) for this workshop. If everything works correctly you should now have a folder named `workshop_cimh` in your specified download directory.
