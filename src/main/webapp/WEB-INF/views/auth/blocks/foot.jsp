<!--   Core JS Files   -->
<script src="/assets/admin/js/core/jquery.min.js"></script>
<script src="/assets/admin/js/core/popper.min.js"></script>
<script src="/assets/admin/js/core/bootstrap-material-design.min.js"></script>
<script src="/assets/admin/js/plugins/perfect-scrollbar.jquery.min.js"></script>
<!--  Google Maps Plugin    -->
<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
<!-- Chartist JS -->
<script src="/assets/admin/js/plugins/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="/assets/admin/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
<script src="/assets/admin/js/material-dashboard.minf066.js?v=2.1.0" type="text/javascript"></script>
<!-- Material Dashboard DEMO methods, don't include it in your project! -->
<script src="/assets/admin/demo/demo.js"></script>
<script>
    $(document).ready(function () {
        md.checkFullPageBackgroundImage();
        setTimeout(function () {
            $('.card').removeClass('card-hidden');
        }, 200);
    });
</script>