package Platform;
use Sprite;
our @ISA = ("Sprite");
sub update
{
    my ($class, $obj_list) = @_;

    $class->SUPER::update();
    if ($class->y > 768)
    {
        my @objs = @{$obj_list};
        @objs = grep({$_ != $class} @objs);
    }
}

sub gen_pair
{
    my $dest = shift;
    my $first = Platform->new({image => "platform.png", x => -int(rand(1024 - 16) ), y => 0, y_speed => 3, w => 1024, h => 16, dest_surf => $dest});
    my $second = Platform->new({image => "platform.png", x => $first->x + $first->w + int(rand(64) + 64), y => 0, y_speed => 3, w => 1024, h => 16, dest_surf => $dest});

    return [$first, $second];
}

1;
