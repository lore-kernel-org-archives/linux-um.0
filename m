Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By6Lg-00053k-WB for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 03:10:16 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1By6Lg-0000rF-43 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 03:10:16 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [patch] mconsole_proc rewrite (and crash fix).
References: <20040719204008.GA15091@bytesex>
In-Reply-To: <20040719204008.GA15091@bytesex>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200408111957.40575.blaisorblade_spam@yahoo.it>
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
Date: Wed, 11 Aug 2004 19:57:40 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, Jeff Dike <jdike@addtoit.com>

Alle 22:40, luned=EC 19 luglio 2004, Gerd Knorr ha scritto:
>   Hi,
>
> Below is a rewrite of the mconsole_proc function.

First: I'm collecting it inside my 2.6-bb patchset (which is then what I se=
nd=20
for -mm inclusion).

Second: since there is in that tree the mconsole exec support (which allows=
=20
executing any command including cat /proc/file > /dev/ttyN and cat /sys/*),=
=20
which is as reliable as this version of mconsole_proc() but by far more=20
general, I'm not sure if we should keep the proc command.

Actually the exec command cannot send anything to the mconsole, but since i=
t=20
invokes sh -c it allows for redirections to new consoles.

> The old code had the problem that the kernel crashed after calling
> "uml_mconsole proc <somefile>" a few times.  I havn't tracked what
> exactly causes the problem, I guess trying to access the procfs without
> actually mounting it somewhere causes some corruption of kernel data
> structures.

Who said that he didn't have mounted /proc inside the guest? I'm more=20
convinced that while replicating the whole sys_open code Jeff didn't get=20
something right. And it would have been worse if he ever managed to do it: =
it=20
would have broken at the first little VFS change :-(. But it's only IMHO; o=
n=20
the other side, creating a kernel thread with his own namespace is safer bu=
t=20
not cleaner than implementing sys_open ourselves.

However, I see basically two bugs:
1) why put_filesystem is not called at the end?
2) why don't we call dget() onto sb->s_root? I have some doubts about it,=20
anyway.

> The new code simply openes /proc/<file> via sys_open().  That simplifies
> the function alot.  It also doesn't crash any more ;)
> Drawback is that it only works when procfs is actually mounted below
> /proc.  One suggestion I've received to fix the later issue was to mount
> the procfs within a kernel thread with a private namespace, but I havn't
> tried that so far.
I checked if kern_mount() would have worked but it's not straightforward,=20
since it does not add the mounted fs anywhere.

However, sys_mount() and do_mount(), apart from argument checking, do a=20
path_lookup(), to get a struct nameidata representing the mount point, and =

pass it to do_add_mount(). And only path_lookup() checks the current->fs=20
datas, i.e. the root (not the ->namespace). Maybe that could help us, but I=
'm=20
not sure...
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
