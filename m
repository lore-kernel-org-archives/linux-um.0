Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BwnZO-0005Wr-Aa for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Aug 2004 12:55:02 -0700
Received: from ctron-dnm.enterasys.com ([12.25.1.120] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BwnZN-0002fX-Rt for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Aug 2004 12:55:02 -0700
Received: (from uucp@localhost)
	by ctron-dnm.enterasys.com (8.8.7/8.8.7) id PAA18015
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 16 Aug 2004 15:58:12 -0400 (EDT)
Message-ID: <412110C1.7080808@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: handle_trap - failed to wait at end of syscall
	[was Re: [uml- devel] debugging UML cores]
References: <200408132147.i7DLlB2o003883@ccure.user-mode-linux.org>
	<4120F325.9030401@nortelnetworks.com>
	<41210A22.2080404@nortelnetworks.com>
In-Reply-To: <41210A22.2080404@nortelnetworks.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB4A74A1ED7BCD07C34890066"
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
Date: Mon, 16 Aug 2004 15:53:37 -0400
To: Joe Marzot <gmarzot@nortelnetworks.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB4A74A1ED7BCD07C34890066
Content-Type: multipart/mixed; boundary="------------030701050308010106050000"

This is a multi-part message in MIME format.
--------------030701050308010106050000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

does this look familar? humm, here's 2.4.26-3um, backtrace attached.

we do have kernel modules loaded... and lots of communication with
a modified uml_switch going on... otherwise this can happen in a
relatively idle UML after some random period of time.

i have not seen this in a vanilla 2.4.26-3 with a generic redhat 9 file
system just doing 'ls -R' over and over for exercise -- btw: it has no
modules loaded... and none in the filesystem to load for a quick test.

i'm installing Expect.pm so i can play with the test scripts and try
to isolate this and the hostfs troubles... fun.

db

Joe Marzot wrote:

> Joe Marzot wrote:
> 
>> Jeff Dike wrote:
>>
>>> gmarzot@nortelnetworks.com said:
>>>  > WSTOPSIG(err) = SIGHUP
>>>  > does this give any clues...any ideas of what else to look at?
>>>
>>> Do you have any idea how you're making this happen? 
> 
> 
> here's another twist - looks like a different crash but stimulated by 
> the same tests being performed inside UML. This back trace goes on down 
> to zero just like this ->  sig 11, change_sig 10, sig 11...
> 
> looks like a klm might have corrupted kernel mem...or does this look 
> familial to other UML'ers?
> 
> #2156 <signal handler called>
> #2157 0xa0151ac0 in sigismember ()
>     at 
> /localdisk/builds/3pc/2.4.22-i686sim/2.4.22/include/asm/arch/string.h:486
> #2158 0xa00c09eb in change_sig (signal=10, on=1) at signal_user.c:57
> #2159 0xa00c4a01 in sig_handler_common_skas (sig=11, sc_ptr=0xa00cc100)
>     at trap_user.c:31
> #2160 0xa00c2746 in sig_handler (sig=11, sc=
>       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
> 43, __dsh = 0, edi = 10, esi = 2685191148, ebp = 2685191428, esp = 
> 2685191128, ebx = 2685191276, edx = 2685191276, ecx = 2685191276, eax = 
> 354011904, trapno = 14, err = 6, eip = 2685737664, cs = 35, __csh = 0, 
> eflags = 66050, esp_at_signal = 2685191128, ss = 43, __ssh = 0, fpstate 
> = 0x0, oldmask = 134217792, cr2 = 354011904})
>     at trap_user.c:102
> #2161 <signal handler called>
> #2162 0xa0151ac0 in sigismember ()
>     at 
> /localdisk/builds/3pc/2.4.22-i686sim/2.4.22/include/asm/arch/string.h:486
> #2163 0xa00c09eb in change_sig (signal=10, on=1) at signal_user.c:57
> ---Type <return> to continue, or q <return> to quit---
> #2164 0xa00c4a01 in sig_handler_common_skas (sig=0, sc_ptr=0xa00cc560)
>     at trap_user.c:31
> #2165 0xa00c2746 in sig_handler (sig=Cannot access memory at address 0x16
> ) at trap_user.c:102
> Previous frame inner to this frame (corrupt stack?)
> 
> anyone have any tips on interesting fields to look at?
> 
> regards, Giovanni
> 
>>
>>
>> unfortunately not...the UML instance is being used as a test harness 
>> for a complex set of interacting processes. all sorts of things are 
>> going prior to the crash.
>>
>>> The userspace process is
>>> getting a SIGHUP in the middle of having a system call nullified.  
>>
>>
>>
>> what does it mean to nullify a system call?
>>
>> I am also losing whether this is a simulated signal inside the UML 
>> userspace app or a host signal being delivered to the host resident 
>> UML usespace thread.
>>
>>> This is OK
>>> since a SIGHUP can happen any time if you log out on it or something, 
>>> but
>>> I'd like to know exactly what's going on so I can decide what the 
>>> right reaction
>>> to it is.
>>
>>
>>
>> as it is a test harness there are lot's of scripts being invoked - 
>> shells are being spawned and exited. There may be expect scripts 
>> logging into the UML and logging out if that's what mean.
>>
>>>
>>> Simplistically, we could just handle it there and ignore it, since 
>>> UML probably
>>> got the SIGHUP as well, and will deal with it then.
>>
>>
>>
>> something like this?
>>
>> if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP) 
>> || (WSTOPSIG(status) != SIGHUP)) {
>>    ....
>> } else {
>>    handle_syscall(regs);
>> }
>>
>> regards, GSM
>>
>>>
>>>                                 Jeff


