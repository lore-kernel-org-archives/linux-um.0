Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CH8Yr-0001pS-8L for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 15:22:33 -0700
Received: from p15103123.pureserver.info ([217.160.129.185] helo=sektor37.de)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CH8Yl-0001kX-3V for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 15:22:33 -0700
Message-ID: <416B07AC.3030308@sektor37.de>
From: Julian Scheid <julian@sektor37.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000809000207040201040507"
Subject: [uml-devel] Default kernel configuration on 2.6.x
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
Date: Tue, 12 Oct 2004 00:22:36 +0200
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000809000207040201040507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a follow-up to a private message I sent to Jeff in which I 
complained about the UML Howto being incorrect in saying that "[t]he 
[configuration] defaults will give you a useful kernel" since I was 
using an unmodified configuration and ended up with a kernel missing all 
the virtual drivers.

In the meantime I did some further research and it turns out that 
actually, the Howto isn't wrong - the default configuration included in 
the patches is perfectly correct and gives a useful kernel.

Instead, a well-meant feature in the 2.6 build process (IIRC present in 
2.5 too) has been the cause of my difficulties: make *config tries to 
locate default settings by looking for the following files in order:

> const char *conf_confnames[] = {
> 	".config",
> 	"/lib/modules/$UNAME_RELEASE/.config",
> 	"/etc/kernel-config",
> 	"/boot/config-$UNAME_RELEASE",
> 	conf_defname,
> 	NULL,
> };
(taken from linux-2.6.8.1/scripts/kconfig/confdata.c)

In other words, if a file describing the current host kernel's 
configuration is present on the host (the one under /boot is on my 
Debian box) then make config in a fresh or mrproper'ed guest tree will 
use the host configuration instead of the defaults supplied by the UML 
patch. This is true regardless of which kernel version is running on the 
host.

While this is useful under normal circumstances where you usually want 
to continue using your current settings, it seems very unhelpful in the 
case of a UML guest kernel since the guest kernel configuration and the 
host kernel configuration are targeted at two different platforms and 
thus don't have much in common, except perhaps for the choice of 
filesystems if you want the guest to access your host's storage devices.

It should be noted that since the host kernel is usually not a 
UML-patched kernel and therefore none of the UML-specific options are 
given in the host configuration file, the consequence of the current 
behaviour is that all UML-specific options default to off if one of the 
listed files is present on your host.

This is especially fatal because without a virtual character device 
driver, stdio initialization will fail silently or with an unhelpful 
error message ("sleeping process got unexpected signal 11"), leaving 
unsuspecting users like me completely puzzled.

Therefore I think it would make sense to have the UML patches for the 
affected kernel versions remove the second through fourth element from 
conf_confnames (as shown above) so that the build will immediately fall 
back to arch/um/defconfig if .config isn't found, always ignoring status 
quo configuration files on the host. A corresponding patch for 2.6.8.1 
is attached.

Perhaps a note should be added somewhere pointing out the non-standard 
behavior to avoid confusing seasoned kernel recompilers, but I'm not 
sure where to put it. I'll leave that to the maintainers should you 
agree with the patch.

Cheers,

Julian


--------------000809000207040201040507
Content-Type: text/plain;
 name="uml-patch-defconfig-2.6.8.1-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uml-patch-defconfig-2.6.8.1-1"

diff -r orig/linux-2.6.8.1/scripts/kconfig/confdata.c orig_defconfig/linux-2.6.8.1/scripts/kconfig/confdata.c
22,24d21
< 	"/lib/modules/$UNAME_RELEASE/.config",
< 	"/etc/kernel-config",
< 	"/boot/config-$UNAME_RELEASE",

--------------000809000207040201040507--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
