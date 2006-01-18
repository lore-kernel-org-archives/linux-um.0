Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez1At-0007Kk-Cu for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:43 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ez1As-0005Dj-IH
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:43 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060118001946.14622.28532.stgit@zion.home.lan>
In-Reply-To: <20060117235659.14622.18544.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 8/9] uml: allow again to move backing file and to
	override saved location
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
Date: Wed, 18 Jan 2006 01:19:47 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


When the user specifies both a COW file and its backing file, if the previous
backing file is not found, currently UML tries again to use it and fails.

This can be corrected by changing same_backing_files() return value in that
case, so that the caller will try to change the COW file to point to the new
location, as already done in other cases.

Additionally, given the change in the meaning of the func, change its name,
invert its return value, so all values are inverted except when
stat(from_cow,&buf2) fails. And add some comments and two minor bugfixes -
remove a fd leak (return err rather than goto out) and a repeated check.

Tested well.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 49dda56..e498f34 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1109,31 +1109,33 @@ static int ubd_ioctl(struct inode * inod
 	return(-EINVAL);
 }
 
-static int same_backing_files(char *from_cmdline, char *from_cow, char *cow)
+static int path_requires_switch(char *from_cmdline, char *from_cow, char *cow)
 {
 	struct uml_stat buf1, buf2;
 	int err;
 
-	if(from_cmdline == NULL) return(1);
-	if(!strcmp(from_cmdline, from_cow)) return(1);
+	if(from_cmdline == NULL)
+		return 0;
+	if(!strcmp(from_cmdline, from_cow))
+		return 0;
 
 	err = os_stat_file(from_cmdline, &buf1);
 	if(err < 0){
 		printk("Couldn't stat '%s', err = %d\n", from_cmdline, -err);
-		return(1);
+		return 0;
 	}
 	err = os_stat_file(from_cow, &buf2);
 	if(err < 0){
 		printk("Couldn't stat '%s', err = %d\n", from_cow, -err);
-		return(1);
+		return 1;
 	}
 	if((buf1.ust_dev == buf2.ust_dev) && (buf1.ust_ino == buf2.ust_ino))
-		return(1);
+		return 0;
 
 	printk("Backing file mismatch - \"%s\" requested,\n"
 	       "\"%s\" specified in COW header of \"%s\"\n",
 	       from_cmdline, from_cow, cow);
-	return(0);
+	return 1;
 }
 
 static int backing_file_mismatch(char *file, __u64 size, time_t mtime)
@@ -1195,7 +1197,7 @@ int open_ubd_file(char *file, struct ope
 	unsigned long long size;
 	__u32 version, align;
 	char *backing_file;
-	int fd, err, sectorsize, same, mode = 0644;
+	int fd, err, sectorsize, asked_switch, mode = 0644;
 
 	fd = os_open_file(file, *openflags, mode);
 	if(fd < 0){
@@ -1215,6 +1217,7 @@ int open_ubd_file(char *file, struct ope
 		goto out_close;
 	}
 
+	/* Succesful return case! */
 	if(backing_file_out == NULL) return(fd);
 
 	err = read_cow_header(file_reader, &fd, &version, &backing_file, &mtime,
@@ -1226,17 +1229,16 @@ int open_ubd_file(char *file, struct ope
 	}
 	if(err) return(fd);
 
-	if(backing_file_out == NULL) return(fd);
-
-	same = same_backing_files(*backing_file_out, backing_file, file);
+	asked_switch = path_requires_switch(*backing_file_out, backing_file, file);
 
-	if(!same && !backing_file_mismatch(*backing_file_out, size, mtime)){
+	/* Allow switching only if no mismatch. */
+	if (asked_switch && !backing_file_mismatch(*backing_file_out, size, mtime)) {
 		printk("Switching backing file to '%s'\n", *backing_file_out);
 		err = write_cow_header(file, fd, *backing_file_out,
 				       sectorsize, align, &size);
 		if(err){
 			printk("Switch failed, errno = %d\n", -err);
-			return(err);
+			goto out_close;
 		}
 	}
 	else {



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
