Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOL1R-0001pH-3x for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 May 2004 11:33:33 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BOL1Q-0003VI-AK for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 May 2004 11:33:32 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Seeking real kernel bugs mirrored in UML
References: <Pine.LNX.4.60.0405121355060.12720@stclair.eecs.umich.edu>
In-Reply-To: <Pine.LNX.4.60.0405121355060.12720@stclair.eecs.umich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200405122041.12475.blaisorblade_spam@yahoo.it>
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
Date: Wed, 12 May 2004 20:41:12 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:11, mercoled=EC 12 maggio 2004, George Washington Dunlap III ha scr=
itto:
> I'm looking for a bug in any recent version of linux (probably 2.4.18+)
> that would be mirrored in User Mode Linux.  We were thinking probably a
> filesystem bug, but anything would do.  Preferred are bugs that are very
> difficult using traditional iterative debugging techniques: namely, ones
> that involve
>   * a race condition
>   * corruption of the stack / data
>
> I need to know:
>   * What version of linux / UML the bug is in.
>   * The conditions needed to trigger it.

Well, the first idea I have is to check changelogs for them. I remember one=
=20
(fixed in 2.4.25 - check the changelogs) that occurred with /dev/shm when y=
ou=20
run updatedb on it (there are even littler test programs). Since distros ma=
ke=20
updatedb not run on tmpfs folders, this normally does not show, but reenabl=
e=20
updatedb on it (check /etc/updatedb.conf, usually) and you'll see by sure a=
=20
kernel panic, both on a host and on a guest system. Since this disabling do=
es=20
not work from inside a UML for the host /dev/shm mounted through hostfs, th=
at=20
caused the UML's to crash misteriously when they were left running with=20
hostfs mounted.

The fix is a oneliner from James W McMechan <mcmechanjw@juno.com>:

diff -urN linux-2.4.24/fs/readdir.c linux-2.4.25/fs/readdir.c
--- linux-2.4.24/fs/readdir.c   2002-08-02 17:39:45.000000000 -0700
+++ linux-2.4.25/fs/readdir.c   2004-02-18 05:36:31.000000000 -0800
@@ -69,6 +69,7 @@
                        loff_t n =3D file->f_pos - 2;

                        spin_lock(&dcache_lock);
+                       list_del(&cursor->d_child);
                        p =3D file->f_dentry->d_subdirs.next;
                        while (n && p !=3D &file->f_dentry->d_subdirs) {
                                struct dentry *next;
@@ -77,7 +78,6 @@
                                        n--;
                                p =3D p->next;
                        }
-                       list_del(&cursor->d_child);
                        list_add_tail(&cursor->d_child, p);
                        spin_unlock(&dcache_lock);
                }

Even with the patch, figuring out what is the bug is hard. The problem is t=
hat=20
the old version calls list_del while p is onto cursor->d_child (or close to=
=20
it - I don't remember well): anyway this results in a NULL pointer=20
dereference in list_add_tail.

Sorry it is not a race condition - for that search in the changelogs for=20
changes in locking.

For a race condition, look on the ML for 2.6 - UML race conditions fixed in=
=20
the 2.6.4 patch - the fixes with description were posted together with=20
patches.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id%62&alloc_ida84&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
