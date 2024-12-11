<!---------<div>
<head>
  <title>#MiastoX Home page</title>
  <link rel="stylesheet" href="style.css">
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f2f2f2;
    }
    .title {
      background-color: #4CAF50;
      color: #fff;
      padding: 20px;
      text-align: center;
    }
    .title-text {
      font-size: 24px;
      font-weight: bold;
    }
    .click-option {
      background-color: #4CAF50;
      color: #fff;
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
    .click-option:hover {
      background-color: #3e8e41;
    }
    nav {
      background-color: #333;
      color: #fff;
      padding: 10px;
      text-align: center;
    }
    nav ul {
      list-style: none;
      margin: 0;
      padding: 0;
    }
    nav li {
      display: inline-block;
      margin-right: 20px;
    }
    nav a {
      color: #fff;
      text-decoration: none;
    }
    nav a:hover {
      color: #ccc;
    }
  </style></head></div>
 --->
<body>
  <div class="title">
    <div class="title-text">
      <nav>
        <ul>
          <li><a href="#">MiastoX</a></li>
          <li><a href="#">O nas</a></li>
          <li><a href="#">Kontakt</a></li>
        </ul>
      </nav>
      <h4>Miastox</h4>
    </div>
  </div>
  <button class="click-option" onclick="clickOption()">Click Me</button>
  <p id="result"></p> <img src="https://example.com/image.jpg" alt="Example Image"> 
 <div align='center'>
    <img src="./gh-assets/project_logo.svg" alt="Project Logo" width="150" height="150">
    <h1 id="Top">MiastoX</h1>
    <h3>A City4All you out there in Roblox developers to inspire and alow goodnes and shown advanced tehniques to manage project like Pro GitHub workflows, build, and deploy active stations.</h3>
    <img src="https://github.com/iceeburr/roblox-video-codec/actions/workflows/ci.yaml/badge.svg" alt="CI">
    <img src="https://github.com/iceeburr/roblox-video-codec/actions/workflows/release.yaml/badge.svg" alt="Build & Deploy">
    <a href=""><img src="https://img.shields.io/github/issues/iceeburr/roblox-template.svg" alt="Issues"></a>
    <a href="https://www.paypal.me/whitekali"><img src="https://img.shields.io/badge/donate-PayPal-green.svg" alt="Donate"></a>

    <section>
    <h2>Features</h2>
    <ul>
<code>`./scripts/install.sh`</code>

<details>
    <summary>Manual Setup:</summary>
    <br>
    <p>
    First, please head over to the <a href="https://github.com/LPGhatguy/aftman/releases/latest">aftman releases page</a> and download the latest version. Open your terminal and <code>cd</code> into the directory. Finally run <code>./aftman self-install</code>.</br>
    Now you can run <code>aftman install</code>, followed by <code>wally install</code>.
    </br>
    That's it! Read how to build the place file further. (or use the <a href="scripts/build.sh">build.sh</a> script)
    </p>
</details>


    <h2 id="Building & Project Structure">Building & Project Structure</h2>

    <p></p>

    <h2 id="Scripts">Scripts</h2>

    <p>Aftman is required to be installed for all scripts.</p>

    <details>
        <summary>Use Cases</summary>
        <br>
        <p>
        Actions:
        <ul>
            <li>Sourcemap - will generate a sourcemap.json of the project.</li>
            <li>Packages - will install wally packages & update custom ones with git submodules.</li>
            <li>Types - will fix broken wally types</li>
            <li>Builds - will build the place file.</li>
            <li>Serves - will automatically start serving the place file.</li>
            <li>Starts - will automatically open the place file in studio.</li>
            <li>CQ - Runs code quality checks.</li>
            <li>❌ - Script does not execute the action.</li>
            <li>✅ - Script will execute the action.</li>
        </ul>
        <p>
        <br>
        <table>
            <tr align="center">
                <th>Name</th>
                <th>Sourcemap</th>
                <th>Packages</th>
                <th>Types</th>
                <th>Builds</th>
                <th>Serves</th>
                <th>Starts</th>
                <th>CQ</th>
            </tr>
            <tr align="center">
                <td>install.sh</td>
                <td>✅</td>
                <td>✅</td>
                <td>✅</td>
                <td>✅</td>
                <td>❌</td>
                <td>❌</td>
                <td>❌</td>
            </tr>
            <tr align="center">
                <td>build.sh</td>
                <td>❌</td>
                <td>❌</td>
                <td>❌</td>
                <td>✅</td>
                <td>❌</td>
                <td>❌</td>
                <td>❌</td>
            </tr>
            <tr align="center">
                <td>serve.sh</td>
                <td>❌</td>
                <td>❌</td>
                <td>❌</td>
                <td>✅</td>
                <td>✅</td>
                <td>❌</td>
                <td>❌</td>
            </tr>
            <tr align="center">
                <td>start.sh</td>
                <td>❌</td>
                <td>❌</td>
                <td>❌</td>
                <td>✅</td>
                <td>✅</td>
                <td>✅</td>
                <td>❌</td>
            </tr>
            <tr align="center">
                <td>types.sh</td>
                <td>✅</td>
                <td>❌</td>
                <td>✅</td>
                <td>❌</td>
                <td>❌</td>
                <td>❌</td>
                <td>❌</td>
            </tr>
            <tr align="center">
                <td>packages.sh</td>
                <td>✅</td>
                <td>✅</td>
                <td>✅</td>
                <td>❌</td>
                <td>❌</td>
                <td>❌</td>
                <td>❌</td>
            </tr>
            <tr align="center">
                <td>cq.sh</td>
                <td>✅</td>
                <td>❌</td>
                <td>❌</td>
                <td>❌</td>
                <td>❌</td>
                <td>❌</td>
                <td>✅</td>
            </tr>
        </table>
    </details>

    <li>Feature 3</li
</div>

  <script>
    function clickOption() {
      document.getElementById("result").innerHTML = "You clicked the button!";
    }
  </script>
</body>
</html>
  <h1>Nałra of My Miastox Page</h1> 
 <p>This is a simple web page created using HTMLxDDDDDD.</p> 

--->









<h1>THIS TEMPLATE IS STILL IN DEVELOPMENT<br>DO NOT USE IT YET!!!</h1>

<h2 id="Navigation">Navigation</h2>

<h2 id="Project">Project</h3>

<h3 id="About">About</h2>

<p>
This repository serves as a template designed specifically for Roblox developers looking to enhance their development workflow through advanced integration with CLI (Command Line Interface) tools such as Rojo and Tarmac. It aims to streamline the process of building, testing, and deploying Roblox games and assets by leveraging these powerful tools within GitHub Actions workflows. By utilizing this template, developers can automate repetitive tasks, ensure consistency across projects, and significantly reduce manual intervention required during the development lifecycle.
</p>

<details>
	<summary>Featured Games</summary>
	<nav>
		<ol>
			<li><a href="#Project">Project</a></li>
			<ol>
				<li><a href="#About">About</a></li>
				<li><a href="#Features">Features</a></li>
				<li><a href="#Getting Started">Getting Started</a></li>
				<li><a href="#Building & Project Structure">Building & Project Structure</a></li>
				<li><a href="#Scripts">Scripts</a></li>
			</ol>
			<li><a href="#Contributing">Contributing</a></li>
			<li><a href="#License & Copyright">License & Copyright</a></li>
		</ol>
	</nav>
    <a href=""><h3>Tang County by Hebei Studios</h3></a>
    <img src="" alt="Tang County">
    <br>
    <i>Want your game in this list? Open an issue or contact me on Discord @iceeburr</i>
</details>
 </body>
 
  </html>



<!----
<h2 id="Features">Features</h2>

<p></p>

<h2 id="Getting Started">Getting Started</h2>

<p>
To get started, simply clone this repository and follow the setup instructions detailed further. You can customize everything according to your needs.
</p>

<code>git clone https://github.com/iceeburr/roblox-template</code>

<p>
You can either do it manually or use the all-in-one <a href="scripts/install.sh">install.sh</a> script. You can find other useful command snippets in there as well.
</p>
--->

<h1>THIS TEMPLATE IS STILL IN DEVELOPMENT<br>DO NOT USE IT YET!!!</h1>
### Uwagi do pliku `README.md`:
------------
---/. Plik ten powinien kompleksowo opisywać grę poprzez opisanie jej mechaniki, zasobów, zdarzeń, oraz środowisko przedstawione gry.

/game: Zasoby gry
[miro](https://miro.com/app/board/uXjVKtfWXNY=/?share_link_id=381033713650)
# `📦 Project Miastox build on CityxN` !!~ New UPDATE ~!!

**### # [README] - Miastox --- lista funkcji i implementajci

## **Gotowy na Przygody?**

Odkryj sekrety CityX i zmierz się z wyzwaniami! 🏙️✨
[Live MiastoX](https://dawju9.github.io/MiastoX/)
[Live CityxN](https://dawju9.github.io/cityx/)

## 👤 **Kontakt**

- **Autor**: Whitekali
- **E-mail**: whitekali@example.com
- **GitHub**: [Dawju9](https://github.com/Dawju9)

---

### Uwagi do skryptu `PreloadGameSetup`:
- Skrypt ten powinien kompleksowo przygotowywać grę poprzez wczytanie zasobów, konfigurację początkową, wiązanie zdarzeń oraz generację środowiska gry.









<h1>THIS TEMPLATE IS STILL IN DEVELOPMENT<br>DO NOT USE IT YET!!!</h1><!----

<h2 id="Contributing">Contributing</h2>

<p>
There are several ways how you can potentially contribute to this project. One important way to contribute is to actually <i>report bugs/issues</i> you might identify. In addition you can also bring up <i>feature/enhancements</i> requests. Another way is to <i>help translating</i> the README to a wider range of different languages by committing to the <a href="translations">translations</a> folder.
<br>
Make sure you read the <a href=".github/CODE_OF_CONDUCT.md">Code of Conduct</a> and <a href=".github/CONTRIBUTING.md">Contributing Guide</a> first, as well as all other <a href=".github">support guides</a>.
</p>

<h2 id="License & Copyright">License & Copyright</h2>

<p>
This template is distributed and licensed under the MIT License. See <a href="LICENSE">LICENSE</a> for more detailed information. This is NOT legal advice!
</p>

<a href="#Top"><i><u>Back To Top ⬆️</u></i></a>
---> 
</html>
