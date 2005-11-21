Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EeCGh-0001gX-7A for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Nov 2005 06:03:39 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EeCGf-0005EY-Pm
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Nov 2005 06:03:39 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Do we care about 4k stacks?
Message-ID: <20051121145600.GA27086@ccure.user-mode-linux.org>
References: <200511210019.36848.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511210019.36848.rob@landley.net>
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
Date: Mon, 21 Nov 2005 09:56:00 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Nov 21, 2005 at 12:19:36AM -0600, Rob Landley wrote:
> Just curious if this is at all relevant to us, in light of the "yank 8k 
> stacks" patch proposed...

That's just on i386.  Each arch defines its own stack size, and UML uses
16K.  Not that that's good, so we might be following i386 at some point, at
least to 8K.

> $ make checkstack
> objdump -d vmlinux $(find . -name '*.ko') | \
> perl /home/landley/linux-2.6.15-rc1/scripts/checkstack.pl i386
> 0xa010ddcf buffered_vfprintf:                           33168
> 0xa010deca buffered_vfprintf:                           33168
> 0xa00e5d5b buffered_vfprintf:                           8416
> 0xa00e5e43 buffered_vfprintf:                           8416

I don't think these are of concern, but feel free to double-check :-)

If you look at the code, you'll see some care in making sure that certain
things (like printf) run only on the initial process stack, which is expanded
as needed by the host, and not on a UML kernel, which isn't.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
