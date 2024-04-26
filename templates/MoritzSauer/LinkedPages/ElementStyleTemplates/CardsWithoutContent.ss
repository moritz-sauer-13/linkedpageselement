<div class="cardswithoutcontent bg-beige py-4 py-md-5 py-lg-6">
    <div class="typography">
        <% if $ShowTitle || $LinkedPage %>
            <div class="element__header">
                <div class="container">
                    <div class="row align-items-md-center">
                        <% if $ShowTitle %>
                            <div class="col-12 <% if $LinkedPage %>col-md-5 col-lg-4<% end_if %>">
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
                            <div class="col-12 <% if $ShowTitle %>col-md-5 col-lg-3 offset-md-2 offset-lg-5 mt-4 mt-md0 <% end_if %> text-md-end">
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
                        <% loop $sortedLinkedPages %>
                            <div class="col-md-6 mb-4 mb-md-5 mb-lg-6">
                                <div class="linked__page">
                                    <div class="position-relative">
                                        <img src="$Image.FocusFill(1000,900).Link" class="img-fluid">
                                        <% if $ShowBadge %>
                                            <div class="card__badge $BadgePosition">
                                                <img src="$Badge.FocusFill(140,140).Link" class="img-fluid">
                                            </div>
                                        <% end_if %>
                                    </div>
                                    <div class="linked__page--content bg-beige mt-3 mt-md-4">
                                        <% if $Title %>
                                            <h4>
                                                $Title
                                            </h4>
                                        <% end_if %>
                                        <% if $SubTitle %>
                                            <% if $LinkedPage || $ExternalLink %>
                                                <div class="linked__page--button">
                                                    <a href="<% if $LinkedPage %>$LinkedPage.Link<% else %>$ExternalLink<% end_if %>" <% if $ExternalLink %>target="_blank"<% end_if %> class="h5 subtitle">
                                                        $SubTitle
                                                    </a>
                                                </div>
                                            <% end_if %>
                                        <% end_if %>
                                    </div>
                                </div>
                            </div>
                        <% end_loop %>
                    </div>
                </div>
            </div>
        <% end_if %>
    </div>
</div>