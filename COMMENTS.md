This is a ruby project. Further commands assume you have ruby version 3.2.0 with bundler installed.

```bash
cd virs_pipeline
bundle install
rails db:setup
rake virs_report:generate
```

Last command will read all report files from ./reports folder; update database and generate virs_report.tsv file in project root.