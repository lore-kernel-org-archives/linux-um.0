Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AaJLm-0000uD-Ts
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 27 Dec 2003 10:39:46 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AaJCr-0006ES-BR
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 27 Dec 2003 10:30:33 -0800
From: BlaisorBlade <blaisorblade_work@yahoo.it>
References: <200312242019.23335.blaisorblade_work@yahoo.it> <20031225104559.A23615@infradead.org>
In-Reply-To: <20031225104559.A23615@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312271835.36286.blaisorblade_work@yahoo.it>
Subject: [uml-devel] Re: [kbuild-devel] Needed help for UML kbuild.
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 27 Dec 2003 18:35:35 +0100
Content-Transfer-Encoding: quoted-printable
To: kbuild-devel@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 11:45, gioved=EC 25 dicembre 2003, Christoph Hellwig ha scritto:

> Please don't use shouting names..

Ok. Then user-objs; or if this could be used somewhere else, uml-user-objs.

> > The list always contains, in the arch/um subfolders, all objects whose
> > name matches %_user.o(as it has always been for UML).
>
> This doesn't sound like a good heuristic, imagine a driver using e.g.
> foo_user.c for the chardev user interface.

UML 2.4 has been written with this in mind. If an UML file is named *_user.=
c,=20
that already means that it needs special treatment. Everywhere inside=20
arch/um.
So the heuristic does work, for UML (and only for UML). Really.

> In general I'd suggest adding
> parallel infrastructure for user-$(CONFIG_FOO) variables in addition to
> the current obj-* and host-*.  The only problem you could get with that
> is that you need to take special care of the link order.

In general you are right. But the current content of the average UML Makefi=
le=20
is like this:

<setting obj-y and obj-m the normal way>

<1:> USER_SINGLE_OBJS =3D $(foreach f,$(patsubst %.o,%,$(obj-y)=20
$(obj-m)),$($(f)-objs))

<2:> USER_OBJS =3D $(filter %_user.o,$(obj-y) $(obj-m) $(USER_SINGLE_OBJS))=
 fd.o=20
\
        null.o pty.o tty.o xterm.o

<3:> $(USER_OBJS) : %.o: %.c
        $(CC) $(CFLAGS_$@) $(USER_CFLAGS) -c -o $@ $<

And this content is repeated for each single Makefile.

That becomes, with the API I suggest:

<setting obj-y and obj-m as always>
user-objs +=3D  fd.o null.o pty.o tty.o xterm.o

But if you don't like that heuristic, this means that <1:> and <2:> remain =

repeated in each Makefile, while only <3:> can be removed.
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
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
