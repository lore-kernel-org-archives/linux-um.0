Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Subject: Re: [Valgrind-users] Re: [uml-devel] Re: UML and valgrind
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com>
	<200408030517.i735HZUE026250@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031028541.22157@hermes-1.csi.cam.ac.uk>
	<200408031450.i73EoEvv002040@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031527320.22157@hermes-1.csi.cam.ac.uk>
	<200408031750.i73HoMvv002966@ccure.user-mode-linux.org>
	<410FCC70.1050902@enterasys.com>
	<200408031931.i73JVkvv003367@ccure.user-mode-linux.org>
From: Tom Hughes <thh@cyberscience.com>
In-Reply-To: <200408031931.i73JVkvv003367@ccure.user-mode-linux.org> (Jeff
	Dike's message of "Tue, 03 Aug 2004 15:31:45 -0400")
Message-ID: <yek3c33tk5o.fsf@audi.uk.cyberscience.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Wed, 04 Aug 2004 08:52:19 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: "D. Bahi" <dbahi@enterasys.com>, Nicholas Nethercote <njn25@cam.ac.uk>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

In message <200408031931.i73JVkvv003367@ccure.user-mode-linux.org>
        Jeff Dike <jdike@addtoit.com> wrote:

> dbahi@enterasys.com said:
>> ugh, so close - it bails - stopped by clone() !?!!?? : 
>
> OK, there were a bunch of problems that were fixed when me, Jeremy,
> and Julian were working on this.  The clone one seems to have not
> made it.  I've lost the patches I had, but I dug this out of a piece
> of email.  It applies to coregrind/vg_syscalls.c:

Clone is not (at least in general) supportable in valgrind without
a reasonably large amount of work.

>> @@ -39,6 +40,10 @@
>>  # code which copies from baseBlock before the call, into
>>  # m_state_static, and back afterwards.
>>  
>> +.section .data
>> +save_ip:
>> +        .long   0
>> +
>>  VG_(do_syscall):
>>         # Save all the int registers of the real machines state on the
>>         # simulators stack.
>> @@ -80,10 +85,27 @@
>>         movl    VG_(m_state_static)+48, %esi
>>         movl    VG_(m_state_static)+52, %edi
>>  
>> +       cmpl    $__NR_clone, %eax
>> +       jne     not_clone
>> +
>> +       pushl   %eax
>> +       movl    VG_(m_state_static)+60, %eax
>> +       movl    %eax, save_ip
>> +       popl    %eax
>> +
>> +       int     $0x80
>> +
>> +       cmpl    $0, %eax
>> +       jne     parent_finish
>> +
>> +       jmp     *save_ip
>> +
>> +not_clone:
>>         # esp now refers to the simulatees stack
>>         # Do the actual system call
>>         int     $0x80

I don't see how a patch that small can have made clone work for you in
any version - at the very least you would need a change to vg_syscall.c
to stop it trapping the clone and complaining about it or you would
never actually reach VG_(do_syscall).

> It handles the clone by calling clone itself, creating a new
> valgrind thread which will go on grinding the new UML thread.

But how did you cope with the fact that valgrind doesn't protect it's
internal data structures in any way? You would have all sorts of
problems with two threads trying to access the same data.

Or are you not specifying CLONE_VM among the flags? it is it more like
a fork than a thread creation? That valgrind may be able to handle
quite easily.

In fact, what is the exact set of flags you're using to clone?

Tom

-- 
Tom Hughes (thh@cyberscience.com)
Software Engineer, Cyberscience Corporation
http://www.cyberscience.com/


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
