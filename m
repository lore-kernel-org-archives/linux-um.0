Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2A9p-00008p-0b for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Feb 2005 07:35:05 -0800
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D2A9o-00021p-Gm for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Feb 2005 07:35:04 -0800
Subject: Re: [uml-devel] [BUG: UML 2.6.11-rc4-bk-latest] sleeping function
	called from invalid context and segmentation fault
From: Anton Altaparmakov <aia21@cam.ac.uk>
In-Reply-To: <200502161935.43820.blaisorblade@yahoo.it>
References: <1108381733.10703.5.camel@imp.csi.cam.ac.uk>
	<200502161935.43820.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1108740823.6713.28.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Fri, 18 Feb 2005 15:33:43 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, lkml <linux-kernel@vger.kernel.org>

On Wed, 2005-02-16 at 19:35 +0100, Blaisorblade wrote:
> On Monday 14 February 2005 12:48, Anton Altaparmakov wrote:
> > Hi,
> >
> > I get a few Debug messages of the form from UML:
> >
> > Debug: sleeping function called from invalid context at
> > include/asm/arch/semaphore.h:107
> > in_atomic():0, irqs_disabled():1
> > Call Trace:
> > 087d77b0:  [<0809aaa5>] __might_sleep+0x135/0x180
> > 087d77d8:  [<084d377f>] mcount+0xf/0x20
> > 087d77e0:  [<0807cc13>] uml_console_write+0x33/0x80
> 
> > Most are coming via uml_console_write.
> The problem is that the UML tty drivers use a semaphore instead of a spinlock 
> for the locking, which also causes some other problems.
> 
> The attached patch should fix this, but I've not yet made sure it is not 
> deadlock-prone (I didn't hit any during some very limited testing).
> 
> So it's not yet ready for 2.6.11.

Trying with the above patch in now only get two "sleeping function
called from invalid context" warnings during boot and none during
running.  However I get a lot of those errors:

arch/um/drivers/line.c:262: spin_lock(arch/um/drivers/line.c:085b5900)
already locked by arch/um/drivers/line.c/262

Also both before and after the patch I see a lot of messages like:

kernel: line_write_room: tty2: no room left in buffer

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
