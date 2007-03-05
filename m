Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOM0E-0002Bq-PC for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:49:58 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOM0D-0005Y3-6j
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:49:58 -0800
Message-Id: <200703052241.l25MfLh5008435@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 05 Mar 2007 17:41:21 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/4] UML - Add a debugging message
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Add a debugging message in the case that mapping a stub fails.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/os-Linux/skas/process.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: test/arch/um/os-Linux/skas/process.c
===================================================================
--- test.orig/arch/um/os-Linux/skas/process.c	2007-03-05 15:08:18.000000000 -0500
+++ test/arch/um/os-Linux/skas/process.c	2007-03-05 16:14:56.000000000 -0500
@@ -419,9 +419,12 @@ void map_stub_pages(int fd, unsigned lon
 					  .offset  = code_offset
 	} } });
 	n = os_write_file(fd, &mmop, sizeof(mmop));
-	if(n != sizeof(mmop))
+	if(n != sizeof(mmop)){
+		printk("mmap args - addr = 0x%lx, fd = %d, offset = %llx\n",
+		       code, code_fd, (unsigned long long) code_offset);
 		panic("map_stub_pages : /proc/mm map for code failed, "
 		      "err = %d\n", -n);
+	}
 
 	if ( stack ) {
 		__u64 map_offset;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
