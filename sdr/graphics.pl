use PDL;
use PDL::Constants qw/PI/;
use PDL::Graphics::Gnuplot;

{
  my $w = gpwin('svg', output => 'gen/aliased-sines.svg', size => [ 1000, 350, ], );


  my $freq = 0.2;


  my $x = sequence(10000) / 1000;

  $w->options(key => 'bmargin', );

  $w->plot({ with => 'lines', lt => 1, lc => 1, legend => 'frequency = ' . $freq },
           $x, sin($freq * 2 * PI * $x));



  $x = sequence(11);

  $w->replot({ with => 'points', lt => 3, lc => 3, },
             $x, sin($freq * 2 * PI * $x));



  $x = sequence(10000) / 1000;

  $w->replot({ with => 'lines', lt => 1, lc => 8, legend => 'frequency = ' . (1 - $freq) },
             $x, sin(((1 - $freq) * 2 * PI * $x) + PI));


  $w->close();
}
