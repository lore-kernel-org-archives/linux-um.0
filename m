Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CLYgf-0003JO-0e for User-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Oct 2004 20:04:53 -0700
Received: from bay24-f2.bay24.hotmail.com ([64.4.18.52] helo=hotmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CLYge-00044D-4K for User-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Oct 2004 20:04:52 -0700
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: [uml-devel] [patches] ptrace fix, x11 fb update, minor stuff.
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_4c75_41b1_31ca"
Message-ID: <BAY24-F2R77bieLYCT40001280e@hotmail.com>
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
Date: Sun, 24 Oct 2004 03:03:42 +0000
To: kraxel@bytesex.org
Cc: User-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_4c75_41b1_31ca
Content-Type: text/plain; format=flowed

Gerd Knorr wrote:
>the X-Server wants IOPL access for some obscure
>reason, it shouldn't need that when running on top of a framebuffer
>device.  Anyone has an idea on that?

I looked into this a while ago.  What I found was that you have to add UML 
to the exclude ifdef in CheckGenericGA() from xfree86/common/xf86Bus.c, and 
also around all the iopl() and ioperm() exclude ifdefs in 
xfree86/os_support/linux/linux_video.c.

I think it doesn't hurt to add  Option "PciOsConfig"  to the ServerFlags 
section in the conf file.

I also remember making the attached guest kernel patch at one point 
(apologies for hand editing it).

It would be nice if someone would code up an Option "NoHwIO" or something to 
X that takes care of this, instead of the ifdef hell. :)

Hope that helps,

Steve Schmidtke


------=_NextPart_000_4c75_41b1_31ca
Content-Type: text/plain; name="vt_kbd.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="vt_kbd.txt"

diff *~ -Naur linux.orig/drivers/char/vt.c linux.new/drivers/char/vt.c
--- linux.orig/drivers/char/vt.c	Thu Nov 28 18:53:12 2002
+++ linux.new/drivers/char/vt.c		Sun Aug  1 13:44:36 2003
@@ -146,7 +146,13 @@

int _kbd_rate(struct kbd_repeat *rep)
{
+#if defined(__arch_um__)
+	/* if X finds that this succeeds, it won't try to bang on
+	 * the (non-existent) hardware directly */
+	return 0;
+#else
	return -EINVAL;
+#endif
}

void (*kd_mksound)(unsigned int hz, unsigned int ticks) = _kd_mksound;


------=_NextPart_000_4c75_41b1_31ca--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
