Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbYux-00040K-9C for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 22:33:47 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CbYuv-0006Kr-Af for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 22:33:47 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] Any complaints about parallel make in
	2.6.10-rc?
References: <200412070628.26267.blaisorblade_spam@yahoo.it>
	<004301c4dc20$3dbbd280$0201a8c0@hawk>
	<200412070725.15921.blaisorblade_spam@yahoo.it>
In-Reply-To: <200412070725.15921.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_q+UtBmHxtVhIeSV"
Message-Id: <200412070737.30905.blaisorblade_spam@yahoo.it>
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
Date: Tue, 7 Dec 2004 07:37:30 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Christopher S. Aker" <caker@theshore.net>, user-mode-linux-user@lists.sourceforge.net

--Boundary-00=_q+UtBmHxtVhIeSV
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 07 December 2004 07:25, Blaisorblade wrote:
> On Tuesday 07 December 2004 06:47, Christopher S. Aker wrote:
> > > Since somebody (maybe Christopher Aker) said that parallel make was
> > > broken in 2.6.10-rc, I'm asking to report it in detail, if the
> > > complaint is correct.
> >
> > Odd.. "make ARCH=um -jN" works, but "make -jN ARCH=um" doesn't.  How did
> > I miss that?
>
> ??? Well, missing such a difference is *obvious*, since it does not make
> sense at all.
I've tested both things... and it appears I get the same problems / success 
with both things:



> I'm instead discovering a more interesting issue, due to some mainline
> updates to Kconfig, preventing Ramdisk code to build. Trivial fix attached.
> A less trivial fix, i.e. uml-depend-out-main-block-Kconfig.patch, cleaning
> things up definitely (i.e. going to drop arch/um/Kconfig_block , which is a
> selected duplicate of what's in drivers/block/Kconfig), is attached too.
In the second one, I forgot to add UBD (and COW and CONFIG_MMAPER) config 
option to drivers/block/Kconfig, so use the updated version I'm attaching.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_q+UtBmHxtVhIeSV
Content-Type: text/x-diff; charset="iso-8859-15";
	name="uml-depend-out-main-block-Kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-depend-out-main-block-Kconfig.patch"


Finally, we end with this the need to update arch/um/Kconfig_block with
changes in drivers/block/Kconfig.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/Kconfig       |    2 -
 linux-2.6.10-rc-paolo/drivers/block/Kconfig |   40 ++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 3 deletions(-)

diff -puN drivers/block/Kconfig~uml-depend-out-main-block-Kconfig drivers/block/Kconfig
--- linux-2.6.10-rc/drivers/block/Kconfig~uml-depend-out-main-block-Kconfig	2004-12-07 07:35:05.993665856 +0100
+++ linux-2.6.10-rc-paolo/drivers/block/Kconfig	2004-12-07 07:35:39.037642408 +0100
@@ -6,7 +6,7 @@ menu "Block devices"
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
-	depends on (!ARCH_S390 && !M68K && !IA64) || Q40 || (SUN3X && BROKEN)
+	depends on (!ARCH_S390 && !M68K && !IA64 && !USERMODE) || Q40 || (SUN3X && BROKEN)
 	---help---
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM
@@ -208,6 +208,39 @@ config BLK_DEV_UMEM
 	  one is chosen dynamically.  Use "devfs" or look in /proc/devices
 	  for the device number
 
+config BLK_DEV_UBD
+	bool "Virtual block device"
+	depends on USERMODE
+	help
+          The User-Mode Linux port includes a driver called UBD which will let
+          you access arbitrary files on the host computer as block devices.
+          Unless you know that you do not need such virtual block devices say
+          Y here.
+
+config BLK_DEV_UBD_SYNC
+	bool "Always do synchronous disk IO for UBD"
+	depends on BLK_DEV_UBD
+	help
+	  Writes to the virtual block device are not immediately written to the
+	  host's disk; this may cause problems if, for example, the User-Mode
+	  Linux 'Virtual Machine' uses a journalling filesystem and the host
+	  computer crashes.
+
+          Synchronous operation (i.e. always writing data to the host's disk
+          immediately) is configurable on a per-UBD basis by using a special
+          kernel command line option.  Alternatively, you can say Y here to
+          turn on synchronous operation by default for all block devices.
+
+          If you're running a journalling file system (like reiserfs, for
+          example) in your virtual machine, you will want to say Y here.  If
+          you care for the safety of the data in your virtual machine, Y is a
+          wise choice too.  In all other cases (for example, if you're just
+          playing around with User-Mode Linux) you can choose N.
+
+config BLK_DEV_COW_COMMON
+	bool
+	default BLK_DEV_UBD
+
 config BLK_DEV_LOOP
 	tristate "Loopback device support"
 	---help---
@@ -384,9 +417,11 @@ config INITRAMFS_SOURCE
 
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
@@ -394,6 +429,7 @@ config LBD
 
 config CDROM_PKTCDVD
 	tristate "Packet writing on CD/DVD media"
+	depends on !USERMODE
 	help
 	  If you have a CDROM drive that supports packet writing, say Y to
 	  include preliminary support. It should work with any MMC/Mt Fuji
diff -puN arch/um/Kconfig~uml-depend-out-main-block-Kconfig arch/um/Kconfig
--- linux-2.6.10-rc/arch/um/Kconfig~uml-depend-out-main-block-Kconfig	2004-12-07 07:35:05.995665552 +0100
+++ linux-2.6.10-rc-paolo/arch/um/Kconfig	2004-12-07 07:35:05.999664944 +0100
@@ -238,7 +238,7 @@ source "drivers/base/Kconfig"
 
 source "arch/um/Kconfig_char"
 
-source "arch/um/Kconfig_block"
+source "drivers/block/Kconfig"
 
 config NETDEVICES
 	bool
_

--Boundary-00=_q+UtBmHxtVhIeSV--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
