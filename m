Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bf12o-0000YS-Oo for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jun 2004 11:39:54 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bf12n-0002br-De for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jun 2004 11:39:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by sindar.exse.net (Postfix) with ESMTP id AE5B620DA5
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 28 Jun 2004 20:39:49 +0200 (CEST)
Received: from sindar.exse.net ([127.0.0.1])
	by localhost (sindar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25192-07
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 28 Jun 2004 20:39:48 +0200 (CEST)
Received: from [10.0.2.8] (port-212-202-40-228.dynamic.qsc.de [212.202.40.228])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by sindar.exse.net (Postfix) with ESMTP id A97FA2E12
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 28 Jun 2004 20:39:48 +0200 (CEST)
Mime-Version: 1.0 (Apple Message framework v618)
Content-Transfer-Encoding: 7bit
Message-Id: <87496858-C932-11D8-9806-000393C969F4@exse.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
From: =?ISO-8859-1?Q?Sebastian_B=F6hm?= <seb@exse.net>
Subject: [uml-devel] uml crash
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
Date: Mon, 28 Jun 2004 20:39:46 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I applied that "[uml-devel] Patch for arch/um/kernel/trap_kern.c to fix 
bad panic"-patch, but now my easiely reproduceable mysql-server-start 
crash seems to produce an endless bt.


Breakpoint 1, panic (fmt=0x0) at panic.c:58
58              machine_paniced = 1;
(gdb) bt
#0  panic (fmt=0x0) at panic.c:58
#1  0xa008e02b in segv (address=3746590716, ip=778989417, is_write=2,
     is_user=0, sc=0x0) at trap_kern.c:142
#2  0xa008e3b7 in segv_handler (sig=11, regs=0xa036c274) at 
trap_user.c:67
#3  0xa0090e84 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
     at trap_user.c:35
#4  0xa008e3e8 in sig_handler (sig=0, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2, esi = 8, ebp = 2687959356, esp = 2687959332, 
ebx = 26, edx = 2687960140, ecx = 2687960140, eax = 3486502863, trapno 
= 14, err = 7, eip = 2684937237, cs = 35, __csh = 0, eflags = 66182, 
esp_at_signal = 2687959332, ss = 43, __ssh = 0, fpstate = 0x0, oldmask 
= 167772160, cr2 = 3746590716})
     at trap_user.c:101
#5  <signal handler called>
#6  0xa008e415 in alarm_handler (sig=26, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2, esi = 8, ebp = 2687960100, esp = 2687960092, 
ebx = 1, edx = 2687960140, ecx = 2687960140, eax = 0, trapno = 14, err 
= 7, eip = 1074022116, cs = 35, __csh = 0, eflags = 658, esp_at_signal 
= 2687960092, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 134218752, 
cr2 = 3486502891}) at trap_user.c:110
#7  <signal handler called>
#8  0x400446e4 in sigprocmask () from /lib/libc.so.6
#9  0xa008c3a5 in set_signals (enable=1) at signal_user.c:117
---Type <return> to continue, or q <return> to quit---
#10 0xa0016617 in force_sig_info (sig=11, info=0xa037052c, t=0xa0370000)
     at signal.c:607
#11 0xa008e0cb in bad_segv (address=2687960140, ip=3486502863,
     is_write=-1607007156) at trap_kern.c:166
#12 0xa008e324 in segv_handler (sig=11, regs=0xa0370274) at 
trap_user.c:54
#13 0xa0090e84 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
     at trap_user.c:35
#14 0xa008e3e8 in sig_handler (sig=0, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2, esi = 3486502891, ebp = 2687961420, esp = 
2687961348, ebx = 3486502863, edx = 0, ecx = 2684354560, eax = 
3486502891, trapno = 14, err = 7, eip = 2684935257, cs = 35, __csh = 0, 
eflags = 66194, esp_at_signal = 2687961348, ss = 43, __ssh = 0, fpstate 
= 0x0, oldmask = 134217728, cr2 = 3486502891})
     at trap_user.c:101
