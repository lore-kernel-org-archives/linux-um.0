Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbYj7-0003EZ-1Z for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 22:21:33 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CbYj5-0004u4-Ot for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 22:21:32 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <200412070628.26267.blaisorblade_spam@yahoo.it>
	<004301c4dc20$3dbbd280$0201a8c0@hawk>
In-Reply-To: <004301c4dc20$3dbbd280$0201a8c0@hawk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LzUtBCmxKnYMATr"
Message-Id: <200412070725.15921.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] Any complaints about parallel make in
	2.6.10-rc?
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
Date: Tue, 7 Dec 2004 07:25:15 +0100
To: "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

--Boundary-00=_LzUtBCmxKnYMATr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 07 December 2004 06:47, Christopher S. Aker wrote:
> > Since somebody (maybe Christopher Aker) said that parallel make was
> > broken in 2.6.10-rc, I'm asking to report it in detail, if the complaint
> > is correct.
>
> Odd.. "make ARCH=um -jN" works, but "make -jN ARCH=um" doesn't.  How did I
> miss that?
??? Well, missing such a difference is *obvious*, since it does not make sense 
at all.

I'm instead discovering a more interesting issue, due to some mainline updates 
to Kconfig, preventing Ramdisk code to build. Trivial fix attached. A less 
trivial fix, i.e. uml-depend-out-main-block-Kconfig.patch, cleaning things up 
definitely (i.e. going to drop arch/um/Kconfig_block , which is a selected 
duplicate of what's in drivers/block/Kconfig), is attached too.
> -Chris

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_LzUtBCmxKnYMATr
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-kconfig-block-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="uml-kconfig-block-update.patch"



Update the text of Kconfig_block to match mainline changes. I'll later maybe
submit a cleanup about the duplication of part of drivers/block/Kconfig in
Kconfig_block - with appropriate fixes, we could just use
drivers/block/Kconfig.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/Kconfig_block |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletion(-)

diff -puN arch/um/Kconfig_block~uml-kconfig-block-update arch/um/Kconfig_block
--- linux-2.6.10-rc/arch/um/Kconfig_block~uml-kconfig-block-update	2004-12-07 07:12:44.045672960 +0100
+++ linux-2.6.10-rc-paolo/arch/um/Kconfig_block	2004-12-07 07:12:44.048672504 +0100
@@ -43,14 +43,32 @@ config BLK_DEV_NBD
 config BLK_DEV_RAM
 	tristate "RAM disk support"
 
+config BLK_DEV_RAM_COUNT
+	int "Default number of RAM disks" if BLK_DEV_RAM
+	default "16"
+	help
+	  The default value is 16 RAM disks. Change this if you know what
+	  are doing. If you boot from a filesystem that needs to be extracted
+	  in memory, you will need at least one RAM disk (e.g. root on cramfs).
+
 config BLK_DEV_RAM_SIZE
-	int "Default RAM disk size"
+	int "Default RAM disk size (kbytes)"
 	depends on BLK_DEV_RAM
 	default "4096"
+	help
+	  The default value is 4096 kilobytes. Only change this if you know
+	  what are you doing. If you are using IBM S/390, then set this to
+	  8192.
 
 config BLK_DEV_INITRD
 	bool "Initial RAM disk (initrd) support"
 	depends on BLK_DEV_RAM=y
+	help
+	  The initial RAM disk is a RAM disk that is loaded by the boot loader
+	  (loadlin or lilo) and that is mounted as root before the normal boot
+	  procedure. It is typically used to load modules needed to mount the
+	  "real" root file system, etc. See <file:Documentation/initrd.txt>
+	  for details.
 
 #Copied directly from drivers/block/Kconfig
 config INITRAMFS_SOURCE
_

--Boundary-00=_LzUtBCmxKnYMATr
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-depend-out-main-block-Kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="uml-depend-out-main-block-Kconfig.patch"


Finally, we end with this the need to update arch/um/Kconfig_block with
changes in drivers/block/Kconfig.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/Kconfig       |    2 +-
 linux-2.6.10-rc-paolo/drivers/block/Kconfig |    7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff -puN drivers/block/Kconfig~uml-depend-out-main-block-Kconfig drivers/block/Kconfig
--- linux-2.6.10-rc/drivers/block/Kconfig~uml-depend-out-main-block-Kconfig	2004-12-07 07:20:37.450704456 +0100
+++ linux-2.6.10-rc-paolo/drivers/block/Kconfig	2004-12-07 07:20:37.456703544 +0100
@@ -6,7 +6,7 @@ menu "Block devices"
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
-	depends on (!ARCH_S390 && !M68K && !IA64) || Q40 || (SUN3X && BROKEN)
+	depends on (!ARCH_S390 && !M68K && !IA64 && !USERMODE) || Q40 || (SUN3X && BROKEN)
 	---help---
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM
@@ -384,9 +384,11 @@ config INITRAMFS_SOURCE
 
 	  If you are not sure, leave it blank.
 
+#XXX - it makes sense to enable this only for 32-bit subarch's, not for x86_64
+#for instance.
 config LBD
 	bool "Support for Large Block Devices"
-	depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH
+	depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH || USERMODE
 	help
 	  Say Y here if you want to attach large (bigger than 2TB) discs to
 	  your machine, or if you want to have a raid or loopback device
@@ -394,6 +396,7 @@ config LBD
 
 config CDROM_PKTCDVD
 	tristate "Packet writing on CD/DVD media"
+	depends on !USERMODE
 	help
 	  If you have a CDROM drive that supports packet writing, say Y to
 	  include preliminary support. It should work with any MMC/Mt Fuji
diff -puN arch/um/Kconfig~uml-depend-out-main-block-Kconfig arch/um/Kconfig
--- linux-2.6.10-rc/arch/um/Kconfig~uml-depend-out-main-block-Kconfig	2004-12-07 07:20:37.452704152 +0100
+++ linux-2.6.10-rc-paolo/arch/um/Kconfig	2004-12-07 07:20:37.456703544 +0100
@@ -238,7 +238,7 @@ source "drivers/base/Kconfig"
 
 source "arch/um/Kconfig_char"
 
-source "arch/um/Kconfig_block"
+source "drivers/block/Kconfig"
 
 config NETDEVICES
 	bool
_

--Boundary-00=_LzUtBCmxKnYMATr--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
