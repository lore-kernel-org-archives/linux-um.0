Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDFUq-0006qu-Am for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 21:30:36 -0800
Received: from rproxy.gmail.com ([64.233.170.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DDFUo-00083O-V4 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 21:30:36 -0800
Received: by rproxy.gmail.com with SMTP id 40so339418rnz
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 20 Mar 2005 21:30:34 -0800 (PST)
Message-ID: <cbec11ac05032021301a9083f7@mail.gmail.com>
From: Ian McDonald <imcdnzl@gmail.com>
Reply-To: Ian McDonald <imcdnzl@gmail.com>
Subject: Re: BUG with proposed fix Re: [uml-devel] Can't compile under vanilla
	2.6.11
In-Reply-To: <cbec11ac05032020433867d95e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <cbec11ac05031719187cb8e7d2@mail.gmail.com>
	<200503181843.05832.rob@landley.net>
	<cbec11ac05032020433867d95e@mail.gmail.com>
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
Date: Mon, 21 Mar 2005 17:30:34 +1200
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

The other problem with not linking va_copy has been resolved by
changing to __va_copy in skas/uaccess.c. This seems to be a known
problem with older compilers and there is a patch out there but not in
2.6.11 or by the looks of it 2.6.12 rc1 by my reading of the log (nor
for one for my previous e-mail)


On Mon, 21 Mar 2005 16:43:54 +1200, Ian McDonald <imcdnzl@gmail.com> wrote:
> OK after much further investigation, redownloading of source
> (2.6.11.4) and looking at what you have said I know why it is
> breaking....
> 
> I had assumed (wrongly of course) that ARCH_SYSCALLS was a one line
> symbol definition but it is much more than this.
> 
> The problem occurs because in both
> arch/um/include/sysdep-i386/syscalls.h and in
> arch/um/kernel/sys_call_table.c a number of the elements are defined
> in BOTH files.
> 
> I presume the reason why this doesn't break others systems is that
> they are not using the same version of gcc as me (2.95.4). I would
> guess that with a later gcc in an enum you can redefine an element and
> it doesn't complain...
> 
> Anyway I believe the proper fix is to delete the lines from
> arch/um/kernel/sys_call_table.c and here is a patch to do that:
> 
> 255d254
> <       [ __NR_statfs64 ] = (syscall_handler_t *) sys_statfs64,
> 258,260d256
> <       [ __NR_utimes ] = (syscall_handler_t *) sys_utimes,
> <       [ __NR_fadvise64_64 ] = (syscall_handler_t *) sys_fadvise64_64,
> <       [ __NR_vserver ] = (syscall_handler_t *) sys_vserver,
> 
> Can somebody verify that and if correct submit to whoever (this is my
> first ever attempt at fixing something in the kernel so not quite sure
> what to do next!!)
> 
> Regards,
> 
> Ian
> 
> PS still have some linking issues and I will report on them as I work
> out why....
> 
> On Fri, 18 Mar 2005 18:43:05 -0500, Rob Landley <rob@landley.net> wrote:
> > Ah, nevermind.  Check out Anton's message.  You were using a -bk snapshot
> > rather than the officially 2.6.11 release, I take it?
> >
> > Rob
> >
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
