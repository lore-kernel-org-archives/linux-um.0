Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8O8s-00042d-LG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 12:11:34 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C8O8r-00051S-0d for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 12:11:34 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Read method for /proc/mconsole
References: <MA6t3A81.1095323691.3565850.galan@agora-2000.com>
In-Reply-To: <MA6t3A81.1095323691.3565850.galan@agora-2000.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200409172108.28345.blaisorblade_spam@yahoo.it>
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
Date: Fri, 17 Sep 2004 21:08:28 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: =?iso-8859-1?q?Ferm=EDnGal=E1n?= <fermin.galan@agora-2000.com>, vnuml-devel@mail.dit.upm.es

On Thursday 16 September 2004 10:34, Ferm=EDnGal=E1n wrote:
> Hello,

> I'm working in the arch/um/drivers/mconsole_kern.c code in order to
> implement a reading method for /proc/mconsole that allows me to send by
> the "notify" socket in the host and receive in /proc/mconsole (exactly
> the opposite to the current /proc/mconsole -> notify sockect mechanism).

> In create_proc_mconsole I've changed the ent->read_proc from 'NULL' to
> a handle function, read_proc_mconsole
>
>    ent->read_proc =3D read_proc_mconsole;

> My problem now is how to implement read_proc_mconsole:

> static int read_proc_mconsole(char *page, char **start, off_t off,
>                               int count, int *eof, void *data)
> {
>    ...
> }
>
> The problems that I'm facing are:

> - I've found out the right header for the function in
> include/linux/proc_fs.h (the read_proc_t typedef), but I don't know
> what the arguments means and I wasn't able to find documentation about
> it. Anyone can give a pointer to this information?

Linux Device Drivers, 2nd Ed: - it contains a detailed explaination of that=
=20
function (which has a very weird API):

http://www.xml.com/ldd/chapter/book/index.html

An alternate explaination is in 2.6 kernel sources, in the point where it=20
calls read_proc (i.e. grep read_proc linux-2.6/fs/proc/*

> - The nofity socket descriptor is hold in the notify_socket global
> variable, set up in mconsole_setup function. It seems that for pushing
> information to the socket, the mconsole_notify method is called (defined
> in mconsole_user.c). What function should I use to pull information from
> the socket?

Note: I've read your message quickly, so I'm not sure.
On the host? In mconsole_user.c there are some wrappers to call recv*() and=
=20
send*() (or something such).

In this case, you should patch mconsole_get_request, to understand also the=
=20
requests you are going to send. However, the host must use a special reques=
t,=20
or mconsole will get confused - otherwise, if this is not possible for you,=
=20
you might create a new socket on the host just for this purpose (note that =

IIRC you cannot anyway use "cat " on the host socket, even if I have 0=20
experience with sockets).

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
