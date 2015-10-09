use strict;
use warnings;
use diagnostics;

use SDL ':all';
use SDL::Video;
use SDL::Image;
use SDL::Rect;
use SDL::Events;

use Player;

SDL::init(SDL::SDL_INIT_EVERYTHING);

my $win = SDL::Video::set_video_mode(1024, 768, 32, SDL::Video::SDL_SWSURFACE);

my $spr = Player->new({image => "dino.png", x => 0, y => 0, w => 32, h =>32,
                      dest_surf => $win});

my $running = 1;
while ($running)
{
    SDL::Events::pump_events();

    my $state = SDL::Events::get_key_state();
    if ($state->[SDL::Events::SDLK_ESCAPE])
    {
        $running = 0;
    }

    $spr->update($state);
    $spr->draw();
    SDL::Video::flip($win);
    SDL::delay(1000/60);
}

