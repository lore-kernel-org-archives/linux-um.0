Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bwn6w-0008PV-VK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Aug 2004 12:25:38 -0700
Received: from zrc2s0jx.nortelnetworks.com ([47.103.122.112])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bwn6w-0005g6-Ep for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Aug 2004 12:25:38 -0700
Message-ID: <41210A22.2080404@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
References: <200408132147.i7DLlB2o003883@ccure.user-mode-linux.org>
	<4120F325.9030401@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: handle_trap - failed to wait at end of syscall [was
	Re: [uml- devel] debugging UML cores]
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
Date: Mon, 16 Aug 2004 15:25:22 -0400
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Joe Marzot wrote:
> Jeff Dike wrote:
> 
>> gmarzot@nortelnetworks.com said:
>>  > WSTOPSIG(err) = SIGHUP
>>  > does this give any clues...any ideas of what else to look at?
>>
>> Do you have any idea how you're making this happen? 

here's another twist - looks like a different crash but stimulated by 
the same tests being performed inside UML. This back trace goes on down 
to zero just like this ->  sig 11, change_sig 10, sig 11...

looks like a klm might have corrupted kernel mem...or does this look 
familial to other UML'ers?

#2156 <signal handler called>
#2157 0xa0151ac0 in sigismember ()
     at 
/localdisk/builds/3pc/2.4.22-i686sim/2.4.22/include/asm/arch/string.h:486
#2158 0xa00c09eb in change_sig (signal=10, on=1) at signal_user.c:57
#2159 0xa00c4a01 in sig_handler_common_skas (sig=11, sc_ptr=0xa00cc100)
     at trap_user.c:31
#2160 0xa00c2746 in sig_handler (sig=11, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 10, esi = 2685191148, ebp = 2685191428, esp = 
2685191128, ebx = 2685191276, edx = 2685191276, ecx = 2685191276, eax = 
354011904, trapno = 14, err = 6, eip = 2685737664, cs = 35, __csh = 0, 
eflags = 66050, esp_at_signal = 2685191128, ss = 43, __ssh = 0, fpstate 
= 0x0, oldmask = 134217792, cr2 = 354011904})
     at trap_user.c:102
#2161 <signal handler called>
#2162 0xa0151ac0 in sigismember ()
     at 
/localdisk/builds/3pc/2.4.22-i686sim/2.4.22/include/asm/arch/string.h:486
#2163 0xa00c09eb in change_sig (signal=10, on=1) at signal_user.c:57
---Type <return> to continue, or q <return> to quit---
#2164 0xa00c4a01 in sig_handler_common_skas (sig=0, sc_ptr=0xa00cc560)
     at trap_user.c:31
#2165 0xa00c2746 in sig_handler (sig=Cannot access memory at address 0x16
) at trap_user.c:102
Previous frame inner to this frame (corrupt stack?)

anyone have any tips on interesting fields to look at?

regards, Giovanni

> 
> 
> unfortunately not...the UML instance is being used as a test harness for 
> a complex set of interacting processes. all sorts of things are going 
> prior to the crash.
> 
>> The userspace process is
>> getting a SIGHUP in the middle of having a system call nullified.  
> 
> 
> what does it mean to nullify a system call?
> 
> I am also losing whether this is a simulated signal inside the UML 
> userspace app or a host signal being delivered to the host resident UML 
> usespace thread.
> 
>> This is OK
>> since a SIGHUP can happen any time if you log out on it or something, but
>> I'd like to know exactly what's going on so I can decide what the 
>> right reaction
>> to it is.
> 
> 
> as it is a test harness there are lot's of scripts being invoked - 
> shells are being spawned and exited. There may be expect scripts logging 
> into the UML and logging out if that's what mean.
> 
>>
>> Simplistically, we could just handle it there and ignore it, since UML 
>> probably
>> got the SIGHUP as well, and will deal with it then.
> 
> 
> something like this?
> 
> if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP) || 
> (WSTOPSIG(status) != SIGHUP)) {
>    ....
> } else {
>    handle_syscall(regs);
> }
> 
> regards, GSM
> 
>>
>>                                 Jeff
>>
>>
>>
> 
> 
> 





-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
