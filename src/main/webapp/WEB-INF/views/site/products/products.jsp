
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<c:set var="data" value="${content.objs}"/>

<div class="row">
    <div class="col-lg-12">
        <div class="osahan-listing">
            <div class="d-flex align-items-center mb-3">
                <h4>Products</h4>
                <div class="m-0 text-center ml-auto">
                    <a href="/list"
                        class="btn text-muted bg-white mr-2"><i class="icofont-loop mr-1"></i> Reload</a>
                    <a href="#" data-toggle="modal" data-target="#exampleModal"
                        class="btn text-muted bg-white"><i class="icofont-signal mr-1"></i> Filter</a>
                </div>
            </div>
            <div class="row">
                <c:forEach var="item" items="${data.productPage.content}">
                    <div class="col-6 col-md-3 mb-3">
                        <div
                            class="list-card bg-white h-100 rounded overflow-hidden position-relative shadow-sm">
                            <div class="list-card-image">
                                <a href="/product/detail/${item.productId}" class="text-dark">
                                    <div class="member-plan position-absolute"><span
                                            class="badge m-3 badge-danger">${item.discount}%</span></div>
                                    <div class="p-3">
                                        <img src="/uploads/images/${item.image}" class="img-fluid item-img w-100 mb-3">
                                        <h6 class="name-product">${item.name}</h6>
                                        <div class="d-flex align-items-center">
                                            <h6 class="price m-0 text-success">${item.unitPrice}</h6>
                                            <a data-toggle="collapse" href="#product${item.productId}" role="button"
                                                aria-expanded="false" aria-controls="product${item.productId}"
                                                class="btn btn-success btn-sm ml-auto">+</a>
                                            <div class="collapse qty_show" id="product${item.productId}">
                                                <div>
                                                    <span class="ml-auto" href="#">
                                                        <form id='myform' class="cart-items-number d-flex"
                                                            method='POST' action='#'>
                                                            <input type='button' value='-'
                                                                class='qtyminus btn btn-success btn-sm'
                                                                field='quantity' />
                                                            <input type='text' name='quantity' value='1'
                                                                class='qty form-control quantityProduct${item.productId}' />
                                                            <input type='button' value='+'
                                                                class='qtyplus btn btn-success btn-sm'
                                                                field='quantity' />
                                                        </form>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                                <button onclick="addToCart('${item.productId}')">Add to cart</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="card-footer text-mutted">
                <c:if test="${data.productPage.totalPages > 0}">
                    <form action="/list">
                        <input type="hidden" name="keyword" value="${param.keyword}">
                        <input type="hidden" name="page" value="${param.page}">
                        <div class="form-group d-flex align-items-center">
                            <select class="custom-select" data-size="7"
                                data-style="btn btn-primary btn-round" title="Size on page"
                                onchange="this.form.submit()" name="size" id="size">
                                <option disabled selected>Size on page</option>
                                <option ${data.productPage.size==5 ? 'selected' : '' } value="5">Size: 5
                                </option>
                                <option ${data.productPage.size==10 ? 'selected' : '' } value="10">Size:
                                    10</option>
                                <option ${data.productPage.size==15 ? 'selected' : '' } value="15">Size:
                                    15</option>
                                <option ${data.productPage.size==20 ? 'selected' : '' } value="20">Size:
                                    20</option>
                                <option ${data.productPage.size==30 ? 'selected' : '' } value="30">Size:
                                    30</option>
                            </select>
                        </div>
                    </form>
                    <nav aria-label="Page navigation">
                        <ul style="margin-bottom: 0;" class="pagination justify-content-center">
                            <li class="page-item ${data.productPage.number + 1 == 1 ? 'active': ''}">
                                <a class="page-link"
                                    href="/list/?keyword=${data.keyword}&size=${data.productPage.size}&page=1"
                                    aria-label="Previous">
                                    <span>&laquo; First</span>
                                </a>
                            </li>
                            <c:if test="${data.productPage.totalPages > 1}">
                                <c:forEach var="pageNumber" items="${data.pageNumbers}"
                                    varStatus="loop">
                                    <li
                                        class="page-item ${pageNumber == data.productPage.number + 1 ? 'active' : ''}">
                                        <a class="page-link"
                                            href="/list/?keyword=${data.keyword}&size=${data.productPage.size}&page=${pageNumber}">${pageNumber}</a>
                                    </li>
                                </c:forEach>
                            </c:if>
                            <li
                                class="page-item ${data.productPage.number + 1 == data.productPage.totalPages ? 'active': ''}">
                                <a class="page-link"
                                    href="/list/?keyword=${data.keyword}&size=${data.productPage.size}&page=${data.productPage.totalPages}"
                                    aria-label="Previous">
                                    <span>Last &raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </div>
