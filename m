Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fc1fE-0003mH-PX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 07:52:16 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fc1fE-0004jX-UD for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 07:52:16 -0700
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]
	helo=aa004msg.fastwebnet.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fc1fD-0003ID-CD
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 07:52:16 -0700
From: Mattia Dongili <malattia@linux.it>
Subject: Re: [uml-devel] Problem on generation a locales on uml image
Message-ID: <20060505145248.GE23227@inferi.kami.home>
References: <20060505124937.GA4327@SteX> <20060505141208.GA4940@SteX>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505141208.GA4940@SteX>
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
Date: Fri, 5 May 2006 16:52:48 +0200
To: Stefano Melchior <stefano.melchior@openlabs.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, May 05, 2006 at 04:12:08PM +0200, Stefano Melchior wrote:
> On Fri, May 05, 2006 at 02:49:37PM +0200, Stefano Melchior wrote:
[...]
> >   en_GB.UTF-8...BUG: soft lockup detected on CPU#0!
> > 
> > EIP: 0073:[<40058d3f>] CPU: 0 Not tainted ESP: 007b:af86bd78 EFLAGS:
> > 00200246
> >     Not tainted
> > EAX: 4014ea20 EBX: 4014eff4 ECX: af86c394 EDX: af86c428
> > ESI: 0808c3e4 EDI: 00000000 EBP: af86c370 DS: 007b ES: 007b
> > 0f307ba8:  [<0806efa0>] show_regs+0xb4/0xb9
> > 0f307bd4:  [<0808ab3e>] softlockup_tick+0x46/0x4b
> > 0f307be8:  [<0807b1cd>] do_timer+0xa4/0xaa
> > 0f307bf8:  [<0805cb10>] um_timer+0xf/0x94
> > 0f307c14:  [<0808acc3>] handle_IRQ_event+0x2a/0x5e
> > 0f307c3c:  [<0808ad51>] __do_IRQ+0x5a/0x99
> > 0f307c54:  [<08059c87>] do_IRQ+0x22/0x2e
> > 0f307c60:  [<0805cab4>] timer_irq+0xff/0x12d
> > 0f307c84:  [<0805cdcc>] timer_handler+0x46/0x4e
> > 0f307c9c:  [<0806caa4>] user_signal+0x3e/0x5a
> > 0f307cb4:  [<0806c2dc>] userspace+0x213/0x23f
> > 0f307d04:  [<0805e486>] fork_handler+0x82/0x89
> > 0f307d1c:  [<ffffe420>] _etext+0xf7e6d406/0x0

AFAIU, it's an harmless warning telling that UML didn't receive the
timer interrupt for too long.

-- 
mattia
:wq!


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
