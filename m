Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBh8H-0007s3-KR for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 14:32:21 -0700
Received: from [66.193.15.66] (helo=faith.mccarroll.org.uk)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BBh8H-00036Y-9m
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 14:32:21 -0700
Received: from jmb by faith.mccarroll.org.uk with local (Exim 4.24)
	id 1BBhAA-0003WL-PU for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 22:34:18 +0100
From: Jody Belka <lists-uml@pimb.org>
Message-ID: <20040408213418.GA13465@faith.gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
Subject: [uml-devel] rewrite of humfsify (in perl)
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 8 Apr 2004 21:34:18 +0000
To: user-mode-linux-devel@lists.sourceforge.net



--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

After seeing mention on #uml that humfsify was a tad slow i thought
i'd take a look for myself. It was indeed, so I took a go at rewriting
it in perl. Ended up a bit faster, so here it is.

Timings for 95236 files, totalling 1.7G:

artemis:/home/knew/test# time ~knew/dl/tools/humfsify/humfsify knew knew 2G

real    112m32.607s
user    25m46.860s
sys     75m31.920s


artemis:/home/knew/test# time ~knew/dl/tools/humfsify/humfsify.pl knew knew 2G

real    3m42.792s
user    0m12.070s
sys     0m22.440s


-- 
Jody
knew (at) pimb (dot) org

--zhXaljGHf11kAtnf
Content-Type: application/x-perl
Content-Disposition: attachment; filename="humfsify.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl=0Ause strict;=0A=0Ause File::Find::Rule;=0Ause File::Path;=
=0A=0Amy ($user, $group, $size) =3D @ARGV;=0A=0Aif (!defined $user or !defi=
ned $group or !defined $size) {=0A  print "Usage: $0 user group size\n";=0A=
  exit 1;=0A}=0A=0A$user =3D getpwnam($user) if $user !~ /^[0-9]+$/;=0A$gro=
up =3D getgrnam($group) if $group !~ /^[0-9]+$/;=0A=0Amy %mult =3D ( K =3D>=
 1024, M =3D> 1024*1024, G =3D> 1024*1024*1024 );=0A=0A(my $sizeb =3D $size=
) =3D~ s/^([0-9]+)([KMG])$/$1*$mult{$2}/e;=0A=0Aif ($sizeb !~ /^[0-9]+$/) {=
=0A  print "Bad filesystem size - $size\n";=0A  exit 1;=0A}=0A=0Amy $used =
=3D `du -skD data`;=0Achomp $used;=0A$used =3D~ s/^([0-9]+)\sdata$/$1*1024/=
e;=0A=0Aif ($used > $sizeb) {=0A  print "Current disk usage greater than th=
e requested size - $used vs $sizeb\n";=0A  exit 1;=0A}=0A=0Amy $pwd =3D `pw=
d`;=0Achomp $pwd;=0A$pwd =3D~ s|/$||;=0A$pwd =3D $pwd . '/';=0Achdir "data"=
;=0A=0AFile::Find::Rule->exec(=0Asub{=0A  my ($shortname, $path, $fullname)=
 =3D @_;=0A  my $full =3D "${pwd}data/$path/$shortname";=0A  my ($uid, $gid=
) =3D (stat($shortname))[4,5];=0A  my $meta =3D "${pwd}metadata/$path/$shor=
tname";=0A  if (-d _) {=0A    mkpath $meta;=0A    chown $user, $group, $met=
a;=0A    $meta =3D "$meta/metadata";=0A  } else {=0A    mkpath "${pwd}metad=
ata/$path";=0A    chown $user, $group, "$meta/$path";=0A  }=0A  chown $user=
, $group, $full;=0A  open META, '>', $meta or die "Can't open metadata file=
($meta): $!";=0A  print META "$uid $gid\n";=0A  close META;=0A  chown $user=
, $group, $meta;=0A=0A  return 0; =0A})->in('.');=0A=0Achdir $pwd;=0A=0Aope=
n SUPER, '>', 'superblock';=0Aprint SUPER <<EOF;=0Aversion 1=0Aused $used=
=0Aavailable $sizeb=0AEOF=0Aclose SUPER;=0A
--zhXaljGHf11kAtnf--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
