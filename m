Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGLr2-00038Y-0y	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 12:26:36 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EGLr0-0004dx-3l
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 12:26:36 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] testing: 2.6.13 to 2.6.14-rc1 TT boot hangs early
	(sometimes)
References: <1126653933.3769.45.camel@localhost>
In-Reply-To: <1126653933.3769.45.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6vxKD3mZlDuPEfB"
Message-Id: <200509162124.42522.blaisorblade@yahoo.it>
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
Date: Fri, 16 Sep 2005 21:24:42 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: antoine <antoine@nagafix.co.uk>, Jeff Dike <jdike@addtoit.com>

--Boundary-00=_6vxKD3mZlDuPEfB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 14 September 2005 01:25, antoine wrote:
> Hello list,

> I am back testing things, some initial results:

> * Some of the latest kernels I've built for x86 stop early in the boot.
> Here is a 2.6.14-rc1 TT guest:

> waitpid(-1, Checking for /proc/mm...found
> Checking for the skas3 patch in the host...found
> UML running in SKAS3 mode
> Checking PROT_EXEC mmap in /tmp...OK
> Kernel virtual memory size shrunk to 28311552 bytes
This is running in SKAS3 mode - see message. However, the problem may be TT in 
the meaning you'd better probably disable it.

> [{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0) = 922
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> --- SIGCHLD (Child exited) @ 0 (0) ---
> waitpid(-1, 0xbf8c7e6c, WNOHANG)        = -1 ECHILD (No child processes)
> sigreturn()                             = ? (mask now [])
> rt_sigaction(SIGINT, {SIG_DFL}, {0x8078320, [], 0}, 8) = 0
> rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
> read(255, "", 330)                      = 0
> exit_group(1)                           = ?

> # uname -a
> Linux localhost 2.6.13.1-skas3-v9-pre7 #3 Sat Sep 10 20:35:26 BST 2005
> i686 AMD Athlon(tm) XP 3200+ unknown GNU/Linux

> What's this about shrinking vm size? (reducing the mem gets rid of this
> warning)
By how much? If you tried to pass it 1G of mem it's ok it complains (when TT 
mode is enabled and HIGHMEM disabled it doesn't work - disabling TT should 
fix this).
> - Google found some dead links. 
Hmm, problems with memory layout on the host. Likely disabling TT mode in 
compilation will avoid it.
> I also tried mode=tt and mode=skas0 with the same result.
> I've also had kernels booting up to the point of mounting root and then
> spinning at 100% cpu usage.
Had something like this here too, but some random fixes resolved that. 
However, will see.
> * Next one:

> Not sure if I am supposed to be able to strace a TT kernel,
IIRC you are supposed to be able, just to get uninteresting things (because to 
get the real stuff you should use the ptrace proxy, via debug=<pid> thing. 
See the webpage about how to apply this to strace).
> but when I 
> do (this is on another system that breaks) here is what I get (end of
> long log only).

> Kernel panic - not syncing: Kernel mode fault at addr 0x8c2420, ip
> 0x8c2420

> [42949374.400000] ReiserFS: ubda: Using r5 hash to sort names
> [42949374.400000] VFS: Mounted root (reiserfs filesystem) readonly.
> waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGALRM}], WSTOPPED) =
> 2037


