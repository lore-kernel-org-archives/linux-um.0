Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHnYG-00051O-18 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Oct 2004 11:08:40 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CHnYE-0006Nm-80 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Oct 2004 11:08:39 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: Auto-updating Jeff Dike tree (was: [uml-devel] Re: Inconsistency
	in incremental patches 2.6.9)
References: <200410081635.i98GZgr02277@trolli.pdb.fsc.net>
	<200410122343.i9CNh03P004317@ccure.user-mode-linux.org>
	<416D5CDA.9030007@fujitsu-siemens.com>
In-Reply-To: <416D5CDA.9030007@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_78WbBbmvg9AkK50"
Message-Id: <200410132008.59231.blaisorblade_spam@yahoo.it>
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
Date: Wed, 13 Oct 2004 20:08:59 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>, bodo.stroesser@fujitsu-siemens.com


--Boundary-00=_78WbBbmvg9AkK50
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 13 October 2004 18:50, Bodo Stroesser wrote:
> Jeff Dike wrote:
> > bodo.stroesser@fujitsu-siemens.com said:
> >>The incremental patches for 2.6.9 do not fully apply. Before
> >>"signal-interface-cleaning" this patch is missing:
> >
> > That's in the signal_cleanup patch.  Am I missing something?
> >
> > 				Jeff
>
> No. I was wrong. I used an old version of the signal_cleanup patch.
>
> Sorry!
>
> Bodo
I use the attached script (questionable as much as you want, i.e. it kind of 
works here, no guarantee, not even "I think it works") to download the 
patches. It parses the patches.html in a very rough Way. I mean 
"DownloadAllPatches".

Also, the generated series file must be edited: it appends the new patch list, 
so if you use it as-is it has duplicate patches and won't work.

"Get", instead, is to download announce.txt and patch-series for mm kernels 
(maybe useless on broad-band). If you want to download them for a certain 
release, simply do mkdir ./<release> and launch Get. End.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_78WbBbmvg9AkK50
Content-Type: application/x-perl;
  name="Get"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Get"

#!/usr/bin/perl -w
$baseUrl = "ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/";
foreach $i (<*>) {
	( -d $i ) or next;
	$i =~ /^2\.6\.(.*)-mm(\d)$/ or next;
	$version = "2.6.$1";
	$mmNum="$2";
	chdir $i;
	$thisMmUrl = "$baseUrl/$version/$version-mm$mmNum";
	foreach $j ("announce.txt", "patch-series") {
		$name = $j;
		$name eq "patch-series" and $name = "series";
		( ! -f $name ) or next;
		system("http_proxy= wget $thisMmUrl/$j");
		system("mv $j $name") if ($name ne $j);
	}
	$name = "series";
	( -f "umlSeries" ) or system("grep uml series > umlSeries");
	chdir "..";
	#To add.
#while read i; do http_proxy= wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/broken-out/$i; done < umlSeries
}

--Boundary-00=_78WbBbmvg9AkK50
Content-Type: application/x-perl;
  name="DownloadAllPatches"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="DownloadAllPatches"

#!/usr/bin/perl -w

open LIST4, ">>2.4-series";
open LIST6, ">>2.6-series";
open LIST6mm, ">>2.6mm-series";
$dir4 = "2.4.26-3um";
$dir6 = "2.6.8.1-1um";
$dir6mm = "2.6.9-rc2-mm4";
mkdir $dir4;
mkdir $dir6;
mkdir $dir6mm;

$currDate = `date`;
$comm = "#\n#Downloading from Jeff Dike web-site on " . chomp($currDate) . "\n#\n";
print LIST4 $comm;
print LIST6 $comm;
print LIST6mm $comm;

$hostName = "user-mode-linux.sourceforge.net";
#$host = "66.35.250.209";
$host = $hostName;

system("wget -N http://user-mode-linux.sourceforge.net/patches.html");

open PATCHES, "patches.html";
while (<PATCHES>) {
	$is24 = /name="2.4/ .. /name="2.6/;
	$is26 = /name="2.6[^"]*um"/ .. /name="2.6[^"]*mm[^"]*"/;
	$is26mm = /name="2.6[^"]*mm[^"]*"/ .. eof;
	
	next if (!($is24 || $is26 || $is26mm));
	die "Both 2.4 and 2.6 kernel, problems in parsing" if ($is24 && $is26 && ! /name="2.6/);
	die "Both 2.6 and 2.6mm kernel, problems in parsing" if ($is26 && $is26mm && ! /name="2.6[^"]*mm[^"]*"/);
	# So either $is24 or $is26 is set, not both.

	/href="(work[^"]+)"\>\s*([\w-]+)\<\/a\>/ or next;
	$url = "http://$host/$1";
	$name = "$2.patch\n";

	if ($is24) {
		print LIST4 "$name";
		$outDir = $dir4;
	} elsif ($is26) {
		print LIST6 "$name";
		$outDir = $dir6;
	} else {
		print LIST6mm "$name";
		$outDir = $dir6mm;
	}
	#With -N check timestamps of the file.
	
	$i = 0;
	do {
		#system("cd $outDir && http_proxy= wget -N -S --header='Host: $hostName' $url");
		system("cd $outDir && http_proxy= wget -N $url");
		$i++;
	} while ($? != 0 && $i < 10);
}

--Boundary-00=_78WbBbmvg9AkK50--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
