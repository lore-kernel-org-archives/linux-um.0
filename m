Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DrO1F-0001q3-V1	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Jul 2005 15:41:57 -0700
Received: from smtp.gentoo.org ([134.68.220.30])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DrO1C-0003Zz-LD	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Jul 2005 15:41:58 -0700
Received: from nuthatch.gentoo.osuosl.org ([140.211.166.163]
	helo=nuthatch.gentoo.org)	by smtp.gentoo.org with esmtp (Exim 4.43)
	id 1DrO16-0006fH-KD	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Jul 2005 22:41:48 +0000
Received: from apache by nuthatch.gentoo.org with local (Exim 4.43)
	id 1DrO16-0002dS-Az	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Jul 2005 22:41:48 +0000
From: bugzilla-daemon@gentoo.org
In-Reply-To: <bug-49277@bugs.gentoo.org>
Message-Id: <E1DrO16-0002dS-Az@nuthatch.gentoo.org>
Subject: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
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
Date: Sat, 09 Jul 2005 22:41:48 +0000
To: user-mode-linux-devel@lists.sourceforge.net

Clear-Text: http://bugs.gentoo.org/show_bug.cgi?id=49277
Secure: https://bugs.gentoo.org/show_bug.cgi?id=49277





------- Additional Comments From x-drum@libero.it  2005-07-09 15:41 PDT -------
(In reply to comment #52)
> usermode-sources-2.6.12 is in portage. Please test it (see comment #51) as it
> should solve the NPTL issues.

Hi,
I'm using glibc-2.3.4.20041102-r1 compiled with the USE="nptl nptlonly".

Finally i was able to build an uml kernel from the source with this "mix"!!!
i patched the host kernel (gentoo-sources-2.6.12-r4)
with this patch:
http://www.user-mode-linux.org/~blaisorblade/patches/skas3-2.6/skas-2.6.12-rc4-v9-pre4/skas-2.6.12-rc4-v9-pre4.patch.bz2

then i emerged the usermode-sources-2.6.12
and in the kernel configuration 
i disabled CONFIG_MODE_TT 
and enabled CONFIG_SKAS 
(see comment #41 by BlaisorBlade)

NOTE1: when CONFIG_MODE_TT is disabled in the guest kernel (uml)
the host kernel must be patched with the skas patch.

NOTE2: i would like to thank you all! :D

my emerge info:
-----------------------------------------------------------------
Portage 2.0.51.19 (default-linux/x86/2005.0, gcc-3.3.5-20050130,
glibc-2.3.4.20041102-r1, 2.6.12-gentoo-r4-skas3-v9-pre4 i686)
=================================================================
System uname: 2.6.12-gentoo-r4-skas3-v9-pre4 i686 Intel(R) Pentium(R) 4 CPU 2.53GHz
Gentoo Base System version 1.6.12
Python:              dev-lang/python-2.3.5 [2.3.5 (#1, Apr 28 2005, 17:46:54)]
dev-lang/python:     2.3.5
sys-apps/sandbox:    [Not Present]
sys-devel/autoconf:  2.59-r6, 2.13
sys-devel/automake:  1.7.9-r1, 1.8.5-r3, 1.5, 1.4_p6, 1.6.3, 1.9.5
sys-devel/binutils:  2.15.92.0.2-r10
sys-devel/libtool:   1.5.18-r1
virtual/os-headers:  2.6.11-r2
ACCEPT_KEYWORDS="x86"
AUTOCLEAN="yes"
CFLAGS="-march=pentium4 -O2 -pipe -fomit-frame-pointer"
CHOST="i686-pc-linux-gnu"
CONFIG_PROTECT="/etc /usr/kde/2/share/config /usr/kde/3.4/env
/usr/kde/3.4/share/config /usr/kde/3.4/shutdown /usr/kde/3/share/config
/usr/lib/X11/xkb /usr/share/config /var/qmail/control"
CONFIG_PROTECT_MASK="/etc/gconf /etc/splash /etc/terminfo /etc/env.d"
CXXFLAGS="-O2 -mcpu=i686 -pipe"
DISTDIR="/usr/portage/distfiles"
FEATURES="autoaddcvs autoconfig ccache distlocks sandbox sfperms strict"
GENTOO_MIRRORS="http://distfiles.gentoo.org
http://distro.ibiblio.org/pub/Linux/distributions/gentoo"
LANG="it_IT@euro"
LINGUAS="it"
MAKEOPTS="-j1"
PKGDIR="/usr/portage/packages"
PORTAGE_TMPDIR="/var/tmp"
PORTDIR="/usr/portage"
PORTDIR_OVERLAY="/usr/local/portage"
SYNC="rsync://rsync1.it.gentoo.org/gentoo-portage"
USE="x86 X aalib acpi alsa apm arts avi berkdb bitmap-fonts cdr crypt cups curl
dvd dvdr emboss encode esd fam flac foomaticdb fortran gdbm gif gnome gpm gtk
gtk2 imagemagick imlib ipv6 java jpeg junit kde libg++ libwww mad mikmod mmx
motif mp3 mpeg mysql ncurses nls nptl nptlonly odbc ogg oggvorbis opengl oss pam
pdflib perl png python qt quicktime readline samba sdl slang spell ssl svga tcpd
tiff truetype truetype-fonts type1-fonts unicode usb vorbis xine xinerama xml
xml2 xmms xv zlib linguas_it userland_GNU kernel_linux elibc_glibc"
Unset:  ASFLAGS, CBUILD, CTARGET, LC_ALL, LDFLAGS




-- 
Configure bugmail: http://bugs.gentoo.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
