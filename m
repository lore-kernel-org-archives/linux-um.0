Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H8SXK-0000Yn-UM for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Jan 2007 18:34:26 -0800
Received: from web15301.mail.cnb.yahoo.com ([203.209.230.31])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H8SXI-0008Ns-TV
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Jan 2007 18:34:26 -0800
Date: Sun, 21 Jan 2007 10:34:11 +0800 (CST)
From: An Ching <an.ching@yahoo.com.cn>
MIME-Version: 1.0
Message-ID: <420863.17264.qm@web15301.mail.cnb.yahoo.com>
Subject: [uml-devel] Something wrong with booting the UML in new kernel
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1735458886=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

--===============1735458886==
Content-Type: multipart/alternative; boundary="0-1804006600-1169346851=:17264"

--0-1804006600-1169346851=:17264
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by nerdnet.nl id
	l0L2YUjb016277

Hi,

I had recompiled my host kernel with setting the EXT2_FS_SECURITY and EXT=
3_FS_SECURITY in filesystem configuration. My UML is OK before doing this=
, but now I can not boot the UML in the new-recompiled kernel. It just we=
nt to the step...

[root@RH9 linux-2.6.17]# ./linux root=3D/dev/sda1 rootflags=3D/ rootfstyp=
e=3Dhostfs ro con0=3Dfd:0,fd;1 init/bin/sh -l
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK

Just down to this step, and not any response next...

I guessed maybe the kernel of UML didn't support the XATTR  of filesystem=
 and then I reconfigured the UML and set EXT2_XATTR, EXT2_FS_SECURITY, EX=
T3_XATTR, EXT3_FS_SECURITY to "Y". But after I recompiled the kernel of U=
ML and run it,  I  was given the same  message mentioned above.

What should do  next?   Could anybody  give me some advices?

Thank you very much~

Best Regards,

An  Ching=20

 	=09
---------------------------------
 =D1=C5=BB=A2=C3=E2=B7=D1=D3=CA=CF=E4-3.5G=C8=DD=C1=BF=A3=AC20M=B8=BD=BC=FE
--0-1804006600-1169346851=:17264
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by nerdnet.nl id
	l0L2YUjb016277

Hi,<br><br>I had recompiled my host kernel with setting the EXT2_FS_SECUR=
ITY and EXT3_FS_SECURITY in filesystem configuration. My UML is OK before=
 doing this, but now I can not boot the UML in the new-recompiled kernel.=
 It just went to the step...<br><br>[root@RH9 linux-2.6.17]# ./linux root=
=3D/dev/sda1 rootflags=3D/ rootfstype=3Dhostfs ro con0=3Dfd:0,fd;1 init/b=
in/sh -l<br>Checking that ptrace can change system call numbers...OK<br>C=
hecking syscall emulation patch for ptrace...OK<br>Checking advanced sysc=
all emulation patch for ptrace...OK<br>Checking for tmpfs mount on /dev/s=
hm...OK<br>Checking PROT_EXEC mmap in /dev/shm/...OK<br>Checking for the =
skas3 patch in the host:<br>&nbsp; - /proc/mm...not found<br>&nbsp; - PTR=
ACE_FAULTINFO...not found<br>&nbsp; - PTRACE_LDT...not found<br>UML runni=
ng in SKAS0 mode<br>Checking that ptrace can change system call numbers..=
.OK<br>Checking syscall emulation patch for ptrace...OK<br>Checking advan=
ced syscall emulation patch for
 ptrace...OK<br><br>Just down to this step, and not any response next...<=
br><br>I guessed maybe the kernel of UML didn't support the XATTR&nbsp; o=
f filesystem and then I reconfigured the UML and set EXT2_XATTR, EXT2_FS_=
SECURITY, EXT3_XATTR, EXT3_FS_SECURITY to "Y". But after I recompiled the=
 kernel of UML and run it,&nbsp; I&nbsp; was given the same&nbsp; message=
 mentioned above.<br><br>What should do&nbsp; next?&nbsp;&nbsp; Could any=
body&nbsp; give me some advices?<br><br>Thank you very much~<br><br>Best =
Regards,<br><br>An&nbsp; Ching <br><p>&#32;
		<hr size=3D1><a href=3D"http://cn.mail.yahoo.com/" target=3Dblank>=20
=D1=C5=BB=A2=C3=E2=B7=D1=D3=CA=CF=E4-3.5G=C8=DD=C1=BF=A3=AC20M=B8=BD=BC=FE
</a>
--0-1804006600-1169346851=:17264--


--===============1735458886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1735458886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1735458886==--
