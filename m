Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AriF7-00063y-7H
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 10:40:49 -0800
Received: from [69.93.28.254] (helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AriDF-0003dO-OG
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 10:38:53 -0800
Subject: Re: [uml-devel] uml-patch-2.6.3-rc2-1
From: Matt Ayres <matta@tektonic.net>
In-Reply-To: <200402131818.i1DIIRsq002831@ccure.user-mode-linux.org>
References: <200402131818.i1DIIRsq002831@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1076697530.20064.21.camel@wopr.tektonic.net>
Mime-Version: 1.0
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
Date: Fri, 13 Feb 2004 13:38:51 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

I'm still receiving the "NET: Registered protocol family 2" hang using
this kernel, FYI.

On Fri, 2004-02-13 at 13:18, Jeff Dike wrote:
> This patch updates UML to 2.6.3-rc2.  This breaks with my usual practice of
> ignoring test patches.  However, when I updated my UML tree, I had forgotten
> that my stock Linus tree was up to 2.6.3-rc2.  I took this as a sign from a
> higher power that this was Meant To Be.
> 
> As well as catching up, there are some bug fixes and cleanups -
> 	modules should now work
> 	worked around a process start time bug
> 	fixed a bug which caused ps to divide by zero
> 
> The 2.6.3-rc2-1 UML patch is available at
> 	http://www.user-mode-linux.org/mirror/uml-patch-2.6.3-rc2-1.bz2
> 
> BK users can pull my 2.5 repository from
> 	http://www.user-mode-linux.org:5000/uml-2.5
> 
> For the other UML mirrors and other downloads, see 
>         http://user-mode-linux.sourceforge.net/dl-sf.html
>  
> Other links of interest:
>  
>         The UML project home page : http://user-mode-linux.sourceforge.net
>         The UML Community site : http://usermodelinux.org
> 
> 				Jeff
> 
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
-- 
Matt Ayres <matta@tektonic.net>
TekTonic



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
