Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DIRhL-0005KF-Hf for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Apr 2005 06:32:59 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DIRhG-0008Hm-Lw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Apr 2005 06:32:59 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.9-bs7 panic on check_sysemu
References: <4250729B.7040407@rimuhosting.com>
In-Reply-To: <4250729B.7040407@rimuhosting.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504041532.23866.blaisorblade@yahoo.it>
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
Date: Mon, 4 Apr 2005 15:32:23 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Peter <peter.spamcatcher@rimuhosting.com>

On Monday 04 April 2005 00:47, Peter wrote:
> I get this error starting up a 2.6.9-bs7 guest:
>
> Checking syscall emulation patch for ptrace...<0>Kernel panic - not
> syncing: check_sysemu : expected SIGTRAP, got status = 256
>
> The host is 2.6.8.1 with host-skas3-2.6.7-v2.patch.
>
> The 2.6.9-bs7 kernel runs OK on my newer host kernels.
>
> Is this a case where I should be upgrading my host kernels (will do that
> in time anyway)?

You simply need to update the SKAS patch version. -V2 is very old, and many 
bugs (including this, that is a bug in the SYSEMU part of the SKAS patch). 
Upgrading to -V7 for the SKAS patch, even on the same host kernel version 
(i.e. against 2.6.8.1), would fix that.

Also, some older guest kernels may seem to work, because they don't diagnose 
such bugs. But actually they have problems in some situations, because of the 
host bugs. For instance panicking with a simple "echo 0 > /proc/sysemu; echo 
1 > /proc/sysemu".

>
> Or is there something that can be done on the guest to make it work on
> older kernels also?
Not a lot, except disabling SYSEMU (and its performance advantage) entirely - 
add the "nosysemu" param to the UML command line and it will work.

But it won't be as slow as if you didn't use SKAS.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
