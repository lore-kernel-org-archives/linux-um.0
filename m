Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuEgt-0003re-RU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 09:43:55 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AuERy-0008Nv-JK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 09:28:30 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <200402162004.i1GK4isq024309@ccure.user-mode-linux.org>
In-Reply-To: <200402162004.i1GK4isq024309@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402201837.13918.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: 2.4.24-1um - exec-shield - [PATCH][RFC] memory
	shortness fix
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
Date: Fri, 20 Feb 2004 18:37:13 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: M A Young <m.a.young@durham.ac.uk>

Alle 21:04, luned=EC 16 febbraio 2004, Jeff Dike ha scritto:
> This patch updates UML to 2.4.24, and pushes out the fixes that have
> accumulated, including

>         fixed some exec_shield brokenness.

I diffed the two patches (2.4.23-2 and 2.4.24-1) and what I saw was that yo=
u=20
just applied first part of Young's patch. I.e. the user actually gets less =

memory, as in his first patch, so the kernel will crash when it would be=20
exhausting memory. Have you thought to something? IMHO, the broken code is =

this one in setup_physmem():

+       offset =3D uml_reserved - uml_physmem;
+       err =3D os_map_memory((void *) uml_reserved, physmem_fd, offset,
+                           len - offset, 1, 1, 0);

because uml_reserved is (in this point) sbrk(0) rounded up to 4 M:=20

+       /* Reserve up to 4M after the current brk */
+       uml_reserved =3D ROUND_4M(brk_start) + (1 << 22);

the setup_physmem code thinks that "offset" bytes of real memory have alrea=
dy=20
been allocated, while this is not true. Also, after calling setup_physmem y=
ou=20
change uml_reserved:

+       /* Map in the area just after the brk now that kmalloc is about
+        * to be turned on.
+        */
+       brk_end =3D (unsigned long) UML_ROUND_UP(sbrk(0));
+       map_cb(NULL);
+       initial_thread_cb(map_cb, NULL);
+       free_bootmem(__pa(brk_end), uml_reserved - brk_end);
+       uml_reserved =3D brk_end;

This seems to me a bit inconsistent and difficult to read (uml_reserved is =
a=20
global variable); the 4 missing megas (reserved to give some space to=20
malloc() before kmalloc can be used through __wrap_malloc) are then remappe=
d=20
by map_cb, but this sounds a bit kludgy.

Anyway, changing uml_reserved that way deserves at least a comment.

The simple fix would be IMHO to add in setup_physmem:

  offset -=3D UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);

similarly to what Young proposed, (something similar but less kludgy could =
be=20
put here); but his fix was just like increasing the mem=3D param on the com=
mand=20
line, and the increased value is then passed to init_maps so that=20
totalram_pages (i.e. how much memory the kernel thinks to have) will be the=
=20
increased one: once again, the kernel has less memory than it thinks to hav=
e;=20
so instead of swapping when memory ends UML will crash.

Instead, with this one, UML still thinks to have 32 mega and gets them.

Any idea or comment?
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
