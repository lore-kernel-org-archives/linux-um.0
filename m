Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPmMs-0006mw-DD for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 12:02:10 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DPmMq-0001gM-FH for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 12:02:10 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Segfault 2.6.11-rc1-mm1
References: <200504241945.51674.lil_tux@web.de>
In-Reply-To: <200504241945.51674.lil_tux@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504242059.15078.blaisorblade@yahoo.it>
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
Date: Sun, 24 Apr 2005 20:59:14 +0200
To: user-mode-linux-devel@lists.sourceforge.net, lil_tux@web.de

On Sunday 24 April 2005 19:45, Heiko Przybyl wrote:
> Same problem here (i'm using gentoo, too), but with 2.6.11 and 2.6.12-rc3
> (both vanilla-sources from kernel.org)
>
> gdb:
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x6023a788 in __libc_setup_tls () at swab.h:134
> 134     {
> (gdb) tb
> Breakpoint 1 at 0x6023a788: file swab.h, line 134.
> (gdb) bt
> #0  0x6023a788 in __libc_setup_tls () at swab.h:134

> #7  0x20202820 in ?? ()
> #8  0x00000000 in ?? ()
> #9  0x00000000 in ?? ()
> #10 0x20202020 in ?? ()
> #11 0x00000884 in ?? ()
> #12 0x00000004 in ?? ()
> #13 0x00000004 in ?? ()
> #14 0x00000084 in ?? ()
> #15 0x00000084 in ?? ()

> #23 0xbfb143a8 in ?? ()
> #24 0x0002060c in ?? ()
> #25 0x00000003 in ?? ()
> #26 0x00000005 in ?? ()
> #27 0x6023a957 in __pthread_initialize_minimal () at swab.h:134
> #28 0x00000014 in ?? ()
> #29 0x00000004 in ?? ()
> #30 0x60254841 in uname () at swab.h:134
> #31 0x6023a2f9 in __libc_start_main () at swab.h:134
> ---Type <return> to continue, or q <return> to quit---
> #47 0x756e694c in ?? ()

> #63 0x726f7400 in ?? ()
> #64 0x746e656d in ?? ()
> #65 0x732d6465 in ?? ()
> #66 0x006c756f in ?? ()

> ---Type <return> to continue, or q <return> to quit---

> #79 0x2e320000 in ?? ()
> #80 0x32312e36 in ?? ()
> #81 0x58755a2d in ?? ()

> #96 0x65572031 in ?? ()
> #97 0x70412064 in ?? ()
> #98 0x20362072 in ?? ()
> #99 0x343a3931 in ?? ()
> #100 0x31313a39 in ?? ()
> #101 0x53454320 in ?? ()
> #102 0x30322054 in ?? ()
> #103 0x00003530 in ?? ()
> #112 0x36383669 in ?? ()
> #113 0x00000000 in ?? ()
> ---Type <return> to continue, or q <return> to quit---

> #128 0x6f6e2800 in ?? ()
> #129 0x0029656e in ?? ()


> #170 0x60066021 in _start () at proc_fs.h:183
> #171 0x60067c20 in last_ditch_exit () at main.c:79
> Previous frame inner to this frame (corrupt stack?)
>
> strace:
>
> execve("./linux", ["./linux"], [/* 60 vars */]) = 0
> uname({sys="Linux", node="tormented-soul", ...}) = 0
> brk(0x612070ff)                         = 0xa0389000
> --- SIGSEGV (Segmentation fault) @ 0 (0) ---
> +++ killed by SIGSEGV +++

> Could be the problem the position independent code or native posix thread
> library? I've got both enabled, but i don't want to recompile my whole
> system..
Well, I have 
> It doesn't matter if I turn on the 2G/2G or not. Or doesn't uml work
> without skas, anymore?
Well, playing with all possible settings of MODE_TT, MODE_SKAS and 
STATIC_LINKING is welcome.
> Thx, Heiko.

> > --  There are no patches that I can think of.  If it"s any help, I"m
> >  running gentoo.  I"m listing the output of gcc and libc in case my
> >  configuration of them might be a problem.
> >
> >  gcc --version
> >  gcc (GCC) 3.3.4 20040623 (Gentoo Hardened Linux 3.3.4-r1, ssp-3.3.2-2,
> >  pie-8.7.6)
Hmm, Gentoo Hardened... I'd like to cross-check this with the other report, 
but unfortunately I cannot find it. Can you forward it me, please?
> >  /lib/libc.so.6
> >  Available extensions:
> >   GNU libio by Per Bothner
> >   crypt add-on version 2.1 by Michael Glad and others
> >   Native POSIX Threads Library by Ulrich Drepper et al
> >   BIND-8.2.3-T5B
> >   NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
> >  Thread-local storage support included.
> >
> >
> >  strace ./linux
> >  execve("./linux", ["./linux"], [/* 35 vars */]) = 0
> >  uname({sys="Linux", node="sentient", ...}) = 0
> >  brk(0)                                  = 0xa0360000
> >  brk(0xa0361f2c)                         = 0xa0361f2c
> >  set_thread_area({entry_number:-1 -> 6, base_addr:0xa0361ef8,
> >  limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
> >  limit_in_pages:1, seg_not_present:0, useable:1}) = 0
> >  --- SIGSEGV (Segmentation fault) @ 0 (0) ---
> >  +++ killed by SIGSEGV +++


-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
