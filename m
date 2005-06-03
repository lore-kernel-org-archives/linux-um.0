Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DeEu3-0000FP-0l	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Jun 2005 09:20:11 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DeEu2-0003bL-0z	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Jun 2005 09:20:10 -0700
Subject: Re: [uml-devel] Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <20050603023809.GA28818@ccure.user-mode-linux.org>
References: <1115481468.925.9.camel@localhost.localdomain>
	<20050507180356.GA10793@ccure.user-mode-linux.org>
	<1115573839.10373.42.camel@cobra>
	<20050508183533.GA27251@ccure.user-mode-linux.org>
	<1115590823.10373.68.camel@cobra> <1115600253.10373.74.camel@cobra>
	<1117691482.10122.107.camel@localhost>
	<20050602210649.GA24306@ccure.user-mode-linux.org>
	<1117766016.10122.202.camel@localhost>
	<20050603023809.GA28818@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1117826890.10090.48.camel@localhost>
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
Date: Fri, 03 Jun 2005 20:28:10 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 2005-06-02 at 22:38 -0400, Jeff Dike wrote:
> On Fri, Jun 03, 2005 at 03:33:36AM +0100, antoine wrote:
> > Thanks, almost all applied cleanly - I skipped the s390 ones for now.
> 
> I wouldn't cherry-pick patches.  You may be right, but it also means you're
> running different code than me.
I wouldn't normally do that, but there is a patch that does not apply
cleanly: fp-state (can't find file to patch at input line 28 ...)
So I started thinking that there were things I did not necessarily need
or want (s390, x11fb, audio, etc) - I guess I was wrong...

I started again, applying everything else, some files complained about
missing skas.h or proc_mm.h, another case of empty file, easy fix:
rm ./arch/um/kernel/skas/include/skas.h

I got tired of doing the same steps over and over again (to be sure I
wasn't reporting my own mistakes) so I made this very simple script to
untar kernel source + apply MM + apply UML patches:
http://213.228.237.37/uml/2.6.12-rc5-mm2/make-uml64.sh
I've also dumped the compile errors, kernel binary, .config in the same
directory.

Everything kinda works now! And it is *very* fast (compared to TT x86
guest) And this time it is a bit more stable.
I think there is still a memory leak lurking, OOM seems to kick in (see
bottom of this email)

Very minor thing: I noticed that the TT threads generally do not show
which process they are running inside the UML (as it used to), any way
to restore this?

Thanks
Antoine


> 
> > I can bring the network up manually (ifconfig) and ping (in and out),
> > but running any of the /etc/init.d/ scripts locks up, same goes for
> > starting sshd or even "Hello World" in hello.sh
> 
> Dunno, it works here, and I've beat on it a bunch.  If you can get stack
> traces or anything from the hangs, that might help.
> 
> 				Jeff
*********
* OOM
* 128RAM + 128swap should be enough to emerge things...
*********

[42951416.180000] oom-killer: gfp_mask=0xd2
[42951416.180000] DMA per-cpu:
[42951416.180000] cpu 0 hot: low 30, high 90, batch 15
[42951416.180000] cpu 0 cold: low 0, high 30, batch 15
[42951416.180000] Normal per-cpu: empty
[42951416.180000] HighMem per-cpu: empty
[42951416.180000]
[42951416.180000] Free pages:        1432kB (0kB HighMem)
[42951416.180000] Active:166 inactive:333 dirty:0 writeback:0 unstable:0
free:358 slab:999 mapped:82 pagetables:9547
[42951416.180000] DMA free:1432kB min:1448kB low:1808kB high:2172kB
active:664kB inactive:1332kB present:131072kB pages_scanned:1301
[42951416.180000] lowmem_reserve[]: 0 0 0
[42951416.180000] Normal free:0kB min:0kB low:0kB high:0kB active:0kB
inactive:0kB present:0kB pages_scanned:0
[42951416.180000] lowmem_reserve[]: 0 0 0
[42951416.180000] HighMem free:0kB min:128kB low:160kB high:192kB
active:0kB inactive:0kB present:0kB pages_scanned:0
[42951416.180000] lowmem_reserve[]: 0 0 0
[42951416.180000] DMA: 0*4kB 5*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB
0*512kB 1*1024kB 0*2048kB 0*4096kB = 1432kB
[42951416.180000] Normal: empty
[42951416.180000] HighMem: empty
[42951416.180000] Swap cache: add 314384, delete 314009, find
48066/104534, race 0+0
[42951416.180000] Free swap  = 112048kB
[42951416.180000] Total swap = 131064kB
[42951416.180000] Out of Memory: Killed process 978 (emerge).
[42951416.180000] oom-killer: gfp_mask=0xd2
[42951416.180000] DMA per-cpu:
[42951416.180000] cpu 0 hot: low 30, high 90, batch 15
[42951416.180000] cpu 0 cold: low 0, high 30, batch 15
[42951416.180000] Normal per-cpu: empty
[42951416.180000] HighMem per-cpu: empty
[42951416.180000]
[42951416.180000] Free pages:        1432kB (0kB HighMem)
[42951416.180000] Active:166 inactive:333 dirty:0 writeback:0 unstable:0
free:358 slab:1000 mapped:82 pagetables:9519
[42951416.180000] DMA free:1432kB min:1448kB low:1808kB high:2172kB
active:664kB inactive:1332kB present:131072kB pages_scanned:1301
[42951416.180000] lowmem_reserve[]: 0 0 0
[42951416.180000] Normal free:0kB min:0kB low:0kB high:0kB active:0kB
inactive:0kB present:0kB pages_scanned:0
[42951416.180000] lowmem_reserve[]: 0 0 0
[42951416.180000] HighMem free:0kB min:128kB low:160kB high:192kB
active:0kB inactive:0kB present:0kB pages_scanned:0
[42951416.180000] lowmem_reserve[]: 0 0 0
[42951416.180000] DMA: 0*4kB 5*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB
0*512kB 1*1024kB 0*2048kB 0*4096kB = 1432kB
[42951416.180000] Normal: empty
[42951416.180000] HighMem: empty
[42951416.180000] Swap cache: add 314384, delete 314009, find
48066/104535, race 0+0
[42951416.180000] Free swap  = 123236kB
[42951416.180000] Total swap = 131064kB
[42951416.180000] Out of Memory: Killed process 5713 (portageq).




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
