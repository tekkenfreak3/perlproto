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

    if (grep({$_->contains_rect($class->x - 1, $class->y + 1, 
                                $class->w + 2, $class->h - 4)} @platforms))
    {
        $class->{x_speed} = 0;
    }
    if (my @plat = grep({$_->contains_rect($class->{x}, $class->{y} + 30, 
                             $class->{w}, 2)} @platforms))
    {
        $class->{y_speed} = ($plat[0])->{y_speed};
        $class->{y} = ($plat[0])->y - $class->h - 1;
    }
    elsif (grep({$_->contains_rect($class->{x}, $class->{y} - 1, 
                             $class->{w}, 1)} @platforms))
    {
        $class->{y} = ($_[0])->y + ($_[0])->h + 1;
        $class->{y_speed} = ($_)->{y_speed};
    }

    else
    {
        $class->{y_speed} += 3 unless $class->{y_speed} > 10;
    }
}

1;
