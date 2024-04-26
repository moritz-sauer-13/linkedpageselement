<div class="cardswithoverlay py-4 py-md-5 py-lg-6">
    <div class="typography">
        <% if $ShowTitle %>
            <div class="element__header">
                <div class="container">
                    <div class="row">
                        <% if $ShowTitle %>
                            <div class="col-12 text-center">
                                <span class="h1 d-block mb-0">
                                    $Title.RAW
                                </span>
                                <% if $SubTitle %>
                                    <span class="h1 subtitle d-block">
                                        $SubTitle
                                    </span>
                                <% end_if %>
                            </div>
                        <% end_if %>
                    </div>
                </div>
            </div>
        <% end_if %>
        <% if $sortedLinkedPages %>
            <div class="element__linkedpages <% if $ShowTitle %>mt-4 mt-md-5<% end_if %>">
                <div class="container">
                    <div class="row">
                        <% loop $sortedLinkedPages %>
                            <div class="col-md-6 col-lg-4 mb-4 mb-md-5 mb-lg-6">
                                <div class="linked__page">
                                    <div class="position-relative">
                                        <img src="$Image.FocusFill(1008,1536).Link" class="img-fluid">
                                        <% if $ShowBadge %>
                                            <div class="card__badge $BadgePosition">
                                                <img src="$Badge.FocusFill(140,140).Link" class="img-fluid">
                                            </div>
                                        <% end_if %>
                                        <% if $Content %>
                                            <div class="modal fade" id="content--{$ID}" tabindex="-1" aria-labelledby="content__label--{$ID}" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title mb-0" id="content__label--{$ID}">$Title</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            $Content
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        <% end_if %>
                                    </div>
                                    <div class="linked__page--content mt-3 mt-md-4">
                                        <% if $SubTitle %>
                                            <div>
                                                <span class="h6 subtitle d-block" data-bs-toggle="modal" data-bs-target="#content--{$ID}">
                                                    $SubTitle
                                                </span>
                                            </div>
                                        <% end_if %>
                                        <% if $Title %>
                                            <h6 class="mb-0" data-bs-toggle="modal" data-bs-target="#content--{$ID}">
                                                $Title
                                            </h6>
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