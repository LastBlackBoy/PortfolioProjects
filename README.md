COVID-19 Data Analysis SQL Queries

This repository contains a set of SQL queries for analyzing COVID-19 data. The queries focus on various aspects, including total cases, total deaths, vaccination rates, and infection rates across different geographical locations.


Table of Contents

Introduction

Data Sources

Queries Overview

Views

How to Use

Contributing

License


Introduction
The SQL queries in this repository are designed to analyze COVID-19 data, providing insights into the global and regional impact of the pandemic. The queries cover aspects such as total cases, total deaths, vaccination rates, infection rates, and more.


Data Sources
The data used in these queries is sourced from the COVID-19 dataset, specifically from tables CovidDeaths and CovidVaccinations. The dataset is part of the PortfolioProject database.


Queries Overview
Data Selection: Basic queries to select and display relevant data from the CovidDeaths table.


Global Numbers: Aggregated global statistics, including total cases, total deaths, and death percentage.


Total Cases vs Total Deaths: Comparative analysis of total cases and total deaths globally, in Africa, and for specific countries.


Total Cases vs Population: Examination of the relationship between total cases and population globally, in Africa, and for specific countries.


Total Deaths vs Population: Analysis of the relationship between total deaths and population globally, in Africa, and for specific countries.


Countries with High Infection Rates vs Population: Identification of countries with the highest infection rates relative to their population.


Continent with the Highest Deaths: Determination of the continent with the highest total deaths.


Countries with the Highest Death per Population: Identification of countries with the highest death rates per population.


Total Population vs Vaccinations: Analysis of global and African data comparing total population and new vaccinations.


Views
The repository includes the creation of several views to facilitate easier data retrieval and visualization. Views include:

GlobalTotalCasesVSPop: View comparing global total cases with population.

AfricaTotalCasesVSPop: View comparing total cases in Africa with population.

NigeriaTotalCasesVSPop: View comparing total cases in Nigeria with population.

GlobalTotalDeathsVSPop: View comparing global total deaths with population.

AfricaTotalDeathsVSPop: View comparing total deaths in Africa with population.

NigeriaDailyDeathsVSPop: View comparing daily deaths in Nigeria with population.

GlobalCasesVsDeaths: View comparing global total cases with total deaths.

AfricaCasesVsDeaths: View comparing total cases and deaths in Africa.

NigeriaDailyCasesVsDeaths: View comparing daily cases and deaths in Nigeria.

GlobalInfectionRate: View identifying countries with the highest infection rates globally.

AfricaInfectionRate: View identifying countries with the highest infection rates in Africa.

VaccinationVsPopGlobal: View comparing global new vaccinations with population.

VaccinationVsPopAfrica: View comparing new vaccinations in Africa with population.

How to Use

Clone the repository to your local machine:

bash
Copy code
git clone https://github.com/your-username/your-repository.git
Open your preferred SQL editor or tool.

Execute the SQL queries by copy-pasting them into your SQL editor.


Explore the results and adapt the queries as needed for your analysis.


Contributing
If you would like to contribute to this project, feel free to submit a pull request. Your contributions are welcome!

License
This project is licensed under the MIT License.


Adjust the placeholders such as your-username and your-repository with your GitHub username and repository name. Additionally, include the appropriate license file (e.g., LICENSE) in your repository.
