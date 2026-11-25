Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF96B606A32E
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 03:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VX96Cpef;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=uVJtjK/k;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DlNzxpVr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=C7sWl1wG48MQ07r4zoW2vh68HNiuHxVXcgb2L1fNbYE=; b=VX96Cpefu+kYGJQgZlzIlp99pf
	0VEDGu5G6JmhGgPSnKRSugnvRaDg0BqDjOzBq9xT6knPodngE2XAlSWzwPByBYVYV/tYcUQUF6LP3
	8AEvJMeZN1O/Xjm+hrq4adPFP0A9qq8V7bVM60t6AwyXNddPurWHXKSp8ezXPUzeB1jAwlZOaRlMs
	wF4f0hvtBzpRA6bkYTAlSh7fhglWjd3SEDkLsDJLPTd4xko1wi/RrqEyd4kiyRBlP/ZZaVL7SBwTl
	44Tu4cCVmSdNA1ybKGsOB8YIDJ9VVFd5GDcESc2MNlnYvOPO9pJ7eS6wyd6SDkivZzerqrAJ+Z4+e
	LIIoaRcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3xa-00000008LI0-1n7Y;
	Wed, 25 Nov 2026 03:46:18 +0000
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3xW-00000008LFz-2Pjm
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 03:46:17 +0000
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A873FEC09B4
	for <linux-um@lists.infradead.org>; Tue, 24 Nov 2026 22:46:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 24 Nov 2026 22:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578373;
	 x=1795664773; bh=C7sWl1wG48MQ07r4zoW2vh68HNiuHxVXcgb2L1fNbYE=; b=
	uVJtjK/kqBeLCHeTuAHRJuLlf3RPlcath2fFONrOMLHy+oKwGL1wpxT3pS2agxig
	0J+LVxx3Gbm7TXxFLoKND6VP5K/bjuUB8aU2CbSmWaWmqD7dq8Ra+qHdd69d7yhH
	WrQdVd7GTdbbOmj3DKvaowfj+2/CYrCswVxxc6VT5ZNf73AQjd7ugBDmlVW+3rKZ
	wk7f/uT3ClLF7ZbC8fMVAflfI3ASxPieHksWGlt1qEeGvee4UyuWW7NHvICSiSDs
	iT1Tk0yD4XELKo2AWBFzE/zZ7jnDGgLd8YHEM3eWycSGBXQMWUCvbeqTE0+Ba/ar
	fR27hTwhoD8KywuFByw03g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578373; x=1795664773; bh=C
	7sWl1wG48MQ07r4zoW2vh68HNiuHxVXcgb2L1fNbYE=; b=DlNzxpVrSoePkYu9v
	NF8GJpmu9FXSNB01Xmzx1wvX0kQgU0j3eZF+eztbtQABZNd2wmFyQrVaFVgtNfz2
	v7bkIuWRjANsIsASGAAqP/WUuHmxIcWa05q8PnsiQxRkv1THlOSkGT6zw+qoQpKH
	ef2WOxyAm8MvZMPdl4jGJJGcyDMWkOjADw/GDrcLcoYQfjQItIK3n1lUxxMShIfJ
	/GT7VsbQbZuNs4mcJP+l7aLK8HouyTW/E8DIx2ehg3dhhh8+rRizrgBdumi0E4kd
	W66/ElL77DmIimEpr+Fg03gujFcLEzaOafsI3mmsQQFDR2tWtAeLhO0hVFa1oUSL
	kHt/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578373; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:BzepbYnR1mUNOUa9isB2EOx52vmQRXYib7ONMcMPIQkN7Km
	WaMfm01yHak9o1SawI0flXqaWCTYfuhs6c32vIjVq3suG8DIvFZczXCzTUMf0XUr
	OTbNYXfWY1WaR7rWCCYPMJqH7tqeBR3/h6E18tSZ6RiwifFgJY6TCeOUKmfjf9H/
	1pFZmnMOYOR0bQXmEY8h4LDoJ6LfAD60O8tngusklL0NJ3nQeahFqOMAkXUDZwTe
	vUo5LiVR7Cmm15l6tzluSfA3j1aA8LJvq2TgGgaqpucz6cwphbkjwHDR3YLYlwuv
	pL09HkkGh0V53hB8Q4P9tWPJI98QpnV66r/tGmg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:KKPLl7NOjgl4PUEDrs6CD/OeuuCjs3Y6C8+VT2udHV4=:Xd1WqezOWR4RGPff0oXZeRAR/TSzcmc9gClT/ovY9uY=;
