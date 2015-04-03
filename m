Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1Ye0GZ-0007xa-CV
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Apr 2015 12:00:03 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ye0GX-0006vW-6w
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Apr 2015 12:00:03 +0000
Received: from [217.255.221.57] (helo=localhost.localdomain)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.80.1)
	(envelope-from <thomas@m3y3r.de>) id 1Ye0GQ-0006ij-7y
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Apr 2015 13:59:54 +0200
Message-ID: <1428062392.106641.3.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Fri, 03 Apr 2015 13:59:52 +0200
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
Subject: [uml-devel] [PATCH v2] um: Print minimum physical memory requirement
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Print a more sensible message about the minimum physical memory
requirement.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 549ecf3..f7af5e6 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -61,18 +61,26 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 			  unsigned long len, unsigned long long highmem)
 {
 	unsigned long reserve = reserve_end - start;
-	int pfn = PFN_UP(__pa(reserve_end));
-	int delta = (len - reserve) >> PAGE_SHIFT;
-	int err, offset, bootmap_size;
+	unsigned long pfn = PFN_UP(__pa(reserve_end));
+	unsigned long delta = (len - reserve) >> PAGE_SHIFT;
+	unsigned long offset, bootmap_size;
+	int err, map_size;
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

