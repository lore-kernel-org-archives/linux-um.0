Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRs0i-0003GO-QN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:28 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRs0f-00079k-7e
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:28 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060407143128.19201.32039.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 17/17] uml: avoid warnings for diffent names for
	an unsigned quadword
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
Date: Fri, 07 Apr 2006 16:31:29 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Since on some 64-bit systems __u64 is rightfully defined to unsigned long and
GCC recognizes anyway unsigned long and unsigned long long as different, fix
some types back to being unsigned long long to avoid warnings and errors (for
prototype mismatch) on those systems.

Thanks to the report by Wesley Emeneker wesleyemeneker (at) google (dot) com

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow.h     |    2 +-
 arch/um/drivers/cow_sys.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/cow.h b/arch/um/drivers/cow.h
index 04e3958..dc36b22 100644
--- a/arch/um/drivers/cow.h
+++ b/arch/um/drivers/cow.h
@@ -46,7 +46,7 @@ extern int file_reader(__u64 offset, cha
 extern int read_cow_header(int (*reader)(__u64, char *, int, void *),
 			   void *arg, __u32 *version_out,
 			   char **backing_file_out, time_t *mtime_out,
-			   __u64 *size_out, int *sectorsize_out,
+			   unsigned long long *size_out, int *sectorsize_out,
 			   __u32 *align_out, int *bitmap_offset_out);
 
 extern int write_cow_header(char *cow_file, int fd, char *backing_file,
diff --git a/arch/um/drivers/cow_sys.h b/arch/um/drivers/cow_sys.h
index 94de4ea..7a5b4af 100644
--- a/arch/um/drivers/cow_sys.h
+++ b/arch/um/drivers/cow_sys.h
@@ -28,7 +28,7 @@ static inline int cow_seek_file(int fd, 
 	return(os_seek_file(fd, offset));
 }
 
-static inline int cow_file_size(char *file, __u64 *size_out)
+static inline int cow_file_size(char *file, unsigned long long *size_out)
 {
 	return(os_file_size(file, size_out));
 }


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
