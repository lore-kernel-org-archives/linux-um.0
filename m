Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZAX6-0008Nc-Vw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 08:07:16 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CZAX5-00074z-TG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 08:07:16 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] skas mode on a non-skas host
References: <200411292250.iATMoWOF004837@ccure.user-mode-linux.org>
	<Pine.LNX.4.58.0411291623340.5077@sparrow>
In-Reply-To: <Pine.LNX.4.58.0411291623340.5077@sparrow>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411301710.15691.blaisorblade_spam@yahoo.it>
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
Date: Tue, 30 Nov 2004 17:10:15 +0100
To: William Stearns <wstearns@pobox.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 29 November 2004 22:26, William Stearns wrote:
> Good afternoon, Jeff,
>
> On Mon, 29 Nov 2004, Jeff Dike wrote:
> > Prompted by some questions from Blaisorblade about whether something like
> > skas mode might be implemented on unpatched hosts, I went ahead and did
> > exactly that.
> >
> > The basic idea is that in place of /proc/mm and PTRACE_FAULTINFO, we have
> > a couple of extra pages in the userspace process to hold code that we are
> > going to use to make it change its address space and to handle segfaults
> > so addresses and access modes can be reported back to the kernel process.
> >
> > The end result is something that is very close to skas mode, just as
> > secure, loses two pages of address space to UML rather than .5G, should
> > be almost as fast, and runs on a stock host kernel.
> >
> > The patch is available as skas0 from my patches page -
> >  http://user-mode-linux.sourceforge.net/patches.html
> > and there is a good deal of commentary associated with it.
>
>  /me drops jaw.... :-)
>
>  Nice work to both of you - I'm sincerely impressed.  Jeff, is
> there a place to grab a "all current 2.6 patches as a single patch" so I
> can give it a try?  Or do I need to grab all the 2.6 patches off the
> sourceforge page and just apply them one at a time?

Search "Auto-updating Jeff Dike tree" in uml-devel and take the script from 
Frank Sorenson in that thread, to download them less painfully - to apply 
them, you'd probably want to download and use quilt or patch-scripts.

With patch-scripts (which I use locally) pushpatch 50 is the command which 
applies the next 50 patches (and the list of applied patches is saved, so you 
can easily go back and forth in the patch stack.

I don't know the quilt syntax but it won't be totally different - it seems it 
is "quilt push 50".
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