#15 <signal handler called>
#16 0xa008dc59 in handle_page_fault (address=3486502891, ip=3486502863,
     is_write=2, is_user=0, code_out=0xa037099c) at rwsem.h:101
#17 0xa008df36 in segv (address=3486502891, ip=3486502863, is_write=2,
     is_user=0, sc=0xcfcfcfeb) at trap_kern.c:131
#18 0xa008e3b7 in segv_handler (sig=11, regs=0xa0370274) at 
trap_user.c:67
#19 0xa0090e84 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
     at trap_user.c:35
#20 0xa008e3e8 in sig_handler (sig=-808464405, sc=
---Type <return> to continue, or q <return> to quit---
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2, esi = 3486502891, ebp = 2687962564, esp = 
2687962492, ebx = 3486502863, edx = 0, ecx = 2684354560, eax = 
3486502891, trapno = 14, err = 7, eip = 2684935257, cs = 35, __csh = 0, 
eflags = 66194, esp_at_signal = 2687962492, ss = 43, __ssh = 0, fpstate 
= 0x0, oldmask = 134217728, cr2 = 3486502891})
     at trap_user.c:101
#21 <signal handler called>
#22 0xa008dc59 in handle_page_fault (address=3486502891, ip=3486502863,
     is_write=2, is_user=0, code_out=0xa0370e14) at rwsem.h:101
#23 0xa008df36 in segv (address=3486502891, ip=3486502863, is_write=2,
     is_user=0, sc=0xcfcfcfeb) at trap_kern.c:131
#24 0xa008e3b7 in segv_handler (sig=11, regs=0xa0370274) at 
trap_user.c:67
#25 0xa0090e84 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
     at trap_user.c:35
#26 0xa008e3e8 in sig_handler (sig=-808464405, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2, esi = 3486502891, ebp = 2687963708, esp = 
2687963636, ebx = 3486502863, edx = 0, ecx = 2684354560, eax = 
3486502891, trapno = 14, err = 7, eip = 2684935257, cs = 35, __csh = 0, 
eflags = 66194, esp_at_signal = 2687963636, ss = 43, __ssh = 0, fpstate 
= 0x0, oldmask = 134217728, cr2 = 3486502891})
     at trap_user.c:101
#27 <signal handler called>
#28 0xa008dc59 in handle_page_fault (address=3486502891, ip=3486502863,
#31 0xa0090e84 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
     at trap_user.c:35
#32 0xa008e3e8 in sig_handler (sig=-808464405, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2, esi = 3486502891, ebp = 2687964852, esp = 
2687964780, ebx = 3486502863, edx = 0, ecx = 2684354560, eax = 
3486502891, trapno = 14, err = 7, eip = 2684935257, cs = 35, __csh = 0, 
eflags = 66198, esp_at_signal = 2687964780, ss = 43, __ssh = 0, fpstate 
= 0x0, oldmask = 134217728, cr2 = 3486502891})
     at trap_user.c:101
#33 <signal handler called>
#34 0xa008dc59 in handle_page_fault (address=3486502891, ip=3486502863,
     is_write=2, is_user=0, code_out=0xa0371704) at rwsem.h:101
#35 0xa008df36 in segv (address=3486502891, ip=3486502863, is_write=2,
     is_user=0, sc=0xcfcfcfeb) at trap_kern.c:131
#36 0xa008e3b7 in segv_handler (sig=11, regs=0xa0370274) at 
trap_user.c:67
#37 0xa0090e84 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
     at trap_user.c:35
#38 0xa008e3e8 in sig_handler (sig=-808464405, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh ---Type <return> to continue, or q <return> to quit---
= 0, edi = 2, esi = 3486502891, ebp = 2687965996, esp = 2687965924, ebx 
= 3486502863, edx = 0, ecx = 2684354560, eax = 3486502891, trapno = 14, 
err = 7, eip = 2684935257, cs = 35, __csh = 0, eflags = 66198, 
esp_at_signal = 2687965924, ss = 43, __ssh = 0, fpstate = 0x0, oldmask 
= 134217728, cr2 = 3486502891})
     at trap_user.c:101
