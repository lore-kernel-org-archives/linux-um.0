Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xt2I-000876-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 11:52:50 -0700
Received: from marco.bezeqint.net ([192.115.106.37])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xt2H-0003A6-UU
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 11:52:50 -0700
Received: from bezeqint.net (bzq-218-95-114.red.bezeqint.net [81.218.95.114])
	by marco.bezeqint.net (Bezeq International SMTP out Mail Server) with ESMTP id EF21BA1B
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 03:40:51 +0300 (IDT)
Message-ID: <3F621741.4000606@bezeqint.net>
From: Etay Meiri <etay-m@bezeqint.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [uml-devel] Cannot see stack after add-symbol-file
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
Date: Fri, 12 Sep 2003 21:58:09 +0300
Content-Transfer-Encoding: 8bit
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Hi,

I have a strange problem when debugging my module under uml.
When the module crashes, I go into the debugger and display
the stack trace. There are several frame and there is one named
"????". I assume this is my module so I add the symbol file according
to the howto. The symbols load ok but the next time I do 'bt' I get
only the frame of the panic.
Here's a sample (I annotated it a bit):

<<< uml starting >>>

Breakpoint 3, start_kernel () at init/main.c:361
361             printk(linux_banner);
(gdb) c
Continuing.

<<< crashed caused here.... >>>

Breakpoint 1, panic (
     fmt=0xa01ef540 "Kernel mode fault at addr 0x%lx, ip 0x%lx") at 
panic.c:52
52              bust_spinlocks(1);
(gdb) bt
#0  panic (fmt=0xa01ef540 "Kernel mode fault at addr 0x%lx, ip 0x%lx")
     at panic.c:52
#1  0xa00f0f36 in segv (address=7286388, ip=2743086726, is_write=0, 
is_user=0,
     sc=0xa20d8274) at trap_kern.c:149
#2  0xa00f135e in segv_handler (sig=11, regs=0xa20d8274) at trap_user.c:69
#3  0xa00f49a6 in sig_handler_common_tt (sig=11, sc_ptr=0x58) at 
trap_user.c:37
#4  0xa00f143b in sig_handler (sig=0, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 123, __esh = 0, ds = 
123, __ds
h = 0, edi = 0, esi = 4294967280, ebp = 2718809004, esp = 2718808924, 
ebx = 2687
597856, edx = 0, ecx = 2718808656, eax = 7286388, trapno = 14, err = 4, 
eip = 27
43086726, cs = 115, __csh = 0, eflags = 66118, esp_at_signal = 
2718808924, ss =
123, __ssh = 0, fpstate = 0x0, oldmask = 134283264, cr2 = 7286388})
     at trap_user.c:104
#5  <signal handler called>
#6  0xa3802e86 in ?? ()
#7  0xa0012df4 in sys_delete_module (name_user=0xa0317d20 "??\r?$}1?$}1?")
     at module.c:636

<<< adding the symbols >>>

(gdb) p module_list
$1 = (struct module *) 0xa3802000
(gdb) add-symbol-file /home/cl/hacking/kernel/plkp/knet/modknet.o 0xa3802060
add symbol table from file "/home/cl/hacking/kernel/plkp/knet/modknet.o" at
         .text_addr = 0xa3802060
(y or n) y
Reading symbols from /home/cl/hacking/kernel/plkp/knet/modknet.o...
done.

<<< another backtraced >>>

(gdb) bt
#0  panic (fmt=0xa01ef540 "Kernel mode fault at addr 0x%lx, ip 0x%lx")
     at panic.c:52
(gdb)


The host is RH9 running kernel 2.6.0-test4. The uml is 2.4.22. This also
happened when I loaded the symbols before the module crashed.

Any idea?


-- 
--------------------------------
Etay Meiri
etay-m@bezeqint.net
--------------------------------



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
