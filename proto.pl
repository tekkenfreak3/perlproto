use strict;
use warnings;
use diagnostics;

use SDL ':all';
use SDL::Video;
use SDL::Image;
use SDL::Rect;
use SDL::Events;

use Player;
use Platform;

SDL::init(SDL::SDL_INIT_EVERYTHING);

my $win = SDL::Video::set_video_mode(1024, 768, 32, SDL::Video::SDL_SWSURFACE);

my $bg = SDL::Image::load("bg.jpg");

my @objects;
@objects = (Player->new({image => "dino_small.png", x => 0, y => 650, w => 32, h =>32,
                            dest_surf => $win}),
               Platform->new({image => "platform.png", x => 0, y=> 700, w => 1024, h => 16, dest_surf => $win}));

my $running = 1;
while ($running)
{
    SDL::Events::pump_events();

    my $state = SDL::Events::get_key_state();
    if ($state->[SDL::Events::SDLK_ESCAPE])
    {
        $running = 0;
    }

    SDL::Video::blit_surface($bg,
                             SDL::Rect->new(0, 0, 1024, 768),
                             $win,
                             SDL::Rect->new(0, 0, 1024, 768));

    foreach my $obj (@objects)
    {
        $obj->update($state, \@objects);
        $obj->draw();
    }

    SDL::Video::flip($win);
    SDL::delay(1000/60);
}

