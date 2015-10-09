package Sprite;
use strict;
use diagnostics;

sub new {
    my ($class, $args) = @_;
    
    my $self = bless({image => SDL::Image::load($args->{image}),
                      x => $args->{x},
                      y => $args->{y},
                      w => $args->{w},
                      h => $args->{h},
                      obj_list => $args->{objs}, # A reference to the list of objects, nice for some things
                      dest_surf => $args->{dest_surf}}, $class);
}

sub draw {
    my ($class) = @_;

    SDL::Video::blit_surface($class->{"image"}, SDL::Rect->new(0,
                                                         0, $class->{"w"}, $class->{"h"}), $class->{"dest_surf"},
                         SDL::Rect->new($class->{"x"}, $class->{"y"}, 680, 480));
}

1;
