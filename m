Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5ABFD9E19
	for <linux-um@archiver.kernel.org>; Thu, 26 Feb 2026 22:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E2VTeQ3C2cQkljrZGq8S36jL6ptQw/xTjrmx61gZgJI=; b=Z0iaxwd7xJKLb11Dx7MzNU0RD/
	MmSUzTDSa02XntOGti+clg4UqRXsQSCATl6C338fnA4vKEHSr+9z7/Je8qnssWiTiK2xNJONSjzj7
	Q8yaQYjLHHGpZ32pDrOiZZFeQKsEjG1jpL9qQNXuoryUu6XaWla9qzw6aSd6UYApRPFb+1j2+WNFk
	X3p2it+YQYN3wWyiO0A266e5egyGpE3z09+vBtZBJP7wsXfAzuqOgnxzvoW6k8zMMwpDDWhgbEMgW
	RA6KQTWx+GMUv4chTY6WUbtaKc2Tk5Uw6S0AZVn0buKOFJtOYH69eL2vcSeeqdH6olOmM1oo8O0OP
	9gfX3mrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvjZk-00000007Hmy-1rHk;
	Thu, 26 Feb 2026 22:11:16 +0000
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvjZh-00000007Hmm-1SH2;
	Thu, 26 Feb 2026 22:11:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH] um: time-travel: clean up kernel-doc warnings
Date: Thu, 26 Feb 2026 14:11:12 -0800
Message-ID: <20260226221112.1042008-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Repair all kernel-doc warnings in um_timetravel.h:
- add one enum description
- mark "reserve" as private
- use a leading '@' on current_time

Warning: include/uapi/linux/um_timetravel.h:59 Enum value
 'UM_TIMETRAVEL_SHARED_MAX_FDS' not described in enum
 'um_timetravel_shared_mem_fds'
Warning: include/uapi/linux/um_timetravel.h:245 union member 'reserve'
 not described in 'um_timetravel_schedshm_client'
Warning: include/uapi/linux/um_timetravel.h:288 struct member
 'current_time' not described in 'um_timetravel_schedshm'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org

 include/uapi/linux/um_timetravel.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-next-20260226.orig/include/uapi/linux/um_timetravel.h
+++ linux-next-20260226/include/uapi/linux/um_timetravel.h
@@ -56,6 +56,9 @@ enum um_timetravel_shared_mem_fds {
 	 *	in the control message
 	 */
 	UM_TIMETRAVEL_SHARED_LOGFD,
+	/**
+	 * @UM_TIMETRAVEL_SHARED_MAX_FDS: number of fds listed here
+	 */
 	UM_TIMETRAVEL_SHARED_MAX_FDS,
 };
 
@@ -242,6 +245,7 @@ union um_timetravel_schedshm_client {
 		__u64 req_time;
 		__u64 name;
 	};
+	/* private: */
 	char reserve[128]; /* reserved for future usage */
 };
 
@@ -264,7 +268,7 @@ union um_timetravel_schedshm_client {
  *	is made by any client. Clients also must update this value when they
  *	insert/update an own request into the shared memory while not running
  *	themselves, and the new request is before than the current value.
- * current_time: Current time, can only be set by the client in running state
+ * @current_time: Current time, can only be set by the client in running state
  *	(indicated by @running_id), though that client may only run until @free_until,
  *	so it must remain smaller than @free_until.
  * @running_id: The current client in state running, set before a client is

