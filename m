Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9206E7716D
	for <linux-um@archiver.kernel.org>; Wed,  4 Dec 2024 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p53t8iZMez4jcRJ04TNPA5c8FLXV/27TaDupjCONLPQ=; b=L10/7yMRh58grt1/3iJIXVmzHQ
	PHlRWl9na9dHtkgarCbseSepbPmUQDS1WiXu7Kh3l8AnwZgH2TCq7INSifY9/1eC00QavqezmbLsF
	udbcDqBYfvdblgEhRtHkGyge8a9w5/YvzzFQt8EZuGvrDfyMgl+Cg2igceFhZ0df9xEIEjkVTQrnd
	YrNcylZaFuOwXNvHeLpoPo6iT3ChAFFpkQa2AII4V7sckN3IbZQ2mbn5qmxFSnzaY+3gAQvjh+aJ1
	NDvHBFjbtOim0gMZJXX5aKq4lvwljR387krQSQrqjIq1DjkRG5NSx+dV3dzuHipVPezqQTLHUxyFj
	MGqloELg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIs87-0000000DAPM-29PO;
	Wed, 04 Dec 2024 16:21:35 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIs7V-0000000DAHo-44gG
	for linux-um@lists.infradead.org;
	Wed, 04 Dec 2024 16:20:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p53t8iZMez4jcRJ04TNPA5c8FLXV/27TaDupjCONLPQ=;
	t=1733329257; x=1734538857; b=b0OtomV14NyR7pY/2rSm38xvq25Cqli24GXDbDuELSRp7T9
	Xe7lrQw/dnnXpSLIGSPF6H8jUhUx+qxodUmVuk9Z3HPZp1mtJMlM5ehE0Ca1LyPBgM3rBMNkqviE0
	ZGSWE2Wp9TX6HMl3fysaFRfVOWR6MXJWsLIOacmTFZCzT1IuaRVQSwaReysy6RR5e8oEVVmGjpc7+
	pfKsfkK7vLW/AMNU7uS2oei1PaM5xY/1TGX9JoFHf31vzehUi4mgOS7BiXTiB2SaFrtHB6aVHAA7o
	EJrU2+GJmuglFqiaIo91LQxzpWCc8gVBUd8gmWp72TMVCqe/gZok1CiTm5UdMJgg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIs7Q-000000073t2-2ucC;
	Wed, 04 Dec 2024 17:20:52 +0100
Message-ID: <5b5b50909f7c23f09500d7ecc8b57b46c33ab7b0.camel@sipsolutions.net>
Subject: Re: [PATCH v3 02/13] x86/um: nommu: elf loader for fdpic
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com, Eric Biederman
 <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date: Wed, 04 Dec 2024 17:20:51 +0100
In-Reply-To: <215895272109f7b0a4a00625e86b57f39fa13af8.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
	 <215895272109f7b0a4a00625e86b57f39fa13af8.1733199769.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_082058_006418_79F6BC74 
X-CRM114-Status: UNSURE (   5.91  )
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

On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
>=20
>  arch/um/include/asm/Kbuild           |  1 +
>=20
>  arch/x86/um/asm/module.h             | 24 ------------------------
>=20

These changes could be a separate cleanup?

johannes

