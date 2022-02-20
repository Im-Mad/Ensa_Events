<div id="top"></div>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Im-Mad/Ensa_Events">
    <img src="src/main/webapp/assets/img/Logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">EnsaEvents</h3>

  <p align="center">
    EnsaEvent is a self-service platform aimed at better connecting our school's clubs with their members and all the other students that are intrested in the events organized by these clubs. It allows anyone to share, find and attend events that fuel their passions and enrich their academic lives. From confrences, formations, workshops, to gaming competitions, coding contests and hackathons.
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
        <li><a href="#website-map">Website Map</a></li>
      </ul>
    </li>
    <li>
      <a href="#contact">Contact</a>
    </li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

![ScreenShot][product-screenshot]

<p align="right">(<a href="#top">back to top</a>)</p>



### Built With

* [Spring Framework](https://spring.io/projects/spring-framework)
* [Spring Security](https://spring.io/projects/spring-security)
* [Hibernate](https://hibernate.org/)
* [Commons FileUpload](https://commons.apache.org/proper/commons-fileupload/)
* [JavaMail](https://javaee.github.io/javamail/)
* [Bootstrap](https://getbootstrap.com)
* [Swiper](https://swiperjs.com/)

<p align="right">(<a href="#top">back to top</a>)</p>

### Website Map

| Path | SubPath | Description |
| ---- | ------- | ---- |
| ```@``` | ```/``` | Homepage |
| - | ```/login``` | Login page | 
| - | ```register``` | Register page | 
| ```@/event``` | - | - | 
| - | ```/all``` | Display all events list | 
| - | ```/:id``` | Find an event based on id attribute | 
| - | ```/create``` | Create a new event | 
| - | ```/filterEvents``` | Get filtred events | 
| - | ```/:id/participate``` | Participate on an event based on id attribute | 
| - | ```/:id/unparticipate``` | Remove participation from an event based on id attribute | 
| - | ```/manage``` | Manage events | 
| - | ```/update``` | Update event | 
| - | ```/delete``` | Delete event | 
| ```@/club``` | - | - |
| - | ```/all``` | Display all clubs | 
| - | ```/:name``` | Find club based on name attribute | 
| - | ```/manage``` | Manage clubs | 
| - | ```/update``` | Updtae club details | 
| - | ```/join``` | Join club | 
| - | ```/leave``` | Leave club | 
| ```@/review``` | - | - |
| - | ```/add``` | Add review | 
| - | ```/delete/:id``` | Delete review based on id attribute| 
| ```@/user``` | - | - |
| - | ```/me``` | Display currently logged-in user's account | 
| - | ```/updatePassword``` | Update password of currently logged-in user's account | 
| - | ```/myEvents``` | Display all events of currently logged-in user's account | 
| - | ```/myClubs``` | display all clubs of currently logged-in user's account | 
| - | ```/manage``` | manage users | 
| - | ```/suspend``` | Suspend a user | 
| - | ```/unsuspend``` | Unsuspend a suspended user |


### Contact

email: imad.chai2@gmail.com
Linkedin: [Imad Chaichaa](https://www.linkedin.com/in/imad-chaichaa-a30786201/)
Portfolio: []()


<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Im-Mad/Ensa_Events.svg?style=for-the-badge
[contributors-url]: https://github.com/Im-Mad/Ensa_Events/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Im-Mad/Ensa_Events.svg?style=for-the-badge
[forks-url]: https://github.com/Im-Mad/Ensa_Events/network/members
[stars-shield]: https://img.shields.io/github/stars/Im-Mad/Ensa_Events.svg?style=for-the-badge
[stars-url]: https://github.com/Im-Mad/Ensa_Events/stargazers
[issues-shield]: https://img.shields.io/github/issues/Im-Mad/Ensa_Events.svg?style=for-the-badge
[issues-url]: https://github.com/Im-Mad/Ensa_Events/issues
[license-shield]: https://img.shields.io/github/license/Im-Mad/Ensa_Events.svg?style=for-the-badge
[license-url]: https://github.com/Im-Mad/Ensa_Events/blob/master/LICENSE.txt
[product-screenshot]: home.png
