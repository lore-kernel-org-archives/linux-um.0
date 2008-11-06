Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <htmldeveloper@gmail.com>) id 1Ky6wy-0001ly-Dk
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Nov 2008 15:39:12 +0000
Received: from yw-out-1718.google.com ([74.125.46.158])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ky6wk-0006nR-Ol for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Nov 2008 15:39:12 +0000
Received: by yw-out-1718.google.com with SMTP id 6so251993ywa.82
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 06 Nov 2008 07:38:57 -0800 (PST)
Message-ID: <804dabb00811060738r4517f07fs758ee997995a48ce@mail.gmail.com>
Date: Thu, 6 Nov 2008 23:38:56 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
In-Reply-To: <dfed62190811060520i6e51b844l4600222304bab23@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <804dabb00811060245t2dcae77bkcbba0156b9002c6d@mail.gmail.com>
	<dfed62190811060520i6e51b844l4600222304bab23@mail.gmail.com>
Subject: Re: [uml-devel] How to avoid stopping at gdb's "Program received
	signal SIGSEGV, Segmentation fault"?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Samuel Korpi <strontianite@gmail.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Nov 6, 2008 at 9:20 PM, Samuel Korpi <strontianite@gmail.com> wrote:
> On Thu, Nov 6, 2008 at 12:45 PM, Peter Teoh <htmldeveloper@gmail.com> wrote:
>> When I run gdb ./linux (my UML-compiled kernel):
>>
>> (gdb) run ubda=/mnt/hd1/download/FedoraCore5-x86-root_fs mem=128M
>> The program being debugged has been started already.
>> Start it from the beginning? (y or n) y
>> Starting program: /mnt/hd0/download/linux-2.6-latest/uml/linux
>> ubda=/mnt/hd1/download/FedoraCore5-x86-root_fs mem=128M
>> Locating the bottom of the address space ...
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x080664ff in page_ok (page=<value optimized out>) at
>> /mnt/hd0/download/linux-2.6-latest/arch/um/os-Linux/sys-i386/task_size.c:31
>> 31                      n = *address;
>>
>> The flow keep stopping at the following message:
>>
>> Program received signal SIGTRAP, Trace/breakpoint trap.
>>
>> And I have to "next" many many times....the execution flow continue as
>> per normal.   But I would like to ignore the breakpoint trap, how?
>>
>
> Try giving the following commands to gdb before starting UML:
>
> handle SIGSEGV pass nostop noprint
> handle SIGUSR1 pass nostop noprint
>
> Hope it helps,
>
> Samuel Korpi
>

thanks....that worked!!!


-- 
Regards,
Peter Teoh

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
