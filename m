Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51D5C41513
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QWp50eFh0kKVE5eT7r5zN58MKkl3FY30z5zuxP3UJOg=; b=cHq17aZDprS96szIsmrKxI9JRH
	+dM7HtzIpMapQqPngyDWct6vHm6zxSjyMFo3RTlxMpHlWSh6uUAJGJsjc2g2TLp7SMhBz+i9X3PVA
	oPXKId7YGo+2cnJNgDWB2K+/7/zADLzr+ywyU3lf7larpQbx2raM5hD7autlEl1HcEGiuK0h5Ax26
	FJBXNFgjeFnVni5LbFCbSXjn+Uwsd0dWMgF+1gM5jLcT3gh7BXAFLWs8djnHexN56famlW6lNJRga
	mVjqJ1+qnI22StBg9ifYwuudul8d9nMApJ7k7cXfqPsuLrZuX3uM6BcuREtRywu3E4HjRPEe+l8Si
	VdOO0Hjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOhC6-00000007UzO-0IOJ;
	Tue, 02 Jul 2024 17:21:30 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOhC2-00000007Uxw-2itp
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 17:21:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=QWp50eFh0kKVE5eT7r5zN58MKkl3FY30z5zuxP3UJOg=; t=1719940884; x=1721150484; 
	b=g53xwB5nWsrg1INwI8WaN/bzYuSq5KUZ2+ogSMbR4QaMkyA62zWJSfVwGSL14RgjGeFPWYk6IHA
	jkCIH0VAUhV7UMQk/VN7UW98mKZyRTbmPI5cpTvGI+mnwssbmGLA/3RoYjBnBd5WFQjODiVJXjWGv
	SK9u0dgrAMBf/777qJRe1q4BxSmDOvIMAt3qPljjHxsh2khUMa6UK46whKIhHt17h7eWqzeiRNrl3
	3Y+izeK5o8oSbSmoIi//GMlKUJQ3lMeX9mRGNukbsZawWZr66ILGWwP32TNLih497WL2TGyx1XkWz
	uCCJ7khPr1a8l4NqpZA4Ol+Z2A0wnFqZYs5Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOhBw-000000069u7-31e4;
	Tue, 02 Jul 2024 19:21:20 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Mordechay Goodstein <mordechay.goodstein@intel.com>
