# userMetrics-gtm
userMetric tag for google tag manager template document
## How to implement on customer page

### First Step: get your own table name

The first step is ask 8ndpoint to support your own `BIGQUERY_TABLE_NAME`.

### Second Step: edit google tag arguments

There are three arguments `BigQuery Table Name`, `Google Analytics Measurement ID` and `enableTdid`.

- `BigQuery Table Name`: bigQuery table where we store your data.

- `Google Analytics Measurement ID`: we will send two events `setUserInfo` and `get-tdid` to Google Anaylytics. `setUserInfo`. And they will trigger by page view.

- `enableTdid`: will depend this to check whether send Google analytics event `get-tdid`.

### Publish tag
Publish your tag manager. Check your page whether insert the `https://tracking-library.8ndpoint.com/usermetrics.js`.
