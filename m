Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xQcR-0004dF-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 05:32:15 -0700
Received: from home.linuxhacker.ru ([194.67.236.68] helo=linuxhacker.ru)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19xQcQ-0002s6-GN
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Sep 2003 05:32:14 -0700
Received: from car.linuxhacker.ru (localhost.localdomain [127.0.0.1])
	by linuxhacker.ru (8.12.9/8.12.5) with ESMTP id h8BCSOg7010168
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 16:28:24 +0400
Message-Id: <200309111228.h8BCSOu9010164@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [uml-devel] Kernel panic: I/O op mismatch
References: <Pine.LNX.4.44.0309081936590.26334-100000@gradall.private.brainfood.com> <200309091310.h89DAt2J002539@ccure.karaya.com> <20030909164152.GB7799@alcor.net> <3F5E057E.9030209@davidcoulson.net> <20030909170808.GC7799@alcor.net> <3F5E3295.1080004@davidcoulson.net>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 11 Sep 2003 16:28:24 +0400
To: user-mode-linux-devel@lists.sourceforge.net

Hello!

David Coulson <david@davidcoulson.net> wrote:
>> Host filesystem or UML filesystem?  Adam and I were both using ext2 inside
>> UML when we spoke, and I'm using ext3 on the host side.
DC> Sorry, filesystem was the wrong word to use - 'image file' is more accurate.

That's how I reproduce it:
on host (underlying fs is reiserfs):
dd if=/dev/zero of=scratch bs=1024k seek=4096 count=1
./linux mem=100M ubd0=/space/green/rootfs debug xterm=rxvt ubd1=/space/green/scratch 

in uml:
# mkreiserfs /dev/ubd1
<-------------mkreiserfs, 2001------------->
reiserfsprogs 3.x.0k-pre9

mkreiserfs: Guessing about desired format.. 
mkreiserfs: Kernel 2.4.23-pre3-2um is running.
3276k will be used
Block 16 (0x6210) contains super block of format 3.5 with standard journal
Block count: 1048832
Bitmap number: 33
Blocksize: 4096
Free blocks: 1040588
Root block: 8211
Tree height: 2
Hash function used to sort names: "r5"
Objectid map size 2, max 1004
Journal parameters:
        Device [0x0]
        Magic [0x5db630ce]
        Size 8193 (including journal header) (first block 18)
        Max transaction length 1024
        Max batch size 900
        Max commit age 30
Space reserved by journal: 0
Correctness checked after mount 1
Fsck field 0x0
ATTENTION: YOU SHOULD REBOOT AFTER FDISK!
        ALL DATA WILL BE LOST ON './aaa'!
Continue (y/n):y
Initializing journal - 0%....20%....40%....60%....80%....100%

In gdb at this point:
Breakpoint 1, panic (fmt=0xa0180615 "I/O op mismatch") at panic.c:60
60              bust_spinlocks(1);
(gdb) bt
#0  panic (fmt=0xa0180615 "I/O op mismatch") at panic.c:60
#1  0xa00c92a4 in ubd_handler () at ubd_kern.c:471
#2  0xa0083510 in handle_IRQ_event (irq=4, regs=0xa01a4274, action=0xa0ab31f4)
    at irq.c:160
#3  0xa00836d5 in do_IRQ (irq=4, regs=0xa01a4274) at irq.c:323
#4  0xa0083f7f in sigio_handler (sig=29, regs=0xa01a4274) at irq_user.c:73
#5  0xa0090cc2 in sig_handler_common_tt (sig=29, sc_ptr=0xe8) at trap_user.c:37
#6  0xa008d7ab in sig_handler (sig=1, sc=
      {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 123, __esh = 0, ds = 123, __dsh = 0, edi = 2686091136, esi = 2686074880, ebp = 2686091104, esp = 2686091076, ebx = 2686091096, edx = 2686074880, ecx = 0, eax = 4294967292, trapno = 1, err = 0, eip = 2685643674, cs = 115, __csh = 0, eflags = 582, esp_at_signal = 2686091076, ss = 123, __ssh = 0, fpstate = 0xa01a7cc8, oldmask = 134283264, cr2 = 0})
    at trap_user.c:104
#7  <signal handler called>
#8  0xa013ab9a in nanosleep () at pgtable.h:257
#9  0xa008c5f6 in idle_sleep (secs=-4) at time.c:115
#10 0xa0085ef6 in cpu_idle () at process_kern.c:206
#11 0xa000b4ae in rest_init () at init/main.c:346

(btw, did you know that to compile 2.4.22-2um with ptrace support one needs to
add "#include <errno.h>" at arch/um/kernel/tt/ptproxy/sysdep.c otherwise
it won't compile).

Host is SMP.

Hm, interesting if this one of the races I observed long time ago.

Bye,
    Oleg


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
