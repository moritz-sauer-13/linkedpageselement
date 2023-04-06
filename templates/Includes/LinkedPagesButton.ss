<% if $LinkedPage || $ExternalLink %>
    <div class="linked__page--button">
        <a href="<% if $LinkedPage %>$LinkedPage.Link<% else %>$ExternalLink<% end_if %>" <% if $ExternalLink %>target="_blank"<% end_if %>>
            $ButtonCaption
        </a>
    </div>
<% end_if %>