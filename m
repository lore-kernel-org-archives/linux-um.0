Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCz9-0001ai-BF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:31 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CpCz8-0001Ue-AB for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:31 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113210101.0A34F1FB6F@zion>
Subject: [uml-devel] [patch 06/11] uml: allow free ubd flag ordering
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
Date: Thu, 13 Jan 2005 22:01:00 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


When parsing the <flags> section in ubd<n><flags>=file[,file2], instead of
requiring that the flags are specified in a certain order, just make the code
smarter.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/ubd_kern.c |   48 +++++++++++++++-----------
 1 files changed, 29 insertions(+), 19 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-free-flag-ordering arch/um/drivers/ubd_kern.c
--- linux-2.6.11/arch/um/drivers/ubd_kern.c~uml-ubd-free-flag-ordering	2005-01-13 03:11:22.564889912 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/ubd_kern.c	2005-01-13 03:11:22.567889456 +0100
@@ -250,7 +250,7 @@ static int ubd_setup_common(char *str, i
 	struct ubd *dev;
 	struct openflags flags = global_openflags;
 	char *backing_file;
-	int n, err;
+	int n, err, i;
 
 	if(index_out) *index_out = -1;
 	n = *str;
@@ -312,29 +312,40 @@ static int ubd_setup_common(char *str, i
 	dev = &ubd_dev[n];
 	if(dev->file != NULL){
 		printk(KERN_ERR "ubd_setup : device already configured\n");
-		goto out2;
+		goto out;
 	}
 
-	if(index_out) *index_out = n;
+	if (index_out)
+		*index_out = n;
 
-	if (*str == 'r'){
-		flags.w = 0;
-		str++;
-	}
-	if (*str == 's'){
-		flags.s = 1;
-		str++;
-	}
-	if (*str == 'd'){
-		dev->no_cow = 1;
+	for (i = 0; i < 4; i++) {
+		switch (*str) {
+		case 'r':
+			flags.w = 0;
+			break;
+		case 's':
+			flags.s = 1;
+			break;
+		case 'd':
+			dev->no_cow = 1;
+			break;
+		case '=':
+			str++;
+			goto break_loop;
+		default:
+			printk(KERN_ERR "ubd_setup : Expected '=' or flag letter (r,s or d)\n");
+			goto out;
+		}
 		str++;
 	}
 
-	if(*str++ != '='){
+        if (*str == '=')
+		printk(KERN_ERR "ubd_setup : Too many flags specified\n");
+        else
 		printk(KERN_ERR "ubd_setup : Expected '='\n");
-		goto out2;
-	}
+	goto out;
 
+break_loop:
 	err = 0;
 	backing_file = strchr(str, ',');
 
@@ -354,7 +365,7 @@ static int ubd_setup_common(char *str, i
 	dev->file = str;
 	dev->cow.file = backing_file;
 	dev->boot_openflags = flags;
- out2:
+out:
 	spin_unlock(&ubd_lock);
 	return(err);
 }
@@ -385,8 +396,7 @@ __uml_help(ubd_setup,
 "    machine by running 'dd' on the device. <n> must be in the range\n"
 "    0 to 7. Appending an 'r' to the number will cause that device\n"
 "    to be mounted read-only. For example ubd1r=./ext_fs. Appending\n"
-"    an 's' (has to be _after_ 'r', if there is one) will cause data\n"
-"    to be written to disk on the host immediately.\n\n"
+"    an 's' will cause data to be written to disk on the host immediately.\n\n"
 );
 
 static int fakehd_set = 0;
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
