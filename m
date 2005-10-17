Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERYUa-00019e-P4	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Oct 2005 10:09:44 -0700
Received: from wproxy.gmail.com ([64.233.184.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ERYUW-0004f5-DF
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Oct 2005 10:09:44 -0700
Received: by wproxy.gmail.com with SMTP id i5so479232wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 17 Oct 2005 10:09:21 -0700 (PDT)
Message-ID: <229e70f20510171009x103fe854ncb91021c3ce0e31e@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5554_4054200.1129568961511"
Subject: [uml-devel] Starting uml with the debugger
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
Date: Mon, 17 Oct 2005 19:09:21 +0200
To: user-mode-linux-devel@lists.sourceforge.net

------=_Part_5554_4054200.1129568961511
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm trying to start uml under the controller of gdb using the following
command:

./vmlinux mem=3D128m ubda=3Droot_fs.fc4_client ubdb=3Dswap_client con=3Dxte=
rm
eth0=3Dtuntap,,,10.10.20.10 <http://10.10.20.10> debug

uml is started ok but there is no sigh of the debugger.

Any idea?

Thanks,

--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_5554_4054200.1129568961511
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
I'm trying to start uml under the controller of gdb using the following com=
mand:<br>
<br>
./vmlinux mem=3D128m ubda=3Droot_fs.fc4_client ubdb=3Dswap_client con=3Dxte=
rm eth0=3Dtuntap,,,<a href=3D"http://10.10.20.10">10.10.20.10</a> debug<br =
clear=3D"all"><br>
uml is started ok but there is no sigh of the debugger.<br>
<br>
Any idea?<br>
<br>
Thanks,<br>
<br>-- <br>------------------------------------------------------<br>Etay M=
eiri<br><a href=3D"mailto:etay.meiri@gmail.com">etay.meiri@gmail.com</a>

------=_Part_5554_4054200.1129568961511--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
