Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AUrst-0006M5-De
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Dec 2003 10:19:27 -0800
Received: from mout1.freenet.de ([194.97.50.132])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AUrst-0007XQ-29
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Dec 2003 10:19:27 -0800
Received: from [194.97.50.138] (helo=mx0.freenet.de)
	by mout1.freenet.de with asmtp (Exim 4.30)
	id 1AUrsm-0008Tg-G8
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Dec 2003 19:19:20 +0100
Received: from b29f6.b.pppool.de ([213.7.41.246] helo=home.petschge.de)
	by mx0.freenet.de with esmtp (Exim 4.30 #1)
	id 1AUrsl-0006Bf-8D
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Dec 2003 19:19:20 +0100
Received: from localhost (localhost [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id 54E183BCB8
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Dec 2003 19:17:08 +0100 (CET)
Received: from mars (localhost [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id 8D2B83BCB7
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Dec 2003 19:17:05 +0100 (CET)
Content-Type: text/plain; charset="iso-8859-15"
From: Patrick Kilian <petschge@gmx.de>
Reply-To: petschge@web.de
MIME-Version: 1.0
Message-Id: <200312121917.05059.petschge@gmx.de>
Subject: [uml-devel] linux-2.4.23
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 12 Dec 2003 19:17:05 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

when trying to compile linux-2.4.23 from kernel.org patched with=20
uml_patch-2.4.22-uml6 I get the following error:

make all_targets
make[2]: Wechsel in das Verzeichnis Verzeichnis=20
=BB/usr/src/linux-2.4.23-uml/fs=AB
gcc -D__KERNEL__ -I/usr/src/linux-2.4.23-uml/include -Wall=20
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =20
-U__i386__ -Ui386 -DUM_FASTCALL -g -D__arch_um__ -DSUBARCH=3D"i386"=20
-D_LARGEFILE64_SOURCE -I/usr/src/linux-2.4.23-uml/arch/um/include=20
-Derrno=3Dkernel_errno=20
-I/usr/src/linux-2.4.23-uml/arch/um/kernel/tt/include=20
-I/usr/src/linux-2.4.23-uml/arch/um/kernel/skas/include   -nostdinc=20
-iwithprefix include -DKBUILD_BASENAME=3Dbinfmt_elf  -c -o binfmt_elf.o=20
binfmt_elf.c
binfmt_elf.c:806: macro `ELF_PLAT_INIT' used with too many (2) args
make[2]: *** [binfmt_elf.o] Fehler 1
make[2]: Verlassen des Verzeichnisses Verzeichnis=20
=BB/usr/src/linux-2.4.23-uml/fs=AB
make[1]: *** [first_rule] Fehler 2
make[1]: Verlassen des Verzeichnisses Verzeichnis=20
=BB/usr/src/linux-2.4.23-uml/fs=AB
make: *** [_dir_fs] Fehler 2

Is this a know behavourier? Is there a workaround other than to wait for=20
uml_patch-2.4.23-uml1?

mfg,
Patrick "Petschge" Kilian


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
