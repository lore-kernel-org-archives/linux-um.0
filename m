Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdwRH-0001kg-Nl for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 11:00:27 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AdwRG-0004bC-Df for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 11:00:26 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000,
	ip 0x400e51a4 (fwd)
References: <Pine.LNX.4.58.0401070219030.1840@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.58.0401070219030.1840@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401062000.08665.blaisorblade_spam@yahoo.it>
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
Date: Tue, 6 Jan 2004 20:00:08 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 19:23, marted=EC 6 gennaio 2004, Jeff Chua ha scritto:

> read(3, Kernel panic: Kernel mode fault at addr 0x48965000, ip 0x400df1a4
> It seems to break while reading /dev/kmem
This is likely, since a change to the /dev/kmem driver is in the patch=20
starting with 2.4.22-6 (not in -5). It was needed to fix another bug. By th=
e=20
way, what is your exact command line? I've a suspect... (but I've been=20
careful enough).

diff -Naur -X ../exclude-files orig/drivers/char/mem.c um/drivers/char/mem.c
--- orig/drivers/char/mem.c     2003-08-29 17:25:51.000000000 -0400
+++ um/drivers/char/mem.c       2003-11-09 03:17:45.000000000 -0500
@@ -209,6 +209,8 @@
        return 0;
 }

+extern unsigned long uml_physmem;
+
 /*
  * This function reads the *virtual* memory as seen by the kernel.
  */
@@ -219,7 +221,8 @@
        ssize_t read =3D 0;
        ssize_t virtr =3D 0;
        char * kbuf; /* k-addr because vread() takes vmlist_lock rwlock */
-
+
+       p +=3D uml_physmem;
        if (p < (unsigned long) high_memory) {
                read =3D count;
                if (count > (unsigned long) high_memory - p)
@@ -268,7 +271,7 @@
                }
                free_page((unsigned long)kbuf);
        }
-       *ppos =3D p;
+       *ppos =3D p - uml_physmem;
        return virtr + read;
 }


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
