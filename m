Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYtrv-0003HY-D0 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Nov 2005 15:24:11 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EYtrs-000882-ON
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Nov 2005 15:24:11 -0800
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200511061723.32848.rob@landley.net>
Subject: [uml-devel] Does UML 2.6.14 work under x86-64?
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
Date: Sun, 6 Nov 2005 17:23:32 -0600
Content-Transfer-Encoding: quoted-printable
To: David Lang <dlang@invendra.net>, user-mode-linux-devel@lists.sourceforge.net

David Lang is trying to get my firmware build working under x86-64, and whe=
n I=20
upgraded him to 2.6.14 (to get around the memory leak in 2.6.13.2), he=20
started getting this:

>> Checking PROT_EXEC mmap in /tmp...OK
>> Checking for the skas3 patch in the host:
>> =A0 =A0- /proc/mm...not found
>> =A0 =A0- PTRACE_FAULTINFO...not found
>> =A0 =A0- PTRACE_LDT...not found
>> UML running in SKAS0 mode
>> Kernel panic - not syncing: get_skas_faultinfo : failed to wait for
>> SIGUSR1/SIGTRAP, pid =3D 16411, n =3D 16411, errno
>> =A0 0, status =3D 0xb7f

This is 2.6.14 configured like so:

make ARCH=3Dum allnoconfig &&
cat >> .config << EOF &&
CONFIG_MODE_SKAS=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_HOSTFS=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_STDERR_CONSOLE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_UBD=3Dy
CONFIG_TMPFS=3Dy
CONFIG_SWAP=3Dy
CONFIG_LBD=3Dy
CONFIG_EXT2_FS=3Dy
CONFIG_PROC_FS=3Dy
EOF
yes "" | make ARCH=3Dum oldconfig &&
make ARCH=3Dum

And then run via:

tmpdir/linux rootfstype=3Dhostfs rw quiet mem=3D64M ubd0=3Dtmpdir/swap.img =

init=3D/bin/sh

He first tried with the LDT patch applied.  Then he tried reverting it (and=
=20
adding LD_ASSUME_KERNEL=3D2.4.1 to the kernel command line), but that didn'=
t=20
help.

Any clues?  (Should I tell him to just try -tt mode?  Or revert to 2.6.13 w=
ith=20
the leak fix?)

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
