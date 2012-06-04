Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Sbdse-0005K9-7b
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 20:28:00 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Sbdsd-0007JE-ER
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 20:28:00 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon,  4 Jun 2012 22:27:37 +0200
Message-Id: <1338841657-30358-7-git-send-email-richard@nod.at>
In-Reply-To: <1338841657-30358-1-git-send-email-richard@nod.at>
References: <1338841657-30358-1-git-send-email-richard@nod.at>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 6/6] um: remove count_lock
To: jslaby@suse.cz
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, alan@linux.intel.com

this lock is no longer needed.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/line.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 95d5e78..555ccfc 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -382,8 +382,6 @@ int setup_one_line(struct line *lines, int n, char *init,
 	struct tty_driver *driver = line->driver->driver;
 	int err = -EINVAL;
 
-	mutex_lock(&line->count_lock);
-
 	if (line->port.count) {
 		*error_out = "Device is already open";
 		goto out;
@@ -425,7 +423,6 @@ int setup_one_line(struct line *lines, int n, char *init,
 		}
 	}
 out:
-	mutex_unlock(&line->count_lock);
 	return err;
 }
 
@@ -513,7 +510,6 @@ int line_get_config(char *name, struct line *lines, unsigned int num, char *str,
 
 	line = &lines[dev];
 
-	mutex_lock(&line->count_lock);
 	if (!line->valid)
 		CONFIG_CHUNK(str, size, n, "none", 1);
 	else {
@@ -525,7 +521,6 @@ int line_get_config(char *name, struct line *lines, unsigned int num, char *str,
 			tty_kref_put(tty);
 		}
 	}
-	mutex_unlock(&line->count_lock);
 
 	return n;
 }
@@ -578,7 +573,6 @@ int register_lines(struct line_driver *line_driver,
 		tty_port_init(&lines[i].port);
 		lines[i].port.ops = &line_port_ops;
 		spin_lock_init(&lines[i].lock);
-		mutex_init(&lines[i].count_lock);
 		lines[i].driver = line_driver;
 		INIT_LIST_HEAD(&lines[i].chan_list);
 	}
-- 
1.7.7.3


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

