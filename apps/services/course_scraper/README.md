# Web Scraper for Module Listings

This document provides installation and usage instructions for the web scraper component of the "Software Engineering 1" project.

## Overview

The web scraper is designed to extract module information from the ZPA module listings page and post the results to a REST endpoint.

## Prerequisites

- Python 3.10 or higher
- Conda

## Setup

### Install Dependencies with Conda

It is recommended to use a Conda environment to manage the dependencies of your project. Conda is an open-source package management system and environment management system that runs on Windows, macOS, and Linux. Using Conda, you can create isolated environments that have their own versions of Python and installed packages.

If you do not have Conda installed, follow the instructions from the [Conda installation guide](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html).

To create an environment from the given `environment.yml` file, use the following command:

```bash
conda env create -f environment.yml
```

Activate the environment using the following command:

```bash
conda activate se_praktikum_scraper
```

## Usage

Remember to always activate your Conda environment before running the scraper to ensure all dependencies are managed correctly:

```bash
conda activate se_praktikum_scraper
```

Run the scraper using the following command:

```bash
python run_scraper.py
```

The scraper will automatically connect to the rest endpoint on `http://localhost:8080`. This means your Springboot backend must be up and running. The scraper will then scrape the module listings page, and insert the data into the modules table.

## Important Notes

- Adjust the `time.sleep` delay in the script if necessary to manage the request rate.
- The script will print each module's data to the console before insertion for debugging purposes.
