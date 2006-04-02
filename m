Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQ6SQ-0004U7-HM for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Apr 2006 10:33:46 -0700
Received: from 213-140-2-73.ip.fastwebnet.it ([213.140.2.73]
	helo=aa006msg.fastwebnet.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FQ6SN-0005Fq-LV
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Apr 2006 10:33:46 -0700
Received: from ms001msg.fastwebnet.it (10.31.41.32) by aa006msg.fastwebnet.it
	(7.2.069.1)
	id 44214BA400454D69 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 2 Apr 2006 19:33:36 +0200
Received: from inferi (23.251.77.98) by ms001msg.fastwebnet.it (7.2.070)
	id 4408479400BF824F for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 2 Apr 2006 19:33:36 +0200
Received: from mattia by inferi with local (Exim 4.60)
	(envelope-from <malattia@linux.it>) id 1FQ6TO-0005Zv-4O
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Apr 2006 19:34:46 +0200
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20060402173445.GB5108@inferi.kami.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
Subject: [uml-devel] [RFC][PATCH] include /usr/lib/uml in PATH
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
Date: Sun, 2 Apr 2006 19:34:46 +0200
To: UML-devel <user-mode-linux-devel@lists.sourceforge.net>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

some time ago it's been proposed to let uml_net live in /usr/lib/uml to
comply the FHS (I have version 2.3 at hand):

  /usr/lib includes object files, libraries, and internal binaries that
  are not intended to be executed directly by users or shell scripts.

see chapter 4.7.1
The attached patch implements it and keeps backward compatibility.
It's kind of brutal because putenv will wipe any user-defined PATH, if
this is a problem I can provide an improved patch that appends
/usr/lib/uml to the existing PATH. Is this the way to go?

Signed-off-by: Mattia Dongili <malattia@linux.it>
-- 
mattia
:wq!

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_uml_net.diff"

--- a/arch/um/os-Linux/helper.c	2006-04-02 16:32:38.340801686 +0200
+++ b/arch/um/os-Linux/helper.c	2006-04-02 16:34:13.454745936 +0200
@@ -22,6 +22,9 @@ struct helper_data {
 	int fd;
 };
 
+/* PATH variable to find uml helpers  installed in FHS compliant locations */
+static char *alt_path = "PATH=:/bin:/usr/bin:/usr/lib/uml"; 
+
 /* Debugging aid, changed only from gdb */
 int helper_pause = 0;
 
@@ -41,6 +44,7 @@ static int helper_child(void *arg)
 	}
 	if(data->pre_exec != NULL)
 		(*data->pre_exec)(data->pre_data);
+	putenv(alt_path);
 	execvp(argv[0], argv);
 	errval = errno;
 	printk("execvp of '%s' failed - errno = %d\n", argv[0], errno);

--5vNYLRcllDrimb99--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
