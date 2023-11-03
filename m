Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BF3C0018C
	for <linux-um@archiver.kernel.org>; Fri,  3 Nov 2023 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:In-Reply-To:References:Message-ID
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gaw/XFMNC8H1y4CEvhsTN9/5WixLWjm0MU8RIDXj+t8=; b=0b2vg6RBSAePrb
	vr7gULf5pZoCHMppLDdYk9UMsV/sOH3+4B3GHpWDkrsIj9lkS/rhFau8IegBSEE0t8sWwGu1WQzn3
	TknNd69Bmv6OEX1D350Kz0gzpyCxpF48p9lIfsUp0eFzDObOy0YSa1ls3UjJh0EiK1PvgSKfM3y4r
	wcO5j7ppSoP4z3Bj8DyFqw7mpoqZ0Z6J9aE8lXjNZ7oMnmDGYg1XYL5jvUh7evGY/vErmg0yyBUeE
	k4cj/z1W31P3+mGAJCI1oVNWgXl/m3UrpxKiMsGjSvSw9kJ8cCLiTuxMsbiYFmqqk5ks/Pl/KSCTd
	tuh50m71mcy38KmLYQYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFU-00Bnn4-04;
	Fri, 03 Nov 2023 16:42:20 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFO-00BnjU-1S
	for linux-um@lists.infradead.org;
	Fri, 03 Nov 2023 16:42:18 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 03 Nov 2023 16:42:01 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699029721; bh=jjwJeBNe5bbnB9KvKnjg9trRyvejsrwdh8jj/IFUpB0=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 3w+1bcYg09YjF1fULpPck3fq8hHe6KF3miQQUMqB7zrPMl8pWPstsIy4Att0cWL51Y6p0CZQW7sPXI3zg7bKAQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699029721; bh=jjwJeBNe5bbnB9KvKnjg9trRyvejsrwdh8jj/IFUpB0=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 bbGEI+5fOIPUe0TOHQl4o/Cl+XbHfEWqlnhvK/jtDv/4bj9cTcp/UDUsvB1JrdP4LooakLPw9tfqkySdrVs8xnrWGWhcuqJaA422U0GbRvTrT9TPmWlA5m5Iag65sl1sGlMb2DO/YNxVbv80z2xSQn3A2lAMtXokv3eEfoo6/1Y=
Received: from mininet-experimente.amd.e-technik.uni-rostock.de (139.30.201.3)
 by mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 17:41:57 +0100
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Date: Fri, 3 Nov 2023 16:41:42 +0000
Subject: [PATCH RFC 04/11] um: Handle UM_TIMETRAVEL_RUN only in idle loop,
 signal success in ACK
MIME-Version: 1.0
Message-ID: <20231103-bb-timetravel-patches-v1-4-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
In-Reply-To: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, Benjamin Beichler
	<benjamin.beichler@uni-rostock.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699029716; l=3277;
 i=benjamin.beichler@uni-rostock.de; s=20231103; h=from:subject:message-id;
 bh=68xaPxhF/gjlITnoUUTiX6mxysJibaWtipP09hmTvZY=;
 b=7eLrtotia2kss+e/X1cK8+HOJRxXKWTNQC5lNVU+Gph7I4B8veTibqlKj0mzIjLX6tVT3pu9f
 HZc+Y+v2+S2DKhdoR5jocSV+Wn56thvPBPSMbt6SB4NXyhFHdi2RlEr
X-Developer-Key: i=benjamin.beichler@uni-rostock.de; a=ed25519;
 pk=fla2/IRwqFWH5W+fACqQyDu/mTc6mEcSPQtqb/SoX8o=
X-Originating-IP: [139.30.201.3]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: AA8504E183ABEE817E3869628ED743540B1317AB9F0C7583C412BE14DF0C944D2000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_094214_786871_8704DD26 
X-CRM114-Status: GOOD (  19.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

The Timetravel socket can be read from the SIGIO handler, which may
catch a RUN message that was expected to be received in the wait loop.

It can happen that the device simulation only "created" one interrupt,
but an uncertain (i.e., hard to predict by the calendar/device
simulation) number of SIGIOs are emitted, with each SIGIO interrupt
producing a GET message. The calendar might try to send a RUN message
after the first GET message, which is then processed in the SIGIO
handler, waiting for the response to a subsequent GET message. However,
time is advanced by the received RUN message. Typically, this doesn't
pose problems because the interrupt implies that the next RUN message
should be at the current time (as sent by the calendar with the GET
message). But there are corner cases, such as simultaneous other
interrupts, which may desynchronize the current time in the UML instance
from the expected time from the calendar. Since there is no real use
case for advancing time in the SIGIO handler with RUN messages (in
contrast to UPDATE messages), we logically only expect time to advance
in the idle loop in TT-ext mode. Therefore, with this patch, we restrict
time changes to the idle loop.

Additionally, since both the idle loop and the signal/interrupt handlers
do blocking reads from the TT socket, a deadlock can occur if a RUN
message intended for the idle loop is received in the SIGIO handler. In
this situation, the calendar expects the UML instance to run, but it
actually waits for another message, either in the SIGIO handler (e.g.,
a second interrupt) or in a poll in the idle loop, as the previous
message was handled by the signal handler, which returned execution to
the main loop and ultimately entered the idle loop.

Therefore, this patch also allows checking whether the current RUN
message was handled by the idle loop or by the signal/interrupt handlers
in the ACK of the RUN.

With the information in the ACK of the RUN message, the calendar knows
whether the RUN was answered in a signal handler and can act
accordingly.

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/kernel/time.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index fddd1dec27e6..ff5ef75bbb94 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -94,7 +94,10 @@ static void time_travel_handle_message(struct um_timetravel_msg *msg,
 	case UM_TIMETRAVEL_ACK:
 		return;
 	case UM_TIMETRAVEL_RUN:
-		time_travel_set_time(msg->time);
+		// the caller time_travel_handle_message will do the appropriate time advance
+		// return here 0, if we got RUN, but are not in idle/ext_wait, to
+		// actually do anything with the run
+		resp.time = (mode != TTMH_READ) ? 1 : 0;
 		break;
 	case UM_TIMETRAVEL_FREE_UNTIL:
 		time_travel_ext_free_until_valid = true;
@@ -238,7 +241,7 @@ static void time_travel_ext_wait(bool idle)
 	 */
 	while (msg.op != UM_TIMETRAVEL_RUN)
 		time_travel_handle_message(&msg, idle ? TTMH_IDLE : TTMH_POLL);
-
+	time_travel_set_time(msg.time);
 	time_travel_ext_waiting--;
 
 	/* we might request more stuff while polling - reset when we run */

-- 
2.34.1



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
