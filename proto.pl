use strict;
use warnings;
use diagnostics;
use v5.14; 
use SDL ':all';
use SDL::Video;
use SDL::Image;
use SDL::Rect;
use SDL::Events;

use Player;
use Platform;

my $running = 1;
sub end_game
{
    $running = 0;
}

SDL::init(SDL::SDL_INIT_EVERYTHING);

my $win = SDL::Video::set_video_mode(1024, 768, 32, SDL::Video::SDL_SWSURFACE);

my $bg = SDL::Image::load("bg.jpg");

my @objects;
@objects = (Player->new({image => "dino_small.png", x => 32, y => 50, w => 32, h =>32, running => \$running,
                            dest_surf => $win}),
               Platform->new({image => "platform.png", x => 0, y=> 100, w => 1024, h => 16, dest_surf => $win, running => \$running,
                             y_speed => 3}));

my $ticks = 0;
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


    if ($ticks % 30 == 0)
    {
        push(@objects, @{Platform::gen_pair($win)});
    }

    foreach my $obj (@objects)
    {
        $obj->update($state, \@objects);
      
        $obj->draw();
    }

    SDL::Video::flip($win);
    SDL::delay(1000/60);
    $ticks++;
#    say(@objects);
}

