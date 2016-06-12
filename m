Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1bCBjM-0007of-5i
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2016 20:11:36 +0000
Received: from mail-oi0-f68.google.com ([209.85.218.68])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bCBjL-00055D-Gu
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2016 20:11:36 +0000
Received: by mail-oi0-f68.google.com with SMTP id e205so16222529oig.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 Jun 2016 13:11:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOMGZ=H-fi-Wqmc36ts5LULSe=QD9Q-ys7GKryFWRZw_iO-J=A@mail.gmail.com>
References: <CAOMGZ=GpWk1=9HeTxz6NBVh-Y8TZS8ZBHaaqDdxOqvRHD+f_TQ@mail.gmail.com>
	<6AAB4FAC-99C2-4B3C-88CA-C210193E74EF@m3y3r.de>
	<CAOMGZ=H-fi-Wqmc36ts5LULSe=QD9Q-ys7GKryFWRZw_iO-J=A@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 12 Jun 2016 22:11:29 +0200
Message-ID: <CAFLxGvw1jahqtNPkyBiMq_P4no+uersN4fGMcFqexikyLwm83w@mail.gmail.com>
Subject: Re: [uml-devel] current_thread_info() returns invalid pointer in
 early UML boot code
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
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, Thomas Meyer <thomas@m3y3r.de>

On Sun, May 22, 2016 at 5:39 PM, Vegard Nossum <vegard.nossum@gmail.com> wrote:
> On 21 May 2016 at 20:18, Thomas Meyer <thomas@m3y3r.de> wrote:
>> Am 21.05.2016 um 15:51 schrieb Vegard Nossum <vegard.nossum@gmail.com>:
>>> I'm having some trouble with using current_thread_info() during UML
>>> early boot. Sometimes it works just fine, but often I get segfaults
>>> because current_thread_info() is returning an invalid pointer. It
>>> looks random: 0x202118, 0x1003e0003, 0xd33b90b3, 0x6db043, etc.
>>
>> Mhh. Strange. Do you have a stack trace to call to current thread info which ends up with a wrong value. I wonder from were it originates.
>
> One such trace would be:
>
> #2  0x000000006026652c in snprintf (buf=<optimized out>,
> size=<optimized out>, fmt=<optimized out>) at lib/vsprintf.c:2181
> #3  0x00000000600046f8 in setup_env_path () at arch/um/os-Linux/main.c:109
> #4  main (argc=3, argv=0x7ffc3d8c23e8, envp=<optimized out>) at
> arch/um/os-Linux/main.c:125
>
> I wonder why setup_env_path() ends up calling the kernel's snprintf(),
> I thought that it would be using the glibc snprintf() at this point?

That early you cannot use current() nor any other core kernel stuff
since the kernel has not started so far.
So, the current thread info struct points to garbage.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

