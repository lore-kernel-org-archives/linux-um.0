Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FgBx0-0000Ys-Mi for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 19:39:50 -0700
Received: from wx-out-0102.google.com ([66.249.82.203])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FgBwz-0003bD-PC
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 19:39:50 -0700
Received: by wx-out-0102.google.com with SMTP id s10so91969wxc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 16 May 2006 19:39:48 -0700 (PDT)
From: Alberto Bertogli <albertito@gmail.com>
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on
	x86-64ync-mailbox><next-undeleted><enter-command>set editor=vim
Message-ID: <20060517023942.GI9066@gmail.com>
References: <20060514182541.GA4980@gmail.com>
	<20060515033919.GD21383@ccure.user-mode-linux.org>
	<20060515152958.GA4553@gmail.com>
	<20060516191244.GB6337@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516191244.GB6337@ccure.user-mode-linux.org>
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
Date: Tue, 16 May 2006 23:39:42 -0300
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 03:12:44PM -0400, Jeff Dike wrote:
> On Mon, May 15, 2006 at 12:29:58PM -0300, Alberto Bertogli wrote:
> > Sure, here it is:
> > (gdb) disas stub_segv_handler
> 
> Sorry, I misread the error message and asked for the wrong thing.
> Your UML is seeing a process segfault during a system call, before the
> SIGTRAP expected at the end of the system call.  I don't know what's
> happening there.
> 
> Can you apply the following patch, which will just give you a register
> dump of the process, and send me the output?

Here it is. While the patch worked, it was for 2.6.16, and I'm using
2.6.17-rc4, I hope that's not a problem.


[42949373.940000] EXT3-fs: mounted filesystem with ordered data mode.
[42949373.940000] VFS: Mounted root (ext3 filesystem) readonly.
[42949374.050000] Stub registers -
[42949374.050000]       0 - 8
[42949374.050000]       1 - 400040
[42949374.050000]       2 - 40001530
[42949374.050000]       3 - 2
[42949374.050000]       4 - fffffffd
[42949374.050000]       5 - 7
[42949374.050000]       6 - 5
[42949374.050000]       7 - 37
[42949374.050000]       8 - 3
[42949374.050000]       9 - 20611
[42949374.050000]       10 - 0
[42949374.050000]       11 - 2d
[42949374.050000]       12 - 11
[42949374.050000]       13 - 7f7f8d4539
[42949374.050000]       14 - 0
[42949374.050000]       15 - ffffffffffffffff
[42949374.050000]       16 - 4000eae0
[42949374.050000]       17 - 33
[42949374.050000]       18 - 10246
[42949374.050000]       19 - 7f7f8d4498
[42949374.050000]       20 - 2b
[42949374.050000] Kernel panic - not syncing: Kernel mode fault at addr 0x0, ip 0x4000f349
[42949374.050000]
[42949374.050000] Modules linked in:
[42949374.050000] Pid: 1, comm: init Not tainted 2.6.17-rc4
[42949374.050000] RIP: 0033:[<000000004000f349>]
[42949374.050000] RSP: 0000007f7f8d4498  EFLAGS: 00000246
[42949374.050000] RAX: 0000000000000000 RBX: 0000007f7f8d44b0 RCX: ffffffffffffffff
[42949374.050000] RDX: 0000007f7f8d4770 RSI: 0000000040010900 RDI: 0000007f7f8d44b0
[42949374.050000] RBP: 0000000000402240 R08: 0000000000000000 R09: 0000000000000000
[42949374.050000] R10: 0000000000000064 R11: 0000000000000246 R12: 0000007f7f8d4640
[42949374.050000] R13: 0000000040001530 R14: 0000000000400040 R15: 0000000000000008
[42949374.050000] Call Trace:
[42949374.050000] 60433888:  [<6001a10a>] panic_exit+0x2a/0x50
[42949374.050000] 60433898:  [<60044acc>] notifier_call_chain+0x1c/0x30
[42949374.050000] 604338b8:  [<600348cf>] panic+0xcf/0x170
[42949374.050000] 60433918:  [<600285b4>] set_signals+0x14/0x30
[42949374.050000] 60433928:  [<6001947b>] handle_page_fault+0x1bb/0x270
[42949374.050000] 60433998:  [<600197b8>] segv+0x208/0x300
[42949374.050000] 60433a80:  [<60019530>] segv_handler+0x0/0x80
[42949374.050000] 60433a98:  [<600195ab>] segv_handler+0x7b/0x80
[42949374.050000] 60433ab8:  [<6002ca18>] sig_handler_common_skas+0xe8/0x140
[42949374.050000] 60433ae8:  [<6002873f>] sig_handler+0x5f/0x80
[42949374.050000] 60433c20:  [<6001b450>] copy_chunk_to_user+0x0/0x40
[42949374.050000] 60433c88:  [<6002b877>] ptrace_dump_regs+0x47/0x70
[42949374.050000] 60433dc0:  [<60014010>] init+0x0/0x170
[42949374.050000] 60433dd8:  [<6001a7a2>] new_thread_handler+0x102/0x140
[42949374.050000]

Please let me know if there's anything else you want me to try.

Thanks,
		Alberto




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
