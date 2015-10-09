package Player;
use strict;
use diagnostics;

use SDL ':all';
use SDL::Video;
use SDL::Image;
use SDL::Rect;
use SDL::Events;

use Sprite;

our @ISA = ("Sprite");
sub update {
    my ($class, $keystate) = @_;
    if ($keystate->[SDL::Events::SDLK_LEFT])
    {
        $class->{"x"} -= 5;
    }
    if ($keystate->[SDL::Events::SDLK_RIGHT])
    {
        $class->{"x"} += 5;
    }

    $class->{"y"} -= 3 unless 
}
1;
