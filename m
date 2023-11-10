Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2407C4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 20:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VLmMlAJHr9HOau5T1GPrnnqPgde+WkCovvFBX8bL22w=; b=FfUMRxEK1IWb0F
	on8ZHA85mPeyehwbGUyqnA8LzSs6qcdjZfyp/xuAjs9hBYDSExGYVveSpF3LKlq4QY7f+XqORmCA/
	wbGpHN7K/VnHuWtByLXE2NxHJWyBgyL+UAG1xJbZWMApxCpWfUM6wBC5au5/1YOkSfSsMe37vZIzJ
	vPRtn14BtMUK7XPfSNAm8P+BSXvx54L42qwF//77kqKf/iYEYJlmlhYkND3Gqz5a0/JQNouQvm1Uw
	w7lgl7kST2A8F3cO7EX9xRSJ703M74p6rYjDRbpNv51nP2IJWZa/5R/UHiiK9vhG2xcqRZKU3ykcO
	EdSkcPAVaVcg3iph4GNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1YLv-009PsI-2H;
	Fri, 10 Nov 2023 20:43:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1YLt-009Pq0-1J
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 20:43:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AOJp2+m6haXwispPDqwoL60Uzy3H0NgukQRsUVrI4OQ=;
	t=1699649018; x=1700858618; b=JmqFUoHc4GIKWvuZHTBpm6lZ//abbqDmev3rJ/QwgcHTGqZ
	XmbMqXWOKy4UmCHPZXIe4CTzdhnx/4sxV6ETN2+EfaWPMbF5r4dux2qABJM/MBEhJ9kFE8hl+8DpY
	B0I8PY34hIN94386Q4/BOENUAJRgsw42x3oRtT2em0xs7+m6JnH55N8PL2NsbC1XUjJ3m35uiVb9J
	Bxupx+yqFI4S/5taf0ZIEcOzewkIOTd8aSy45g9oI1q4oI2DGr5G3/VyAtPlZ42urwa9EkZafcadT
	fCT5NIQXtLQ6ecXKctXbjJ1K/t5B8B1jklhq9j7mL3hwxPeswwfI2vZXYfwyNYxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r1YLj-00000003CLx-0c4k;
	Fri, 10 Nov 2023 21:43:31 +0100
Message-ID: <050726523918d795130778f2aa233ffa34a1e3d2.camel@sipsolutions.net>
Subject: Re: [PATCH 3/4] um: add mmap/mremap/munmap OS calls
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, 
	linux-um@lists.infradead.org
Date: Fri, 10 Nov 2023 21:43:30 +0100
In-Reply-To: <11a25e62-be07-9a37-71f3-0607b0591623@kot-begemot.co.uk>
References: <20231110185255.32006-5-johannes@sipsolutions.net>
	 <20231110195255.711150d60a27.Ic2da1d3a983fe57340c1b693badfa9c5bd2d8c61@changeid>
	 <11a25e62-be07-9a37-71f3-0607b0591623@kot-begemot.co.uk>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_124341_463674_BF0DF8C8 
X-CRM114-Status: UNSURE (   4.05  )
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

On Fri, 2023-11-10 at 20:40 +0000, Anton Ivanov wrote:
> os_munmap already exists as os_munmap_memory
> 

Hah, oops. Thanks :)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
