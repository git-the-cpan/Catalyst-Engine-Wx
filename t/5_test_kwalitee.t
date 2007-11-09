use Test::More;

if (exists $ENV{TEST_AUTHOR}) {
   eval { require Test::Kwalitee; Test::Kwalitee->import() };
   plan( skip_all => 'Test::Kwalitee not installed; skipping' ) if $@;
}
else {
    plan( skip_all => 'Set $ENV{TEST_AUTHOR} to a true value to run.' );
}
