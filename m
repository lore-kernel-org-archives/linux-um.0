Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] RE: [uml-user] Kernel panic: Segfault with no mm &&
	CONFIG_DEBUG_SLAB
Message-ID: <EAC7622167479948B614F8B9AD41C505ECA578@MAANDMBX2.ets.enterasys.com>
From: "Tsillas, Demetrios J" <jtsillas@enterasys.com>
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
Date: Fri, 24 Sep 2004 17:00:12 -0400
Content-Transfer-Encoding: 8bit
To: stian@nixia.no
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-user@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

I don't think it's a compiler bug. It has all the signs of
a timing related bug.

It happens less often when CONFIG_DEBUG_SLAB is enabled.
It happens more often when we run the UML on a fast hyperthreading CPU.

The problem only occurs at startup and always at the same place.

-----Original Message-----
From: user-mode-linux-user-admin@lists.sourceforge.net
[mailto:user-mode-linux-user-admin@lists.sourceforge.net] On Behalf Of
stian@nixia.no
Sent: Friday, September 24, 2004 5:01 AM
To: Tsillas, Demetrios J
Cc: stian@nixia.no; BlaisorBlade;
user-mode-linux-user@lists.sourceforge.net; Jeff Dike;
user-mode-linux-devel@lists.sourceforge.net
Subject: RE: [uml-devel] RE: [uml-user] Kernel panic: Segfault with no
mm && CONFIG_DEBUG_SLAB

take a clean make and compile without the -O2 and see if you see the
same
wierd things. If you do, UML has a bug, else gcc.

> I use gcc 3.2.2 with -O2. The kernel is being built with frame
> pointers.
>
> -----Original Message-----
> From: stian@nixia.no [mailto:stian@nixia.no]
> Sent: Thursday, September 23, 2004 5:25 AM
> To: Tsillas, Demetrios J
> Cc: BlaisorBlade; user-mode-linux-user@lists.sourceforge.net; Jeff
Dike;
> user-mode-linux-devel@lists.sourceforge.net
> Subject: Re: [uml-devel] RE: [uml-user] Kernel panic: Segfault with no
> mm && CONFIG_DEBUG_SLAB
>
>> I have a core image now that I can browse. There's something
>> very odd about the stack after the sig_handler.
>> (gdb) p/x segfault_record[4]
>> $24 = {address = 0x28828000, is_write = 0x2, pid = 0x11db, sp
> 0x40001fb4,
>> is_user = 0x0}
>
>> (gdb) down
>> #6  0x080d9bf9 in segv (address=671088640, ip=135618305, is_write=0,
>> is_user=0, sc=0x9310270) at trap_kern.c:149
>> (gdb) p/x 671088640
>> $26 = 0x28000000
>>
>> Address is wrong and is_write should be 0x2. It looks like the call
>> stack
>> from the _previous_ segfault_record.
>
> What version of gcc do you use? And what optimize-flags do you use?
> (stack-frames can't be trusted 100% with some combinations of
> gcc-versions/optimize-levels.
>
>
> Stian Skjelstad
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement
on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
