<div id="top"></div>

<br />
<div align="center">
<h3 align="center">amw_stats</h3>

  <p align="center">
    browse published stats at <a href="https://wykop.pl/tag/anonimowemirkowyznaniastatystyki">#amw_stats</a> 
    <br />
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
  </ol>
</details>



## About The Project

Project to generate various statistic from AMW database content.  

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With

* [python](https://python.org/)
* [pandas](https://pandas.pydata.org/)
* [numpy](https://numpy.org/)
* [matplotlib](matplotlib.org/)
* [docker](https://docker.com/)

<p align="right">(<a href="#top">back to top</a>)</p>


## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites
Docker is required

<p align="right">(<a href="#top">back to top</a>)</p>


## Usage
Set environmental variables
`AMW_STATS_MONGO_HOST` connection string to amw instance database to generate stats from
`SINCE` since when to generate date (ISO)
`UNTIL` until when to generate date (ISO)
`PERIOD` string name of given period
`APPKEY` wykop api appkey
`SECRET` wykop api secret key
`ACCOUNT_KEY` wykop api account key
and run `./docker.sh`. 

<p align="right">(<a href="#top">back to top</a>)</p>

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>
