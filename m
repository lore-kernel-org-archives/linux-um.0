Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cdfrey@foursquare.net>) id 1Um8wU-0003L3-PW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jun 2013 20:43:54 +0000
Received: from nic.netdirect.ca ([216.16.235.2] helo=rubicon.netdirect.ca)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Um8wT-0006z8-Me
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jun 2013 20:43:54 +0000
Received: from localhost (nic.NetDirect.CA [216.16.235.2])
	by rubicon.netdirect.ca (8.13.8/8.13.8) with ESMTP id r5AKhlA1027191
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 10 Jun 2013 16:43:47 -0400
Date: Mon, 10 Jun 2013 16:43:47 -0400
From: Chris Frey <cdfrey@foursquare.net>
Message-ID: <20130610204347.GA27111@foursquare.net>
References: <20130610193722.GA23009@foursquare.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130610193722.GA23009@foursquare.net>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] kernel warning and hang in 3.4.47
To: user-mode-linux-devel@lists.sourceforge.net

And another error, this time a panic in the UML kernel again, using
the same versions:

EIP: 0073:[<0805f5c2>] CPU: 0 Not tainted ESP: 007b:0827227c EFLAGS: 00210206
    Not tainted
EAX: 00000000 EBX: 0000000b ECX: 00000000 EDX: 0000000e
ESI: 000000a0 EDI: 0827232c EBP: 08272318 DS: 007b ES: 007b
08271dc8:  [<0806fb90>] show_regs+0xc5/0xcd
08271df4:  [<0805f5d3>] segv+0x59/0x242
08271e9c:  [<0805f811>] segv_handler+0x55/0x60
08271ec4:  [<0806b1ae>] sig_handler_common+0x6d/0x7f

Kernel panic - not syncing: Segfault with no mm
08271dc0:  [<081f3adb>] dump_stack+0x1c/0x20
08271dd8:  [<081f3b48>] panic+0x69/0x157
08271df0:  [<0805f681>] segv+0x107/0x242
08271e9c:  [<0805f811>] segv_handler+0x55/0x60
08271ec4:  [<0806b1ae>] sig_handler_common+0x6d/0x7f


EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
    Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
08271d34:  [<0806fb90>] show_regs+0xc5/0xcd
08271d60:  [<0805f920>] panic_exit+0x25/0x3b   
08271d74:  [<0808afed>] notifier_call_chain+0x25/0x4a
08271d9c:  [<0808b029>] __atomic_notifier_call_chain+0x17/0x19
08271dac:  [<0808b040>] atomic_notifier_call_chain+0x15/0x17
08271dc8:  [<081f3b60>] panic+0x81/0x157
08271df0:  [<0805f681>] segv+0x107/0x242
08271e9c:  [<0805f811>] segv_handler+0x55/0x60
08271ec4:  [<0806b1ae>] sig_handler_common+0x6d/0x7f


- Chris



On Mon, Jun 10, 2013 at 03:37:22PM -0400, Chris Frey wrote:
> Hi,
> 
> I'm running a 3.4.47 UML kernel on a 3.4.47 system.
> 
> Recently I got the following warning, just before the UML guest system
> became unresponsive:
> 
> ------------[ cut here ]------------
> WARNING: at kernel/softirq.c:159 local_bh_enable+0x3b/0x8b()
> Modules linked in:
> 21274430:  [<081f3adb>] dump_stack+0x1c/0x20
> 
> This is little to go on, I'm guessing.  What should I do to provide
> more data?
> 
> Thanks,
> - Chris
> 
> 
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by Windows:
> 
> Build for Windows Store.
> 
> http://p.sf.net/sfu/windows-dev2dev
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

