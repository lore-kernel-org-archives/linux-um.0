Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F32Ys-00086S-EJ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Jan 2006 18:45:06 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F32Ys-0006K1-5u
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Jan 2006 18:45:06 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] many cow files with ubd_kern.c
Message-ID: <20060129024620.GB7933@ccure.user-mode-linux.org>
References: <BAY101-F14AF59E645AF66A2146EF5E2170@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY101-F14AF59E645AF66A2146EF5E2170@phx.gbl>
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
Date: Sat, 28 Jan 2006 21:46:20 -0500
To: James McMechan <james_mcmechan@hotmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Jan 28, 2006 at 11:11:31PM +0000, James McMechan wrote:
> allocation failed: out of vmalloc space - use "vmalloc=<size>" to increse 
> size
> Failed to vmalloc COW bitmap
> ubd0: Can't open "COW0": errno -12

I have a report (which I haven't looked into yet) of the ubd driver
double-vmallocing the bitmap.  This is the call trace of the vmallocs
as reported on IRC:

ubd_add
 enter
Attempting to vmalloc COW bitmap \"cow0\" at
 25600
cow.bitmap = 0x00000000 (before vmalloc)
abrooks
 cow.bitmap = 0xa2800000 (after vmalloc)
ubd_open enter
 Attempting to vmalloc COW bitmap \"cow0\" at 25600
cow.bitmap =
 0xa2800000 (before vmalloc)
cow.bitmap = 0xa280a000 (after
 vmalloc)
ubd_open exit
 /dev/ubd/disc0: p1
abrooks
 ubd_close() enter
ubd_close() exit
ubd_close()
 enter
ubd_close() exit
ubd_add exit

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
