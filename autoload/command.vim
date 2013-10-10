" Command line plugin
"
" documentacao:
"  http://vimdoc.sourceforge.net/htmldoc/if_pyth.html#python-vim
"
" exemplo:
"   http://brainacle.com/how-to-write-vim-plugins-with-python.html#index
"
" plugins:
"   http://el-tramo.be/blog/my-favorite-vim-plugins/
" hacks
"   http://blog.netguru.co/post/61101011518/win-vim-hacks
"
" criando menu e icones para gvim
"    exemplo:
"      :tmenu ToolBar.taglist Toggle display of the Taglist
"      :amenu ToolBar.taglist :TlistToggle<CR>
"   http://superuser.com/questions/11289/how-do-i-customize-the-gvim-toolbar  
"   
" Again, you need to specify the name of the menu ("ToolBar") and the name of your new menu entry ("taglist").
" The name of the new entry will also be used to search for an icon. 
" You can place the icon in your ~/.vim/bitmaps/ directory (simply create it if it doesn't exist yet). 
" Supposedly,tmenu tmenuyou need a .bmp on Windows and a .xpm everywhere else. The icon's size needs to be 18 x 18 pixels.
" tmenu  
" tmenu is responsible for the tooltip displayed when hovering the icon. Use amenu to decide what should happen when the icon is clicked.
"
"

" au FocusLost * :echo 'perdeu focu?'
"
" ao abrir vim, nao cada arquivo, e sim o vim
"   au VimEnter * :echo 'abriu arquivo: ' . expand('%:t')
" 
" ao sair da janela
"   au WinLeave * :echo 'saiu da janela'
"
"

if !has('python')
  echo "Error: Required vim compiled with +python"
  finish
endif

function! Reddit()

" We start the python code like the next line.

python << EOF
# the vim module contains everything we need to interface with vim from
# python. We need urllib2 for the web service consumer.
import vim, urllib2
# we need json for parsing the response
import json

# we define a timeout that we'll use in the API call. We don't want
# users to wait much.
TIMEOUT = 20
URL = "http://reddit.com/.json"

try:
    # Get the posts and parse the json response
    response = urllib2.urlopen(URL, None, TIMEOUT).read()
    json_response = json.loads(response)

    posts = json_response.get("data", "").get("children", "")

    # vim.current.buffer is the current buffer. It's list-like object.
    # each line is an item in the list. We can loop through them delete
    # them, alter them etc.
    # Here we delete all lines in the current buffer
    del vim.current.buffer[:]

    # Here we append some lines above. Aesthetics.
    vim.current.buffer[0] = 80*"-"

    for post in posts:
        # In the next few lines, we get the post details
        post_data = post.get("data", {})
        up = post_data.get("ups", 0)
        down = post_data.get("downs", 0)
        title = post_data.get("title", "NO TITLE").encode("utf-8")
        score = post_data.get("score", 0)
        permalink = post_data.get("permalink").encode("utf-8")
        url = post_data.get("url").encode("utf-8")
        comments = post_data.get("num_comments")

        # And here we append line by line to the buffer.
        # First the upvotes
        vim.current.buffer.append("↑ %s"%up)
        # Then the title and the url
        vim.current.buffer.append("    %s [%s]"%(title, url,))
        # Then the downvotes and number of comments
        vim.current.buffer.append("↓ %s    | comments: %s [%s]"%(down, comments, permalink,))
        # And last we append some "-" for visual appeal.
        vim.current.buffer.append(80*"-")

except Exception, e:
    print e

EOF
" Here the python code is closed. We can continue writing VimL or python again.
endfunction
