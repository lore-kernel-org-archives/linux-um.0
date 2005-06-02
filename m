Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ddp7y-00057w-1t	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Jun 2005 05:48:50 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Ddp7w-0006FJ-VI	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Jun 2005 05:48:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id D5550AEF83
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  2 Jun 2005 13:10:15 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27485-06 for <user-mode-linux-devel@lists.sourceforge.net>;
 Thu,  2 Jun 2005 13:10:14 +0100 (BST)
Received: from [192.168.0.1] (unknown [81.1.81.138])
	by mail.nagafix.co.uk (Postfix) with ESMTP id E0DE6AEF82
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  2 Jun 2005 13:10:12 +0100 (BST)
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <1117307236.10041.4.camel@localhost>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net>
	 <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra>
	 <1115483506.12131.33.camel@cobra>
	 <1115481468.925.9.camel@localhost.localdomain>
	 <20050507180356.GA10793@ccure.user-mode-linux.org>
	 <1115573839.10373.42.camel@cobra>
	 <20050508183533.GA27251@ccure.user-mode-linux.org>
	 <1115590823.10373.68.camel@cobra>  <1115600253.10373.74.camel@cobra>
	 <1117307236.10041.4.camel@localhost>
Content-Type: text/plain
Message-Id: <1117727574.10122.146.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Problems applying patches to 2.6.12-rc5-mm1
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
Date: Thu, 02 Jun 2005 16:52:54 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Note: this is an attempt at running it on x86_64 host, so the errors
may or may not be the same...

I applied the patches on the website to 2.6.12-rc5 (mm1 and mm2: most
patches apply cleanly to both, some have been merged in mm2 obviously),
I got an error here:

gcc   -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -O2 -fno-omit-frame-pointer
-fno-optimize-sibling-calls -g -U__x86_64__ -fno-builtin -D__arch_um__
-DSUBARCH=\"x86_64\" -Iarch/um/include
-I/usr/src/linux-2.6.12-rc5-mm2-uml/arch/um/kernel/tt/include
-D__x86_64__ -D_GNU_SOURCE -D_LARGEFILE64_SOURCE -c -o
arch/um/sys-x86_64/stub_segv.o arch/um/sys-x86_64/stub_segv.c
In file included from /usr/include/asm/ucontext.h:2,
                 from arch/um/sys-x86_64/stub_segv.c:8:
