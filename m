Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aw1Xr-0004Tu-Bx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 08:05:59 -0800
Received: from [166.70.202.181] (helo=denlin.zserve.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Aw1Oz-0004XU-EU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 07:56:49 -0800
Message-ID: <403CC5BA.50808@muhlesteins.com>
From: Dennis Muhlestein <devel@muhlesteins.com>
MIME-Version: 1.0
References: <403BD8BC.4080205@muhlesteins.com>
In-Reply-To: <403BD8BC.4080205@muhlesteins.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] 2.6.3 Kernel panics (kernel/exit.c:793)
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
Date: Wed, 25 Feb 2004 08:56:42 -0700
To: user-mode-linux-devel@lists.sourceforge.net

I had another failure.  This time:

Kernel panic: kernel BUG at kernel/exit.c:793

These errors (see below) are all releated I believe.  Here is some more 
info:
Before I was using skas3, I had the system running in TT mode.  The 
problem occurred faster then.

I can reproduce this simply by trying to compile something.  Sometimes 
it takes only a minute or so, sometimes it lasts 5 or 10.  I don't 
always get the exact same error but I do consistently get a kernel panic.

Be glad to provide some more information if requested.
-Dennis

Dennis Muhlestein wrote:

> Host is 2.4.24 w/ skas3
> Kernel is 2.6.3 with uml-patch 2.6.3-rc2-1
>
> My file system is based on gentoo.  The system seems to boot and run,
> ok, but if I try to install any
> new applications, invariably I get a kernel panic somewhere in the build
> process.
>
> It's quite sparatic and I get different messages when it dies: here 
> are two:
>
>    Kernel mode fault at addr 0x0, ip 0x400cfa89
>    Kernel panic: Segfault with no mm
>
> Any suggestions where to look for answers?  I've seen some other
> references on the mailing lists to gentoo root file systems.  Is anyone
> having better luck than I?  Thanks for input.
>
> -Dennis
>
>
>
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
>
>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
