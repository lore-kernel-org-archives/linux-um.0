Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWNu5-00010E-Cv
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 14:42:57 -0800
Received: from mta13.mail.adelphia.net ([68.168.78.44] helo=mta13.adelphia.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWNu5-0003mn-0P
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 14:42:57 -0800
Received: from mizar.alcor.net ([68.64.159.24]) by mta13.adelphia.net
          (InterMail vM.5.01.06.05 201-253-122-130-105-20030824) with SMTP
          id <20031216222608.KCCX16367.mta13.adelphia.net@mizar.alcor.net>
          for <user-mode-linux-devel@lists.sourceforge.net>;
          Tue, 16 Dec 2003 17:26:08 -0500
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20031216222607.GA31999@alcor.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
Subject: [uml-devel] [PATCH] hostaudio fails to build as a module
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
Date: Tue, 16 Dec 2003 14:26:07 -0800
To: user-mode-linux-devel@lists.sourceforge.net



--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

DSP_HELP and MIXER_HELP are undefined when MODULE is defined.  This patch
just moves them out of the conditional.

-- 
 - mdz

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hostaudio-module.diff"

--- kernel-source-2.4.22/arch/um/drivers/hostaudio_kern.c.orig	2003-12-16 14:23:31.000000000 -0800
+++ kernel-source-2.4.22/arch/um/drivers/hostaudio_kern.c	2003-12-16 14:24:02.000000000 -0800
@@ -20,6 +20,14 @@
 char *dsp = HOSTAUDIO_DEV_DSP;
 char *mixer = HOSTAUDIO_DEV_MIXER;
 
+#define DSP_HELP \
+"    This is used to specify the host dsp device to the hostaudio driver.\n" \
+"    The default is \"" HOSTAUDIO_DEV_DSP "\".\n\n"
+
+#define MIXER_HELP \
+"    This is used to specify the host mixer device to the hostaudio driver.\n" \
+"    The default is \"" HOSTAUDIO_DEV_MIXER "\".\n\n"
+
 #ifndef MODULE
 static int set_dsp(char *name, int *add)
 {
@@ -27,10 +35,6 @@
 	return(0);
 }
 
-#define DSP_HELP \
-"    This is used to specify the host dsp device to the hostaudio driver.\n" \
-"    The default is \"" HOSTAUDIO_DEV_DSP "\".\n\n"
-
 __uml_setup("dsp=", set_dsp, "dsp=<dsp device>\n" DSP_HELP);
 
 static int set_mixer(char *name, int *add)
@@ -39,10 +43,6 @@
 	return(0);
 }
 
-#define MIXER_HELP \
-"    This is used to specify the host mixer device to the hostaudio driver.\n" \
-"    The default is \"" HOSTAUDIO_DEV_MIXER "\".\n\n"
-
 __uml_setup("mixer=", set_mixer, "mixer=<mixer device>\n" MIXER_HELP);
 
 #else /*MODULE*/

--dDRMvlgZJXvWKvBx--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
