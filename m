Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <martin.partel@gmail.com>) id 1ScR2f-0006dP-5B
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 00:57:37 +0000
Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ScR2e-0004OV-G7
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 00:57:37 +0000
Received: by lbol5 with SMTP id l5so188710lbo.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 06 Jun 2012 17:57:30 -0700 (PDT)
Message-ID: <4FCFFC77.4000605@gmail.com>
Date: Thu, 07 Jun 2012 03:57:27 +0300
From: =?ISO-8859-1?Q?Martin_P=E4rtel?= <martin.partel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000704020406010002020204"
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] Fix readonly ubd
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000704020406010002020204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

ubd_file_size() was recently patched so that it fails if an image is 
readonly. Patch attached.

--------------000704020406010002020204
Content-Type: text/x-diff;
 name="readonly-ubd-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="readonly-ubd-fix.patch"

--- a/arch/um/drivers/ubd_kern.c	2012-06-01 10:18:44.000000000 +0300
+++ b/arch/um/drivers/ubd_kern.c	2012-06-07 03:41:44.790899305 +0300
@@ -514,7 +514,7 @@
 		goto out;
 	}
 
-	fd = os_open_file(ubd_dev->file, global_openflags, 0);
+	fd = os_open_file(ubd_dev->file, of_read(OPENFLAGS()), 0);
 	if (fd < 0)
 		return fd;
 

--------------000704020406010002020204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------000704020406010002020204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------000704020406010002020204--


