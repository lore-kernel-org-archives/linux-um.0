Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB480C021B0
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 20:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gcNDnYJThlJOmj/T61HFmAWqujk785+9Soz8B7mvAt4=; b=zauiAMtWwoeE+0ICclKRsll5ux
	FG5tFWVbfdG6+cpxzoUS6f4BWiQ1dUJHG8Dk01inuRtL5OxKHp14RxNbjj5jZt1E0MM2+LMy/imBh
	qJUjunUubKjySAO7w3pLTgis5JsieZrJrgqwOc2zcCNrzdOKkpFmzs52HvEJmeyEH4I2rW9/O872v
	hhazAxHyH2Jgi7fbS3FcJzE8FuInfHh2Q9Er9aMwdpSOh2lJYirzgCox22A9fZbXr1J+hyenj6qnf
	zWBlNiJpw/E7YCPWLGCtmRjEUCLORH3DIVaXcLR60eMxgPy8MvYigMaShN6lVnjh2ZHwTea6X9Mgz
	pQGJ1pIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkUfO-00000009tbW-3QpS;
	Tue, 18 Feb 2025 20:58:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkUBR-00000009lJ7-2nV4
	for linux-um@lists.infradead.org;
	Tue, 18 Feb 2025 20:27:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D37CB5C61ED;
	Tue, 18 Feb 2025 20:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4626C4CEE2;
	Tue, 18 Feb 2025 20:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910428;
	bh=2sohyi4xEaTC1NwXXc7Lqb9YoGirX8UCnEFaPIM4CvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMVYB0No8vuUs/c2IoJS1UPeFhxRLp+5e/+5RrmW7OYTxf1RFCnm57ILm3Cs4eK0q
	 y/iai5Q7uMI2HiFAL/c4dY1I4sCQTvkNFYzKaHicdsiEvw07kqar895v5Pa65dQIK2
	 lUOM8HAQdKA9SZm7lOF+ujOGYvXPiaHEMAmBIOjWiXoamlurGkhnQqgTIuuLG7hAYM
	 dk+pkrtEf0KWWafhQEskDx8bbb9UCQ1wlIm/CCAHPtv+bDKFZQnftdkaNgd5YCA2HD
	 y0YinMNdqA2SLtPUykm3noJCMLc5wzg1lChDCjbwtrZ0xEVdfckbNbV8DfW6yJzKji
	 zIyjWAqscnp1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	benjamin.berg@intel.com,
	thehajime@gmail.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 23/31] um: convert irq_lock to raw spinlock
Date: Tue, 18 Feb 2025 15:26:09 -0500
Message-Id: <20250218202619.3592630-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_122709_817455_A0BC68A6 
X-CRM114-Status: GOOD (  17.93  )
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 96178631c3f53398044ed437010f7632ad764bf8 ]

Since this is deep in the architecture, and the code is
called nested into other deep management code, this really
needs to be a raw spinlock. Convert it.

Link: https://patch.msgid.link/20250110125550.32479-8-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/irq.c | 79 ++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 534e91797f892..ebf8012bbec45 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -52,7 +52,7 @@ struct irq_entry {
 	bool sigio_workaround;
 };
 
-static DEFINE_SPINLOCK(irq_lock);
+static DEFINE_RAW_SPINLOCK(irq_lock);
 static LIST_HEAD(active_fds);
 static DECLARE_BITMAP(irqs_allocated, UM_LAST_SIGNAL_IRQ);
 static bool irqs_suspended;
@@ -257,7 +257,7 @@ static struct irq_entry *get_irq_entry_by_fd(int fd)
 	return NULL;
 }
 
-static void free_irq_entry(struct irq_entry *to_free, bool remove)
+static void remove_irq_entry(struct irq_entry *to_free, bool remove)
 {
 	if (!to_free)
 		return;
@@ -265,7 +265,6 @@ static void free_irq_entry(struct irq_entry *to_free, bool remove)
 	if (remove)
 		os_del_epoll_fd(to_free->fd);
 	list_del(&to_free->list);
-	kfree(to_free);
 }
 
 static bool update_irq_entry(struct irq_entry *entry)
@@ -286,17 +285,19 @@ static bool update_irq_entry(struct irq_entry *entry)
 	return false;
 }
 
