Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AD6J2-00034u-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 11:05:00 -0700
Received: from ctron-dnm.enterasys.com ([12.25.1.120] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1ACfjS-00067U-8f
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 23 Oct 2003 06:42:30 -0700
Received: (from uucp@localhost)
	by ctron-dnm.enterasys.com (8.8.7/8.8.7) id JAA10913
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 09:40:57 -0400 (EDT)
Message-ID: <3F97DA89.4010900@enterasys.com>
From: Demetrios Tsillas <jtsillas@enterasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [Fwd: kernel assertion failed]
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
Date: Thu, 23 Oct 2003 09:41:29 -0400
To: user-mode-linux-devel@lists.sourceforge.net

Running a 2.4.22 uml kernel under a 2.4.22 host with skas3.
Running program under gdb in skas-mode. In the process of
debugging some development code (the rmc files).

I haven't seen this one before so it may interest UML developers:

#0  panic (fmt=0xa01f8ccc "kernel BUG at %s:%d!\n") at panic.c:52
#1  0xa000c7f9 in schedule () at sched.c:681
#2  0xa00dd826 in __down (sem=0xa024999c) at semaphore.c:80
#3  0xa00dd9a0 in __down_failed ()
#4  0xa000f964 in __call_console_drivers (start=4390, end=4431) at 
printk.c:311
#5  0xa000f9ce in _call_console_drivers (start=2934026484, end=0, 
msg_log_level=24) at printk.c:326
#6  0xa000faae in call_console_drivers (start=0, end=4431) at printk.c:372
#7  0xa000fd18 in release_console_sem () at printk.c:524
#8  0xa000fc68 in printk (fmt=0xa01ff275 "<2>rmc_send_nak: %lu,%u-%u\n") 
at printk.c:464
#9  0xa016785e in rmc_send_nak (sk=0xaf365b60, to=16885952, toport=24, 
begin=3069329452, end=3069376236) at rmc_output.c:809
#10 0xa01646d9 in rmc_rcv_data (sk=0xaf365b60, skb=0xa0395c60) at 
rmc_input.c:261
#11 0xa0164374 in rmc_master_rcv (sk=0xaf365b60, skb=0xa0395c60) at 
rmc_input.c:127
#12 0xa0164325 in rmc_do_rcv (sk=0x0, skb=0xaee1b0f4) at rmc_input.c:108
#13 0xa01642f2 in rmc_ip_rcv (skb=0xa0395c60) at rmc_input.c:93
#14 0xa012b80b in ip_local_deliver_finish (skb=0xa0395c60) at 
ip_input.c:262
#15 0xa012b582 in ip_local_deliver (skb=0x0) at ip_input.c:302
#16 0xa012ba4e in ip_rcv_finish (skb=0xa0395c60) at ip_input.c:367
#17 0xa012b733 in ip_rcv (skb=0xa0395c60, dev=0xaf850000, pt=0xa024af38) 
at ip_input.c:437
#18 0xa011eff3 in netif_receive_skb (skb=0xa0395c60) at dev.c:1529
#19 0xa011f0a8 in process_backlog (blog_dev=0xa024ff48, 
budget=0xaee1b56c) at dev.c:1562
#20 0xa011f1d3 in net_rx_action (h=0xa024fc50) at dev.c:1624
#21 0xa0015e07 in do_softirq () at softirq.c:90
#22 0xa00d28eb in do_IRQ (irq=5, regs=0xaee18274) at irq.c:340
#23 0xa00d30fa in sigio_handler (sig=29, regs=0xaee18274) at irq_user.c:73
#24 0xa00dc46e in sig_handler_common_skas (sig=29, sc_ptr=0xa0244d48) at 
trap_user.c:33
#25 0xa00da2bd in sig_handler (sig=29, sc={gs = 0, __gsh = 0, fs = 0, 
__fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 2934028868, esi 
= 1, ebp = 2934028636, esp = 2934028588, ebx = 1, edx = 1, ecx = 
2934028868, eax = 1, trapno = 14, err = 6, eip = 2686096365, cs = 35, 
__csh = 0, eflags = 582, esp_at_signal = 2934028588, ss = 43, __ssh = 0, 
fpstate = 0x0, oldmask = 0, cr2 = 2969649152}) at trap_user.c:102
#26 <signal handler called>
#27 0xa01a93ed in __libc_write () at __libc_write:-1
#28 0xaf83e240 in ?? ()
#29 0xa011468b in generic_write (fd=1, buf=0xaee1ba44 ".", n=1, 
unused=0xaf83a8e0) at chan_user.c:46
#30 0xa0113e54 in write_chan (chans=0xaee1ba44, buf=0xaee1ba44 ".", 
len=1, write_irq=3) at chan_kern.c:198
#31 0xa0114d73 in line_write (lines=0x0, tty=0xa0394000, from_user=0, 
buf=0xaee1ba44 ".", len=1) at line.c:128
#32 0xa011397d in con_write (tty=0xa0394000, from_user=0, buf=0xaee1ba44 
".", count=1) at stdio_console.c:151
#33 0xa00e3fc8 in opost_block (tty=0xa0394000, inbuf=0x40016000 <Address 
0x40016000 out of bounds>, nr=1) at n_tty.c:305
#34 0xa00e565d in write_chan (tty=0xa0394000, file=0xaf822320, 
buf=0x40016000 <Address 0x40016000 out of bounds>, nr=1) at n_tty.c:1179
#35 0xa00e397a in do_tty_write (write=0xa00e552d <write_chan>, 
tty=0xa0394000, file=0xaf822320, buf=0x40016000 <Address 0x40016000 out 
of bounds>, count=1) at tty_io.c:749
#36 0xa00e0e9f in tty_write (file=0xaf822320, buf=0x40016000 <Address 
0x40016000 out of bounds>, count=1, ppos=0xaf822340) at tty_io.c:832
#37 0xa00346ea in sys_write (fd=24, buf=0x40016000 <Address 0x40016000 
out of bounds>, count=1) at read_write.c:203
#38 0xa00dbfdd in execute_syscall_skas (r=0xaee18274) at syscall_kern.c:28
#39 0xa00d8b5f in execute_syscall (r=0xaee18274) at syscall_kern.c:315
#40 0xa00dc00e in handle_syscall (regs=0xaee18274) at syscall_user.c:26
#41 0xa00db2f5 in handle_trap (pid=7579, regs=0xaee18274) at process.c:83
#42 0xa00db50f in userspace (regs=0xaee18274) at process.c:156
#43 0xa00dbcbb in fork_handler (sig=10) at process_kern.c:102
#44 <signal handler called>
#45 0xa019b291 in __kill () at __kill:-1
#46 0xa00def41 in os_usr1_process (pid=-1360945152) at process.c:95
#47 0xa00dbc1c in new_thread_proc (stack=0xaee1a000, handler=0xa00dbc28 
<fork_handler>) at process_kern.c:79



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
