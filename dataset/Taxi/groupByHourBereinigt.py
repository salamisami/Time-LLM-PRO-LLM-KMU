import pandas as pd

# Read the CSV into a DataFrame
df = pd.read_csv('train100K.csv', sep=',')

# Convert the pickup_datetime column to a datetime object
df['pickup_datetime'] = pd.to_datetime(df['pickup_datetime'])

# Filter out rows with invalid latitude, longitude, and passenger count
valid_df = df[(df['pickup_longitude'] != 0) & (df['pickup_latitude'] != 0) & (df['passenger_count'] != 0)]

# Create a new column 'date_hour' containing the formatted datetime
valid_df['date_hour'] = valid_df['pickup_datetime'].dt.strftime('%Y-%m-%d %H')

# Group by 'date_hour' and count the number of trips
result = valid_df.groupby('date_hour').size().reset_index(name='trip_count')

# Save the result to a new CSV
result.to_csv('results100K.csv', index=False)
