Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Aft2T-00072x-RF for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 19:46:53 -0800
Received: from adsl-b4-97-138.telepac.pt ([81.193.97.138]
	helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aft2T-0006fD-3J for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 19:46:53 -0800
Message-ID: <40021933.5090604@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML running on host-kernel 2.6.0 with NPTL-enabled
	glibc problem
References: <3FFE6FE3.8090303@vgertech.com>
	<200401102025.i0AKPXeA004382@car.linuxhacker.ru>
In-Reply-To: <200401102025.i0AKPXeA004382@car.linuxhacker.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 12 Jan 2004 03:49:07 +0000
To: Oleg Drokin <green@linuxhacker.ru>
Cc: user-mode-linux-devel@lists.sourceforge.net



Oleg Drokin wrote:
> Hello!
> 
> Nuno Silva <nuno.silva@vgertech.com> wrote:
> 
> NS> I've been trying for days and made lots of tests and it seems that the
> NS> 2.4 UML binary can't run on a host with 2.6 kernel and nptl-enabled glibc.
> 
> Hm. I guess you are running some sort of old uml code.
> The fix was oneliner and included long ago. See the patch below.
> Apply it and then recompile.
> 
> I use 2.6.1 + glibc 2.3.2-101 from Fedora Core 1,
> I hope this is new enough? ;)

Thanks, but this patch is in my tree (2.4.23-um1). And, as BlaisorBlade 
mentions in the next message, I'm trying to build a dynamic UML -- This 
is mainly to try to take advantage of sysenter/sysexit. Sysenter could 
speedup UML a bit :)

Also, the version of glibc itself says nothing about this subject. You 
must make sure that you're using a nptl-tls-enabled one. These optimized 
libraries are usually in /lib/tls/i686/cmov/* or something similar. One 
nice way to verify is ldd:

ldd on my debian sid instalation:
# ldd ./linux
         libutil.so.1 => /lib/tls/i686/cmov/libutil.so.1 (0x40018000)
         libc.so.6 => /lib/tls/i686/cmov/libc.so.6 (0x4001b000)
         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
#

ldd in my chroot (only) with optimized glibc:
# ldd ./linux
         linux-gate.so.1 =>  (0xffffe000)
         libutil.so.1 => /lib/libutil.so.1 (0x40019000)
         libc.so.6 => /lib/libc.so.6 (0x4001c000)
         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
#

That "linux-gate" thing is the system call multiplexer that enables 
sysenter.

DISCLAIMER: I'm no expert in this linker/sysenter/glibc magic so I might 
be wrong. The fact is that ./linux doesn't run when ldd reports 
"linux-gate" in it's output.

I'll try BlaisorBlade's /arch/um/dyn.lds.S patch next.

Thanks,
Nuno Silva


> 
> Bye,
>     Oleg
> 
> --- linux-2.4.20.orig/arch/um/link.ld.in	2003-10-25 00:35:59.000000000 +0400
> +++ linux-2.4.20/arch/um/link.ld.in	2003-10-25 00:36:02.000000000 +0400
> @@ -6,7 +6,6 @@
>  {
>    . = START() + SIZEOF_HEADERS;
>  
> -  . = ALIGN(4096);
>    __binary_start = .;
>  ifdef(`MODE_TT', `
>    .thread_private : {
> 



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
