```ruby

#test cases
#1
#Albums
io = double :io

app = Application.new(
    'music_library',
    io,
    AlbumRepository.new,
    ArtistRepository.new
)
expect(io).to receive(:gets).and_return("1")
expect(io).to receive(:puts).with("1 - Bossanova\n2 - Surfer Rosa")

app.run 

```