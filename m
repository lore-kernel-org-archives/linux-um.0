Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3gsR-00041i-5H for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Feb 2005 12:43:27 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D3gsN-0004jE-GH for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Feb 2005 12:43:27 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [BUG: UML 2.6.11-rc4-bk-latest] sleeping function
	called from invalid context and segmentation fault
References: <1108381733.10703.5.camel@imp.csi.cam.ac.uk>
	<200502161935.43820.blaisorblade@yahoo.it>
	<1108740823.6713.28.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1108740823.6713.28.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502222141.54891.blaisorblade@yahoo.it>
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
Date: Tue, 22 Feb 2005 21:41:54 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Jeff Dike <jdike@addtoit.com>, lkml <linux-kernel@vger.kernel.org>

On Friday 18 February 2005 16:33, Anton Altaparmakov wrote:
> On Wed, 2005-02-16 at 19:35 +0100, Blaisorblade wrote:
> > On Monday 14 February 2005 12:48, Anton Altaparmakov wrote:
> > > Hi,
> > >
> > > I get a few Debug messages of the form from UML:
> > >
> > > Debug: sleeping function called from invalid context at
> > > include/asm/arch/semaphore.h:107
> > > in_atomic():0, irqs_disabled():1
> > > Call Trace:
> > > 087d77b0:  [<0809aaa5>] __might_sleep+0x135/0x180
> > > 087d77d8:  [<084d377f>] mcount+0xf/0x20
> > > 087d77e0:  [<0807cc13>] uml_console_write+0x33/0x80
> > >
> > > Most are coming via uml_console_write.
> >
> > The problem is that the UML tty drivers use a semaphore instead of a
> > spinlock for the locking, which also causes some other problems.
> >
> > The attached patch should fix this, but I've not yet made sure it is not
> > deadlock-prone (I didn't hit any during some very limited testing).
> >
> > So it's not yet ready for 2.6.11.
>
> Trying with the above patch in now only get two "sleeping function
> called from invalid context" warnings during boot and none during
> running.
I'll look at whether I can produce them... if it's no problem, post their 
traces anyway, please.
> However I get a lot of those errors: 
>
> arch/um/drivers/line.c:262: spin_lock(arch/um/drivers/line.c:085b5900)
> already locked by arch/um/drivers/line.c/262
Ok, I'll be looking into them ASAP (which infortunately means not very soon, 
sorry).

At a quick look, I see that line 262 is a "spin_lock" called by 
line_write_interrupt. I used spin_lock_irqsave everywhere else... but 
actually the interrupt must explicitly disable interrupts (I forgot) so, the 
simple answer seems to be using spin_lock_irqsave() would fix it. I cannot 
make a patch now.
> Also both before and after the patch I see a lot of messages like:
>
> kernel: line_write_room: tty2: no room left in buffer
I've never seen them... which is your test case?
Anyway, I'm not sure this is a needed warning: 

in include/linux/tty_driver.h, the .write_room member must tell the available 
space... it's reasonable that the TTY layer will call a flush_buffers 
function. However, looking at stdio_console, I'm seeing that, in fact, there 
is no flush_chars function(!!). I'll provide one ASAP.

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
