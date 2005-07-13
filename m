Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DspDn-0004aX-LT	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 14:56:51 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1DspDn-0008Sk-EU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 14:56:51 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
References: <200507122346.40320.rob@landley.net>
	<20050713121520.GA4460@ccure.user-mode-linux.org>
In-Reply-To: <20050713121520.GA4460@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507131656.37695.rob@landley.net>
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
Date: Wed, 13 Jul 2005 16:56:37 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 13 July 2005 07:15, Jeff Dike wrote:
> On Tue, Jul 12, 2005 at 11:46:40PM -0500, Rob Landley wrote:
> > VFS: Mounted root (hostfs filesystem) readonly.
> > Kernel panic - not syncing: get_skas_faultinfo : failed to wait for
> > SIGUSR1/SIGTRAP, pid = 7944, n = 7944, errno = 0, status = 0xb
>
> A bunch of people are seeing this.  What's supposed to happen when the
> segfault hits is that it's supposed to continue into the segfault handler.
>
> The fact that it is terminating with SIGSEGV immediately after stopping
> with SIGSEGV means that the signal handler couldn't be delivered for some
> reason.
>
> Either the signal stack or handler aren't present, or the stack isn't
> writable.
>
> So, maybe the stubs aren't being set up properly.  Can you gdb the thing,
> put a breakpoint in get_skas_faultinfo, and look at /proc/<pid>/maps, where
> pid is the pid being ptraced?
>
> The last two pages, at 0x7fffe000 and 7ffff000 are the stubs.  The first
> should be mapped in from the temp VM file with permissions r-x, and the
> second should be anonymous with permissions rwx.
>
>     Jeff

It broke with SIGUSR1 in __kernel_vsyscall(), which I assume is close enough.  
(I typed "go" until it reached the end and it never broke in 
get_skas_faultinfo, but then my gdb is a bit shaky so I'm possibly doing 
something wrong.)

Here's the maps:

landley@driftwood:/proc/7972$ cat maps
08048000-08132000 rwxp 00000000 03:05 
2801050    /home/landley/linux-2.6.12.2/linux
08132000-08165000 rw-p 08132000 00:00 0
08800000-0a000000 rw-s 00800000 03:05 4922001    /tmp/vm_file-gYGr1Q (deleted)
b7eb7000-b7eb9000 rw-p b7eb7000 00:00 0
b7eb9000-b7fdb000 r-xp 00000000 03:05 
2371242    /lib/tls/i686/cmov/libc-2.3.2.so
b7fdb000-b7fe4000 rw-p 00121000 03:05 
2371242    /lib/tls/i686/cmov/libc-2.3.2.so
b7fe4000-b7fe6000 rw-p b7fe4000 00:00 0
b7fe6000-b7fe8000 r-xp 00000000 03:05 
2371260    /lib/tls/i686/cmov/libutil-2.3.2.so
b7fe8000-b7fe9000 rw-p 00001000 03:05 
2371260    /lib/tls/i686/cmov/libutil-2.3.2.so
b7fe9000-b7feb000 rw-p b7fe9000 00:00 0
b7feb000-b8000000 r-xp 00000000 03:05 2371080    /lib/ld-2.3.2.so
b8000000-b8001000 rw-p 00015000 03:05 2371080    /lib/ld-2.3.2.so
bffeb000-c0000000 rwxp bffeb000 00:00 0
ffffe000-fffff000 ---p 00000000 00:00 0

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
