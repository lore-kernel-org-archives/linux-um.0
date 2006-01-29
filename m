Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F33S8-0003MJ-FB for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Jan 2006 19:42:12 -0800
Received: from bay101-f6.bay101.hotmail.com ([64.4.56.16] helo=hotmail.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1F33S7-0004Lb-CY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Jan 2006 19:42:12 -0800
Message-ID: <BAY101-F6796135F4986D1075AD47E2160@phx.gbl>
In-Reply-To: <20060129024620.GB7933@ccure.user-mode-linux.org>
From: "James McMechan" <james_mcmechan@hotmail.com>
Subject: Re: [uml-devel] many cow files with ubd_kern.c
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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
Date: Sun, 29 Jan 2006 03:42:06 +0000
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

Humm, I will look to see if that happens on my machines, nope
I just tested on a machine with more real memory but no skas3 no tmpfs I 
appear to have ~64M in use with one COW bitmap and 140M in use with 2 (from 
top in guest) the
other machine was shrinking the guest virtual address space to ~128M even 
when told to use 384M and the tmp(on tmpfs) was remounted with 
-oremount,size=10G

Though come to think of it the guest does not really need to have the 
vmalloced space
actually allocated with the backing file on tmp... but I can't think of a 
way to have it just mapped into high memory or something, but that would 
really be the place to put the 600M of bitmaps I expect to have if I can get 
things working.


>From: Jeff Dike <jdike@addtoit.com>
>To: James McMechan <james_mcmechan@hotmail.com>
>CC: user-mode-linux-devel@lists.sourceforge.net
>Subject: Re: [uml-devel] many cow files with ubd_kern.c
>Date: Sat, 28 Jan 2006 21:46:20 -0500
>
>On Sat, Jan 28, 2006 at 11:11:31PM +0000, James McMechan wrote:
> > allocation failed: out of vmalloc space - use "vmalloc=<size>" to 
>increse
> > size
> > Failed to vmalloc COW bitmap
> > ubd0: Can't open "COW0": errno -12
>
>I have a report (which I haven't looked into yet) of the ubd driver
>double-vmallocing the bitmap.  This is the call trace of the vmallocs
>as reported on IRC:
>
>ubd_add
>  enter
>Attempting to vmalloc COW bitmap \"cow0\" at
>  25600
>cow.bitmap = 0x00000000 (before vmalloc)
>abrooks
>  cow.bitmap = 0xa2800000 (after vmalloc)
>ubd_open enter
>  Attempting to vmalloc COW bitmap \"cow0\" at 25600
>cow.bitmap =
>  0xa2800000 (before vmalloc)
>cow.bitmap = 0xa280a000 (after
>  vmalloc)
>ubd_open exit
>  /dev/ubd/disc0: p1
>abrooks
>  ubd_close() enter
>ubd_close() exit
>ubd_close()
>  enter
>ubd_close() exit
>ubd_add exit
>
>				Jeff




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
