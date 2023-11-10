Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E0FC4167D
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=x1EfUL5E2NeMKSU2OAlA5ldSKtFsRERgtGGJenT25ho=; b=OFJJCgT2gJf3S3
	1+3M4iNq66Qsexe2e5YuIx3Pq2a5sBzFo6anyybqu2cniIIRIL4UZwF5l1wypDh3XHWCZVNmV+lho
	EdPACFB6NEqSMb14BhLaNutbN5pdutU+3ejtiVq7v5tdkWB+xca0GPnH4rkhjDi8zY3iCtgfZKFJF
	aNFoggWatObC5sO9uEqjMOmRz/jw3CJc6qFXWiKrD1qgcj0yNizBneFxpyjSrOqp8tuvJq7kJOg43
	CPxII8NutdRyXw3NXu1+JCZFohtDI+IIv7r2cSEskTGlnVVwbZh7jgytULm6WBmL3yca3vVNuq/0g
	9Gpv/qypfWzDESNtOmuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1WeE-009GTT-1k;
	Fri, 10 Nov 2023 18:54:30 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1WeC-009GS2-0H
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 18:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=+7eOjKcoTS0KkY72GuFBo81b13u26JDst0Aw8BOWF3c=; t=1699642467; x=1700852067; 
	b=Vi55l4eWRyuF6bIuo95m45PofeZAZiVlsBqT0CfqyLqMlEcE6vdi5emXyp7V1Kx+MGwQB8j4wqJ
	P6HixUGtchqhPynM3UTO9e1NR7HDcwOvxT3OHl+/wrUD0qmx7qlrI12fxOsyrQV5soIhBE+/Q2W1q
	JhlYpCDscNpfE7YIB7ijN7xB+L4u6nG64EDnyLOTr2Ka0Vf3bpTa2vW1Ez4MLyWt3Pv+G47ETlRR9
	Vc1JAXrDzI5YJQk3Vu2tU2vMvKgk4cx3BTJqK0ukSzHeDRaq5+DOiLVMdCfio0TJS6V+1BXVbX51H
	M7CS20iZsWCmaqxTbliOrM42k3Vc9vz2DzTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r1WeA-000000039LG-0ICo
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 19:54:26 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Subject: [PATCH 0/4] time-travel broadcast and shared memory
Date: Fri, 10 Nov 2023 19:52:56 +0100
Message-ID: <20231110185255.32006-5-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_105428_124104_A8708D3F 
X-CRM114-Status: UNSURE (   4.74  )
X-CRM114-Notice: Please train this message.
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

So I've been mentioning the shared memory part, but because it
(mechanically, not semantically) depends on the broadcast
messages we use to separate tests, I've included those patches
here as well.

As for the shared memory part, the calendar/controller we have
already implements that protocol, see
https://github.com/linux-test-project/usfstl/tree/main/control

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
