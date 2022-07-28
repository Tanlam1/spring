<nav class="navbar navbar-expand-lg navbar-transparent navbar-absolute fixed-top text-white">
    <div class="container">
        <div class="navbar-wrapper">
            <a class="navbar-brand" href="#pablo">${content.heading_text}</a>
        </div>
        <button class="navbar-toggler" type="button" data-toggle="collapse" aria-controls="navigation-index"
            aria-expanded="false" aria-label="Toggle navigation">
            <span class="sr-only">Toggle navigation</span>
            <span class="navbar-toggler-icon icon-bar"></span>
            <span class="navbar-toggler-icon icon-bar"></span>
            <span class="navbar-toggler-icon icon-bar"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a href="/admin" class="nav-link">
                        <i class="material-icons">dashboard</i> Dashboard
                    </a>
                </li>
                <li class="nav-item ">
                    <a href="/index" class="nav-link">
                        <i class="material-icons">home</i> Home
                    </a>
                </li>
                <li class="nav-item  ${content.objs.loginActive} ">
                    <a href="/admin/login" class="nav-link">
                        <i class="material-icons">fingerprint</i> Login
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>