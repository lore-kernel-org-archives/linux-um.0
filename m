Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB30C30653
	for <linux-um@archiver.kernel.org>; Mon,  1 Jul 2024 21:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hei3cgIU+UFMNopAKAKSrAt8+W1FkjANxW1KwiUVDVY=; b=Y8pKs3/up1RMry5iEZ042phkTl
	VRztvKun5OXRXM+qFAXG3ZfBQwwM/iUIn5Qr226xtduKJkoVMqc8TFFIokCpXLqInxJHy2FxxYsAE
	83YrDpDUSUrjosATl0i/xDsw6/KjAeg/clr5lcdPRyKuvX/vUlp3iz86K+mdw0ONMvO3asyIQIGwm
	vAmVb5sDNlL437L19elM7PG8SN/WvJkxZhmd4tHGjO7oDlTHXajBsZBLgHb23WUWEyhjNusUZ3/Eb
	Z/ZoQVYRVr+hNfYwXC05Pvbp2vf3ANdP2qbDy4Y6P9jZxsQ6LtQDaJiC45QKSnb5hgBBzOjWYyTZa
	3O9YIyYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOOd8-00000004tjT-3wKw;
	Mon, 01 Jul 2024 21:32:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOOd4-00000004tgy-1SKA
	for linux-um@lists.infradead.org;
	Mon, 01 Jul 2024 21:32:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hei3cgIU+UFMNopAKAKSrAt8+W1FkjANxW1KwiUVDVY=;
	t=1719869526; x=1721079126; b=oK8iG3O6him8qO0gEHR+e5603tcZAGSrjLX2GD39H8AHzFx
	pDmS79UBfH+d6Jhq4WhaaAdOFpHwpqDr2DUv8TQyCuKn2XFytIlEzWYEuWdD5xJ8ZXEY3xH7DZ59B
	C1TVdbiP5cGXo3ugbv2I5KFORj/L42PpvGMG9vyinXFyqCHjk/xacpuCzYWDGw1UZ8mcCGFtFrWTK
	YPGk+B+TV+iaR69OmTa1GPckr3yZd35suZ3SbOELFvSmwvcR2BFkO+gB5c6hdtflU3fdPxS+uotic
	ihSw4zuACX8uLhyk6Lee31FI6M7mm++cZCjlji3e+WtCDCaCnoLKMe+D1BIBL1Yw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOOd1-00000003LSU-16sR;
	Mon, 01 Jul 2024 23:32:03 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Mordechay Goodstein <mordechay.goodstein@intel.com>
Subject: [PATCH v3 4/4] um: add shared memory optimisation for time-travel=ext
Date: Mon,  1 Jul 2024 23:31:59 +0200
Message-ID: <20240701233155.5611a2fb21be.Ie41206c8ce4507fe26b991937f47e86c24ca7a31@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701233155.4e9de8a682eb.I2ca8d006b67feeb866ac2017af7b741c9e06445a@changeid>
References: <20240701233155.4e9de8a682eb.I2ca8d006b67feeb866ac2017af7b741c9e06445a@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_143206_740806_DCFE9577 
X-CRM114-Status: GOOD (  40.02  )
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

With external time travel, a LOT of message can end up
being exchanged on the socket, taking a significant
amount of time just to do that.