</div>

<div class="modal fade right-modal" id="exampleModal" tabindex="-1" role="dialog"
    aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Filter</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body p-0">
                <div class="osahan-filter">
                    <div class="filter">

                        <div class="p-3 bg-light border-bottom">
                            <h6 class="m-0">SORT BY</h6>
                        </div>
                        <div class="custom-control border-bottom px-0  custom-radio">
                            <input type="radio" id="customRadio1" name="location" class="custom-control-input"
                                checked>
                            <label class="custom-control-label py-3 w-100 px-3" for="customRadio1">Top Rated</label>
                        </div>
                        <div class="custom-control border-bottom px-0  custom-radio">
                            <input type="radio" id="customRadio2" name="location" class="custom-control-input">
                            <label class="custom-control-label py-3 w-100 px-3" for="customRadio2">Nearest
                                Me</label>
                        </div>
                        <div class="custom-control border-bottom px-0  custom-radio">
                            <input type="radio" id="customRadio3" name="location" class="custom-control-input">
                            <label class="custom-control-label py-3 w-100 px-3" for="customRadio3">Cost High to
                                Low</label>
                        </div>
                        <div class="custom-control border-bottom px-0  custom-radio">
                            <input type="radio" id="customRadio4" name="location" class="custom-control-input">
                            <label class="custom-control-label py-3 w-100 px-3" for="customRadio4">Cost Low to
                                High</label>
                        </div>
                        <div class="custom-control border-bottom px-0  custom-radio">
                            <input type="radio" id="customRadio5" name="location" class="custom-control-input">
                            <label class="custom-control-label py-3 w-100 px-3" for="customRadio5">Most
                                Popular</label>
                        </div>

                        <div class="p-3 bg-light border-bottom">
                            <h6 class="m-0">FILTER</h6>
                        </div>
                        <div class="custom-control border-bottom px-0  custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="defaultCheck1" checked>
                            <label class="custom-control-label py-3 w-100 px-3" for="defaultCheck1">Open Now</label>
                        </div>
                        <div class="custom-control border-bottom px-0  custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="defaultCheck2">
                            <label class="custom-control-label py-3 w-100 px-3" for="defaultCheck2">Credit
                                Cards</label>
                        </div>
                        <div class="custom-control border-bottom px-0  custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="defaultCheck3">
                            <label class="custom-control-label py-3 w-100 px-3" for="defaultCheck3">Alcohol
                                Served</label>
                        </div>

                        <div class="p-3 bg-light border-bottom">
                            <h6 class="m-0">ADDITIONAL FILTERS</h6>
                        </div>
                        <div class="px-3 pt-3">
                            <input type="range" class="custom-range" min="0" max="100" name="">
                            <div class="form-row">
                                <div class="form-group col-6">
                                    <label>Min</label>
                                    <input class="form-control" placeholder="$0" type="number">
                                </div>
                                <div class="form-group text-right col-6">
                                    <label>Max</label>
                                    <input class="form-control" placeholder="$1,0000" type="number">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer p-0 border-0">
                <div class="col-6 m-0 p-0">
                    <button type="button" class="btn border-top btn-lg btn-block"
                        data-dismiss="modal">Close</button>
                </div>
                <div class="col-6 m-0 p-0">
                    <button type="button" class="btn btn-success btn-lg btn-block">Apply</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const addToCart = (id) => {
        const valueQuantity = document.querySelector('.quantityProduct' + id)

        if(valueQuantity) {
            window.location.href = '/cart/add/product/'+id+'/'+valueQuantity.value
        }
    }
</script>