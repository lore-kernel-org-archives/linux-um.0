Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adwpj-0003IX-BT for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 11:25:43 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Adwpi-0005lr-I7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 11:25:42 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip 0x400e51a4
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200401061918.31447.blaisorblade_spam@yahoo.it>
	<a0602040bbc20b325acfd@[192.168.1.10]>
In-Reply-To: <a0602040bbc20b325acfd@[192.168.1.10]>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401062007.49310.blaisorblade_spam@yahoo.it>
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
Date: Tue, 6 Jan 2004 20:07:49 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Johannes Formann <johannes@formann.de>

Alle 19:49, marted=EC 6 gennaio 2004, Johannes Formann ha scritto:
> At 19:18 Uhr +0100 06.01.2004, BlaisorBlade wrote:
> >you need to type this before starting:
> >
> >(host gdb) handle SIGSEGV pass nostop noprint
> >(host gdb) handle SIGUSR1 pass nostop noprint
>
> When I type that, It hit no breakpoint, so I cant get any backtarce
You didn't hit breakpoints, but signals. You need to do this:
<shell prompt>gdb linux

<gdb prompt> handle SIGSEGV pass nostop noprint
> handle SIGUSR1 pass nostop noprint
> break panic
> run <put here the arguments to give to Uml>
for instance:
run ubd0=3D~/Uml/root_fs_toms1.7.205 root=3D/dev/ubd0
type cont if it stops with SIGTRAP

then, it will stop saying "breakpoint hit" and then you can type "bt" and p=
ost=20
the resulting backtrace. But you need a kernel with debugging symbols, whil=
e=20
this is not:
> (no debugging symbols found)...(no debugging symbols found)...(no
> debugging symbols found)...

Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