#39 <signal handler called>
#40 0xa008dc59 in handle_page_fault (address=3486502891, ip=3486502863,
     is_write=2, is_user=0, code_out=0xa0371b7c) at rwsem.h:101
#41 0xa008df36 in segv (address=3486502891, ip=3486502863, is_write=2,
     is_user=0, sc=0xcfcfcfeb) at trap_kern.c:131
#42 0xa008e3b7 in segv_handler (sig=11, regs=0xa0370274) at 
trap_user.c:67
#43 0xa0090e84 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
     at trap_user.c:35
#44 0xa008e3e8 in sig_handler (sig=-808464405, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2, esi = 3486502891, ebp = 2687967140, esp = 
2687967068, ebx = 3486502863, edx = 0, ecx = 2684354560, eax = 
3486502891, trapno = 14, err = 7, eip = 2684935257, cs = 35, __csh = 0, 
eflags = 66198, esp_at_signal = 2687967068, ss = 43, __ssh = 0, fpstate 
= 0x0, oldmask = 134217728, cr2 = 3486502891})
     at trap_user.c:101
#45 <signal handler called>
#46 0xa008dc59 in handle_page_fault (address=3486502891, ip=3486502863,
     is_write=2, is_user=0, code_out=0xa0371ff4) at rwsem.h:101
---Type <return> to continue, or q <return> to quit---
#47 0xa008df36 in segv (address=3486502891, ip=3486502863, is_write=2,
     is_user=0, sc=0xcfcfcfeb) at trap_kern.c:131
#48 0xa008e3b7 in segv_handler (sig=11, regs=0xa0370274) at 
trap_user.c:67
#49 0xa0090e84 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
     at trap_user.c:35
#50 0xa008e3e8 in sig_handler (sig=-808464405, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2, esi = 3486502891, ebp = 2687968284, esp = 
2687968212, ebx = 3486502863, edx = 0, ecx = 2684354560, eax = 
3486502891, trapno = 14, err = 7, eip = 2684935257, cs = 35, __csh = 0, 
eflags = 66198, esp_at_signal = 2687968212, ss = 43, __ssh = 0, fpstate 
= 0x0, oldmask = 134217728, cr2 = 3486502891})
     at trap_user.c:101
#51 <signal handler called>
#52 0xa008dc59 in handle_page_fault (address=3486502891, ip=3486502863,
     is_write=2, is_user=0, code_out=0xa037246c) at rwsem.h:101
#53 0xa008df36 in segv (address=3486502891, ip=3486502863, is_write=2,
     is_user=0, sc=0xcfcfcfeb) at trap_kern.c:131
#54 0xa008e3b7 in segv_handler (sig=11, regs=0xa0370274) at 
trap_user.c:67
#55 0xa0090e84 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
     at trap_user.c:35
#56 0xa008e3e8 in sig_handler (sig=-808464405, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2, esi = 3486502891, ebp = 2687969428, esp = 
2687969356, ebx = 348650---Type <return> to continue, or q <return> to 
quit---
2863, edx = 0, ecx = 2684354560, eax = 3486502891, trapno = 14, err = 
7, eip = 2684935257, cs = 35, __csh = 0, eflags = 66194, esp_at_signal 
= 2687969356, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 134217728, 
cr2 = 3486502891})
     at trap_user.c:101
#57 <signal handler called>
#58 0xa008dc59 in handle_page_fault (address=3486502891, ip=3486502863,
     is_write=2, is_user=0, code_out=0xa03728e4) at rwsem.h:101
#59 0xa008df36 in segv (address=3486502891, ip=3486502863, is_write=2,
     is_user=0, sc=0xcfcfcfeb) at trap_kern.c:131
#60 0xa008e3b7 in segv_handler (sig=11, regs=0xa0370274) at 
trap_user.c:67
#61 0xa0090e84 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
     at trap_user.c:35
#62 0xa008e3e8 in sig_handler (sig=-808464405, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2, esi = 3486502891, ebp = 2687970572, esp = 
2687970500, ebx = 3486502863, edx = 0, ecx = 2684354560, eax = 
3486502891, trapno = 14, err = 7, eip = 2684935257, cs = 35, __csh = 0, 
eflags = 66194, esp_at_signal = 2687970500, ss = 43, __ssh = 0, fpstate 
= 0x0, oldmask = 134217728, cr2 = 3486502891})
     at trap_user.c:101
