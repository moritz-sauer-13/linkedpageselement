<div class="imagetextboxslider">
    <div class="typography">
        <% if $ShowTitle || $ButtonLinkedPage %>
            <div class="element__header">
                <div class="container">
                    <div class="row align-items-md-center">
                        <% if $ShowTitle %>
                            <div class="col-12 <% if $ButtonLinkedPage %>col-md-7 col-lg-9<% end_if %>">
                                <span class="h2">
                                    $Title.RAW
                                </span>
                                <% if $SubTitle %>
                                    <span class="h2 subtitle">
                                        $SubTitle
                                    </span>
                                <% end_if %>
                            </div>
                        <% end_if %>
                        <% if $LinkedPage %>
                            <div class="col-12 <% if $ShowTitle %>col-md-5 col-lg-3<% end_if %> text-md-end">
                                <a href="$LinkedPage.URL" class="" <% if $LinkedPage.OpenInNew %>target="_blank"
                                   rel="noopener noreferrer"<% end_if %>>
                                    $LinkedPage.Title
                                </a>
                            </div>
                        <% end_if %>
                    </div>
                </div>
            </div>
        <% end_if %>
        <% if $sortedLinkedPages %>
            <div class="element__linkedpages <% if $ShowTitle || $LinkedPage %>mt-4 mt-md-5<% end_if %>">
                <div class="swiper-container" id="linkedpages--{$ID}">
                    <div class="swiper-wrapper">
                        <% loop $sortedLinkedPages %>
                            <div class="swiper-slide">
                                <div class="linked__page">
                                    <picture>
                                        <source srcset="$Image.FocusFill(1920,1080).Link" media="(min-width: 768px)">
                                        <source srcset="$Image.FocusFill(800,1000).Link" media="(min-width: 1px)">
                                        <img src="$Image.FocusFill(1920,1080).Link" class="img-fluid">
                                    </picture>
                                    <div class="linked__page--content mt-3 mt-md-4">
                                        <% if $Title %>
                                            <h4>
                                                $Title
                                            </h4>
                                        <% end_if %>
                                        <% if $SubTitle %>
                                            <span class="h4 subtitle d-block">
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
            <script>
                let swiper{$ID} = new Swiper('#linkedpages--{$ID}', {
                    slidesPerView: 2,
                    centeredSlides: true,
                    loop: true,
                    spaceBetween: 30
                })
            </script>
        <% end_if %>
    </div>
</div>