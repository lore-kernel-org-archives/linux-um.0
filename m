Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILQZl-00071n-3n for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 14:38:49 -0700
Received: from nef2.ens.fr ([129.199.96.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ILQZj-00033x-HW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 14:38:49 -0700
Date: Wed, 15 Aug 2007 23:38:25 +0200
From: Nicolas George <nicolas.george@normalesup.org>
Message-ID: <20070815213825.GA26490@clipper.ens.fr>
References: <20070813124247.GA7414@she-seel.salle-s.org>
	<20070815171247.GA7948@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070815171247.GA7948@c2.user-mode-linux.org>
Subject: [uml-devel] [PATCH] UML: BLKGETSIZE takes a long, not an int
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The BLKGETSIZE ioctl expects a pointer to a long, os_file_size was providing
an int. Therefore, ubd access to host block devices caused a segmentation
fault on 64 bits systems.

Signed-off-by: Nicolas George <nicolas.george@normalesup.org>

---

Jeff Dike wrote:
> Looks sane, can I have a properly Signed-off-by: version of the patch?

Of course. I should have sent it correctly the first time. And I am terribly
sorry for the mess my mailer have done with my second mail.

Here is the hopefully correct patch, against current git.

Regards.

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 6f92f73..c3ecc2a 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -320,7 +320,8 @@ int os_file_size(char *file, unsigned long long *size_out)
 	}
 
 	if(S_ISBLK(buf.ust_mode)){
-		int fd, blocks;
+		int fd;
+		long blocks;
 
 		fd = os_open_file(file, of_read(OPENFLAGS()), 0);
 		if(fd < 0){

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
