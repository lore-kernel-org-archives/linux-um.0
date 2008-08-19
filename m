Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVKPH-0004Mq-D6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 23:09:27 -0700
Received: from courier.cs.helsinki.fi ([128.214.9.1] helo=mail.cs.helsinki.fi)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVKPF-0006Vl-VJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 23:09:27 -0700
Date: Tue, 19 Aug 2008 09:09:16 +0300 (EEST)
From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Message-ID: <Pine.LNX.4.64.0808190904200.4551@wrl-59.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-696208474-1272281867-1219126156=:4551"
Subject: [uml-devel] [RFC PATCH] uml: fix double statement if missing braces
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696208474-1272281867-1219126156=:4551
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

...I'm not fully sure what's the intention here, ie., whether
the return belongs to a block with the assignment or not.

Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>
---
 arch/um/os-Linux/sys-i386/tls.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/sys-i386/tls.c b/arch/um/os-Linux/sys-i386/tl=
s.c
index 32ed41e..2a1412d 100644
--- a/arch/um/os-Linux/sys-i386/tls.c
+++ b/arch/um/os-Linux/sys-i386/tls.c
@@ -24,11 +24,12 @@ void check_host_supports_tls(int *supports_tls, int *tl=
s_min) {
 			*supports_tls =3D 1;
 			return;
 		} else {
-			if (errno =3D=3D EINVAL)
+			if (errno =3D=3D EINVAL) {
 				continue;
-			else if (errno =3D=3D ENOSYS)
+			} else if (errno =3D=3D ENOSYS) {
 				*supports_tls =3D 0;
 				return;
+			}
 		}
 	}
=20
--=20
1.5.2.2

---696208474-1272281867-1219126156=:4551
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
---696208474-1272281867-1219126156=:4551
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

---696208474-1272281867-1219126156=:4551--

