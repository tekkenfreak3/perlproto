package Player;
use strict;
use diagnostics;
use v5.18;

use SDL ':all';
use SDL::Video;
use SDL::Image;
use SDL::Rect;
use SDL::Events;

use Sprite;

use Util;

our @ISA = ("Sprite");

sub update {
    my ($class, $keystate, $objs) = @_;

    $class->SUPER::update();

    $class->{x_speed} = step_towards($class->{x_speed}, 0, 10);

    if (($class->y + $class->h) > 768)
    {
        ${$class->{running}} = 0;
    }
    
    my @obj_list = @{$objs};
    
    if ($keystate->[SDL::Events::SDLK_LEFT])
    {
        $class->{x_speed} = -15;
    }
    if ($keystate->[SDL::Events::SDLK_RIGHT])
    {
        $class->{x_speed} = 15;
    }

    if ($keystate->[SDL::Events::SDLK_UP])
    {
        $class->{y_speed} = -20;
        $class->{y} -= 1;
    }

    my @platforms = grep({$_->isa("Platform")} @obj_list);

    if (my @plat = grep({$_->contains($class->{x} + ($class->{w} / 2), $class->{y} + $class->{h} + 1)} @platforms))
    {
        $class->{y_speed} = ($plat[0])->{y_speed};
        $class->{y} = ($plat[0])->y - $class->{h} - 1;
    }
    else
    {
        $class->{y_speed} += 3 unless $class->{y_speed} > 10;
    }
}

1;
