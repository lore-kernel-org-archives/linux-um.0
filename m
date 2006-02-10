Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F7k5D-0003Wm-0z for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Feb 2006 18:01:55 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1F7k5B-0003JI-1X
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Feb 2006 18:01:55 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: (solved?) Bridge code Oops with 2.6.14.2 (was: Re: [uml-devel]
	RE: [uml-user] guest soft lockup after mounting root fs in skasmode)
References: <7B4268E5ACB878429B58D4BE5B780E83506E53@NWS-EXCH2.nws.oregonstate.edu>
In-Reply-To: <7B4268E5ACB878429B58D4BE5B780E83506E53@NWS-EXCH2.nws.oregonstate.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101812.53619.blaisorblade@yahoo.it>
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
Date: Fri, 10 Feb 2006 18:12:53 +0100
To: "Brock, Anthony - NET" <Anthony.Brock@oregonstate.edu>, user-mode-linux-devel@lists.sourceforge.net

On Thursday 29 December 2005 21:57, Brock, Anthony - NET wrote:
> Blaisorblade,
>
> Thanks! This clears up the source of the issue. Unfortunately, I'm now a
> little baffled by why a newer guest kernel would change behavior. In any
> case, we now need to decide if a bug-report is worth the effort. *sigh*

I was looking at newly released 2.6.15.4, and found this in the log:

commit a426fa9147f034d5355875ffcb91f0a61e5b393a
tree 9ae78d4cf9ae05fc71183e1b3a23244dc2cd3bc2
parent ec81e3178071f3747bd1522c959972105584514b
author Stephen Hemminger <shemminger@osdl.org> lun, 06 feb 2006 15:42:45 -0800
committer Chris Wright <chrisw@sous-sol.org> gio, 09 feb 2006 23:20:15 -0800

    [PATCH] bridge: fix RCU race on device removal

    Patch to 2.6.15 stable kernel to fix race conditions on device
    removal.  These are reproducible by doing delif while packets are
    in flight.

    Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
    Signed-off-by: Chris Wright <chrisw@sous-sol.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

commit ec81e3178071f3747bd1522c959972105584514b
tree 7af2fd04c854e0c3c2e4637d3b404499e360a28d
parent 09a17332563531806883b67bf8a9fe0ef0200262
author Stephen Hemminger <shemminger@osdl.org> lun, 06 feb 2006 15:41:15 -0800
committer Chris Wright <chrisw@sous-sol.org> gio, 09 feb 2006 23:20:15 -0800

    [PATCH] bridge: netfilter races on device removal

    Fix bridge netfilter to handle case where interface is deleted
    from bridge while packet is being processed (on other CPU).

    Fixes: http://bugzilla.kernel.org/show_bug.cgi?id=5803

    Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
    Signed-off-by: Chris Wright <chrisw@sous-sol.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Indeed, since you are shutting down a guest instance when getting the crash, 
