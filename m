Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Co7SU-000373-Gb for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 13:52:18 -0800
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Co7SQ-0000ft-HR
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 13:52:16 -0800
Received: from [128.187.171.102] (obelix.cs.byu.edu [128.187.171.102])
	(authenticated bits=0)
	by tuxrocks.com (8.12.11/8.12.11) with ESMTP id j0ALqCOv001117
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 10 Jan 2005 14:52:13 -0700
Message-ID: <41E2F90C.4020707@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070500010205020408010804"
Subject: [uml-devel] [PATCH] Put the check for NULL before the use of a
	potentially-null value
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
Date: Mon, 10 Jan 2005 14:52:12 -0700
To: UML Devel <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070500010205020408010804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch reorders two lines to check a variable for NULL before using 
the variable.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

Frank
---------------------------------------------------------------------------
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com

--------------070500010205020408010804
Content-Type: text/plain;
 name="reorder_null_check"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reorder_null_check"

diff -Naur linux-2.6.10-mm2.orig/arch/um/drivers/line.c linux-2.6.10-mm2/arch/um/drivers/line.c
--- linux-2.6.10-mm2.orig/arch/um/drivers/line.c	2005-01-10 14:35:20.379815252 -0700
+++ linux-2.6.10-mm2/arch/um/drivers/line.c	2005-01-10 14:35:59.786829555 -0700
@@ -593,8 +593,8 @@
 		}
 	}
 	tty  = winch->tty;
-	line = tty->driver_data;
 	if (tty != NULL) {
+		line = tty->driver_data;
 		chan_window_size(&line->chan_list,
 				 &tty->winsize.ws_row, 
 				 &tty->winsize.ws_col);

--------------070500010205020408010804--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