/usr/include/asm/../asm-x86_64/ucontext.h:4: error: redefinition of
`struct ucontext'

I removed the #include "ucontext", and added #include "uml-config.h" to
stub_segv.c. Then it got stuck on:
fixdep: arch/um/sys-x86_64/.stub_segv.o.d: No such file or directory
Re-running the build as suggested by Jeff did not help, but
creating an empty file to make it proceed seems to work...
`touch arch/um/sys-x86_64/.stub_segv.o.d`
(I haven't tried removing the av-skas patch yet)

Then it builds and almost runs:
(...)
[42949373.260000] kjournald starting.  Commit interval 5 seconds
[42949373.260000] EXT3-fs: mounted filesystem with ordered data mode.
[42949373.260000] VFS: Mounted root (ext3 filesystem) readonly.
[42949373.260000] Kernel panic - not syncing: Kernel mode fault at addr
0x0, ip 0x0
[42949373.260000]
[42949373.260000] Pid: 1, comm: bash Not tainted 2.6.12-rc5-mm2
[42949373.260000] RIP: 0000:[<0000000000000000>]
[42949373.260000] RSP: 0000000060453c30  EFLAGS: 00010202
[42949373.260000] RAX: 0000000000000001 RBX: 0000000000000000 RCX:
0000000060194ec1
[42949373.260000] RDX: 000000006002840d RSI: 0000000000000001 RDI:
0000000060453ad0
[42949373.260000] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
[42949373.260000] R10: 0000000000000008 R11: 0000000000000246 R12:
0000000000000000
[42949373.260000] R13: 0000000000000001 R14: 000000000000000a R15:
0000000000000000
[42949373.260000] Call Trace:
[42949373.260000] 604536d8:  [<6001575f>] panic_exit+0x2f/0x50
[42949373.260000] 604536f8:  [<60040c2b>] notifier_call_chain+0x2b/0x50
[42949373.260000] 60453728:  [<6002fe24>] panic+0xe4/0x180
[42949373.260000] 60453768:  [<60194ec1>] __sigprocmask+0x11/0x40
[42949373.260000] 60453788:  [<6010e0b3>] __up_read+0xb3/0xf0
[42949373.260000] 604537a8:  [<60014908>] handle_page_fault+0xc8/0x280
[42949373.260000] 604537d8:  [<6002a1ef>] __do_user_copy+0x4f/0xd0
[42949373.260000] 60453818:  [<60014caa>] segv+0x1ea/0x2b0
[42949373.260000] 60453828:  [<60194f85>] sigemptyset+0x15/0x40
[42949373.260000] 60453838:  [<60028d71>] change_sig+0x61/0x80
[42949373.260000] 604538a8:  [<60194f85>] sigemptyset+0x15/0x40
[42949373.260000] 604538b8:  [<60028de1>] change_signals+0x51/0x80
[42949373.260000] 60453928:  [<60015056>] segv_handler+0x106/0x120
[42949373.260000] 60453958:  [<60014f50>] segv_handler+0x0/0x120
[42949373.260000] 60453968:  [<60017fc9>] sig_handler_common_tt
+0x119/0x1b0
[42949373.260000] 604539d8:  [<60028a80>] sig_handler+0x10/0x20
[42949373.260000] 604539e8:  [<60194c40>] __restore_rt+0x0/0x10
[42949373.260000] 60453a78:  [<6002840d>] run_kernel_thread+0x2d/0x50
[42949373.260000] 60453a88:  [<60194ec1>] __sigprocmask+0x11/0x40
[42949373.260000] 60453ae0:  [<6000f1b0>] init+0x0/0x100
[42949373.260000] 60453b08:  [<6002840d>] run_kernel_thread+0x2d/0x50
[42949373.260000] 60453b88:  [<6000f1b0>] init+0x0/0x100
[42949373.260000] 60453b98:  [<60028e2e>] unblock_signals+0xe/0x10
[42949373.260000] 60453ba8:  [<60016456>] new_thread_handler+0x166/0x1a0
[42949373.260000] 60453cd8:  [<60194ec1>] __sigprocmask+0x11/0x40
[42949373.260000]
[42949373.260000]

Now, I am really stuck.
Any ideas?

Cheers
Antoine


On Sat, 2005-05-28 at 20:07 +0100, antoine wrote:
> Hi Jeff,
> 
> Now that the ptrace host bug has been fixed in 2.6.11.11, I can run
> tests on shared systems without taking too many risks, but I am a little
> bit lost as to which patches I would need to apply, between your
> patches, Blaisorblade's, al's,.. Which all seem to contain x86_64
> patches. Let me know what I can do to help testing. I am sure I can find
> some new bugs, in fact I am working on a Java VM bug atm.
> 
> Cheers
> Antoine
> 
> 
> On Mon, 2005-05-09 at 01:57 +0100, Antoine Martin wrote:
> > Crashing it is quite easy in fact, reiserfs as root_fs just won't work.
> > I don't think this trace is going to help, but here it is anyway:
> > 
> > [42949381.990000] REISERFS: panic (device Null superblock):
> > reiserfs[175]: assertion !( comp_keys( &MAX_KEY, p_s_key ) && !
> > key_in_buffer(p_s_search_path, p_s_key, p_s_sb) ) failed at
> > fs/reiserfs/stree.c:685:search_by_key: PAP-5130: key is not in the
> > buffer
> > [42949381.990000] Kernel panic - not syncing: BUG!
> > [42949381.990000]  [42949381.990000]
> > 
> > 
> > On Sun, 2005-05-08 at 23:20 +0100, Antoine Martin wrote:
> > > All good, builds fine and hasn't crashed yet!
> > > I'll get back to you with (hopefully) more useful debugging information
> > > as soon as Andi Kleen comes up with a patch for the host bug.
> > > 
> > > Antoine
> > > 
> > > On Sun, 2005-05-08 at 14:35 -0400, Jeff Dike wrote:
> > > > I uploaded a new set of patches which patches, builds, and runs on both
> > > > i386 and x86_64.
> > > > 
> > > > On Sun, May 08, 2005 at 06:37:19PM +0100, Antoine Martin wrote:
> > > > > I noticed that you updated the website with patches against -rc4 so I
> > > > > built the beast, As before, I had to do this to fix it:
> > > > > cd include/asm
> > > > > ln -sf elf-x86_64.h elf.h
> > > > 
> > > > I get an empty elf.h which obviously causes build problems.  Removing it
> > > > and rebuilding fixes it.  I haven't looked at this yet.
> > > > 
> > > > > I also had a reject on:
> > > > > arch/um/sys-x86_64/Makefile
> > > > 
> > > > This should be OK now.
> > > > 
> > > > 				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
