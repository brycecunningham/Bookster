module BooksHelper

  def edit_book_button(book)
    link_to edit_book_path(book) do
      content_tag :i, :class => ['fa','fa-pencil','crud'], :title => 'Edit Book' do
      end
    end
  end

  def delete_book_button(book)
    link_to book_path(book), :method => :delete, :data => { 'confirm' => "Are you sure you want to delete this book?" } do
      content_tag :i, :class => ['fa','fa-trash-o','crud'], :title => 'Delete Book' do
      end
    end
  end

end