--------------030701050308010106050000
Content-Type: text/plain;
 name="randomkernelpanic.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="randomkernelpanic.txt"

#35 0x080dd263 in linux_main (argc=12, argv=0x20000000) at um_arch.c:393
#34 0x080debae in start_uml_skas () at process_kern.c:193
#33 0x080de4e5 in start_idle_thread (stack=0x81e8000, switch_buf_ptr=0x81e8578, fork_buf_ptr=0x0) at process.c:303
#32 0x0815a325 in siglongjmp () at proc_fs.h:154
#31 0x0815a691 in kill () at proc_fs.h:154
#30 <signal handler called>
#29 0x080de886 in new_thread_handler (sig=10) at process_kern.c:72
#28 0x080d90ed in run_kernel_thread (fn=0x80deb34 <start_kernel_proc>, arg=0x0, jmp_ptr=0x81e8000) at process.c:231
#27 0x080deb5b in start_kernel_proc (unused=0x0) at process_kern.c:179
#26 0x0804950a in start_kernel () at init/main.c:440
#25 0x0805144e in rest_init () at init/main.c:346
#24 0x080d94f1 in cpu_idle () at process_kern.c:209
#23 0x080dc27a in idle_sleep (secs=-4) at time.c:132
#22 0x0816787a in nanosleep () at proc_fs.h:154
#21 <signal handler called>
#20 0x080dce1e in sig_handler (sig=29, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136216576, esi = 136216576, ebp = 136248204, esp = 136248176, ebx = 136248196, edx = 136216576, ecx = 0, eax = 4294967292, trapno = 14, err = 6, eip = 135690362, cs = 35, __csh = 0, eflags = 582, esp_at_signal = 136248176, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 0, cr2 = 681033728}) at trap_user.c:109
#19 0x080df1f5 in sig_handler_common_skas (sig=29, sc_ptr=0xe8) at trap_user.c:35
#18 0x080d72bb in sigio_handler (sig=29, regs=0x81e8270) at irq_user.c:73
#17 0x080d6c57 in do_IRQ (irq=5, regs=0x81e8270) at irq.c:336
#16 0x0805ae62 in do_softirq () at softirq.c:90
#15 0x08109b50 in net_rx_action (h=0x8203590) at dev.c:1626
#14 0x08109a35 in process_backlog (backlog_dev=0x82038e8, budget=0x81ef7ac) at dev.c:1563
#13 0x08109915 in netif_receive_skb (skb=0x25ba6d20) at dev.c:1530
#12 0x08136763 in arp_process (skb=0x25ba6d20) at arp.c:946
#11 0x0810db92 in neigh_update (neigh=0x260535a0, lladdr=0x20cc7858 "\002", new=2 '\002', override=1, arp=1) at neighbour.c:895
#10 0x0810ef94 in neigh_app_notify (n=0x260535a0) at neighbour.c:1477
#9  0x0810eb11 in neigh_fill_info (skb=0x83cca80, n=0x260535a0, pid=1, seq=1, event=1) at neighbour.c:1341
#8  <signal handler called>
#7  0x080dce1e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 525299216, esi = 138201728, ebp = 136246892, esp = 136246836, ebx = 525299200, edx = 637875616, ecx = 136246660, eax = 1, trapno = 14, err = 4, eip = 135326481, cs = 35, __csh = 0, eflags = 66050, esp_at_signal = 136246836, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 134217728, cr2 = 61}) at trap_user.c:109
#6  0x080df1f5 in sig_handler_common_skas (sig=11, sc_ptr=0x58) at trap_user.c:35
#5  0x080dcdfd in segv_handler (sig=11, regs=0x81e8270) at trap_user.c:74
#4  0x080dcab9 in segv (address=61, ip=0, is_write=0, is_user=0, sc=0x81e8270) at trap_kern.c:149
#3  0x08056215 in panic (fmt=0x81c8b60 "Kernel mode fault at addr 0x%lx, ip 0x%lx") at panic.c:77
#2  0x080612a6 in notifier_call_chain (n=0xf4240, val=0, v=0x820d1c0) at sys.c:148
#1  0x080dd3a9 in panic_exit (self=0x81f6c34, unused1=0, unused2=0x820d1c0) at um_arch.c:403
#0  stop () at user_util.c:52

--------------030701050308010106050000--

--------------enigB4A74A1ED7BCD07C34890066
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBIRDB3XQ4zakZ3z4RAjK+AJ9tWXgZk78/bTAqWDmY/6tnavr12gCeOT95
vjkNRx6ulotKOViQY/CoXRc=
=+NqL
-----END PGP SIGNATURE-----

--------------enigB4A74A1ED7BCD07C34890066--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
