Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYtiD-00064J-3A for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 14:09:37 -0800
Received: from magellan.cs.byu.edu ([128.187.168.24])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CYtiB-0006O3-Fm
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 14:09:36 -0800
Message-ID: <41AB9E02.9050400@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
References: <200410081635.i98GZgr02277@trolli.pdb.fsc.net>
	<200410122343.i9CNh03P004317@ccure.user-mode-linux.org>
	<416D5CDA.9030007@fujitsu-siemens.com>
	<200410132008.59231.blaisorblade_spam@yahoo.it>
In-Reply-To: <200410132008.59231.blaisorblade_spam@yahoo.it>
Content-Type: multipart/mixed; boundary="------------000502080504040905030206"
Subject: [uml-devel] Re: Auto-updating Jeff Dike tree
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
Date: Mon, 29 Nov 2004 15:09:06 -0700
To: user-mode-linux-devel@lists.sourceforge.net
Cc: bodo.stroesser@fujitsu-siemens.com

This is a multi-part message in MIME format.
--------------000502080504040905030206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

BlaisorBlade wrote:
> I use the attached script (questionable as much as you want, i.e. it kind of 
> works here, no guarantee, not even "I think it works") to download the 
> patches. It parses the patches.html in a very rough Way. I mean 
> "DownloadAllPatches".
> 
> Also, the generated series file must be edited: it appends the new patch list, 
> so if you use it as-is it has duplicate patches and won't work.

BlaisorBlade,

I've modified your DownloadAllPatches script a bit, and thought you 
might want the changes as well.  This version doesn't require editing 
for whatever versions are on the page (now auto-detects), rewrites the 
series file, and is quieter.

Frank
---------------------------------------------------------------------------
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com

--------------000502080504040905030206
Content-Type: text/plain;
 name="DownloadAllPatches"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DownloadAllPatches"

#!/usr/bin/perl -w

$| = 1;

$hostName = "user-mode-linux.sourceforge.net";
$host = $hostName;

print "Downloading latest patchlist\n";
system("wget -N -q http://$host/patches.html");

$KernelVer = 'none';

open PATCHES, "patches.html";
while (<PATCHES>)
{
	if (/name="(2.[^"]+)"/)
	{
		$KernelVer = $1;
		print "Kernel " . $KernelVer . "\n";
		$outDir = $KernelVer;
		mkdir $KernelVer;

		open PATCHLIST, "> $KernelVer-series";
		$currDate = `date`;
      chomp($currDate);
		print PATCHLIST "#\n#Downloading from Jeff Dike web-site on " . $currDate . "\n#\n";
	}

	next if ($KernelVer eq 'none');

	/href="(work[^"]+)"\>\s*([\w-]+)\<\/a\>/ or next;
	$url = "http://$host/$1";
	$name = "$2.patch";

	print PATCHLIST "$name\n";

	print "...patch $name\n";
	system("cd $outDir && http_proxy= wget -N -q -t 10 $url");
}

--------------000502080504040905030206--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
