Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVacO-0004LO-Ny for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:19:01 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GVacK-0005ck-PI
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:19:00 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 5 Oct 2006 13:33:15 +0200
References: <451E9BAB.5030009@linuxbox.cz> <451FE3F0.1070304@linuxbox.cz>
	<45202C79.5080502@linuxbox.cz>
In-Reply-To: <45202C79.5080502@linuxbox.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_71OJF+XCIhoBqc0"
Message-Id: <200610051333.15711.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS mode not working, x86_64 SMP host, x86_64 guest, 
	problems with noprocmm
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nikola Ciprich <nikola.ciprich@linuxbox.cz>

--Boundary-00=_71OJF+XCIhoBqc0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sunday 01 October 2006 23:00, Nikola Ciprich wrote:
> OK, so I've tested 2.6.18-mm2, results are:
> pcap network transport seems to be broken, and doesn't compile, I had to
> disable it
Attached patch should fix it (it's against git head but should be the same 
thing).
> apart from that, all of behavior described before remains the same,
> nothing behaves neither better, nor worse...
> n.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_71OJF+XCIhoBqc0
Content-Type: text/x-diff; charset="iso-8859-1";
	name="const-def-after-decl-pcap.diff"
Content-Disposition: attachment;
	filename="const-def-after-decl-pcap.diff"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by nerdnet.nl id
	k95LJ74b011340

uml: make pcap driver compile again
From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix this error:
arch/um/drivers/pcap_user.c:124: error:  conflicting type qualifiers for =
=E2=80=98pcap_user_info=E2=80=99
arch/um/drivers/pcap_user.h:18: error: previous declaration of =E2=80=98p=
cap_user_info=E2=80=99 was here

the definition recently became const.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/um/drivers/pcap_user.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.git.orig/arch/um/drivers/pcap_user.h
+++ linux-2.6.git/arch/um/drivers/pcap_user.h
@@ -15,7 +15,7 @@ struct pcap_data {
 	void *dev;
 };
=20
-extern struct net_user_info pcap_user_info;
+extern const struct net_user_info pcap_user_info;
=20
 extern int pcap_user_read(int fd, void *buf, int len, struct pcap_data *=
pri);
=20

--Boundary-00=_71OJF+XCIhoBqc0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_71OJF+XCIhoBqc0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_71OJF+XCIhoBqc0--

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

