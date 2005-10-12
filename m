Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EPhBa-0001Dm-Rw	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Oct 2005 07:02:26 -0700
Received: from wproxy.gmail.com ([64.233.184.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EPhB0-0004je-E4
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Oct 2005 07:02:23 -0700
Received: by wproxy.gmail.com with SMTP id i5so48510wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 Oct 2005 07:01:26 -0700 (PDT)
Message-ID: <229e70f20510120701r3d5698ccy992263fac8a8082a@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7016_2990730.1129125686828"
Subject: [uml-devel] swap problem
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
Date: Wed, 12 Oct 2005 16:01:26 +0200
To: user-mode-linux-devel@lists.sourceforge.net

------=_Part_7016_2990730.1129125686828
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm unable to get the swap file working with uml (2.6.13-bs2).
I created a 512Mb file using dd and formatted it using 'mkswap ./swap'.
I start uml with the command:
vmlinux mem=3D128m ubd0d=3Droot_fs.fc4 ubd1d=3Dswap
eth0=3Dtuntap,,,10.10.20.6<http://10.10.20.6>
I've got 8 devices under /dev/ubd and only /dev/ubd/0 seems to be working
and used for the root partition.
I see the following messages during the boot:
.
.
[42949373.340000] ubda: unknown partition table
[42949373.340000] ubdb: unknown partition table
.
.
Enabling swap space: swapon: /dev/ubd/1: No such device or address [FAILED]

Any idea?

Thanks,

--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_7016_2990730.1129125686828
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
I'm unable to get the swap file working with uml (2.6.13-bs2).<br>
I created a 512Mb file using dd and formatted it using 'mkswap ./swap'.<br>
I start uml with the command:<br>
vmlinux mem=3D128m ubd0d=3Droot_fs.fc4 ubd1d=3Dswap eth0=3Dtuntap,,,<a href=
=3D"http://10.10.20.6">10.10.20.6</a><br>
I've got 8 devices under /dev/ubd and only /dev/ubd/0 seems to be working<b=
r>
and used for the root partition. <br>
I see the following messages during the boot:<br>
.<br>
.<br>
[42949373.340000]&nbsp; ubda: unknown partition table<br>
[42949373.340000]&nbsp; ubdb: unknown partition table<br>
.<br>
.<br>
Enabling swap space:&nbsp; swapon: /dev/ubd/1: No such device or address [F=
AILED]<br>
<br>
Any idea?<br>
<br>
Thanks,<br clear=3D"all"><br>-- <br>---------------------------------------=
---------------<br>Etay Meiri<br><a href=3D"mailto:etay.meiri@gmail.com">et=
ay.meiri@gmail.com</a>

------=_Part_7016_2990730.1129125686828--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
