<!-- sidebar -->
<div class="sidebar" data-color="rose" data-background-color="black" data-image="/assets/admin/img/sidebar-1.jpg">
    <div class="sidebar-wrapper">
        <div class="user">
            <div class="user-info">
                <a data-toggle="collapse" href="#collapseExample" class="username">
                    <span>
                        Admin
                        <b class="caret"></b>
                    </span>
                </a>
                <div class="collapse" id="collapseExample">
                    <ul class="nav">
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <span class="sidebar-mini"> MP </span>
                                <span class="sidebar-normal"> My Profile </span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <span class="sidebar-mini"> S </span>
                                <span class="sidebar-normal"> Settings </span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <ul class="nav">
            <li class="nav-item ${content.objs.dashboardActive} ">
                <a class="nav-link" href="/admin">
                    <i class="material-icons">dashboard</i>
                    <p> Dashboard </p>
                </a>
            </li>
            <li class="nav-item ${content.objs.productsActive} ">
                <a class="nav-link" href="/admin/products">
                    <i class="material-icons">content_paste</i>
                    <p> Product list </p>
                </a>
            </li>
            <li class="nav-item ${content.objs.categoriesActive} ">
                <a class="nav-link" href="/admin/categories">
                    <i class="material-icons">store</i>
                    <p> Categories </p>
                </a>
            </li>
            <li class="nav-item ${content.objs.accountsActive} ">
                <a class="nav-link" href="/admin/accounts">
                    <i class="material-icons">person</i>
                    <p> Accounts </p>
                </a>
            </li>
            <li class="nav-item ${content.objs.ordersActive} ">
                <a class="nav-link" href="/admin/orders">
                    <i class="material-icons">library_books</i>
                    <p> Orders </p>
                </a>
            </li>
        </ul>
    </div>
</div>
<!-- end sidebar -->