Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D784C9831A
	for <linux-um@archiver.kernel.org>; Thu, 24 Sep 2026 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4s6QAGOSw02obaoUejOkLC5JwzN47+Sds/ZrPWOhowY=; b=cQSGEpLKBFpX8IQcJuT4aLwFVw
	wKOs7AZTpx2VZ1/bqb6uNljGll6eFIeVEhbJsUuKw8at68u3vyZR1EzaVBQiDi1+iKCCoREDuk/ip
	i9wqXW6KRzqoZ6tPJTMd/323uudVjVQnOCRtxsmwYa5+nXZUOvx69/mN2drK6BwVnlmKowTbbJQKC
	EM6tHvc1YrHpeXCl7LRJb1RhxmCi5jT/osKvgwVWc9rWeEZbpwz7jkouU706qWm1MMIvSiHcknMOi
	wY3T7ijjT50xyt8oI7uAMs8QVrSvIUR9Syr8+sFsr2RIOt2iYoyNbjKe0aX7ypNhtAGaTYhPBwc4B
	leippkWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9iky-0000000B06y-3JFr;
	Thu, 24 Sep 2026 12:40:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9ikw-0000000B05Q-04F1
	for linux-um@lists.infradead.org;
	Thu, 24 Sep 2026 12:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=4s6QAGOSw02obaoUejOkLC5JwzN47+Sds/ZrPWOhowY=; t=1790253653; x=1791463253; 
	b=HPzhrtN6xEsLlLainF1uKlGsRcsWfP9LJEqfF8vj4cZ3A6UoPvOQ2DIRnMCntriX4nhDecRBJYx
	IQGwYx4QqpTZ0sQtAPhRjNgR0HktuQg8sdAmXUxfy6f+Z5OZWr6DxK2pqWvqNELag2wgtIAFsMCLO
	H7b8Jb8nK0fYmBQ00Fy22mRDHHecedPERSj63KK4yff3f1xx35/zTXCDouFCP39TYVtME5pn8MUdZ
	TtrSxKKUbpvNxCcKfouVk77zxU3Bsb/0eHoITe+ithebq2fRzzKPBvjtTcSzkYcAECZN9m4L4r53x
	tffLKqXnKJ6XJfPkCyHfiOA3298HeWVYH4SQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9ikq-000000092x8-32Wu;
	Thu, 24 Sep 2026 14:40:48 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/4] ORC unwinder cleanup & UML support
Date: Thu, 24 Sep 2026 14:35:49 +0200
Message-ID: <20260924124039.1621965-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_054054_089510_7721743D 
X-CRM114-Status: UNSURE (   9.15  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Since UML is pretty much "just x86" I'd figured for years it
should be "simple" to add ORC unwinder support. It's not quite
as simple as I thought, but I managed - though to not have to
copy/paste _quite_ as much code, this series first cleans up
the already common code between x86 and loongarch.

Most of the code is indeed copy/paste, but with adjustments
that are not really abstractable for making common code.

It touches s390 because I thought we could end up with some
compilation errors from s390 unnecessarily (and accidentally?)
declaring unwind_module_init(), maybe it's not needed since
the new orc.h isn't included anywhere it could conflict.

Works for x86 and um, builds for loongarch (but I don't see
a reason it wouldn't work).

No idea how we'd merge this and if the MAINTAINER entry is
really where it should be, but I'm also not in a hurry :)

johannes


