use common::sense;

use PDL;
use PDL::Complex;
use PDL::Constants qw/PI/;

use SDR;

my $base_frequency = shift;
my $freq = shift;
my $sample_rate = 2_000_000;
my $tone_freq = 1000;

my $radio = SDR->radio(can => 'tx');

$radio->frequency($base_frequency);
$radio->sample_rate($sample_rate);

my $curr_sample = 0;

$radio->tx(sub {
  my $block_size = shift;

  my $time = sequence($block_size / 2) + $curr_sample;

  $curr_sample += $block_size / 2;

  my $radians = 2 * PI * ($freq / $sample_rate) * $time;

  my $tone = 50 * sin(2 * PI * ($tone_freq / $sample_rate) * $time);

  my $signal = cos($radians + $tone) + i * sin($radians + $tone);

  $signal += 128 + (128 * i);

  return $signal->byte->flat->get_dataref;
});

$radio->run;
