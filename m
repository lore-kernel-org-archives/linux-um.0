Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1S7bcX-00008n-FJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Mar 2012 23:59:13 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S7bcW-0005Ud-1B
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Mar 2012 23:59:13 +0000
Message-ID: <4F5FDF42.90004@nod.at>
Date: Wed, 14 Mar 2012 00:58:58 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <4F5FCC7D.5090307@panasas.com>
In-Reply-To: <4F5FCC7D.5090307@panasas.com>
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
Subject: Re: [uml-devel] UML: Please help with __module_text_address crashing
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Am 13.03.2012 23:38, schrieb Boaz Harrosh:
> Since a while now my UMLs are constantly crashing in __module_text_address
>
> which makes no sense because if I do gdb>  list *(__module_text_address+0xd)
> I get:
>
> 0x6005614e is in __module_text_address (/media/usr0/export/dev/bharrosh/git/pub/linux-open-osd/kernel/module.c:3469).
> 3464     * module doesn't get freed during this.
> 3465     */
> 3466    struct module *__module_text_address(unsigned long addr)
> 3467    {
> 3468            struct module *mod = __module_address(addr);
> 3469            if (mod) {
> 3470                    /* Make sure it's within the text section. */
> 3471                    if (!within(addr, mod->module_init, mod->init_text_size)
> 3472&&  !within(addr, mod->module_core, mod->core_text_size))
> 3473                            mod = NULL;
>
> It can not be crashing in line 3469, I suspect it's crashing inside __module_address(addr); at line 3468
>
> Below it's crashing as part of the console operation, which is the most common one, but it can crash in
> __module_text_address as part of other stack traces like networking and so on. From my feel it's always
> related to some UML driver that actually operates as part of the host. But I can't be sure.
>
> I'm running with 3.3-rc4 but I'm hit with this since 3.0, I tried to bisect
> this at the time, but I found out that I could not find a perfectly good point
> even as far as 3.6.37. So I suspected there is something wrong with my uml-image file
> or my host. But now I upgraded both host and image to FC15 (was FC12/FC13) and I get
> the same exact crashes. It came to a situation that I can't complete any kind
> of heavy operation anymore and have abandoned UML for VMS for now. But I'm
> very sorry to see UML go.
>
> Can anyone help me with some insight on what I should try, to debug this thing.
>

What exactly triggers the crash?
IOW, how can I reproduce it?

> BTW:
> How to debug UML under gdb, it forks like mad and if I do:
> 	gdb>  set detach-on-fork off
> It will just freeze. And if I do
> 	gdb>  attach<some-vmlinux-child-process>
> (Try to attach to any but the top parent process)
> Will return "access not permitted". I guess UML is a debugger of sorts and it can't be
> double debugged.

e.g:
$ gdb linux
(gdb) handle SIGSEGV noprint nostop pass
(gdb) set args <your kernel args>
(gdb) run

UML "forks like mad" because it creates an thread for each process 
within UML...

Thanks,
//richard

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

