Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DIthH-00085W-IP for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Apr 2005 12:26:47 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DIthF-0000BC-W7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Apr 2005 12:26:47 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] 2.6.9-bs7 panic on check_sysemu
References: <4250729B.7040407@rimuhosting.com>
	<200504041532.23866.blaisorblade@yahoo.it>
In-Reply-To: <200504041532.23866.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504051323.47160.rob@landley.net>
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
Date: Tue, 5 Apr 2005 13:23:47 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>, Peter <peter.spamcatcher@rimuhosting.com>

On Monday 04 April 2005 09:32 am, Blaisorblade wrote:

> > Is this a case where I should be upgrading my host kernels (will do that
> > in time anyway)?
>
> You simply need to update the SKAS patch version. -V2 is very old, and many
> bugs (including this, that is a bug in the SYSEMU part of the SKAS patch).
> Upgrading to -V7 for the SKAS patch, even on the same host kernel version
> (i.e. against 2.6.8.1), would fix that.
>
> Also, some older guest kernels may seem to work, because they don't
> diagnose such bugs. But actually they have problems in some situations,
> because of the host bugs. For instance panicking with a simple "echo 0 >
> /proc/sysemu; echo 1 > /proc/sysemu".
>
> > Or is there something that can be done on the guest to make it work on
> > older kernels also?
>
> Not a lot, except disabling SYSEMU (and its performance advantage) entirely
> - add the "nosysemu" param to the UML command line and it will work.
>
> But it won't be as slow as if you didn't use SKAS.
>
> Bye

Speaking of which, I ask this from time to time:

What's the minimal patch set that _just_ adds -SKAS0 mode to something like a 
2.6.11 kernel?  I'd like to try it out, but every time I sit down to whack at 
it my interest budget runs out sifting through a mountain of unrelated x86-64 
patches to try to figure out what exactly I need to apply to get just 
SKAS0...

No biggie.  I'll can always ask again later... :)

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
