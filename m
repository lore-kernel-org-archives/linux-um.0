Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <strontianite@gmail.com>) id 1Ky4nH-0002l6-38
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Nov 2008 13:21:03 +0000
Received: from rn-out-0910.google.com ([64.233.170.185])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ky4nF-0007aO-BY for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Nov 2008 13:21:03 +0000
Received: by rn-out-0910.google.com with SMTP id j66so452712rne.9
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 06 Nov 2008 05:20:59 -0800 (PST)
Message-ID: <dfed62190811060520i6e51b844l4600222304bab23@mail.gmail.com>
Date: Thu, 6 Nov 2008 15:20:51 +0200
From: "Samuel Korpi" <strontianite@gmail.com>
In-Reply-To: <804dabb00811060245t2dcae77bkcbba0156b9002c6d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <804dabb00811060245t2dcae77bkcbba0156b9002c6d@mail.gmail.com>
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
To: Peter Teoh <htmldeveloper@gmail.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Nov 6, 2008 at 12:45 PM, Peter Teoh <htmldeveloper@gmail.com> wrote:
> When I run gdb ./linux (my UML-compiled kernel):
>
> (gdb) run ubda=/mnt/hd1/download/FedoraCore5-x86-root_fs mem=128M
> The program being debugged has been started already.
> Start it from the beginning? (y or n) y
> Starting program: /mnt/hd0/download/linux-2.6-latest/uml/linux
> ubda=/mnt/hd1/download/FedoraCore5-x86-root_fs mem=128M
> Locating the bottom of the address space ...
> Program received signal SIGSEGV, Segmentation fault.
> 0x080664ff in page_ok (page=<value optimized out>) at
> /mnt/hd0/download/linux-2.6-latest/arch/um/os-Linux/sys-i386/task_size.c:31
> 31                      n = *address;
>
> The flow keep stopping at the following message:
>
> Program received signal SIGTRAP, Trace/breakpoint trap.
>
> And I have to "next" many many times....the execution flow continue as
> per normal.   But I would like to ignore the breakpoint trap, how?
>

Try giving the following commands to gdb before starting UML:

handle SIGSEGV pass nostop noprint
handle SIGUSR1 pass nostop noprint

Hope it helps,

Samuel Korpi

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
