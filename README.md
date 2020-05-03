### Summary
Backup files to Google Cloud bucket

### Pipeline 
Jenkins setup on VM in Google Cloud.  Takes last tag, creates new release and uploads to GitHub.

### How to tag new release
`git tag -a v0.19 -m "latest version"`
`git push origin v0.19`

Reference link: [Tagging](https://www.atlassian.com/git/tutorials/inspecting-a-repository/git-tag)


