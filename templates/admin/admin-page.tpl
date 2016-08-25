<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading">Markdown</div>
      <div class="panel-body">
        <div class="row">
          <div class="col-lg-6">
            <div class="form-group">
              <label for="xhtmlOut">
                <input type="checkbox" name="xhtmlOut" id="xhtmlOut">
                Use '/' to close single tags (<code>&lt;br /&gt;</code>)
              </label>
            </div>
            <div class="form-group">
              <label for="breaks">
                <input type="checkbox" name="breaks" id="breaks">
                Treat newlines as single line breaks
              </label>
            </div>
            <div class="form-group">
              <label for="typographer">
                <input type="checkbox" name="typographer" id="typographer">
                Enable smartypants and other sweet transforms (e.g. <code>(c)</code> → <code>©</code>)
              </label>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="form-group">
              <label for="linkify">
                <input type="checkbox" name="linkify" id="linkify">
                Autoconvert url-like texts to links
              </label>
            </div>
            <div class="form-group">
              <label for="externalBlank">
                <input type="checkbox" name="externalBlank" id="externalBlank">
                Open external links in a new tab/window
              </label>
            </div>
            <div class="form-group">
              <label for="nofollow">
                <input type="checkbox" name="nofollow" id="nofollow">
                Tell web crawlers that external links are not to be followed
              </label>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="col-lg-12">
    <div id="lists">
    <div class="toolbar">
      <span>Type: </span>
      <select>
        <option value="0">All</option>
        <option value="1">Anime</option>
        <option value="2">Manga</option>
      </select>
      <span>Sort: </span>
      <select>
        <option value="1">test 1</option>
        <option value="2">test 2</option>
        <option value="3">test 3</option>
        <option value="4">test 4</option>
        <option value="5">test 5</option>
      </select>
      <div class="buttons">
        <span class="button"><i class="fa fa-list"></i></span>
        <span class="button selected"><i class="fa fa-th"></i></span>
      </div>
    </div>


    <div class="grid">
        <div class="grid-item" id="add">
        <div class="inner">

          <div class="image" style="cursor:pointer;">
            +
          </div>
          <h3>
      Title
      </h3>
        </div>
      </div>
      <!-- BEGIN data -->
      <div class="grid-item" item-data="{data.json_string}">
      <div class="inner">

        <div class="image" style="cursor:pointer;">

        </div>
        <h3>
    {data.title}
    </h3>
      </div>
    </div>
      <!-- END data -->
    </div>
    </div>
  </div>
    </div>
</div>
<div id="add_new" class="modal">
  <form class="modal">
    <fieldset>
      <input id="form_title" name="title" type="text" required/>
      <label for="form_title">Title</label>
    </fieldset>
    <fieldset>
      <input id="form_image" name="image" type="file" required/>
      <label for="form_image" style="display:none;">Image</label>
    </fieldset>
    <fieldset>
      <input id="form_author" name="author" type="text" required/>
      <label for="form_author">Author</label>
    </fieldset>
    <fieldset>
    <textarea id="form_description" name="description" type="text" rows="3" required></textarea>
      <label for="form_description">Description</label>
    </fieldset>
    <fieldset>
      <select id="form_type" name="type" >
      <option value="anime">Anime</option>
      <option value="manga">Manga</option>
      </select>
      <label for="form_type">Type</label>
    </fieldset>
    <input type="submit" class="button"/>
  </form>
</div>
<div class="template well hidden">
    <form>
        <span class="pull-right"><i class="fa fa-times pointer"></i></span>

        <label>Name
        <input type="text" class="form-control" name="name" value="" />
        </label>

        <label>regex
        <input type="text" class="form-control" name="regex" value="" />
        </label>
        <label>Replacement
        <input type="text" class="form-control" name="replacement" value="" />
        </label>
    </form>
</div>

<button class="btn btn-lg btn-success pull-right" id="add"><i class="fa fa-plus"></i> Add New Mark</button>

<button id="save" class="floating-button mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
    <i class="material-icons">save</i>
</button>

<script>

    document.querySelector('#add_new').style.display = 'none';
    document.querySelector('#add').addEventListener('click', function() {
      Modal.open({
        content: document.querySelector('#add_new').innerHTML,
        draggable: true,
        width: '300px',
        openCallback: function() {
          //alert('This is an example of the use of openCallback');
        }
      });
    });
    $('#modal-container form').on('submit', function(ev) {
        var arr = [];
        $('#lists .grid-item').each(function() {
            var data = $(this).attr('item-data');

                arr.push(data);

        });
        socket.emit('admin.settings.saveMarks', arr, function() {
            app.alertSuccess('Custom marks saved and activated');
        });
    });
</script>
