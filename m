Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <martin.partel@gmail.com>) id 1ScdsU-0006Bd-A6
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 14:39:58 +0000
Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ScdsO-0005Pv-VW
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 14:39:58 +0000
Received: by lags15 with SMTP id s15so534962lag.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 07 Jun 2012 07:39:46 -0700 (PDT)
Message-ID: <4FD0BD2F.4090002@gmail.com>
Date: Thu, 07 Jun 2012 17:39:43 +0300
From: =?ISO-8859-1?Q?Martin_P=E4rtel?= <martin.partel@gmail.com>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] um: fix ubd_file_size for read-only files
To: user-mode-linux-devel@lists.sourceforge.net

Made ubd_file_size not request write access. Fixes use of read-only images.

Signed-off-by: Martin P=E4rtel <martin.partel@gmail.com>
---
diff -uprN -X linux-3.4.1/Documentation/dontdiff linux-3.4.1/arch/um/driver=
s/ubd_kern.c linux-3.4.1-mod/arch/um/drivers/ubd_kern.c
--- linux-3.4.1/arch/um/drivers/ubd_kern.c	2012-06-01 10:18:44.000000000 +0=
300
+++ linux-3.4.1-mod/arch/um/drivers/ubd_kern.c	2012-06-07 17:02:38.62545350=
4 +0300
@@ -514,7 +514,7 @@ static inline int ubd_file_size(struct u
 		goto out;
 	}
 =

-	fd =3D os_open_file(ubd_dev->file, global_openflags, 0);
+	fd =3D os_open_file(ubd_dev->file, of_read(OPENFLAGS()), 0);
 	if (fd < 0)
 		return fd;
 =


---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