Add a new shared memory optimisation to that, where a
number of changes are made:
 - the controller sends a client ID and a shared memory FD
   (and a logging FD we don't use) in the ACK message to
   the initial START
 - the shared memory holds the current time and the
   free_until value, so that there's no need to exchange
   messages for that
 - if the client that's running has shared memory support,
   any client (the running one included) can request the
   next time it wants to run inside the shared memory,
   rather than sending a message, by also updating the
   free_until value
 - when shared memory is enabled, RUN/WAIT messages no
   longer have an ACK, further cutting down on messages

Together, this can reduce the number of messages very
significantly, and reduce overall test/simulation run time.

Co-developed-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/time.c              | 130 +++++++++++++++++++--
 include/uapi/linux/um_timetravel.h | 182 ++++++++++++++++++++++++++---
 2 files changed, 285 insertions(+), 27 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 3f04833f8061..f03667ecce39 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -31,6 +31,7 @@ EXPORT_SYMBOL_GPL(time_travel_mode);
 static bool time_travel_start_set;
 static unsigned long long time_travel_start;
 static unsigned long long time_travel_time;
+static unsigned long long time_travel_shm_offset;
 static LIST_HEAD(time_travel_events);
 static LIST_HEAD(time_travel_irqs);
 static unsigned long long time_travel_timer_interval;
@@ -40,8 +41,11 @@ static int time_travel_ext_fd = -1;
 static unsigned int time_travel_ext_waiting;
 static bool time_travel_ext_prev_request_valid;
 static unsigned long long time_travel_ext_prev_request;
-static bool time_travel_ext_free_until_valid;
-static unsigned long long time_travel_ext_free_until;
+static unsigned long long *time_travel_ext_free_until;
+static unsigned long long _time_travel_ext_free_until;
+static u16 time_travel_shm_id;
+static struct um_timetravel_schedshm *time_travel_shm;
+static union um_timetravel_schedshm_client *time_travel_shm_client;
 
 static void time_travel_set_time(unsigned long long ns)
 {
@@ -58,6 +62,7 @@ enum time_travel_message_handling {
 	TTMH_IDLE,
 	TTMH_POLL,
 	TTMH_READ,
+	TTMH_READ_START_ACK,
 };
 
 static u64 bc_message;
@@ -69,6 +74,40 @@ void _time_travel_print_bc_msg(void)
 	printk(KERN_INFO "time-travel: received broadcast 0x%llx\n", bc_message);
 }
 
+static void time_travel_setup_shm(int fd, u16 id)
+{
+	u32 len;
+
+	time_travel_shm = os_mmap_rw_shared(fd, sizeof(*time_travel_shm));
+
+	if (!time_travel_shm)
+		goto out;
+
+	len = time_travel_shm->len;
+
+	if (time_travel_shm->version != UM_TIMETRAVEL_SCHEDSHM_VERSION ||
+	    len < struct_size(time_travel_shm, clients, id + 1)) {
+		os_unmap_memory(time_travel_shm, sizeof(*time_travel_shm));
+		time_travel_shm = NULL;
+		goto out;
+	}
+
+	time_travel_shm = os_mremap_rw_shared(time_travel_shm,
+					      sizeof(*time_travel_shm),
+					      len);
+	if (!time_travel_shm)
+		goto out;
+
+	time_travel_shm_offset = time_travel_shm->current_time;
+	time_travel_shm_client = &time_travel_shm->clients[id];
+	time_travel_shm_client->capa |= UM_TIMETRAVEL_SCHEDSHM_CAP_TIME_SHARE;
+	time_travel_shm_id = id;
+	/* always look at that free_until from now on */
+	time_travel_ext_free_until = &time_travel_shm->free_until;
+out:
+	os_close_file(fd);
+}
+
 static void time_travel_handle_message(struct um_timetravel_msg *msg,
 				       enum time_travel_message_handling mode)
 {
@@ -89,7 +128,20 @@ static void time_travel_handle_message(struct um_timetravel_msg *msg,
 		}
 	}
 
-	ret = os_read_file(time_travel_ext_fd, msg, sizeof(*msg));
+	if (unlikely(mode == TTMH_READ_START_ACK)) {
+		int fd[UM_TIMETRAVEL_SHARED_MAX_FDS];
+
+		ret = os_rcv_fd_msg(time_travel_ext_fd, fd,
+				    ARRAY_SIZE(fd), msg, sizeof(*msg));
+		if (ret == sizeof(*msg)) {
+			time_travel_setup_shm(fd[UM_TIMETRAVEL_SHARED_MEMFD],
+					      msg->time & UM_TIMETRAVEL_START_ACK_ID);
+			/* we don't use the logging for now */
+			os_close_file(fd[UM_TIMETRAVEL_SHARED_LOGFD]);
+		}
+	} else {
+		ret = os_read_file(time_travel_ext_fd, msg, sizeof(*msg));
+	}
 
 	if (ret == 0)
 		panic("time-travel external link is broken\n");
@@ -105,10 +157,20 @@ static void time_travel_handle_message(struct um_timetravel_msg *msg,
 		return;
 	case UM_TIMETRAVEL_RUN:
 		time_travel_set_time(msg->time);
+		if (time_travel_shm) {
+			/* no request right now since we're running */
+			time_travel_shm_client->flags &=
+				~UM_TIMETRAVEL_SCHEDSHM_FLAGS_REQ_RUN;
+			/* no ack for shared memory RUN */
+			return;
+		}
 		break;
 	case UM_TIMETRAVEL_FREE_UNTIL:
-		time_travel_ext_free_until_valid = true;
-		time_travel_ext_free_until = msg->time;
+		/* not supposed to get this with shm, but ignore it */
+		if (time_travel_shm)
+			break;
+		time_travel_ext_free_until = &_time_travel_ext_free_until;
+		_time_travel_ext_free_until = msg->time;
 		break;
 	case UM_TIMETRAVEL_BROADCAST:
 		bc_message = msg->time;
@@ -149,8 +211,15 @@ static u64 time_travel_ext_req(u32 op, u64 time)
 	block_signals_hard();
 	os_write_file(time_travel_ext_fd, &msg, sizeof(msg));
 
+	/* no ACK expected for WAIT in shared memory mode */
+	if (msg.op == UM_TIMETRAVEL_WAIT && time_travel_shm)
+		goto done;
+
 	while (msg.op != UM_TIMETRAVEL_ACK)
-		time_travel_handle_message(&msg, TTMH_READ);
+		time_travel_handle_message(&msg,
+					   op == UM_TIMETRAVEL_START ?
+						TTMH_READ_START_ACK :
+						TTMH_READ);
 
 	if (msg.seq != mseq)
 		panic("time-travel: ACK message has different seqno! op=%d, seq=%d != %d time=%lld\n",
@@ -158,6 +227,7 @@ static u64 time_travel_ext_req(u32 op, u64 time)
 
 	if (op == UM_TIMETRAVEL_GET)
 		time_travel_set_time(msg.time);
+done:
 	unblock_signals_hard();
 
 	return msg.time;
@@ -193,13 +263,33 @@ static void time_travel_ext_update_request(unsigned long long time)
 	/*
 	 * if we're running and are allowed to run past the request
 	 * then we don't need to update it either
+	 *
+	 * Note for shm we ignore FREE_UNTIL messages and leave the pointer
+	 * to shared memory, and for non-shm the offset is 0.
 	 */
-	if (!time_travel_ext_waiting && time_travel_ext_free_until_valid &&
-	    time < time_travel_ext_free_until)
+	if (!time_travel_ext_waiting && time_travel_ext_free_until &&
+	    time < (*time_travel_ext_free_until - time_travel_shm_offset))
 		return;
 
 	time_travel_ext_prev_request = time;
 	time_travel_ext_prev_request_valid = true;
+
+	if (time_travel_shm) {
+		union um_timetravel_schedshm_client *running;
+
+		running = &time_travel_shm->clients[time_travel_shm->running_id];
+
+		if (running->capa & UM_TIMETRAVEL_SCHEDSHM_CAP_TIME_SHARE) {
+			time_travel_shm_client->flags |=
+				UM_TIMETRAVEL_SCHEDSHM_FLAGS_REQ_RUN;
+			time += time_travel_shm_offset;
+			time_travel_shm_client->req_time = time;
+			if (time < time_travel_shm->free_until)
+				time_travel_shm->free_until = time;
+			return;
+		}
+	}
+
 	time_travel_ext_req(UM_TIMETRAVEL_REQUEST, time);
 }
 
@@ -207,6 +297,14 @@ void __time_travel_propagate_time(void)
 {
 	static unsigned long long last_propagated;
 
+	if (time_travel_shm) {
+		if (time_travel_shm->running_id != time_travel_shm_id)
+			panic("time-travel: setting time while not running\n");
+		time_travel_shm->current_time = time_travel_time +
+						time_travel_shm_offset;
+		return;
+	}
+
 	if (last_propagated == time_travel_time)
 		return;
 
@@ -222,9 +320,12 @@ static bool time_travel_ext_request(unsigned long long time)
 	 * If we received an external sync point ("free until") then we
 	 * don't have to request/wait for anything until then, unless
 	 * we're already waiting.
+	 *
+	 * Note for shm we ignore FREE_UNTIL messages and leave the pointer
+	 * to shared memory, and for non-shm the offset is 0.
 	 */
-	if (!time_travel_ext_waiting && time_travel_ext_free_until_valid &&
-	    time < time_travel_ext_free_until)
+	if (!time_travel_ext_waiting && time_travel_ext_free_until &&
+	    time < (*time_travel_ext_free_until - time_travel_shm_offset))
 		return false;
 
 	time_travel_ext_update_request(time);
@@ -238,7 +339,8 @@ static void time_travel_ext_wait(bool idle)
 	};
 
 	time_travel_ext_prev_request_valid = false;
-	time_travel_ext_free_until_valid = false;
+	if (!time_travel_shm)
+		time_travel_ext_free_until = NULL;
 	time_travel_ext_waiting++;
 
 	time_travel_ext_req(UM_TIMETRAVEL_WAIT, -1);
@@ -261,7 +363,11 @@ static void time_travel_ext_wait(bool idle)
 
 static void time_travel_ext_get_time(void)
 {
-	time_travel_ext_req(UM_TIMETRAVEL_GET, -1);
+	if (time_travel_shm)
+		time_travel_set_time(time_travel_shm->current_time -
+				     time_travel_shm_offset);
+	else
+		time_travel_ext_req(UM_TIMETRAVEL_GET, -1);
 }
 
 static void __time_travel_update_time(unsigned long long ns, bool idle)
diff --git a/include/uapi/linux/um_timetravel.h b/include/uapi/linux/um_timetravel.h
index d119ce14f36a..546a690b0346 100644
--- a/include/uapi/linux/um_timetravel.h
+++ b/include/uapi/linux/um_timetravel.h
@@ -1,17 +1,6 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
 /*
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- *
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019 - 2023 Intel Corporation
  */
 #ifndef _UAPI_LINUX_UM_TIMETRAVEL_H
 #define _UAPI_LINUX_UM_TIMETRAVEL_H
@@ -50,6 +39,36 @@ struct um_timetravel_msg {
 	__u64 time;
 };
 
+/* max number of file descriptors that can be sent/received in a message */
+#define UM_TIMETRAVEL_MAX_FDS 2
+
+/**
+ * enum um_timetravel_shared_mem_fds - fds sent in ACK message for START message
+ */
+enum um_timetravel_shared_mem_fds {
+	/**
+	 * @UM_TIMETRAVEL_SHARED_MEMFD: Index of the shared memory file
+	 *	descriptor in the control message
+	 */
+	UM_TIMETRAVEL_SHARED_MEMFD,
+	/**
+	 * @UM_TIMETRAVEL_SHARED_LOGFD: Index of the logging file descriptor
+	 *	in the control message
+	 */
+	UM_TIMETRAVEL_SHARED_LOGFD,
+	UM_TIMETRAVEL_SHARED_MAX_FDS,
+};
+
+/**
+ * enum um_timetravel_start_ack - ack-time mask for start message
+ */
+enum um_timetravel_start_ack {
+	/**
+	 * @UM_TIMETRAVEL_START_ACK_ID: client ID that controller allocated.
+	 */
+	UM_TIMETRAVEL_START_ACK_ID = 0xffff,
+};
+
 /**
  * enum um_timetravel_ops - Operation codes
  */
@@ -57,7 +76,9 @@ enum um_timetravel_ops {
 	/**
 	 * @UM_TIMETRAVEL_ACK: response (ACK) to any previous message,
 	 *	this usually doesn't carry any data in the 'time' field
-	 *	unless otherwise specified below
+	 *	unless otherwise specified below, note: while using shared
+	 *	memory no ACK for WAIT and RUN messages, for more info see
+	 *	&struct um_timetravel_schedshm.
 	 */
 	UM_TIMETRAVEL_ACK		= 0,
 
@@ -124,7 +145,8 @@ enum um_timetravel_ops {
 	 */
 	UM_TIMETRAVEL_GET_TOD		= 8,
 
-	/** @UM_TIMETRAVEL_BROADCAST: Send/Receive a broadcast messge
+	/**
+	 * @UM_TIMETRAVEL_BROADCAST: Send/Receive a broadcast message.
 	 *	This message can be used to sync all components in the system
 	 *	with a single message, if the calender gets the message, the
 	 *	calender broadcast the message to all components, and if a
@@ -135,4 +157,134 @@ enum um_timetravel_ops {
 	UM_TIMETRAVEL_BROADCAST		= 9,
 };
 
+/* version of struct um_timetravel_schedshm */
+#define UM_TIMETRAVEL_SCHEDSHM_VERSION 2
+
+/**
+ * enum um_timetravel_schedshm_cap - time travel capabilities of every client
+ *
+ * These flags must be set immediately after processing the ACK to
+ * the START message, before sending any message to the controller.
+ */
+enum um_timetravel_schedshm_cap {
+	/**
+	 * @UM_TIMETRAVEL_SCHEDSHM_CAP_TIME_SHARE: client can read current time
+	 *	update internal time request to shared memory and read
+	 *	free until and send no Ack on RUN and doesn't expect ACK on
+	 *	WAIT.
+	 */
+	UM_TIMETRAVEL_SCHEDSHM_CAP_TIME_SHARE = 0x1,
+};
+
+/**
+ * enum um_timetravel_schedshm_flags - time travel flags of every client
+ */
+enum um_timetravel_schedshm_flags {
+	/**
+	 * @UM_TIMETRAVEL_SCHEDSHM_FLAGS_REQ_RUN: client has a request to run.
+	 *	It's set by client when it has a request to run, if (and only
+	 *	if) the @running_id points to a client that is able to use
+	 *	shared memory, i.e. has %UM_TIMETRAVEL_SCHEDSHM_CAP_TIME_SHARE
+	 *	(this includes the client itself). Otherwise, a message must
+	 *	be used.
+	 */
+	UM_TIMETRAVEL_SCHEDSHM_FLAGS_REQ_RUN = 0x1,
+};
+
+/**
+ * DOC: Time travel shared memory overview
+ *
+ * The main purpose of the shared memory is to avoid all time travel message
+ * that don't need any action, for example current time can be held in shared
+ * memory without the need of any client to send a message UM_TIMETRAVEL_GET
+ * in order to know what's the time.
+ *
+ * Since this is shared memory with all clients and controller and controller
+ * creates the shared memory space, all time values are absolute to controller
+ * time. So first time client connects to shared memory mode it should take the
+ * current_time value in shared memory and keep it internally as a diff to
+ * shared memory times, and once shared memory is initialized, any interaction
+ * with the controller must happen in the controller time domain, including any
+ * messages (for clients that are not using shared memory, the controller will
+ * handle an offset and make the clients think they start at time zero.)
+ *
+ * Along with the shared memory file descriptor is sent to the client a logging
+ * file descriptor, to have all logs related to shared memory,
+ * logged into one place. note: to have all logs synced into log file at write,
+ * file should be flushed (fflush) after writing to it.
+ *
+ * To avoid memory corruption, we define below for each field who can write to
+ * it at what time, defined in the structure fields.
+ *
+ * To avoid having to pack this struct, all fields in it must be naturally aligned
+ * (i.e. aligned to their size).
+ */
+
+/**
+ * union um_timetravel_schedshm_client - UM time travel client struct
+ *
+ * Every entity using the shared memory including the controller has a place in
+ * the um_timetravel_schedshm clients array, that holds info related to the client
+ * using the shared memory, and can be set only by the client after it gets the
+ * fd memory.
+ *
+ * @capa: bit fields with client capabilities see
+ *	&enum um_timetravel_schedshm_cap, set by client once after getting the
+ *	shared memory file descriptor.
+ * @flags: bit fields for flags see &enum um_timetravel_schedshm_flags for doc.
+ * @req_time: request time to run, set by client on every request it needs.
+ * @name: unique id sent to the controller by client with START message.
+ */
+union um_timetravel_schedshm_client {
+	struct {
+		__u32 capa;
+		__u32 flags;
+		__u64 req_time;
+		__u64 name;
+	};
+	char reserve[128]; /* reserved for future usage */
+};
+
+/**
+ * struct um_timetravel_schedshm - UM time travel shared memory struct
+ *
+ * @hdr: header fields:
+ * @version: Current version struct UM_TIMETRAVEL_SCHEDSHM_VERSION,
+ *	set by controller once at init, clients must check this after mapping
+ *	and work without shared memory if they cannot handle the indicated
+ *	version.
+ * @len: Length of all the memory including header (@hdr), clients should once
+ *	per connection first mmap the header and take the length (@len) to remap the entire size.
+ *	This is done in order to support dynamic struct size letting number of
+ *	clients be dynamic based on controller support.
+ * @free_until: Stores the next request to run by any client, in order for the
+ *	current client to know how long it can still run. A client needs to (at
+ *	least) reload this value immediately after communicating with any other
+ *	client, since the controller will update this field when a new request
+ *	is made by any client. Clients also must update this value when they
+ *	insert/update an own request into the shared memory while not running
+ *	themselves, and the new request is before than the current value.
+ * current_time: Current time, can only be set by the client in running state
+ *	(indicated by @running_id), though that client may only run until @free_until,
+ *	so it must remain smaller than @free_until.
+ * @running_id: The current client in state running, set before a client is
+ *	notified that it's now running.
+ * @max_clients: size of @clients array, set once at init by the controller.
+ * @clients: clients array see &union um_timetravel_schedshm_client for doc,
+ *	set only by client.
+ */
+struct um_timetravel_schedshm {
+	union {
+		struct {
+			__u32 version;
+			__u32 len;
+			__u64 free_until;
+			__u64 current_time;
+			__u16 running_id;
+			__u16 max_clients;
+		};
+		char hdr[4096]; /* align to 4K page size */
+	};
+	union um_timetravel_schedshm_client clients[];
+};
 #endif /* _UAPI_LINUX_UM_TIMETRAVEL_H */
-- 
2.45.2


