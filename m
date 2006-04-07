Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRs0p-0003Hd-Mx for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:35 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRs0l-0003ZZ-SD
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:35 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060407143051.19201.67922.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 02/17] uml: safe migration path to the correct V3
	COW format
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
Date: Fri, 07 Apr 2006 16:30:52 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

*) Correct the layout of all header versions - make all them well-specified for
any external event. As we don't have 1-byte or 2-byte wide fields, the 32-bit
layout (historical one) has no extra padding, so we can safely add
__attribute__((packed)).

*) Add detection and reading of the broken 64-bit COW format which has been
around for a while - to allow safe migration to the correct 32-bit format. Safe
detection is possible, thanks to some luck with the existing format, and it
works in practice.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow_user.c |   91 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 76 insertions(+), 15 deletions(-)

diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index afdf1ea..a9afccf 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -17,30 +17,34 @@
 
 #define PATH_LEN_V1 256
 
+typedef __u32 time32_t;
+
 struct cow_header_v1 {
-	int magic;
-	int version;
+	__s32 magic;
+	__s32 version;
 	char backing_file[PATH_LEN_V1];
-	time_t mtime;
+	time32_t mtime;
 	__u64 size;
-	int sectorsize;
-};
+	__s32 sectorsize;
+} __attribute__((packed));
 
-#define PATH_LEN_V2 MAXPATHLEN
+/* Define PATH_LEN_V3 as the usual value of MAXPATHLEN, just hard-code it in
+ * case other systems have different values for MAXPATHLEN.
+ *
+ * The same must hold for V2 - we want file format compatibility, not anything
+ * else.
+ */
+#define PATH_LEN_V3 4096
+#define PATH_LEN_V2 PATH_LEN_V3
 
 struct cow_header_v2 {
 	__u32 magic;
 	__u32 version;
 	char backing_file[PATH_LEN_V2];
-	time_t mtime;
+	time32_t mtime;
 	__u64 size;
-	int sectorsize;
-};
-
-/* Define PATH_LEN_V3 as the usual value of MAXPATHLEN, just hard-code it in
- * case other systems have different values for MAXPATHLEN
- */
-#define PATH_LEN_V3 4096
+	__s32 sectorsize;
+} __attribute__((packed));
 
 /* Changes from V2 -
  *	PATH_LEN_V3 as described above
@@ -66,6 +70,15 @@ struct cow_header_v2 {
  *	Fixed (finally!) the rounding bug
  */
 
+/* Until Dec2005, __attribute__((packed)) was left out from the below
+ * definition, leading on 64-bit systems to 4 bytes of padding after mtime, to
+ * align size to 8-byte alignment.  This shifted all fields above (no padding
+ * was present on 32-bit, no other padding was added).
+ *
+ * However, this _can be detected_: it means that cow_format (always 0 until
+ * now) is shifted onto the first 4 bytes of backing_file, where it is otherwise
+ * impossible to find 4 zeros. -bb */
+
 struct cow_header_v3 {
 	__u32 magic;
 	__u32 version;
@@ -77,6 +90,18 @@ struct cow_header_v3 {
 	char backing_file[PATH_LEN_V3];
 } __attribute__((packed));
 
+/* This is the broken layout used by some 64-bit binaries. */
+struct cow_header_v3_broken {
+	__u32 magic;
+	__u32 version;
+	__s64 mtime;
+	__u64 size;
+	__u32 sectorsize;
+	__u32 alignment;
+	__u32 cow_format;
+	char backing_file[PATH_LEN_V3];
+};
+
 /* COW format definitions - for now, we have only the usual COW bitmap */
 #define COW_BITMAP 0
 
@@ -84,6 +109,7 @@ union cow_header {
 	struct cow_header_v1 v1;
 	struct cow_header_v2 v2;
 	struct cow_header_v3 v3;
+	struct cow_header_v3_broken v3_b;
 };
 
 #define COW_MAGIC 0x4f4f4f4d  /* MOOO */
@@ -300,7 +326,8 @@ int read_cow_header(int (*reader)(__u64,
 		*align_out = *sectorsize_out;
 		file = header->v2.backing_file;
 	}
-	else if(version == 3){
+	/* This is very subtle - see above at union cow_header definition */
+	else if(version == 3 && (*((int*)header->v3.backing_file) != 0)){
 		if(n < sizeof(header->v3)){
 			cow_printf("read_cow_header - failed to read V3 "
 				   "header\n");
@@ -310,9 +337,43 @@ int read_cow_header(int (*reader)(__u64,
 		*size_out = ntohll(header->v3.size);
 		*sectorsize_out = ntohl(header->v3.sectorsize);
 		*align_out = ntohl(header->v3.alignment);
+		if (*align_out == 0) {
+			cow_printf("read_cow_header - invalid COW header, "
+				   "align == 0\n");
+		}
 		*bitmap_offset_out = ROUND_UP(sizeof(header->v3), *align_out);
 		file = header->v3.backing_file;
 	}
+	else if(version == 3){
+		cow_printf("read_cow_header - broken V3 file with"
+			   " 64-bit layout - recovering content.\n");
+
+		if(n < sizeof(header->v3_b)){
+			cow_printf("read_cow_header - failed to read V3 "
+				   "header\n");
+			goto out;
+		}
+
+		/* this was used until Dec2005 - 64bits are needed to represent
+		 * 2038+. I.e. we can safely do this truncating cast.
+		 *
+		 * Additionally, we must use ntohl() instead of ntohll(), since
+		 * the program used to use the former (tested - I got mtime
+		 * mismatch "0 vs whatever").
+		 *
+		 * Ever heard about bug-to-bug-compatibility ? ;-) */
+		*mtime_out = (time32_t) ntohl(header->v3_b.mtime);
+
+		*size_out = ntohll(header->v3_b.size);
+		*sectorsize_out = ntohl(header->v3_b.sectorsize);
+		*align_out = ntohl(header->v3_b.alignment);
+		if (*align_out == 0) {
+			cow_printf("read_cow_header - invalid COW header, "
+				   "align == 0\n");
+		}
+		*bitmap_offset_out = ROUND_UP(sizeof(header->v3_b), *align_out);
+		file = header->v3_b.backing_file;
+	}
 	else {
 		cow_printf("read_cow_header - invalid COW version\n");
 		goto out;


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
