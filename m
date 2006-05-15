Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fff1Q-0001pA-0X for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 May 2006 08:30:12 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fff1Q-0000Er-1q for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 May 2006 08:30:12 -0700
Received: from wx-out-0102.google.com ([66.249.82.203])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fff1O-0000Wb-Ce
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 May 2006 08:30:12 -0700
Received: by wx-out-0102.google.com with SMTP id h26so694498wxd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 15 May 2006 08:30:03 -0700 (PDT)
From: Alberto Bertogli <albertito@gmail.com>
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on
	x86-64
Message-ID: <20060515152958.GA4553@gmail.com>
References: <20060514182541.GA4980@gmail.com>
	<20060515033919.GD21383@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515033919.GD21383@ccure.user-mode-linux.org>
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
Date: Mon, 15 May 2006 12:29:58 -0300
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 11:39:19PM -0400, Jeff Dike wrote:
> On Sun, May 14, 2006 at 03:25:41PM -0300, Alberto Bertogli wrote:
> > So I copied them from sysdeps/x86_64/jmpbuf-offsets.h, and building went
> > on. Probably, the same happens under i386.
> 
> The current patch for this is http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17-rc4/patches/jmpbuf
> 
> I need to redo it, but that works for now.

Thanks!


> > It begins to boot, but panics right after mounting root:
> > 
> > [42949373.800000] kjournald starting.  Commit interval 5 seconds
> > [42949373.800000] EXT3-fs: mounted filesystem with ordered data mode.
> > [42949373.800000] VFS: Mounted root (ext3 filesystem) readonly.
> > [42949373.800000] Kernel panic - not syncing: handle_trap - failed to wait at end of syscall, errno = 0, status = 2943
> 
> This is a segfault happening when it shouldn't.
> 
> Can you disassemble stub_segv_handler and send me the output?

Sure, here it is:
(gdb) disas stub_segv_handler
Dump of assembler code for function stub_segv_handler:
0x000000006027c0e0 <stub_segv_handler+0>:       mov    %rdx,%r8
0x000000006027c0e3 <stub_segv_handler+3>:       mov    0xd8(%r8),%rax
0x000000006027c0ea <stub_segv_handler+10>:      mov    $0x7fbffff000,%rdx
0x000000006027c0f4 <stub_segv_handler+20>:      mov    %rax,0x8(%rdx)
0x000000006027c0f8 <stub_segv_handler+24>:      mov    0xc0(%r8),%rax
0x000000006027c0ff <stub_segv_handler+31>:      mov    %eax,(%rdx)
0x000000006027c101 <stub_segv_handler+33>:      mov    0xc8(%r8),%rax
0x000000006027c108 <stub_segv_handler+40>:      mov    %eax,0x10(%rdx)
0x000000006027c10b <stub_segv_handler+43>:      mov    $0x27,%eax
0x000000006027c110 <stub_segv_handler+48>:      syscall
0x000000006027c112 <stub_segv_handler+50>:      mov    $0x3e,%edx
0x000000006027c117 <stub_segv_handler+55>:      movslq %eax,%rdi
0x000000006027c11a <stub_segv_handler+58>:      mov    $0xa,%esi
0x000000006027c11f <stub_segv_handler+63>:      mov    %rdx,%rax
0x000000006027c122 <stub_segv_handler+66>:      syscall
0x000000006027c124 <stub_segv_handler+68>:      mov    %r8,%rsp
0x000000006027c127 <stub_segv_handler+71>:      mov    $0xf,%rax
0x000000006027c12e <stub_segv_handler+78>:      syscall
0x000000006027c130 <stub_segv_handler+80>:      retq
End of assembler dump.


Please let me know if you need anything else.

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
