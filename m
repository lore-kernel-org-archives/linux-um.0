Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOKix-0006MP-1h for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 May 2004 11:14:27 -0700
Received: from [217.138.31.253] (helo=ray.lwpuk.co.uk)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BOKiw-0005sz-Gp for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 May 2004 11:14:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by ray.lwpuk.co.uk (Postfix) with ESMTP id 1A4891EE9D
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 13 May 2004 18:24:11 +0000 (GMT)
Received: from pccw.com (host-212-158-213-142.bulldogdsl.com [212.158.213.142])
	by ray.lwpuk.co.uk (Postfix) with ESMTP id 128491EE98
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 13 May 2004 18:24:08 +0000 (GMT)
Message-ID: <40A3BB29.7050606@pccw.com>
From: Leigh Porter <leigh.porter@pccw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] UML kernel panic
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
Date: Thu, 13 May 2004 19:15:05 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hiya,

I have UML 2.6.4-1 on a stock SuSE 8.1 box (also tried on 8.1) running 
2.4.19

The system boots fine an dnetworking comes up and works. The system
starts sshd, apache etc however, when the system starts bind9 the
UML kernel panics. This only happens when networking has not been 
brought up,
with networking started named starts fine.

Kernel panic: Kernel mode fault at addr 0x4, ip 0xa0030643
 <6>SysRq : Show Regs

EIP: 0023:[<a0030643>] CPU: 0 Not tainted ESP: 002b:a0b8b8f4 EFLAGS: 
00010202
    Not tainted
EAX: 00000000 EBX: a1e56498 ECX: 00000001 EDX: a1e56504
ESI: a1e56498 EDI: a1c53990 EBP: a0b8b90c DS: 002b ES: 002b
Call Trace: [<a018345e>] [<a001c45f>] [<a008b5f8>] [<a0045b56>] [<a0030643>]
   [<a0037945>] [<a00379c7>] [<a0030643>] [<a001b600>] [<a0030643>] 
[<a001b76d>]
   [<a0030643>] [<a001bce0>] [<a0205505>] [<a00194dd>] [<a001bace>] 
[<a0030643>]
   [<a001ba22>] [<a001f9ac>] [<a001fa25>] [<a001bce0>] [<a02053d8>] 
[<a0030643>]
   [<a0205505>] [<a0019743>] [<a0031b68>] [<a0205505>] [<a00194dd>] 
[<a0205505>]
   [<a001956b>] [<a0205505>] [<a0205505>] [<a00194dd>] [<a0205505>] 
[<a0019648>]
   [<a0094756>] [<a0094935>] [<a0086199>] [<a00864aa>] [<a007a51c>] 
[<a006a4f2>]
   [<a006b69f>] [<a007787d>] [<a0044224>] [<a0045080>] [<a001952d>] 
[<a001947b>]
   [<a001884a>] [<a001e678>] [<a001a28e>] [<a0018a81>] [<a001e801>] 
[<a0016b5a>]
   [<a001f9ac>] [<a001f9f5>] [<a001bce0>] [<a02053d8>]


The gdb bt is:

(gdb) bt
#0  panic (fmt=0xa0257de0 "Kernel mode fault at addr 0x%lx, ip 0x%lx")
    at kernel/panic.c:58
#1  0xa001b76d in segv (address=4, ip=2684552771, is_write=0, is_user=0,
    sc=0xa0932f88) at arch/um/kernel/trap_kern.c:151
#2  0xa001bace in segv_handler (sig=11, regs=0xa0932f88)
    at arch/um/kernel/trap_user.c:67
#3  0xa001f9ac in sig_handler_common_tt (sig=11, sc_ptr=0x58)
    at arch/um/kernel/tt/trap_user.c:37
#4  0xa001bce0 in sig_handler (sig=0, sc=
      {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43,
__dsh = 0, edi = 2696380512, esi = 2716447384, ebp = 2714630412, esp =
2714630388, ebx = 2716447384, edx = 2716447492, ecx = 1, eax = 0, trapno =
14, err = 4, eip = 2684552771, cs = 35, __csh = 0, eflags = 66050,
esp_at_signal = 2714630388, ss = 43, __ssh = 0, fpstate = 0x0, oldmask =
201392128, cr2 = 4})
    at arch/um/kernel/trap_user.c:102
#5  <signal handler called>
#6  0xa0030643 in dump_fpu (regs=0x0, fpu=0xa1e9b298)
    at arch/um/sys-i386/ptrace.c:329
#7  0xa0094756 in elf_dump_thread_status (signr=6, p=0xa0b78060,
    thread_list=0xa1cdf9f4) at include/linux/elfcore.h:115
(gdb)

I can supply a disk image and kernel if required.

Thanks,
Leigh




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
