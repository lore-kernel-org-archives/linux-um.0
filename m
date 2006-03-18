Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FKPsV-0005RG-LQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 17:05:11 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FKPsT-0001x0-0K
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 17:05:11 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] kernel BUG at drivers/block/loop.c:621
References: <200603171912.12082.rob@landley.net>
	<200603180124.19077.blaisorblade@yahoo.it>
	<200603171955.38138.rob@landley.net>
In-Reply-To: <200603171955.38138.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603180204.56562.blaisorblade@yahoo.it>
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
Date: Sat, 18 Mar 2006 02:04:55 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org

On Saturday 18 March 2006 01:55, Rob Landley wrote:
> On Friday 17 March 2006 7:24 pm, Blaisorblade wrote:
> > On Saturday 18 March 2006 01:12, Rob Landley wrote:
> > > I can reproduce the following in 2.6.16-rc5, User Mode Linux:
> > >
> > > kernel BUG at drivers/block/loop.c:621!
> > > Kernel panic - not syncing: BUG!
> > >
> > > EIP: 0073:[<ffffe410>] CPU: 0 Not tainted ESP: 007b:b7de1f9c EFLAGS:
> > > 00200246 Not tainted
> > > EAX: 00000000 EBX: 000018be ECX: 00000013 EDX: 000018be
> > > ESI: 000018bb EDI: 00000011 EBP: b7de1fb8 DS: 007b ES: 007b
> > > 09b87bb4:  [<0806c762>] show_regs+0x102/0x110
> > > 09b87bd0:  [<0805b6fc>] panic_exit+0x2c/0x50
> > > 09b87be0:  [<0807ff7d>] notifier_call_chain+0x2d/0x50
> > > 09b87c00:  [<08071095>] panic+0x75/0x120
> > > 09b87c20:  [<0812e181>] loop_thread+0x151/0x160
> > > 09b87c4c:  [<08065297>] run_kernel_thread+0x37/0x60
> > > 09b87cfc:  [<0805bbd1>] new_thread_handler+0x9 1/0xc0
> >
> > The below is strange - GCC is putting disks in the .text section or
> > kallsyms has some bug.
> >
> > > 09b87d20:  [<ffffe420>] disks+0xf7e7ec84/0x4
>
> Isn't ffffe??? the FASTCALL page?

Sorry, didn't mention that according to ctags, disks is defined only as a 
struct member or as a static variable... clearly neither is valid on a call 
stack.

The call trace decoder filters out hex values outside _stext - _etext, but 
maybe it also considers valid the FASTCALL page... leading to this 
interesting bogus output :-)

> Haven't tried.  I value my laptop. :)

> My host is running unbuntu 2.6.12, and my mount test requires a clean
> environment with nothing else mounted when it first runs.  (It basically
> needs to run as PID 1.  Among other things, it synthesizes variants of its
> own fstab...)

> I don't think it's a uml bug, but I cc'd the UML list because that's where
> I can easily reproduce it.

Ok - didn't notice the LKML cc, sorry (it's really late).

> Rob

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
