# InnoRussia
InnoRussia project for the FSE subject

Git Workflow
=====================

For efficient work and convenient control over the development of the application prototype, in addition to the master branch, we will create a develop branch, which will be the main development branch.

For each new feature of the application, there will be a separate feature branch. Feature branches will be created based on the develop branch. When a function finishes, it is merged back into the develop branch. When enough features are released to release a version of the application, a separate release branch is created from develop.

When the preparation of the version of the application is ready and it works stably, the release is merged into the master and we assign it a version number. This does not mean that work on the application is being completed. You also need to continue debugging bugs and do the rest of the tasks.

Just to be able to quickly fix bugs, a hotfix branch will be created from the master branch. It will be needed to quickly fix errors. Then this branch will be merged with the master and develop (And the master branch is marked with an updated version number).

This approach to application development will allow you to create a stable version.

![](https://3.downloader.disk.yandex.ru/preview/c0363687806a036e8c4b466259ebb81aa515bfad9f828d642d753b6a66813ab5/inf/6owOr8jJpI_JkE0XzcoYF7cIhN5rteX7zZh9V9VrJCWotDsFqVIYF1R2BLQjs-qKwrUgdBNRkBEVeIyRdjDo_Q%3D%3D?uid=775467804&filename=Group%2010%20%281%29.png&disposition=inline&hash=&limit=0&content_type=image%2Fpng&owner_uid=775467804&tknv=v2&size=1898x985)
