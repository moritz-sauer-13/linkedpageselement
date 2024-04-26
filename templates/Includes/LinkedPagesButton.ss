<% if $LinkedPage %>
    <div class="linked__page--button">
        <a href="$LinkedPage.URL" <% if $LinkedPage.OpenInNew %>target="_blank" rel="noopener noreferrer"<% end_if %>>
            $LinkedPage.Title
        </a>
    </div>
<% end_if %>
