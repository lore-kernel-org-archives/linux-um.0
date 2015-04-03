Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1Ye2wk-0006nB-Uc
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Apr 2015 14:51:46 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ye2wj-0007Jg-6Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Apr 2015 14:51:46 +0000
Received: from [217.255.199.123] (helo=localhost.localdomain)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.80.1)
	(envelope-from <thomas@m3y3r.de>) id 1Ye2wa-0003Ro-TL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Apr 2015 16:51:38 +0200
Message-ID: <1428072686.106641.7.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Fri, 03 Apr 2015 16:51:26 +0200
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH v3] um: Print minimum physical memory requirement
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Print a more sensible message about the minimum physical memory
requirement.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 549ecf3..6f20626 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -57,22 +57,51 @@ void map_memory(unsigned long virt, unsigned long phys, unsigned long len,
 
 extern int __syscall_stub_start;
 
+/**
+ * setup_physmem() - Setup physical memory for UML
+ * @start:	Start address of the physical kernel memory,
+ *		i.e start address of the executable image.
+ * @reserve_end:	end address of the physical kernel memory.
+ * @len:	Length of total physical memory that should be mapped/made
+ *		available, in bytes.
+ * @highmem:	Number of highmem bytes that should be mapped/made available.
+ *
+ * Creates an unlinked temporary file of size (len + highmem) and memory maps
+ * it on the last executable image address (uml_reserved).
+ *
+ * The offset is needed as the length of the total physical memory
+ * (len + highmem) includes the size of the memory used be the executable image,
+ * but the mapped-to address is the last address of the executable image
+ * (uml_reserved == end address of executable image).
+ *
+ * The memory mapped memory of the temporary file is used as backing memory
+ * of all user space processes/kernel tasks.
+ */
 void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 			  unsigned long len, unsigned long long highmem)
 {
 	unsigned long reserve = reserve_end - start;
-	int pfn = PFN_UP(__pa(reserve_end));
-	int delta = (len - reserve) >> PAGE_SHIFT;
-	int err, offset, bootmap_size;
+	unsigned long pfn = PFN_UP(__pa(reserve_end));
+	unsigned long delta = (len - reserve) >> PAGE_SHIFT;
+	unsigned long offset, bootmap_size;
+	long map_size;
+	int err;
+
+	offset = uml_reserved - uml_physmem;
+	map_size = len - offset;
+	if(map_size <= 0) {
+		printf("Too few physical memory! Needed=%d, given=%d\n",
+		       offset, len);
+		exit(1);
+	}
 
 	physmem_fd = create_mem_file(len + highmem);
 
-	offset = uml_reserved - uml_physmem;
 	err = os_map_memory((void *) uml_reserved, physmem_fd, offset,
-			    len - offset, 1, 1, 1);
+			    map_size, 1, 1, 1);
 	if (err < 0) {
 		printf("setup_physmem - mapping %ld bytes of memory at 0x%p "
-		       "failed - errno = %d\n", len - offset,
+		       "failed - errno = %d\n", map_size,
 		       (void *) uml_reserved, err);
 		exit(1);
 	}




------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

