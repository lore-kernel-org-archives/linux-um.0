Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPlEY-0003bT-6J for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 10:49:30 -0700
Received: from smtp05.web.de ([217.72.192.209])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1DPlEX-0003by-7u
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 10:49:30 -0700
Received: from [217.184.32.149] (helo=tormented-soul)
	by smtp05.web.de with asmtp (TLSv1:EXP1024-RC4-SHA:128)
	(WEB.DE 4.105 #275) id 1DPlEL-0002OB-00
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 19:49:18 +0200
From: Heiko Przybyl <lil_tux@web.de>
Reply-To: lil_tux@web.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504241945.51674.lil_tux@web.de>
Subject: [uml-devel] Re: Segfault 2.6.11-rc1-mm1
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
Date: Sun, 24 Apr 2005 19:45:51 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Same problem here (i'm using gentoo, too), but with 2.6.11 and 2.6.12-rc3 
(both vanilla-sources from kernel.org)

gdb:

Program received signal SIGSEGV, Segmentation fault.
0x6023a788 in __libc_setup_tls () at swab.h:134
134     {
(gdb) tb
Breakpoint 1 at 0x6023a788: file swab.h, line 134.
(gdb) bt
#0  0x6023a788 in __libc_setup_tls () at swab.h:134
#1  0x00000000 in ?? ()
#2  0x00000000 in ?? ()
#3  0x00000000 in ?? ()
#4  0x00000000 in ?? ()
#5  0x00000000 in ?? ()
#6  0x00000000 in ?? ()
#7  0x20202820 in ?? ()
#8  0x00000000 in ?? ()
#9  0x00000000 in ?? ()
#10 0x20202020 in ?? ()
#11 0x00000884 in ?? ()
#12 0x00000004 in ?? ()
#13 0x00000004 in ?? ()
#14 0x00000084 in ?? ()
#15 0x00000084 in ?? ()
#16 0x00000000 in ?? ()
#17 0x00000000 in ?? ()
#18 0x00000000 in ?? ()
#19 0x00000000 in ?? ()
#20 0x00000000 in ?? ()
#21 0x00000000 in ?? ()
#22 0x00000000 in ?? ()
#23 0xbfb143a8 in ?? ()
#24 0x0002060c in ?? ()
#25 0x00000003 in ?? ()
#26 0x00000005 in ?? ()
#27 0x6023a957 in __pthread_initialize_minimal () at swab.h:134
#28 0x00000014 in ?? ()
#29 0x00000004 in ?? ()
#30 0x60254841 in uname () at swab.h:134
#31 0x6023a2f9 in __libc_start_main () at swab.h:134
#32 0x00000000 in ?? ()
#33 0x00000000 in ?? ()
#34 0x00000000 in ?? ()
#35 0x00000000 in ?? ()
#36 0x00000000 in ?? ()
#37 0x00000000 in ?? ()
---Type <return> to continue, or q <return> to quit---
#38 0x00000000 in ?? ()
#39 0x00000000 in ?? ()
#40 0x00000000 in ?? ()
#41 0x00000000 in ?? ()
#42 0x00000000 in ?? ()
#43 0x00000000 in ?? ()
#44 0x00000000 in ?? ()
#45 0x00000000 in ?? ()
#46 0x00000000 in ?? ()
#47 0x756e694c in ?? ()
#48 0x00000078 in ?? ()
#49 0x00000000 in ?? ()
#50 0x00000000 in ?? ()
#51 0x00000000 in ?? ()
#52 0x00000000 in ?? ()
#53 0x00000000 in ?? ()
#54 0x00000000 in ?? ()
#55 0x00000000 in ?? ()
#56 0x00000000 in ?? ()
#57 0x00000000 in ?? ()
#58 0x00000000 in ?? ()
#59 0x00000000 in ?? ()
#60 0x00000000 in ?? ()
#61 0x00000000 in ?? ()
#62 0x00000000 in ?? ()
#63 0x726f7400 in ?? ()
#64 0x746e656d in ?? ()
#65 0x732d6465 in ?? ()
#66 0x006c756f in ?? ()
#67 0x00000000 in ?? ()
#68 0x00000000 in ?? ()
#69 0x00000000 in ?? ()
#70 0x00000000 in ?? ()
#71 0x00000000 in ?? ()
#72 0x00000000 in ?? ()
#73 0x00000000 in ?? ()
#74 0x00000000 in ?? ()
#75 0x00000000 in ?? ()
---Type <return> to continue, or q <return> to quit---
#76 0x00000000 in ?? ()
#77 0x00000000 in ?? ()
#78 0x00000000 in ?? ()
#79 0x2e320000 in ?? ()
#80 0x32312e36 in ?? ()
#81 0x58755a2d in ?? ()
#82 0x00005a65 in ?? ()
#83 0x00000000 in ?? ()
#84 0x00000000 in ?? ()
#85 0x00000000 in ?? ()
#86 0x00000000 in ?? ()
#87 0x00000000 in ?? ()
#88 0x00000000 in ?? ()
#89 0x00000000 in ?? ()
#90 0x00000000 in ?? ()
#91 0x00000000 in ?? ()
#92 0x00000000 in ?? ()
#93 0x00000000 in ?? ()
#94 0x00000000 in ?? ()
#95 0x23000000 in ?? ()
#96 0x65572031 in ?? ()
#97 0x70412064 in ?? ()
#98 0x20362072 in ?? ()
#99 0x343a3931 in ?? ()
#100 0x31313a39 in ?? ()
#101 0x53454320 in ?? ()
#102 0x30322054 in ?? ()
#103 0x00003530 in ?? ()
#104 0x00000000 in ?? ()
#105 0x00000000 in ?? ()
#106 0x00000000 in ?? ()
#107 0x00000000 in ?? ()
#108 0x00000000 in ?? ()
#109 0x00000000 in ?? ()
#110 0x00000000 in ?? ()
#111 0x00000000 in ?? ()
#112 0x36383669 in ?? ()
#113 0x00000000 in ?? ()
---Type <return> to continue, or q <return> to quit---
#114 0x00000000 in ?? ()
#115 0x00000000 in ?? ()
#116 0x00000000 in ?? ()
#117 0x00000000 in ?? ()
#118 0x00000000 in ?? ()
#119 0x00000000 in ?? ()
#120 0x00000000 in ?? ()
#121 0x00000000 in ?? ()
#122 0x00000000 in ?? ()
#123 0x00000000 in ?? ()
#124 0x00000000 in ?? ()
#125 0x00000000 in ?? ()
#126 0x00000000 in ?? ()
#127 0x00000000 in ?? ()
#128 0x6f6e2800 in ?? ()
#129 0x0029656e in ?? ()
#130 0x00000000 in ?? ()
#131 0x00000000 in ?? ()
#132 0x00000000 in ?? ()
#133 0x00000000 in ?? ()
#134 0x00000000 in ?? ()
#135 0x00000000 in ?? ()
#136 0x00000000 in ?? ()
#137 0x00000000 in ?? ()
#138 0x00000000 in ?? ()
#139 0x00000000 in ?? ()
#140 0x00000000 in ?? ()
#141 0x00000000 in ?? ()
#142 0x00000000 in ?? ()
#143 0x00000000 in ?? ()
#144 0x00000000 in ?? ()
#145 0x00000000 in ?? ()
#146 0x00000000 in ?? ()
#147 0x00000000 in ?? ()
#148 0x00000000 in ?? ()
#149 0x00000000 in ?? ()
#150 0x00000000 in ?? ()
#151 0x00000000 in ?? ()
---Type <return> to continue, or q <return> to quit---
#152 0x00000000 in ?? ()
#153 0x00000000 in ?? ()
#154 0x00000000 in ?? ()
#155 0x00000000 in ?? ()
#156 0x00000000 in ?? ()
#157 0x00000000 in ?? ()
#158 0x00000000 in ?? ()
#159 0x00000000 in ?? ()
#160 0x00000000 in ?? ()
#161 0x00000000 in ?? ()
#162 0x00000000 in ?? ()
#163 0x00000000 in ?? ()
#164 0x00000000 in ?? ()
#165 0x00000000 in ?? ()
#166 0x00000000 in ?? ()
#167 0x00000001 in ?? ()
#168 0x00000000 in ?? ()
#169 0x00000000 in ?? ()
#170 0x60066021 in _start () at proc_fs.h:183
#171 0x60067c20 in last_ditch_exit () at main.c:79
Previous frame inner to this frame (corrupt stack?)

strace:

execve("./linux", ["./linux"], [/* 60 vars */]) = 0
uname({sys="Linux", node="tormented-soul", ...}) = 0
brk(0x612070ff)                         = 0xa0389000
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++

Could be the problem the position independent code or native posix thread 
library? I've got both enabled, but i don't want to recompile my whole 
system...
It doesn't matter if I turn on the 2G/2G or not. Or doesn't uml work without 
skas, anymore?

Thx, Heiko.

> --  There are no patches that I can think of.  If it"s any help, I"m
>  running gentoo.  I"m listing the output of gcc and libc in case my
>  configuration of them might be a problem.
>  
>  gcc --version
>  gcc (GCC) 3.3.4 20040623 (Gentoo Hardened Linux 3.3.4-r1, ssp-3.3.2-2,
>  pie-8.7.6)
>  
>  
>  /lib/libc.so.6
>  Available extensions:
>   GNU libio by Per Bothner
>   crypt add-on version 2.1 by Michael Glad and others
>   Native POSIX Threads Library by Ulrich Drepper et al
>   BIND-8.2.3-T5B
>   NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
>  Thread-local storage support included.
>  
>  
>  strace ./linux
>  execve("./linux", ["./linux"], [/* 35 vars */]) = 0
>  uname({sys="Linux", node="sentient", ...}) = 0
>  brk(0)                                  = 0xa0360000
>  brk(0xa0361f2c)                         = 0xa0361f2c
>  set_thread_area({entry_number:-1 -> 6, base_addr:0xa0361ef8,
>  limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
>  limit_in_pages:1, seg_not_present:0, useable:1}) = 0
>  --- SIGSEGV (Segmentation fault) @ 0 (0) ---
>  +++ killed by SIGSEGV +++
 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
