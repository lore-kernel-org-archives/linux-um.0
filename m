Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1Wvh-00083o-Rb for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2004 14:09:37 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C1Wvg-0001cp-Th for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2004 14:09:37 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] tcsetattr returning -1, errno = EINTR
References: <41109B81.3030202@hevanet.com>
In-Reply-To: <41109B81.3030202@hevanet.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8A2KBRluY7PX/fc"
Message-Id: <200408241735.25186.blaisorblade_spam@yahoo.it>
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
Date: Tue, 24 Aug 2004 17:35:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Matt Clay <mattclay@hevanet.com>


--Boundary-00=_8A2KBRluY7PX/fc
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 10:17, mercoled=EC 4 agosto 2004, Matt Clay ha scritto:
> While booting UML in skas mode, I've noticed occasional glitches in the
> console output during the boot process.  At first I thought this was
> related to bug #260111, but now that Allen Chan has found the cause, I'm
> still having this problem after using the move_console_write patch.
>
> Sometimes the console output shows up like this:
>
> <snip>
> NET4: Linux TCP/IP 1.0 for NET4.0
>                                   IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> <snip>
>
> I've tracked this back to calls to tcsetattr failing in
> generic_console_write.  It returns -1, and sets errno to 4 (EINTR).  I
> don't know if failed calls should be restarted or not, but I'm pretty sure
> ignoring the errors isn't a good idea.
Yes, it should be restarted.

=46or avoiding too much boilerplate in such cases, see the CATCH_EINTR macr=
o=20
added in the catch-eintr patch (included in the late 2.4 and 2.6 -um trees,=
=20
see the changelogs for the links). See the attached code, and give an opini=
on=20
=2D I'm not sure it is the exact one.
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_8A2KBRluY7PX/fc
Content-Type: text/x-diff; charset="iso-8859-15";
	name="uml-catch_eintr_generic_console_write.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="uml-catch_eintr_generic_console_write.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.7-paolo/arch/um/drivers/chan_user.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff -puN arch/um/drivers/chan_user.c~catch_eintr_generic_console_write arch/um/drivers/chan_user.c
--- uml-linux-2.6.7/arch/um/drivers/chan_user.c~catch_eintr_generic_console_write	2004-08-24 17:13:31.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/drivers/chan_user.c	2004-08-24 17:30:22.000000000 +0200
@@ -31,23 +31,32 @@ struct winch_data {
 	int close_me;
 };
 
-/* XXX This breaks horribly (by hanging UML) when moved to chan_kern.c - 
- * needs investigation
- */
 int generic_console_write(int fd, const char *buf, int n, void *unused)
 {
 	struct termios save, new;
 	int err;
 
 	if(isatty(fd)){
-		tcgetattr(fd, &save);
+		CATCH_EINTR(err = tcgetattr(fd, &save));
+		if (err)
+			goto error;
 		new = save;
+		/*The terminal becomes a bit less raw, to handle \n
+		 * also as "Carriage Return", not only as "New Line".*/
 		new.c_oflag |= OPOST;
-		tcsetattr(fd, TCSAFLUSH, &new);
+		CATCH_EINTR(err = tcsetattr(fd, TCSAFLUSH, &new));
+		if (err)
+			goto error;
 	}
 	err = generic_write(fd, buf, n, NULL);
-	if(isatty(fd)) tcsetattr(fd, TCSAFLUSH, &save);
+	/*Restore raw mode, in any case; we *must* ignore any error
+	 * apart EINTR, except for debug.*/
+	if(isatty(fd))
+		CATCH_EINTR(tcsetattr(fd, TCSAFLUSH, &save));
+out:
 	return(err);
+error:
+	return(-errno);
 }
 
 static int winch_thread(void *arg)
_

--Boundary-00=_8A2KBRluY7PX/fc--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
