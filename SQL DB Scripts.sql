use Tennis;
CREATE TABLE Categories (
    category_id VARCHAR(50) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);
CREATE TABLE Competitions (
    competition_id VARCHAR(50) PRIMARY KEY,
    competition_name VARCHAR(100) NOT NULL,
    parent_id VARCHAR(50) NULL,
    type VARCHAR(20) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    category_id VARCHAR(50),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
CREATE TABLE Complexes (
    complex_id VARCHAR(50) PRIMARY KEY, -- Unique ID for the complex
    complex_name VARCHAR(100) NOT NULL -- Name of the sports complex
);
CREATE TABLE Venues (
    venue_id VARCHAR(50) PRIMARY KEY, -- Unique ID for the venue
    venue_name VARCHAR(100) NOT NULL, -- Name of the venue
    city_name VARCHAR(100) NOT NULL, -- Name of the city
    country_name VARCHAR(100) NOT NULL, -- Name of the country
    country_code CHAR(3) NOT NULL, -- ISO country code
    timezone VARCHAR(100) NOT NULL, -- Timezone of the venue
    complex_id VARCHAR(50), -- Links to the complexes table
    FOREIGN KEY (complex_id) REFERENCES Complexes(complex_id) -- Foreign key constraint
);
CREATE TABLE Competitors (
    competitor_id VARCHAR(50) PRIMARY KEY, -- Unique ID for each competitor
    name VARCHAR(100) NOT NULL, -- Name of the competitor
    country VARCHAR(100) NOT NULL, -- Competitor's country
    country_code CHAR(3) NOT NULL, -- ISO country code
    abbreviation VARCHAR(10) NOT NULL -- Shortened name/abbreviation of competitor
);
CREATE TABLE Competitor_Rankings (
    rank_id INT PRIMARY KEY AUTO_INCREMENT, -- Unique ID for each ranking record, auto-incremented
    competitor_rank INT NOT NULL, -- Rank of the competitor
    movement INT NOT NULL, -- Rank movement compared to the previous week
    points INT NOT NULL, -- Total ranking points
    competitions_played INT NOT NULL, -- Number of competitions played
    competitor_id VARCHAR(50), -- Links to competitor details
    FOREIGN KEY (competitor_id) REFERENCES Competitors(competitor_id) -- Foreign key constraint
);

