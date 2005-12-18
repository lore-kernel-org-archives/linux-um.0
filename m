Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eo3pN-0000sX-UJ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Dec 2005 11:04:13 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Eo3pM-00074z-8g
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Dec 2005 11:04:13 -0800
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1134932624.10491.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] pcap cross-linking
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
Date: Sun, 18 Dec 2005 19:03:43 +0000
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>, Blaisorblade <blaisorblade@yahoo.it>

Paolo,

pcap builds and runs fine on amd64 but there is a problem when building
with SUBARCH=i386: it uses the wrong version of libpcap.a:
ld -r -dp -o arch/um/drivers/pcap.o arch/um/drivers/pcap_kern.o
arch/um/drivers/pcap_user.o  -m elf_i386
-r /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../libpcap.a
Whereas the one it needs to link against is here:
/emul/linux/x86/usr/lib/libpcap.a

Fixing the Makefile is beyond me (probably not that hard), sorry - so I
link it manually. After that it works perfectly.

On the subject of pcap transport, I couldn't dig the email where you
suggested a way of figuring out which libraries should be placed in the
chroot, I tried to use the same libraries as I used on a 32-bit setup
but it fails to bring up the interface (when it works outside chroot).

I tried to guess and even added a few more, here is the chroot's /lib (I
made /lib64 a link to /lib in chroot):
ld-2.3.5.so           libcrack.so.2.8.0  libm.so.6
libnss_compat-2.3.5.so  libnss_hesiod-2.3.5.so   libpam.so
libpamc.so       libpcap.so.0.9      librt.so.1        security
ld-linux-x86-64.so.2  libcrypt-2.3.5.so  libncurses.so
libnss_compat.so.2      libnss_hesiod.so.2       libpam.so.0
libpamc.so.0     libpthread-0.10.so  libselinux.so.1   tls
libc-2.3.5.so         libcrypt.so.1      libncurses.so.5
libnss_dns-2.3.5.so     libnss_nis-2.3.5.so      libpam.so.0.78
libpamc.so.0.78  libpthread.so.0     libsemanage.so.1
libc.so.6             libdl-2.3.5.so     libncurses.so.5.4
libnss_dns.so.2         libnss_nis.so.2          libpam_misc.so
libpcap.a        libresolv-2.3.5.so  libsepol.so.1
libcrack.so           libdl.so.2         libnsl-2.3.5.so
libnss_files-2.3.5.so   libnss_nisplus-2.3.5.so  libpam_misc.so.0
libpcap.so       libresolv.so.2      libutil-2.3.5.so
libcrack.so.2         libm-2.3.5.so      libnsl.so.1
libnss_files.so.2       libnss_nisplus.so.2      libpam_misc.so.0.78
libpcap.so.0     librt-2.3.5.so      libutil.so.1
lib/tls:
libc-2.3.5.so  libc.so.6
(also lib/security so I can get into the chroot)
But that's not enough... and ldd didn't show me anything missing.
Any ideas?

Thanks
Antoine



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
