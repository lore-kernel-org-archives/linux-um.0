Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BlHuY-0006dQ-VX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Jul 2004 18:53:18 -0700
Received: from rdns.193.240.218.216.fre.communitycolo.net ([216.218.240.193]
	helo=pogo.kaffe.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BlHuY-0003pY-ME for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Jul 2004 18:53:18 -0700
Received: from c-24-7-107-92.client.comcast.net ([24.7.107.92]
	helo=jimpick.com)
	by pogo.kaffe.org with asmtp (Exim 3.35 #1 (Debian))
	id 1BlHzG-00085g-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Jul 2004 18:58:10 -0700
Message-ID: <40F7349E.7010109@jimpick.com>
From: Jim Pick <jim@jimpick.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070108010500090203080505"
Subject: [uml-devel] Off by one error in umid.c
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
Date: Thu, 15 Jul 2004 18:51:26 -0700
To: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------070108010500090203080505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here's a fix for a little memory corruption I was having.  I was passing 
in a uml_dir directory without a trailing slash.

Cheers,

  - Jim

Index: linux-2.4.22-uml1/arch/um/kernel/umid.c
===================================================================
--- linux-2.4.22-uml1.orig/arch/um/kernel/umid.c	2004-07-15 
16:34:57.000000000 -0700
+++ linux-2.4.22-uml1/arch/um/kernel/umid.c	2004-07-15 
18:15:54.699873738 -0700
@@ -200,7 +200,7 @@
  static int __init set_uml_dir(char *name, int *add)
  {
  	if((strlen(name) > 0) && (name[strlen(name) - 1] != '/')){
-		uml_dir = malloc(strlen(name) + 1);
+		uml_dir = malloc(strlen(name) + 2);
  		if(uml_dir == NULL){
  			printf("Failed to malloc uml_dir - error = %d\n",
  			       errno);


--------------070108010500090203080505
Content-Type: text/plain;
 name="umid_dir_off-by-one.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="umid_dir_off-by-one.patch"

Index: linux-2.4.22-uml1/arch/um/kernel/umid.c
===================================================================
--- linux-2.4.22-uml1.orig/arch/um/kernel/umid.c	2004-07-15 16:34:57.000000000 -0700
+++ linux-2.4.22-uml1/arch/um/kernel/umid.c	2004-07-15 18:15:54.699873738 -0700
@@ -200,7 +200,7 @@
 static int __init set_uml_dir(char *name, int *add)
 {
 	if((strlen(name) > 0) && (name[strlen(name) - 1] != '/')){
-		uml_dir = malloc(strlen(name) + 1);
+		uml_dir = malloc(strlen(name) + 2);
 		if(uml_dir == NULL){
 			printf("Failed to malloc uml_dir - error = %d\n",
 			       errno);

--------------070108010500090203080505--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