#63 <signal handler called>
#64 0xa008dc59 in handle_page_fault (address=3486502891, ip=3486502863,
     is_write=2, is_user=0, code_out=0xa0372d5c) at rwsem.h:101
#65 0xa008df36 in segv (address=3486502891, ip=3486502863, is_write=2,

.
.
.
.
.
.

#301 0x00000000 in ?? ()
#302 0x00000000 in ?? ()
#303 0xa037b26c in ?? ()
#304 0xa008de33 in check_remapped_addr (address=0, is_write=1077113681,
     is_user=0) at trap_kern.c:102
#305 0xa008df36 in segv (address=8, ip=1077113681, is_write=0, 
is_user=0,
     sc=0x4) at trap_kern.c:131
#306 0xa008e3b7 in segv_handler (sig=11, regs=0xa0378274) at 
trap_user.c:67
#307 0xa0090e84 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
     at trap_user.c:35
#308 0xa008e3e8 in sig_handler (sig=4, sc=
---Type <return> to continue, or q <return> to quit---
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2687991808, esi = 2688005836, ebp = 2688005812, 
esp = 2688005788, ebx = 0, edx = 4294901759, ecx = 2684354560, eax = 4, 
trapno = 14, err = 4, eip = 2685362279, cs = 35, __csh = 0, eflags = 
66198, esp_at_signal = 2688005788, ss = 43, __ssh = 0, fpstate = 0x0, 
oldmask = 134217728, cr2 = 8}) at trap_user.c:101
#309 <signal handler called>
#310 rwsem_down_failed_common (sem=0x0, waiter=0xa037b6cc, 
adjustment=-65537)
     at list.h:40
#311 0xa00f5edb in rwsem_down_read_failed (sem=0x0) at rwsem.c:162
#312 0xa008e253 in .text.lock.trap_kern () at devpts_i.h:37
#313 0x00000000 in ?? ()
#314 0x40161000 in ?? ()
#315 0xa037b73c in ?? ()
#316 0xa008de33 in check_remapped_addr (address=0, is_write=1077113681,
     is_user=0) at trap_kern.c:102
#317 0xa008df36 in segv (address=1075188088, ip=1077113681, is_write=0,
     is_user=0, sc=0x4) at trap_kern.c:131
#318 0xa008e3b7 in segv_handler (sig=11, regs=0xa0378274) at 
trap_user.c:67
#319 0xa0090e84 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
     at trap_user.c:35
#320 0xa008e3e8 in sig_handler (sig=4, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2687991808, esi = 2688007072, ebp = 2688007048, 
esp = 2688007024, ebx---Type <return> to continue, or q <return> to 
quit---
  = 1075188080, edx = 4294967295, ecx = 1075188080, eax = 1075188084, 
trapno = 14, err = 4, eip = 2685362279, cs = 35, __csh = 0, eflags = 
66178, esp_at_signal = 2688007024, ss = 43, __ssh = 0, fpstate = 0x0, 
oldmask = 0, cr2 = 1075188088})
     at trap_user.c:101
#321 <signal handler called>
#322 rwsem_down_failed_common (sem=0x40161170, waiter=0xa037bba0,
     adjustment=-1) at list.h:40
#323 0xa00f5f1b in rwsem_down_write_failed (sem=0x40161170) at 
rwsem.c:178
#324 0xa001e4f3 in .text.lock.mmap () at proc_fs.h:154
#325 0xffffffff in ?? ()
#326 0x0846b600 in ?? ()
#327 0x80000001 in ?? ()
#328 0x00000000 in ?? ()
#329 0x4015ee74 in ?? ()
#330 0x0000005b in ?? ()
#331 0xa037bc6c in ?? ()
#332 0xa009090a in execute_syscall_skas (r=0x21000) at syscall_kern.c:28
Previous frame identical to this frame (corrupt stack?)
(gdb) 



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