it is _possible_ that an interface is brought down on the host (even if with 
bridging it's strange this happens), so these bugs *may* be fixed by those 
patches.

Hope it helps!

> > > Unable to handle kernel NULL pointer dereference at virtual address
> > > 00000000
> > >  printing eip:
> > > f8be14f4
> > > *pde = 00000000
> > > Oops: 0000 [#1]
> > > SMP
> > > Modules linked in: autofs4 tun ipv6 bridge floppy pcspkr hw_random
> > > i2c_amd8111 generic amd74xx shpchp pci_hotplug ohci_hcd
> >
> > usbcore raid1
> >
> > > md_mod dm_mod rtc w83627hf eeprom lm85 hwmon_vid i2c_isa i2c_amd756
> > > i2c_core tg3 e100 mii psmouse ide_generic ide_disk ide_cd
> >
> > cdrom ide_core
> >
> > > unix
> > > CPU:    1
> > > EIP:    0060:[<f8be14f4>]    Not tainted VLI
> > > EFLAGS: 00010287   (2.6.14.2-skas3-v8.2)
> > > EIP is at br_nf_forward_ip+0xa2/0x16a [bridge]
> > > eax: 00000000   ebx: d7b59dc0   ecx: ea4a5380   edx: 00000080
> > > esi: 00000002   edi: 00000002   ebp: f8bdbdb7   esp: e172bcc8
> > > ds: 007b   es: 007b   ss: 0068
> > > Process linux-2.6.7-02- (pid: 4049, threadinfo=e172a000
> >
> > task=e99ed550)
> >
> > > Stack: 80000000 c03e7350 c02d44e7 00000002 e172bd58
> >
> > f8be1334 80000000
> >
> > > ea4a5380
> > >        e172bd40 80000000 c03e7350 c02d44e7 00000002
> >
> > e172bd7c f2641000
> >
> > > efd7e800
> > >        f8bdbdb7 00000002 e172bd7c c03e7350 f8bdbdb7
> >
> > c02d4564 c03e7350
> >
> > > e172bd7c
> > > Call Trace:
> > >  [<c02d44e7>] nf_iterate+0x66/0x8a
> > >  [<f8be1334>] br_nf_forward_finish+0x0/0x11e [bridge]
> > >  [<c02d44e7>] nf_iterate+0x66/0x8a
> > >  [<f8bdbdb7>] br_forward_finish+0x0/0x6b [bridge]
> > >  [<f8bdbdb7>] br_forward_finish+0x0/0x6b [bridge]
> > >  [<c02d4564>] nf_hook_slow+0x59/0x10e
> > >  [<f8bdbdb7>] br_forward_finish+0x0/0x6b [bridge]
> > >  [<f8bdbefa>] __br_forward+0x63/0x7c [bridge]
> > >  [<f8bdbdb7>] br_forward_finish+0x0/0x6b [bridge]
> > >  [<f8bdc11b>] br_flood_forward+0x27/0x2c [bridge]
> > >  [<f8bdbe97>] __br_forward+0x0/0x7c [bridge]
> > >  [<f8bdcb1b>] br_handle_frame_finish+0x11b/0x137 [bridge]
> > >  [<f8be094c>] br_nf_pre_routing_finish+0x1a6/0x36b [bridge]
> > >  [<f8bdca00>] br_handle_frame_finish+0x0/0x137 [bridge]
> > >  [<f8be07a6>] br_nf_pre_routing_finish+0x0/0x36b [bridge]
> > >  [<f8be07a6>] br_nf_pre_routing_finish+0x0/0x36b [bridge]
> > >  [<c02d4564>] nf_hook_slow+0x59/0x10e
> > >  [<f8be07a6>] br_nf_pre_routing_finish+0x0/0x36b [bridge]
> > >  [<f8bdca00>] br_handle_frame_finish+0x0/0x137 [bridge]
> > >  [<f8be11a6>] br_nf_pre_routing+0x332/0x457 [bridge]
> > >  [<f8be07a6>] br_nf_pre_routing_finish+0x0/0x36b [bridge]
> > >  [<c02d44e7>] nf_iterate+0x66/0x8a
> > >  [<f8bdca00>] br_handle_frame_finish+0x0/0x137 [bridge]
> > >  [<f8bdca00>] br_handle_frame_finish+0x0/0x137 [bridge]
> > >  [<c02d4564>] nf_hook_slow+0x59/0x10e
> > >  [<f8bdca00>] br_handle_frame_finish+0x0/0x137 [bridge]
> > >  [<f8bdccec>] br_handle_frame+0x1b5/0x229 [bridge]
> > >  [<f8bdca00>] br_handle_frame_finish+0x0/0x137 [bridge]
> > >  [<c027e6e9>] netif_receive_skb+0x1af/0x334
> > >  [<f8a74bf5>] e100_poll+0x1cf/0x70c [e100]
> > >  [<c027ea36>] net_rx_action+0xc1/0x197
> > >  [<c01206a2>] __do_softirq+0x72/0xdd
> > >  [<c0120740>] do_softirq+0x33/0x35
> > >  [<c0104e7e>] do_IRQ+0x1e/0x24
> > >  [<c0103772>] common_interrupt+0x1a/0x20
> > > Code: c1 e2 06 8d 82 90 71 3e c0 3b 82 90 71 3e c0 74 58 c7
> >
> > 44 24 18 00
> >
> > > 00 00 80 c7 44 24 14 34 13 be f8 8b 44 24 3c 8b 80 ec 02 00
> >
> > 00 <8b> 00
> >
> > > 8b 40 0c 89 44 24 10 8b 44 24 38 8b 80 ec 02 00 00 8b 00

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
