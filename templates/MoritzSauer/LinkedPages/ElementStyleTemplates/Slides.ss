<% require themedCSS('client/scss/_linkedpagesslides') %>
<div class="slides" id="slides--{$ID}">
    <div class="typography">
        <div class="col__holder items--{$sortedLinkedPages.Count}">
            <% loop $sortedLinkedPages %><div class="linked__page--holder <% if $First %> active <% end_if %>"  data-mobile-target="mobile__content--{$ID}">
                <div class="linked__page" style="background-image: url('$Image.FocusFill(2560,1440).Link');
                        background-position: {$Image.PercentageX}% {$Image.PercentageY}%;
                        background-size: cover;">
                    <div class="linked__page--title">
                        <div class="linked__page--icon mb-3 mb-md-4">
                            <% if $Icon %>
                                <img src="$Icon.Fit(60,60).Link" class="img-fluid icon">
                            <% else_if $FAIcon %>
                                <i class="$FAIcon"></i>
                            <% end_if %>
                        </div>
                        <div class="page__title--content">
                            <h2 class="mb-0">
                                $Title
                            </h2>
                        </div>
                    </div>
                    <% if $Content %>
                        <div class="linked__page--content">
                            <div class="p-3 p-md-4">
                                $Content
                                <% include LinkedPagesButton %>
                            </div>
                        </div>
                    <% end_if %>
                </div>
                <div class="linked__page--passive--title">
                    <div class="page__title--content">
                            <span class="h4">
                                $Title
                            </span>
                    </div>
                    <div class="linked__page--icon">
                        <% if $Icon %>
                            <% if $IconSecondary %>
                                <img src="$IconSecondary.Fit(60,60).Link" class="img-fluid icon">
                            <% else %>
                                <img src="$Icon.Fit(60,60).Link" class="img-fluid icon">
                            <% end_if %>
                        <% else_if $FAIcon %>
                            <i class="$FAIcon"></i>
                        <% end_if %>
                    </div>
                </div>
            </div><% end_loop %>
            <div class="mobile__content--holder position-relative d-block d-md-none">
                <% loop $sortedLinkedPages %>
                    <div class="mobile__content <% if $First %> active <% end_if %>" id="mobile__content--{$ID}">
                        <% if $Content %>
                            <div class="linked__page--content--mobile">
                                <div class="p-3 p-md-4">
                                    $Content
                                    <% include LinkedPagesButton %>
                                </div>
                            </div>
                        <% end_if %>
                    </div>
                <% end_loop %>
            </div>
        </div>
    </div>
</div>
<script>
    let slides = document.querySelectorAll('#slides--{$ID} .linked__page--holder');
    let mobileContents = document.querySelectorAll('#slides--{$ID} .mobile__content');
    let mobContentHolder = document.querySelector('#slides--{$ID} .mobile__content--holder');
    if(mobContentHolder){
        let firstActive = document.querySelector('#slides--{$ID} .mobile__content.active');
        if(firstActive){
            mobContentHolder.style.paddingBottom = firstActive.clientHeight + 20 + 'px';
        }
    }
    slides.forEach((slide) => {
        slide.addEventListener('click', () => {
            slides.forEach((item) => {
                let mobileContent = document.getElementById(item.getAttribute('data-mobile-target'));
                if(item === slide){
                    item.classList.add('active');
                    if(mobileContent){
                        mobileContent.classList.add('active');
                        if(mobContentHolder){
                            mobContentHolder.style.paddingBottom = mobileContent.clientHeight + 20 + 'px';
                        }
                    }
                } else {
                    item.classList.remove('active');
                    if(mobileContent){
                        mobileContent.classList.remove('active');
                    }
                }
            })
        })
    })
</script>