> [42949374.410000] Kernel panic - not syncing: Kernel mode fault at addr
> 0x1a8420, ip 0x1a8420
> [42949374.410000]
> [42949374.410000] EIP: 0073:[<001a8420>] CPU: 0 Not tainted ESP:
> 007b:b022310c EFLAGS: 00010296
> [42949374.410000]     Not tainted
> [42949374.410000] EAX: a03bae68 EBX: 00000001 ECX: 00000005 EDX:
> 00000000
> [42949374.410000] ESI: 00000008 EDI: b022354c EBP: b02233ec DS: 007b ES:
> 007b
Seems change_signal is the culprit, which is impossible. Or it re-enabled 
SIGSEGV, which is impossible too since when it's blocked the process is 
killed.
> [42949374.410000] b02233f0:  [<a00166e2>] change_signals+0x62/0x90
> [42949374.410000] b0223490:  [<a0016742>] unblock_signals+0x12/0x20
> [42949374.410000] b02234a0:  [<a015260b>] generic_unplug_device
> +0x1b/0x20
> [42949374.410000] b02234b0:  [<a015262d>] blk_backing_dev_unplug
> +0x1d/0x20
> [42949374.410000] b02234c0:  [<a00878a2>] sync_buffer+0x42/0x50
> [42949374.410000] b02234d0:  [<a023a966>] __wait_on_bit+0x66/0x70
> [42949374.410000] b02234f0:  [<a023a9f4>] out_of_line_wait_on_bit
> +0x84/0x90
> [42949374.410000] b0223580:  [<a0087948>] __wait_on_buffer+0x38/0x40
> [42949374.410000] b0223590:  [<a00e357e>] search_by_key+0xee/0xe10
> [42949374.410000] b02236d0:  [<a00c979e>] search_by_entry_key+0x2e/0x230
> [42949374.410000] b0223710:  [<a00c9d60>] reiserfs_find_entry+0x90/0x130
> [42949374.410000] b0223770:  [<a00c9e7b>] reiserfs_lookup+0x7b/0x170
> [42949374.410000] b0223860:  [<a00940bc>] real_lookup+0xbc/0xe0
> [42949374.410000] b0223880:  [<a0094464>] do_lookup+0x94/0xa0
> [42949374.410000] b02238b0:  [<a0094c9c>] __link_path_walk+0x82c/0x1070
> [42949374.410000] b02239d0:  [<a0095522>] link_path_walk+0x42/0xf0
> [42949374.410000] b0223a50:  [<a00958c5>] path_lookup+0xa5/0x1e0
> [42949374.410000] b0223ab0:  [<a0090d28>] open_exec+0x28/0xf0
> [42949374.410000] b0223b30:  [<a0091e24>] do_execve+0x44/0x220
> [42949374.410000] b0223b60:  [<a00118d8>] execve1+0x38/0x80
> [42949374.410000] b0223b90:  [<a0011942>] um_execve+0x22/0x60
> [42949374.410000] b0223bb0:  [<a00111bc>] run_init_process+0x4c/0x80
> [42949374.410000] b0223be0:  [<a00112c4>] init+0xd4/0x170
> [42949374.410000] b0223c00:  [<a003ccf9>] run_kernel_thread+0x49/0x50
> [42949374.410000] b0223cd0:  [<a001a7cb>] new_thread_handler+0x14b/0x180
> [42949374.410000] b0223d20:  [<001a8420>] 0x1a8420
> [42949374.410000]
> [42949374.410000]  Failed to restore terminal state - errno = 1
> tracing thread pid = 2033

> # uname -a
> Linux mamba 2.6.12-skas3-v9-pre4 #2 Thu Jun 23 16:28:29 GMT i686 AMD
> Athlon(tm) XP 2000+ AuthenticAMD GNU/Linux
> I tried the same filesystem as ext3 but that made no difference.
> Guest is 2.6.14-rc1

> Same kernel in skas3/skas0 works occasionally! But when it does not:

> [42949374.340000] VFS: Mounted root (ext3 filesystem) readonly.
> [42949384.250000] BUG: soft lockup detected on CPU#0!
Does the box locks up thereafter? Jeff has been seeing these for some time, 
but IIRC the box didn't lock up. (Jeff, what's the actual situation?).

Also, the warning is given when a certain thread, which has only this purpose, 


is not allowed to run for more than 10 seconds (see description in commit 
8446f1d391f3d27e6bf9c43d4cbcdac0ca720417). I.e. a really bad load (or 
scheduler problems, including the fact we are not preemptible) could cause 
this. When this thread is started, this message is printed:
softlockup thread 0 started up.

> * Good points:
> pcap works really well.
> I just wished there was a way to easily figure out which libraries need
> to be included in the chroot to make it work (beyond lipcap)
Idea: try using ltrace with focus on dlopen (from libdl).
> * Some other small issues:
> when building IPv6 & pcap, I get:
> /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/../../../libc.a(in6_addr.o)(.rodat
>a+0x10): multiple definition of `in6addr_loopback'

> (This has been the case with the last few releases)
It's a name conflict with libc... ugh, means adding another -D like 
-Derrno=kernel_errno in the same place. It's trivial, but it's getting boring. 
Attached the fix.

A question: is it ok to be mentioned in the patch changelog? It was suggested 
to do so to give a bit of reward to testers - just I don't know if I should 
or not, and secondly if I should put your email or not.

> Hope this helps, as usual - let me know what I can do to help

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_6vxKD3mZlDuPEfB
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-fix-conflict-libc-ipv6"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fix-conflict-libc-ipv6"

uml: Fix conflict between libc and ipv6

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

gcc is now complaining during link on some hosts - fix it as for other things.
Reported by Antoine Martin.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/um/Makefile
===================================================================
--- linux-2.6.git.orig/arch/um/Makefile
+++ linux-2.6.git/arch/um/Makefile
@@ -53,9 +53,13 @@ SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$
 
 # -Dvmap=kernel_vmap affects everything, and prevents anything from
 # referencing the libpcap.o symbol so named.
+#
+# Same things for in6addr_loopback - found in libc.
 
 CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\" \
-	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap
+	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap \
+	-Din6addr_loopback=kernel_in6addr_loopback
+
 AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))

--Boundary-00=_6vxKD3mZlDuPEfB--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
