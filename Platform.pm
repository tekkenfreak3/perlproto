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
1;
