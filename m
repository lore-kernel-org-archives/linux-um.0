Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez1Aq-0007KY-4C for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:40 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ez1Ap-0000ub-Jx
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:40 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060118001949.14622.23014.stgit@zion.home.lan>
In-Reply-To: <20060117235659.14622.18544.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 9/9] uml ubd code: fix a bit of whitespace
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
Date: Wed, 18 Jan 2006 01:19:50 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Correct a bit of whitespace problems while working here.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index e498f34..f93af66 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1200,15 +1200,16 @@ int open_ubd_file(char *file, struct ope
 	int fd, err, sectorsize, asked_switch, mode = 0644;
 
 	fd = os_open_file(file, *openflags, mode);
-	if(fd < 0){
-		if((fd == -ENOENT) && (create_cow_out != NULL))
+	if (fd < 0) {
+		if ((fd == -ENOENT) && (create_cow_out != NULL))
 			*create_cow_out = 1;
-                if(!openflags->w ||
-                   ((fd != -EROFS) && (fd != -EACCES))) return(fd);
+                if (!openflags->w ||
+                   ((fd != -EROFS) && (fd != -EACCES)))
+			return fd;
 		openflags->w = 0;
 		fd = os_open_file(file, *openflags, mode);
-		if(fd < 0)
-			return(fd);
+		if (fd < 0)
+			return fd;
         }
 
 	err = os_lock_file(fd, openflags->w);
@@ -1218,7 +1219,8 @@ int open_ubd_file(char *file, struct ope
 	}
 
 	/* Succesful return case! */
-	if(backing_file_out == NULL) return(fd);
+	if(backing_file_out == NULL)
+		return(fd);
 
 	err = read_cow_header(file_reader, &fd, &version, &backing_file, &mtime,
 			      &size, &sectorsize, &align, bitmap_offset_out);
@@ -1227,7 +1229,8 @@ int open_ubd_file(char *file, struct ope
 		       "errno = %d\n", file, -err);
 		goto out_close;
 	}
-	if(err) return(fd);
+	if(err)
+		return(fd);
 
 	asked_switch = path_requires_switch(*backing_file_out, backing_file, file);
 
@@ -1236,24 +1239,24 @@ int open_ubd_file(char *file, struct ope
 		printk("Switching backing file to '%s'\n", *backing_file_out);
 		err = write_cow_header(file, fd, *backing_file_out,
 				       sectorsize, align, &size);
-		if(err){
+		if (err) {
 			printk("Switch failed, errno = %d\n", -err);
 			goto out_close;
 		}
-	}
-	else {
+	} else {
 		*backing_file_out = backing_file;
 		err = backing_file_mismatch(*backing_file_out, size, mtime);
-		if(err) goto out_close;
+		if (err)
+			goto out_close;
 	}
 
 	cow_sizes(version, size, sectorsize, align, *bitmap_offset_out,
 		  bitmap_len_out, data_offset_out);
 
-        return(fd);
+        return fd;
  out_close:
 	os_close_file(fd);
-	return(err);
+	return err;
 }
 
 int create_cow_file(char *cow_file, char *backing_file, struct openflags flags,



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
