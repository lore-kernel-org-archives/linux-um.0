Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsWoN-0002s3-A7
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 16:40:35 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AsWlB-0006Bt-IG
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 16:37:17 -0800
Message-ID: <1c2301c3f425$cb9f2e00$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <1bf401c3f3eb$c35704f0$2000000a@schlepptopp> <200402152045.17138.blaisorblade_spam@yahoo.it>
Subject: Re: 2.6.3-rc2 failure - was: Re: [uml-devel] Kernel idles in loop after loading IPv4
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 16 Feb 2004 01:42:45 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

hi!

> > after some investigation i found, that the problem seems to have been
> > introduced with uml-patch-2.6.0-1 (at
> > http://prdownloads.sourceforge.net/user-mode-linux/uml-patch-2.6.0-1.bz2)
> >
> > uml-patch-2.6.0-test9-1 (at
> > http://prdownloads.sourceforge.net/user-mode-linux/uml-patch-2.6.0-test9-1.
> >bz2?download), in conjunction with minor compile-fix
> > http://people.0x63.nu/~andersg/uml-minor-fixes.diff works nicely for me.
> 
> On what guest kernel do you apply the patch? uml-patch-2.6.0-1 gave strange 
> problems with 2.6.1 vanilla kernel.

i applied the patches in the way they are named:
uml-patch-2.6.0-1 to 2.6.0 vanilla kernel and uml-patch-2.6.9-test9-1 to vanilla 2.6.9-test9

> You should try using, as skas patch, 
> http://www.user-mode-linux.org/~blaisorblade/patches/2.6.2-v1-host-skas2/00-2.6.2-v1-host-SKAS2.patch.bz2, 
> which comes from the latest one from Ingo Molnar. I have not been very 
ok - i try this as soon i have some time for this. i will be very busy the next week, so don`t expect an answer too soon.

thanks & regards
roland




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
