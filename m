Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KUUQ4-0005Pi-Kb for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Aug 2008 15:38:52 -0700
Received: from mx1.suse.de ([195.135.220.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KUUQ3-0002rH-VJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Aug 2008 15:38:48 -0700
From: <gregkh@suse.de>
Date: Sat, 16 Aug 2008 15:32:44 -0700
In-Reply-To: <20080805201405.GA11736@c2.user-mode-linux.org>
Message-Id: <20080816223845.535771454450@imap.suse.de>
Subject: [uml-devel] patch uml-missed-kmalloc-in-pcap_user.c.patch added to
	2.6.25-stable tree
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: viro@ftp.linux.org.uk, gregkh@suse.de, jdike@addtoit.com, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, user-mode-linux-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

    Subject: uml: missed kmalloc() in pcap_user.c

to the 2.6.25-stable tree.  Its filename is

    uml-missed-kmalloc-in-pcap_user.c.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


From stable-bounces@linux.kernel.org Tue Aug  5 13:14:38 2008
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 5 Aug 2008 16:14:05 -0400
Subject: uml: missed kmalloc() in pcap_user.c
To: stable@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Message-ID: <20080805201405.GA11736@c2.user-mode-linux.org>
Content-Disposition: inline

From: Al Viro <viro@ftp.linux.org.uk>

commit 296cd66f7f6e130fe08e6880ecb13c3fc615a8db upstream

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/drivers/pcap_user.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/um/drivers/pcap_user.c
+++ b/arch/um/drivers/pcap_user.c
@@ -50,7 +50,7 @@ static int pcap_open(void *data)
 			return -EIO;
 		}
 
-		pri->compiled = kmalloc(sizeof(struct bpf_program),
+		pri->compiled = uml_kmalloc(sizeof(struct bpf_program),
 					UM_GFP_KERNEL);
 		if (pri->compiled == NULL) {
 			printk(UM_KERN_ERR "pcap_open : kmalloc failed\n");


Patches currently in stable-queue which might be from viro@ftp.linux.org.uk are

queue-2.6.25/uml-missed-kmalloc-in-pcap_user.c.patch
queue-2.6.25/uml-missing-export-of-csum_partial-on-uml-amd64.patch

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
