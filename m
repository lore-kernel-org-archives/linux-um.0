Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6b6N-00054m-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 06 Oct 2003 12:33:03 -0700
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A6b6L-0005Sh-2C
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 06 Oct 2003 12:33:01 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: pthreads?
References: <878you2xu2.fsf@bytesex.org> <Pine.GSO.4.21.0309121104430.2312-100000@vervain.sonytel.be> <20031002090834.GS24534@vagabond>
In-Reply-To: <20031002090834.GS24534@vagabond>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200310061529.16173.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 6 Oct 2003 15:29:16 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 11:08, gioved=EC 2 ottobre 2003, Jan Hudec ha scritto:
> On Fri, Sep 12, 2003 at 11:07:54 +0200, Geert Uytterhoeven wrote:
> > BTW, it's libX11 that needs libpthread...
>
> bulb@vagabond:~$ ldd /usr/X11R6/lib/libX11.so.6.2
> 	libdl.so.2 =3D> /lib/libdl.so.2 (0x400d5000)
> 	libc.so.6 =3D> /lib/libc.so.6 (0x400d8000)
> 	/lib/ld-linux.so.2 =3D> /lib/ld-linux.so.2 (0x80000000)
>
> Not see libpthread anywhere around!
Yes, but obviously since it's dinamically loaded, it mustn't be reported.=20
libdl is used for this(Dinamic Loading). While I run gedit, which seems to =

run only 1 thread, and in its /proc/<pid>/maps found libpthread. While I ra=
n=20
xev(which is simple) and didn't find libpthread. Coming back to Gtk, I run =
nm=20
-D on /usr/lib/libglib-2.0.so and it didn't find the "pthr" string, but did=
=20
find the "thread" string(with names I think come from the gthread lib). So,=
=20
they can use pthread, even if this library doesn't appear in ldd output. Ho=
w=20
they do is another problem: probably to use thread, the program will have t=
o=20
be linked to libgthread/pthread.
>
> However, I just checked gmodule and glib and neither seems to report
> libpthread either!
>
> However, I just ran the simplest gtk-2.0 program I could find
Which is this one? It seems like gedit it's too complex....
> and greped
> it's /proc/<pid>/maps for string pthr. NOT FOUND.
>
> Thus it really looks like gtk-2.0 application does NOT have to use
> pthreads!

--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
