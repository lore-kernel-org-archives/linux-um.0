Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DZFgw-0007BB-3s	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 May 2005 15:10:02 -0700
Received: from dynamic.62-99-255-84.adsl-line.inode.at ([62.99.255.84]
	helo=mercury.foo)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DZFgu-0005x7-2O
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 May 2005 15:10:01 -0700
From: Dominik Hackl <dominik@hackl.dhs.org>
Message-ID: <Pine.LNX.4.61.0505202336230.8943@mercury.foo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] [PATCH 2.6.12-rc4] hostaudio MODULE_PARM replacement
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
Date: Sat, 21 May 2005 00:10:16 +0200 (CEST)
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net



This patch replaces the deprecated MODULE_PARM function by the new 
module_param function.


	Signed-off-by: Dominik Hackl <dominik@hackl.dhs.org>


--- linux-2.6.12-rc4.orig/arch/um/drivers/hostaudio_kern.c	2005-03-02 08:38:32.000000000 +0100
+++ linux-2.6.12-rc4/arch/um/drivers/hostaudio_kern.c	2005-05-20 23:25:18.000000000 +0200
@@ -57,10 +57,10 @@ __uml_setup("mixer=", set_mixer, "mixer=
 
 #else /*MODULE*/
 
-MODULE_PARM(dsp, "s");
+module_param(dsp, charp, 0644);
 MODULE_PARM_DESC(dsp, DSP_HELP);
 
-MODULE_PARM(mixer, "s");
+module_param(mixer, charp, 0644);
 MODULE_PARM_DESC(mixer, MIXER_HELP);
 
 #endif


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