X-ME-Sender: <xms:BFoGa3PKtOwxUwkZpViaqRwLM60pvm2UTcI_JQ1z0-14fVuLcq8NPg>
    <xme:BFoGa47ixKdcBLDhCGczbRSygGRbY7bGID5BdiwAtbWJVPCJMHnI6j3Gnv3kcIupU
    RssUQLPMMAwsi7DPxbeNe6a7I8vZcvyImfC2QhSGvOJVXo7hcY>
X-ME-Received: <xmr:BFoGa7VcNwOKoKDCpg6IWBH_2M_tw5767rDkPAQypRXCyrYinMLGTdg5Chvih2ajqY6kIBchkPEE2rNxeuGu_vekhZCZM58>
X-ME-Proxy-Cause: dmFkZTEynqFP7J5CyP864zJ/XBXUDXSwXypje4KQHx8Td74dpnR0VUtokV1VIo6Vx6RvWY
    OwcUpg/bo5jA9DF1nhHbEWSmkeBRQExzYYNm6zYQ4OlhmT8++hv04QLhCP77UTRa+ts0Zn
    emG1u4CBc9EwIQZMHpuGtkFzNaPM0COhHCVGi+vUdiGKTo3oTFKBSdfX5nxIKQZvHQpAoR
    JpPaJpl8D3VaaEmf1HZfBeZUeFh1WggTkTCrotD4I8diURcXOaSBUF/YM1mWjxdOr0yho5
    GSRzb/bSajGZoPtTNw69mn1JgOv5z8FPk55EPMBJOvn4tHIN4QhGRcsvm9DrK4aqK7NvD2
    Auh3n7/rDjlV67SzcxugKanVYG5RjCb+2NOn7i5iXuy1FXFNhK6aoTMbjaXLP86pYz8Ryi
    /xaDjmigZlJ9MzIuCR1/cpAYWU8RM0/OSl8D30BwPV295xbiau2P46CfJBhXPmmAmbwfAA
    rMYnwG0NgcznoAzShUK/LdM32r9rzQJvvXIyjKY9pSIX3gv40Ug5iE5k0g+Fqaspj1Stnt
    Q9On8TYylyL1Vwi7PINVpAOrfn5rfcbPZMFI9FpdLNXs+rdEi8K7Q6RAmcTrnkSDl3Ud9C
    7gTClZteLBjWpe1mA2wn5DDy0iuc9YeQ9wLFR38CzkpMdV5riazKCBcxy66Q
X-ME-Proxy: <xmx:BVoGay1Pb62Umx6kGOGGYs5ti2Gs4wBbDevP3TetIprCpZNgrv0qsw>
    <xmx:BVoGa6MYYvfGpcjV5mkkETu-8Z7WFPT_UmOF76FH0StQi9gMWAEIng>
    <xmx:BVoGa93G_APMlc8X2Es31MMyo9WNoNXWyJxQ1I1bnc39BTUkzwXrsw>
    <xmx:BVoGa52CU_oHN-uQUXv_6U9Kw8RijGEzNEj7wU2ccjFQ_3qEPWatOg>
    <xmx:BVoGa2bN0PF56IAc24GwBM3OzhUNEMeljhz6gvsZ7nSZKLA4AQlU7WUT>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:46:08 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-fsdevel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-afs@lists.infradead.org
Subject: [PATCH v3 02/11] hostfs: don't d_drop() before d_splice_alias() in hostfs_mkdir()
Date: Wed, 25 Nov 2026 14:16:40 +1100
Message-ID: <20261125034543.4084039-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125034543.4084039-1-neilb@ownmail.net>
References: <20261125034543.4084039-1-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_194614_859501_903EB470 
X-CRM114-Status: UNSURE (   8.71  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: NeilBrown <neil@brown.name>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: NeilBrown <neil@brown.name>

hostfs_mkdir() uses d_drop() and d_splice_alias() to ensure it has the
right dentry after a mkdir.
d_drop() is no longer needed here and will cause problem for future
changes to directory locking.  So remove the d_drop().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/hostfs/hostfs_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 613146e76dec..7cf25c29cb78 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -700,7 +700,6 @@ static struct dentry *hostfs_mkdir(const struct mnt_idmap *idmap, struct inode *
 		dentry = ERR_PTR(err);
 	} else {
 		inode = hostfs_iget(dentry->d_sb, file);
-		d_drop(dentry);
 		dentry = d_splice_alias(inode, dentry);
 	}
 	__putname(file);
-- 
2.50.0.107.gf914562f5916.dirty


