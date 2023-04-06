<% require themedCSS('client/scss/_withicons') %>

<div class="withicons py-5 py-lg-6">
    <div class="container">
        <div class="bg-secondary-light py-5 py-lg-6 text-center px-4 px-md-5">
            <div class="row">
                <div class="col-12 col-lg-10 offset-lg-1 col-xl-8 offset-xl-2 typography mb-4 mb-lg-5 mb-xl-6">
                    <span class="h2 color-primary d-block <% if $SubTitle %>mb-0<% else %>mb-4<% end_if %>">
                        $Title.RAW
                    </span>
                    <% if $SubTitle %>
                        <span class="h2 subtitle d-block mb-4">
                            $SubTitle
                        </span>
                    <% end_if %>
                    <% if $Content %>
                        $Content
                    <% end_if %>
                </div>
                <div class="swiper-container typography <% if $sortedLinkedPages.Count > 3 %>mb-5 mb-xl-6<% else %>mb-5 mb-lg-0<% end_if %>" id="linkedpages__withicons--{$ID}">
                    <div class="swiper-wrapper align-items-center <% if $sortedLinkedPages.Count > 3 %>mb-5 mb-xl-6<% else %>mb-5 mb-lg-0<% end_if %>">
                        <% loop $sortedLinkedPages %>
                            <div class="swiper-slide text-center">
                                <% if $Icon %>
                                    <picture>
                                        <source srcset="$Icon.Fit(80,60).Link" media="(min-width: 1200px)">
                                        <source srcset="$Icon.Fit(70,50).Link" media="(min-width: 1024px)">
                                        <source srcset="$Icon.Fit(60,40).Link" media="(min-width: 1px)">
                                        <img src="$Icon.Fit(80,60).Link" class="img-fluid icon mb-4">
                                    </picture>

                                <% end_if %>
                                <h5 class="color-secondary mb-3 withicons-title">$Title</h5>
                                <% include LinkedPagesButton %>
                            </div>
                        <% end_loop %>
                    </div>
                    <% if $sortedLinkedPages.Count > 1 %>
                        <div class="position-relative">
                            <div class="swiper-pagination text-center"></div>
                            <div class="swiper__controls position-relative">
                                <span class="prev">
                                    <i class="fal fa-chevron-left"></i>
                                </span>
                                <span class="next">
                                    <i class="fal fa-chevron-right"></i>
                                </span>
                            </div>
                        </div>
                    <% end_if %>
                </div>
            </div>
        </div>

    </div>
</div>

<script>
    let swiper{$ID} = new Swiper('#linkedpages__withicons--{$ID}', {
        slidesPerView: 2,
        spaceBetween: 30,
        grabCursor: true,
        navigation: {
            nextEl: '#linkedpages__withicons--{$ID} .swiper__controls .next',
            prevEl: '#linkedpages__withicons--{$ID} .swiper__controls .prev',
        },
        autoplay: {
            delay: 7000,
        },
        pagination: {
            el: ".swiper-pagination",
            dynamicBullets: true,
        },
        breakpoints: {
            430: {
                slidesPerView: 2,
            },
            768: {
                slidesPerView: 2,
            },
            992: {
                slidesPerView: 3,
            },
            1200: {
                slidesPerView: 3,
            }
        }
    })
</script>