Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxUm6-0000DD-OU for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 09:30:46 -0800
Received: from mout0.freenet.de ([194.97.50.131])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AxUao-0003Hk-Jj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 09:19:06 -0800
Content-Type: text/plain; charset="iso-8859-1"
From: Patrick Kilian <petschge@gmx.de>
Reply-To: petschge@web.de
References: <200402290158.54770.jdizzl@xs4all.nl>
	<20040229120513.934193BCB7@home.petschge.de>
	<200402291720.12216.blaisorblade_spam@yahoo.it>
In-Reply-To: <200402291720.12216.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Message-Id: <200402291813.09174.petschge@gmx.de>
Subject: [uml-devel] Re: [uml-user] UNIX socket networking
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
Date: Sun, 29 Feb 2004 18:13:09 +0100
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

Hi all,

>> Problem 1.) How do I shutdown a kernel thread when the uml goes
>> down? At the moment my patched kernle gets stuck with 100% CPU
>> usage when I trie to shut down the uml kernel.
> Possibly can be done either through exitcall or uml_exitcall. Give a
> look at the arch/um/kernel/sigio_*.c, especially at sigio_cleanup,
> which is an UML exitcall. Note however that the thread it refers to
> exists only on the host; it could be your case or not.
I did some test with exitcall but it didn't work out. Looks like I was=20
trying to do the roght thing, but did some mistakes.

>> Problem 2.) How can I make sure that my kernel thread I startet
>> _after_ the networking stuff is inited? At the moment I start the
>> kernel thread with a __initcall and just do a sleep(30) in the
>> thread.
> The proper way would be to use late_initcall instead of __initcall
> (check in <linux/init.h>), supposing that network does not already
> use late_initcall.
I didn't know about late_initcall, but it sounds promising.

> Or you can just hack the network initcall and make it call your
> function; or your initcall can call the network init.
I wanted to avoid hacking the network code itself.

> In this case, to avoid double initialization, add at the start of
> network_init (or how is it called) something like:
>
> if (network_already_inited)
>   return (Ok?);
> network_already_inited =3D 1;
>
> and before, in the same file:
> static int network_already_inited =3D 0;
>
> However rename the flag or someone could think you are a Pascal
> programmer (actually, I was). Seems like the actual function is
> called sock_init.
Well, I'll give it a try.


> Also, in 2.6 (what I am checking) initcalls are called after sock_init=20
> (in init/main.c: do_basic_setup()). So if that is right you do not=20
> need anything to make sure that your initcall is after network
> initialized.
The first time I ran into this problem was on 2.4.*. But I tried IIRC on=20
2.6.* too and had the same problems.

>> Problem 3.) I can only create sockets in the "anonymous" namespace.
>> The normal namespace gives me some error which I don't rememeber
>> right now but I could find out what th errorcode was.
> Sorry, but I cannot find any "anonymous" namespace. What is it? Maybe
> PF_UNSPEC?
It's abstract namespace (sorry for my mistake):

It's also in PF_LOCAL but with names that start with \0. I was told to=20
try this on the linux kernel newbies list. If you google with my name=20
and socket you should be able to find that thread.

> I guess the "normal" namespace is PF_LOCAL.
IIRC yes.

>> So if somebody could help me with this problem I'd be willing to
>> put some more work into this. Or I could post my tried on this list
>> or by pm
> There has been a lot of request for a such feature, so I would like
> if you can post it here or rather on uml-devel (especially to avoid
> anyone trying it without specific knowledge), even if it is not
> complete. So we could better help you. Also, state whether it is onto
> 2.4 or 2.6.
It's just some basic test. Far from being a working patch. I'll try your=20
sugestions and send in a patch in the next few days.

Thanks for your help,
Patrick "Petschge" Kilian



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