-static void update_or_free_irq_entry(struct irq_entry *entry)
+static struct irq_entry *update_or_remove_irq_entry(struct irq_entry *entry)
 {
-	if (!update_irq_entry(entry))
-		free_irq_entry(entry, false);
+	if (update_irq_entry(entry))
+		return NULL;
+	remove_irq_entry(entry, false);
+	return entry;
 }
 
 static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id,
 		       void (*timetravel_handler)(int, int, void *,
 						  struct time_travel_event *))
 {
-	struct irq_entry *irq_entry;
+	struct irq_entry *irq_entry, *to_free = NULL;
 	int err, events = os_event_mask(type);
 	unsigned long flags;
 
@@ -304,9 +305,10 @@ static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id,
 	if (err < 0)
 		goto out;
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	irq_entry = get_irq_entry_by_fd(fd);
 	if (irq_entry) {
+already:
 		/* cannot register the same FD twice with the same type */
 		if (WARN_ON(irq_entry->reg[type].events)) {
 			err = -EALREADY;
@@ -316,11 +318,22 @@ static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id,
 		/* temporarily disable to avoid IRQ-side locking */
 		os_del_epoll_fd(fd);
 	} else {
-		irq_entry = kzalloc(sizeof(*irq_entry), GFP_ATOMIC);
-		if (!irq_entry) {
-			err = -ENOMEM;
-			goto out_unlock;
+		struct irq_entry *new;
+
+		/* don't restore interrupts */
+		raw_spin_unlock(&irq_lock);
+		new = kzalloc(sizeof(*irq_entry), GFP_ATOMIC);
+		if (!new) {
+			local_irq_restore(flags);
+			return -ENOMEM;
 		}
+		raw_spin_lock(&irq_lock);
+		irq_entry = get_irq_entry_by_fd(fd);
+		if (irq_entry) {
+			to_free = new;
+			goto already;
+		}
+		irq_entry = new;
 		irq_entry->fd = fd;
 		list_add_tail(&irq_entry->list, &active_fds);
 		maybe_sigio_broken(fd);
@@ -339,12 +352,11 @@ static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id,
 #endif
 
 	WARN_ON(!update_irq_entry(irq_entry));
-	spin_unlock_irqrestore(&irq_lock, flags);
-
-	return 0;
+	err = 0;
 out_unlock:
-	spin_unlock_irqrestore(&irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
 out:
+	kfree(to_free);
 	return err;
 }
 
@@ -358,19 +370,20 @@ void free_irq_by_fd(int fd)
 	struct irq_entry *to_free;
 	unsigned long flags;
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	to_free = get_irq_entry_by_fd(fd);
-	free_irq_entry(to_free, true);
-	spin_unlock_irqrestore(&irq_lock, flags);
+	remove_irq_entry(to_free, true);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+	kfree(to_free);
 }
 EXPORT_SYMBOL(free_irq_by_fd);
 
 static void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
 {
-	struct irq_entry *entry;
+	struct irq_entry *entry, *to_free = NULL;
 	unsigned long flags;
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	list_for_each_entry(entry, &active_fds, list) {
 		enum um_irq_type i;
 
@@ -386,12 +399,13 @@ static void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
 
 			os_del_epoll_fd(entry->fd);
 			reg->events = 0;
-			update_or_free_irq_entry(entry);
+			to_free = update_or_remove_irq_entry(entry);
 			goto out;
 		}
 	}
 out:
-	spin_unlock_irqrestore(&irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+	kfree(to_free);
 }
 
 void deactivate_fd(int fd, int irqnum)
@@ -402,7 +416,7 @@ void deactivate_fd(int fd, int irqnum)
 
 	os_del_epoll_fd(fd);
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	entry = get_irq_entry_by_fd(fd);
 	if (!entry)
 		goto out;
@@ -414,9 +428,10 @@ void deactivate_fd(int fd, int irqnum)
 			entry->reg[i].events = 0;
 	}
 
-	update_or_free_irq_entry(entry);
+	entry = update_or_remove_irq_entry(entry);
 out:
-	spin_unlock_irqrestore(&irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+	kfree(entry);
 
 	ignore_sigio_fd(fd);
 }
@@ -546,7 +561,7 @@ void um_irqs_suspend(void)
 
 	irqs_suspended = true;
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	list_for_each_entry(entry, &active_fds, list) {
 		enum um_irq_type t;
 		bool clear = true;
@@ -579,7 +594,7 @@ void um_irqs_suspend(void)
 				!__ignore_sigio_fd(entry->fd);
 		}
 	}
-	spin_unlock_irqrestore(&irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
 }
 
 void um_irqs_resume(void)
@@ -588,7 +603,7 @@ void um_irqs_resume(void)
 	unsigned long flags;
 
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	list_for_each_entry(entry, &active_fds, list) {
 		if (entry->suspended) {
 			int err = os_set_fd_async(entry->fd);
@@ -602,7 +617,7 @@ void um_irqs_resume(void)
 			}
 		}
 	}
-	spin_unlock_irqrestore(&irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
 
 	irqs_suspended = false;
 	send_sigio_to_self();
@@ -613,7 +628,7 @@ static int normal_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct irq_entry *entry;
 	unsigned long flags;
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	list_for_each_entry(entry, &active_fds, list) {
 		enum um_irq_type t;
 
@@ -628,7 +643,7 @@ static int normal_irq_set_wake(struct irq_data *d, unsigned int on)
 		}
 	}
 unlock:
-	spin_unlock_irqrestore(&irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
 	return 0;
 }
 #else
-- 
2.39.5


