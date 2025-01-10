Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E290EE7719D
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 13:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b45EE9I24afv27ecEDw2LbEGjE+r152NnHoNv9qbUrs=; b=5Feh0NOCWZrmS2NrTxu/BGCXpN
	6zjKv3yCx1kTt/9nEaQ20IlhIeAcbt9QDwoQYJ6yMx4bT+dW+S/HFvAX5OawoQAnqSPoQgsyJ+hX0
	uvj/K/xtn4EoxKS8HLE0yW8Js4QlezcSFYgTpEluW4Gh34ik4HHBtrfFzOTBliFQMqbSRXzu/9AN2
	h7vTSu24egwI7+eOuH94oUr7o+s0LHxNMtZg2fk58dd88RcOZEa/K1r+uPCEwRuM3D3PyOfHeqRXh
	hIvhXHTL/jFPZedtUlJAVSbHP8UxGvUTjaYcT6jYYqgRCdT+hFq6JWWJbckksx60gQoydOQ84iqks
	q2G6NrJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWEpm-0000000FQfa-2frF;
	Fri, 10 Jan 2025 13:13:54 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWEYQ-0000000FMiz-1bOZ
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 12:56:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=b45EE9I24afv27ecEDw2LbEGjE+r152NnHoNv9qbUrs=;
	t=1736513756; x=1737723356; b=xhyZE/tIv7pwrmIFtyfgcNO5PynFks48s+oYtox3x3eRJaA
	Sf1SC9peYXqpnPJ3SHyJkbmQAkiaQ8VogRp08hKZ9CUHuTZp+2NCL17UtkxCl++fqMLmXhGoj4LO3
	RLtcndb3CWD7Gc1C2/YIR+9JLaYrnzv2SsGdT7lXdP9CdNIIl8HYs568o7iycrF64fD26ZXGueH9w
	C+raKf0R9Y9Pakb8RsxDnWs825DX89AGgYaeQJUw0/gLCitFo+LuQHJ1rtncyYlDnwT3RTLHt7J4m
	UnOEhOqSVUsJlxhO0unFI191Vli4D2BccFJYlqyUZt/OZ8iodMwHBvsnR1Q8fq1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tWEYN-0000000Aaru-11Gn;
	Fri, 10 Jan 2025 13:55:55 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] um: convert irq_lock to raw spinlock
Date: Fri, 10 Jan 2025 13:54:06 +0100
Message-ID: <20250110125550.32479-8-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110125550.32479-5-johannes@sipsolutions.net>
References: <20250110125550.32479-5-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_045558_576703_C336E4A3 
X-CRM114-Status: GOOD (  18.29  )
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

Since this is deep in the architecture, and the code is
called nested into other deep management code, this really
needs to be a raw spinlock. Convert it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/irq.c | 79 ++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 338450741aac..a4991746f5ea 100644
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
2.47.1


