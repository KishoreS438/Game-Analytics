import streamlit as st
import pandas as pd
import pymysql

# Establish the MySQL connection
conn = pymysql.connect(
    host="localhost",
    user="root",
    password="Adrian@3003",
    database="Tennis"
)
cursor = conn.cursor()

# Helper function to retrieve data
def fetch_data(query):
    cursor.execute(query)
    data = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description]
    return pd.DataFrame(data, columns=columns)

# Queries for each table
categories_query = "SELECT * FROM Categories"
competitions_query = "SELECT * FROM Competitions"
complexes_query = "SELECT * FROM Complexes"
venues_query = "SELECT * FROM Venues"
competitors_query = "SELECT * FROM Competitors"
rankings_query = "SELECT * FROM Competitor_Rankings"

# Fetch data from each table
categories_df = fetch_data(categories_query)
competitions_df = fetch_data(competitions_query)
complexes_df = fetch_data(complexes_query)
venues_df = fetch_data(venues_query)
competitors_df = fetch_data(competitors_query)
rankings_df = fetch_data(rankings_query)

# Streamlit page layout
st.title('Tennis Data Explorer')

# Summary Statistics
st.subheader("Summary Statistics")
total_competitors = len(competitors_df)
countries_represented = competitors_df['country'].nunique()
total_competitions = len(competitions_df)
highest_points = rankings_df['points'].max()

st.markdown(f"**Total number of competitors:** {total_competitors}")
st.markdown(f"**Number of countries represented:** {countries_represented}")
st.markdown(f"**Total number of competitions:** {total_competitions}")
st.markdown(f"**Highest points scored by a competitor:** {highest_points}")

# Sidebar Filters
st.sidebar.header('Filters')
rank_min, rank_max = st.sidebar.slider(
    "Filter by Rank Range",
    min_value=1,
    max_value=500,
    value=(1, 500)  # Set default to 1 to 500
)

selected_gender = st.sidebar.selectbox('Select Gender', competitions_df['gender'].unique())
selected_category = st.sidebar.selectbox('Select Category', categories_df['category_name'].unique())
selected_competition = st.sidebar.selectbox('Select Competition', competitions_df['competition_name'].unique())
selected_complex = st.sidebar.selectbox('Select Complex', complexes_df['complex_name'].unique())
selected_venue = st.sidebar.selectbox('Select Venue', venues_df['venue_name'].unique())
selected_competitor = st.sidebar.selectbox('Select Competitor', competitors_df['name'].unique())

# Filter data based on selections
rankings_df["ranks"] = pd.to_numeric(rankings_df["ranks"], errors="coerce")
filtered_competitions = competitions_df[(competitions_df['category_id'] == categories_df[categories_df['category_name'] == selected_category].iloc[0]['category_id']) & (competitions_df['gender']==selected_gender)]
filtered_venues = venues_df[venues_df['complex_id'] == complexes_df[complexes_df['complex_name'] == selected_complex].iloc[0]['complex_id']]
filtered_rankings = rankings_df[(rankings_df['competitor_id'] == competitors_df[competitors_df['name'] == selected_competitor].iloc[0]['competitor_id']) & 
                                (rankings_df['ranks'] >= rank_min) & 
                                (rankings_df['ranks'] <= rank_max)]


# Display dataframes
st.subheader('Categories')
st.dataframe(categories_df)

st.subheader('Competitions')
st.dataframe(filtered_competitions)

st.subheader('Complexes')
st.dataframe(complexes_df)

st.subheader('Venues')
st.dataframe(filtered_venues)

st.subheader('Competitors')
st.dataframe(competitors_df)

st.subheader(f"Rankings for {selected_competitor}")
st.dataframe(filtered_rankings)

# Close the database connection
conn.close()