Subject: [PATCH v4 1/4] um: time-travel: support time-travel protocol broadcast messages
Date: Tue,  2 Jul 2024 19:21:18 +0200
Message-ID: <20240702192118.c4093bc5b15e.I2ca8d006b67feeb866ac2017af7b741c9e06445a@changeid>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_102126_921605_C0B77AE8 
X-CRM114-Status: GOOD (  22.44  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Add a message type to the time-travel protocol to broadcast
a small (64-bit) value to all participants in a simulation.
The main use case is to have an identical message come to
all participants in a simulation, e.g. to separate out logs
for different tests running in a single simulation.

Down in the guts of time_travel_handle_message() we can't
use printk() and not even printk_deferred(), so just store
the message and print it at the start of the userspace()
function.

Unfortunately this means that other prints in the kernel
can actually bypass the message, but in most cases where
this is used, for example to separate test logs, userspace
will be involved. Also, even if we could use
printk_deferred(), we'd still need to flush it out in the
userspace() function since otherwise userspace messages
might cross it.

As a result, this is a reasonable compromise, there's no
need to have any core changes and it solves the main use
case we have for it.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/timetravel.h |  9 +++++
 arch/um/kernel/time.c               | 59 +++++++++++++++++++++++++++++
 arch/um/os-Linux/skas/process.c     |  3 ++
 include/uapi/linux/um_timetravel.h  | 11 ++++++
 4 files changed, 82 insertions(+)

diff --git a/arch/um/include/shared/timetravel.h b/arch/um/include/shared/timetravel.h
index e5c3d69f1b69..c8db2f213dba 100644
--- a/arch/um/include/shared/timetravel.h
+++ b/arch/um/include/shared/timetravel.h
@@ -15,8 +15,17 @@ enum time_travel_mode {
 #if defined(UML_CONFIG_UML_TIME_TRAVEL_SUPPORT) || \
     defined(CONFIG_UML_TIME_TRAVEL_SUPPORT)
 extern enum time_travel_mode time_travel_mode;
+extern int time_travel_should_print_bc_msg;
 #else
 #define time_travel_mode TT_MODE_OFF
+#define time_travel_should_print_bc_msg 0
 #endif /* (UML_)CONFIG_UML_TIME_TRAVEL_SUPPORT */
 
+void _time_travel_print_bc_msg(void);
+static inline void time_travel_print_bc_msg(void)
+{
+	if (time_travel_should_print_bc_msg)
+		_time_travel_print_bc_msg();
+}
+
 #endif /* _UM_TIME_TRAVEL_H_ */
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index a8bfe8be1526..3f04833f8061 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -60,6 +60,15 @@ enum time_travel_message_handling {
 	TTMH_READ,
 };
 
+static u64 bc_message;
+int time_travel_should_print_bc_msg;
+
+void _time_travel_print_bc_msg(void)
+{
+	time_travel_should_print_bc_msg = 0;
+	printk(KERN_INFO "time-travel: received broadcast 0x%llx\n", bc_message);
+}
+
 static void time_travel_handle_message(struct um_timetravel_msg *msg,
 				       enum time_travel_message_handling mode)
 {
@@ -101,6 +110,10 @@ static void time_travel_handle_message(struct um_timetravel_msg *msg,
 		time_travel_ext_free_until_valid = true;
 		time_travel_ext_free_until = msg->time;
 		break;
+	case UM_TIMETRAVEL_BROADCAST:
+		bc_message = msg->time;
+		time_travel_should_print_bc_msg = 1;
+		break;
 	}
 
 	resp.seq = msg->seq;
@@ -880,4 +893,50 @@ __uml_help(setup_time_travel_start,
 "time-travel-start=<seconds>\n"
 "Configure the UML instance's wall clock to start at this value rather than\n"
 "the host's wall clock at the time of UML boot.\n");
+static struct kobject *bc_time_kobject;
+
+static ssize_t bc_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%llx", bc_message);
+}
+
+static ssize_t bc_store(struct kobject *kobj, struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int ret;
+	u64 user_bc_message;
+
+	ret = kstrtou64(buf, 0, &user_bc_message);
+	if (ret)
+		return ret;
+
+	bc_message = user_bc_message;
+
+	time_travel_ext_req(UM_TIMETRAVEL_BROADCAST, bc_message);
+	pr_info("um: time: sent broadcast message: 0x%llx\n", bc_message);
+	return count;
+}
+
+static struct kobj_attribute bc_attribute = __ATTR(bc-message, 0660, bc_show, bc_store);
+
+static int __init um_bc_start(void)
+{
+	if (time_travel_mode != TT_MODE_EXTERNAL)
+		return 0;
+
+	bc_time_kobject = kobject_create_and_add("um-ext-time", kernel_kobj);
+	if (!bc_time_kobject)
+		return 0;
+
+	if (sysfs_create_file(bc_time_kobject, &bc_attribute.attr))
+		pr_debug("failed to create the bc file in /sys/kernel/um_time");
+
+	return 0;
+}
+
+void __exit time_exit(void)
+{
+	kobject_put(bc_time_kobject);
+}
+
+late_initcall(um_bc_start);
 #endif
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 41a288dcfc34..45885deb6cae 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -23,6 +23,7 @@
 #include <skas.h>
 #include <sysdep/stub.h>
 #include <linux/threads.h>
+#include <timetravel.h>
 #include "../internal.h"
 
 int is_skas_winch(int pid, int fd, void *data)
@@ -345,6 +346,8 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 	interrupt_end();
 
 	while (1) {
+		time_travel_print_bc_msg();
+
 		if (kill_userspace_mm[0])
 			fatal_sigsegv();
 
diff --git a/include/uapi/linux/um_timetravel.h b/include/uapi/linux/um_timetravel.h
index ca3238222b6d..078ea401aa2a 100644
--- a/include/uapi/linux/um_timetravel.h
+++ b/include/uapi/linux/um_timetravel.h
@@ -123,6 +123,17 @@ enum um_timetravel_ops {
 	 *	the simulation.
 	 */
 	UM_TIMETRAVEL_GET_TOD		= 8,
+
+	/**
+	 * @UM_TIMETRAVEL_BROADCAST: Send/Receive a broadcast message.
+	 *	This message can be used to sync all components in the system
+	 *	with a single message, if the calender gets the message, the
+	 *	calender broadcast the message to all components, and if a
+	 *	component receives it it should act based on it e.g print a
+	 *	message to it's log system.
+	 *	(calendar <-> host)
+	 */
+	UM_TIMETRAVEL_BROADCAST		= 9,
 };
 
 #endif /* _UAPI_LINUX_UM_TIMETRAVEL_H */
-- 
2.45.2


