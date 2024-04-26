<div class="cardsslider">
    <div class="typography">
        <% if $ShowTitle || $LinkedPage %>
            <div class="element__header">
                <div class="container">
                    <div class="row align-items-md-center">
                        <% if $ShowTitle %>
                            <div class="col-12 <% if $LinkedPage %>col-md-7 col-lg-4<% end_if %>">
                                <span class="h1">
                                    $Title.RAW
                                </span>
                                <% if $SubTitle %>
                                    <span class="h1 subtitle">
                                        $SubTitle
                                    </span>
                                <% end_if %>
                            </div>
                        <% end_if %>
                        <% if $LinkedPage %>
                            <div class="col-12 <% if $ShowTitle %>col-md-4 col-lg-3 offset-md-1 offset-lg-5 mt-4 mt-md0 <% end_if %> text-md-end">
                                <% include LinkedPagesButton %>
                            </div>
                        <% end_if %>
                    </div>
                </div>
            </div>
        <% end_if %>
        <% if $sortedLinkedPages %>
            <div class="element__linkedpages <% if $ShowTitle || $LinkedPage %>mt-4 mt-md-5<% end_if %>">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="swiper-container position-relative overflow-hidden" id="linkedpages--{$ID}">
                                <div class="swiper-wrapper">
                                    <% loop $sortedLinkedPages %>
                                        <div class="swiper-slide">
                                            <div class="linked__page">
                                                <div class="position-relative">
                                                    <img src="$Image.FocusFill(1000,1000).Link" class="img-fluid">
                                                    <% if $ShowBadge %>
                                                        <div class="card__badge $BadgePosition">
                                                            <img src="$Badge.FocusFill(140,140).Link" class="img-fluid">
                                                        </div>
                                                    <% end_if %>
                                                </div>
                                                <div class="linked__page--content bg-beige p-3 p-md-4">
                                                    <% if $Title %>
                                                        <h5>
                                                            $Title
                                                        </h5>
                                                    <% end_if %>
                                                    <% if $SubTitle %>
                                                        <span class="h6 subtitle d-block">
                                                            $SubTitle
                                                        </span>
                                                    <% end_if %>
                                                    $Content
                                                    <% include LinkedPagesButton %>
                                                </div>
                                            </div>
                                        </div>
                                    <% end_loop %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                let swiper{$ID} = new Swiper('#linkedpages--{$ID}', {
                    slidesPerView: 1.5,
                    loop: false,
                    spaceBetween: 10,
                    breakpoints:{
                        530:{
                            slidesPerView: 1.8,
                            spaceBetween: 20,
                        },
                        992:{
                            slidesPerView: 3,
                            spaceBetween: 20,
                        }
                    }
                })
            </script>
        <% end_if %>
    </div>
</div>