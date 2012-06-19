Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <david@dit.upm.es>) id 1SguEX-0002u8-LM
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Jun 2012 08:56:21 +0000
Received: from mail.dit.upm.es ([138.4.2.7])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SguEO-0005pH-WF
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Jun 2012 08:56:21 +0000
Message-ID: <4FE03E76.7090400@dit.upm.es>
Date: Tue, 19 Jun 2012 10:55:18 +0200
From: =?ISO-8859-1?Q?David_Fern=E1ndez?= <david@dit.upm.es>
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
Subject: [uml-devel] ubd option parsing problem when using cow filesystems
	in kernel 3.4
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

It seems that the parsing of ubd option is broken in kernels 3.4.X when =

using COW filesystems. Let me show the tests I've done so far.

When starting a virtual machine using a cow fs without pathname:

   linux-3.4.1 udba=3Dcow_fs,debian.img

it works, but the cow file created is named 'cow_fs,debian.img' instead =

of 'cow_fs'.

However, when specifying full pathnames for the cow and root filesystem:

   linux-3.4.1 udba=3D/pathto/cow_fs,/pathto/debian.img

you get a kernel panic and the following errors:

   Open of COW file '/root/uml/test/cow_fs,/root/uml/test/debian.img' =

failed, errno =3D 2
   Failed to open '/root/uml/test/cow_fs,/root/uml/test/debian.img', =

errno =3D 2
   ubda: Can't open "/root/uml/test/cow_fs,/root/uml/test/debian.img": =

errno =3D 2
   Open of COW file '/root/uml/test/cow_fs,/root/uml/test/debian.img' =

failed, errno =3D 2
   Failed to open '/root/uml/test/cow_fs,/root/uml/test/debian.img', =

errno =3D 2
   ubda: Can't open "/root/uml/test/cow_fs,/root/uml/test/debian.img": =

errno =3D 2
   VFS: Cannot open root device "98:0" or unknown-block(98,0): error -2
   Please append a correct "root=3D" boot option; here are the available =

partitions:
   6200         2097152 ubda  driver: uml-blkdev
   Kernel panic - not syncing: VFS: Unable to mount root fs on =

unknown-block(98,0)

The same tests work perfectly with kernel 3.3.8 and older versions. To =

test I've used a debian 6.0 rootfs.

Any idea of the cause of the problem? A simple 'diff' between 3.3 and =

3.4 versions shows the option parsing code has changed significantly.

Best regards,
David Fern=E1ndez
Virtual Networks over linuX (VNX)
http://vnx.dit.upm.es

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

