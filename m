Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Afd8z-0006LA-EY for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 02:48:33 -0800
Received: from host81-134-146-19.in-addr.btopenworld.com ([81.134.146.19]
	helo=factotum.office.bytemark.co.uk)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Afd8y-0002OK-Op for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 02:48:32 -0800
From: Matthew Bloch <matthew-list@bytemark.co.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401111048.23195.matthew-list@bytemark.co.uk>
Subject: [uml-devel] Old COW bug report from latest COW driver
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
Date: Sun, 11 Jan 2004 10:48:21 +0000
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jeff,

We're not running the latest UML patch on our systems (2.4.22-uml5) but when I 
heard you'd fixed the COW bug I copied the changes to drivers/ubd_kern.c from 
the latest version which addressed the issue for our new kernel (at the same 
time as applying the mremap fix).

A customer running that kernel just called saying their machine hangs during 
the boot sequence and the backtrace looks familiar:

(gdb) bt
#0  0xa00010a1 in munmap ()
#1  0xa0169e55 in os_unmap_memory (addr=0xa8800000, len=-1333788672)
    at process.c:133
#2  0xa01662d1 in flush_kernel_vm_range (start=2826960896, end=2961178624)
    at tlb.c:86
#3  0xa016635f in flush_tlb_kernel_vm_skas () at tlb.c:117
#4  0xa01600b1 in segv (address=2827964416, ip=2687238481, is_write=0, 
    is_user=0, sc=0xa7fec274) at trap_kern.c:125
#5  0xa016045a in segv_handler (sig=11, regs=0xa7fec274) at trap_user.c:67
#6  0xa0166464 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
    at trap_user.c:33
#7  0xa0160549 in sig_handler (sig=-1468002304, sc=
      {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, 
__dsh = 0, edi = 8, esi = 255, ebp = 2818504828, esp = 2818504772, ebx = 7, 
edx = 2818505056, ecx = 2827177984, eax = 196607, trapno = 14, err = 4, eip = 
2686290079, cs = 35, __csh = 0, eflags = 66118, esp_at_signal = 2818504772, 
ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 301998080, cr2 = 2827964416}) at 
trap_user.c:103
#8  <signal handler called>
#9  0xa01d889f in cowify_bitmap (io_offset=12142636984069716276, length=8192, 
    cow_mask=0x0, cow_offset=0x12002000, bitmap=0x0, bitmap_offset=6291424, 
    bitmap_words=0x3) at ubd_kern.c:880

This is either a sign that there was more to the COW fix that I've ported 
across or that the fix hasn't worked.  I will try compiling an absolute bang 
up-to-date kernel to see if it makes any difference, but can you at least let 
me know whether there was more to the COW bug fix than I'd found in 
ubd_kern.c ?

cheers,

- -- 
Matthew Bloch                             Bytemark Hosting
                                  tel. +44 (0) 8707 455026
                        http://www.bytemark-hosting.co.uk/
          Dedicated Linux hosts from 15ukp ($26) per month
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAASn1T2rVDg8aLXQRAvmKAJ9OiIG6YGT6W3W4BVYeOlLPiLmi/wCfcMNY
xS7b3uyyHzIimwALGjKHjw4=
=dhRz
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
