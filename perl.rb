require 'formula'

class Perl < Formula
  homepage 'http://www.perl.org/'
  url 'http://www.cpan.org/src/5.0/perl-5.14.2.tar.gz'
  md5 '3306fbaf976dcebdcd49b2ac0be00eb9'

  def options
    [['--use-threads', 'Enable perl threads']]
  end

  def install
    system("rm -f config.sh Policy.sh")
    args = [
        '-des',
        "-Dprefix=#{prefix}",
        "-Dman1dir=#{man1}",
        "-Dman3dir=#{man3}",
        '-Duseshrplib',
        '-Duselargefiles',
    ]

    args << '-Dusethreads' if ARGV.include? '--use-threads'

    system './Configure', *args
    system "make"
    system "make test"
    system "make install"
  end

  def caveats
    unless ARGV.include? '--use-threads' then <<-EOS.undent
      Builds without threads by default. Use --use-threads to build with threads.
      EOS
    end
  end
end
