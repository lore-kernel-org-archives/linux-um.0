Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ENonP-0005pm-Jt	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 02:45:43 -0700
Received: from wproxy.gmail.com ([64.233.184.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ENonO-0005r6-Fb
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 02:45:43 -0700
Received: by wproxy.gmail.com with SMTP id i4so320686wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 07 Oct 2005 02:45:36 -0700 (PDT)
Message-ID: <229e70f20510070245t6abdfe69s88a323bec24ba8be@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
Reply-To: Etay Meiri <etay.meiri@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_46304_24562823.1128678336031"
Subject: [uml-devel] RPM problem in UML rootfs of FC4
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
Date: Fri, 7 Oct 2005 11:45:36 +0200
To: user-mode-linux-devel@lists.sourceforge.net

------=_Part_46304_24562823.1128678336031
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Was anyone successful in getting rpm running in the FC4 root fs from:
http://uml.harlowhill.com/index.php/UML_Fedora_Core_4 ?

I followed all the instructions, UML is working fine but all rpm invocation=
s
cause the following error:

[root@uml-test ~]# rpm -qa
rpmdb: unable to initialize mutex: Function not implemented
rpmdb: /var/lib/rpm/__db.001: unable to initialize environment lock:
Function not implemented
error: db4 error(38) from dbenv->open: Function not implemented
error: cannot open Packages index using db3 - Function not implemented (38)
error: cannot open Packages database in /var/lib/rpm

Thanks,

--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_46304_24562823.1128678336031
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
Was anyone successful in getting rpm running in the FC4 root fs from:<br>
<a href=3D"http://uml.harlowhill.com/index.php/UML_Fedora_Core_4">http://um=
l.harlowhill.com/index.php/UML_Fedora_Core_4</a>&nbsp;&nbsp;&nbsp; ?<br cle=
ar=3D"all"><br>
I followed all the instructions, UML is working fine but all rpm invocation=
s<br>
cause the following error:<br>
<br>
[root@uml-test ~]# rpm -qa<br>
rpmdb: unable to initialize mutex: Function not implemented<br>
rpmdb: /var/lib/rpm/__db.001: unable to initialize environment lock: Functi=
on not implemented<br>
error: db4 error(38) from dbenv-&gt;open: Function not implemented<br>
error: cannot open Packages index using db3 - Function not implemented (38)=
<br>
error: cannot open Packages database in /var/lib/rpm<br>
<br>
Thanks,<br>
<br>-- <br>------------------------------------------------------<br>Etay M=
eiri<br><a href=3D"mailto:etay.meiri@gmail.com">etay.meiri@gmail.com</a>

------=_Part_46304_24562823.1128678336031--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
