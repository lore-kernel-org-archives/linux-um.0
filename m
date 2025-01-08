Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13066E77199
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ANUvPJPmCwfnSIifNyQzf/CqpAfBelwQQUJ3KUaRJ3k=; b=AREQNAlxZPA3axTmI1M4buybfE
	Th33HwcEsU+qTtEe+d/7syifcum6n4FIyMAt+sUSeFQZcrBJY5hbspKARLQub4HHSFYjrxjw21Um1
	Hskk03E31lvaq8tfbDFoivqB55llFFLAvoVFES+4OozPdNPFjH4SeiO8iipQ6ShwKtSjMqSL7DadI
	CAE9hDq2h9vD7HpDeDpqkKzBoRCotfuGt9hLFJ2bAFVW7CnxraRP4BuagbrtKkQ9ZoSrNXV6lxtSZ
	YU+N3xTRBjeF8zPFgXFGo1rXaah6GrcnRJ85G3JqyOFGsJYfWifmqYD+23f93kub1fwE/UY9k49M+
	kFt8b6oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTlX-000000086AW-0wpY;
	Wed, 08 Jan 2025 10:58:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTaH-0000000831n-3Php
	for linux-um@lists.infradead.org;
	Wed, 08 Jan 2025 10:46:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ANUvPJPmCwfnSIifNyQzf/CqpAfBelwQQUJ3KUaRJ3k=;
	t=1736333205; x=1737542805; b=qDZ+/jSwLhDoFMCnxfzrBqxGGEmtS5lH889+7L0ePNAFBeC
	9414dhQEyyUWjEujDRJ8NJfjbJg/xMkS482GC7bO4IMI9Q6pcYfoIFW+Qnecckra1m1t5i1m8E7NB
	L7kBCvnEGgcGN+UhYe71Vuo8Qo5kyZbtBngWsawHL/ymsCmPtWsTOhzqLOEM35Kyy41Cls3LFY6jM
	0cPw3l50l+hCS9IHu0VXern3Ay8ywQEzmSgD4fnOxMkFycMwlLMAlBTlga1kuHoBUOBuNK29bXZJW
	t5qkkJWOmzjsGv0NaW7Rf/bx+ts0WBxcTfRT/4oVl5C4FnzCmf1Az3bYmTxvpy7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tVTaC-00000008DOx-0Drd;
	Wed, 08 Jan 2025 11:46:40 +0100
Message-ID: <01be0810b37628a4f8cd6e4b64b68ff7bf9d4ace.camel@sipsolutions.net>
Subject: Re: close_range is not available on older systems, preventing the
 building of a UML kernel
From: Benjamin Berg <benjamin@sipsolutions.net>
To: development@efficientek.com, linux-um <linux-um@lists.infradead.org>
Cc: Richard Weinberger <richard@nod.at>, Johannes Berg
	 <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Date: Wed, 08 Jan 2025 11:46:37 +0100
In-Reply-To: <20250108022404.05e0de1e@crass-HP-ZBook-15-G2>
References: <20250108022404.05e0de1e@crass-HP-ZBook-15-G2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_024645_847911_3319D49A 
X-CRM114-Status: GOOD (  18.08  )
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

Hi,

On Wed, 2025-01-08 at 02:24 -0600, Glenn Washburn wrote:
> I'm wanting to build a UML kernel on Debian bullseye, which is at
> kernel version 5.10, which does not support close_range(). It appears
> as though close_range() support is required on the host since commit
> 32e8eaf263d ("um: use execveat to create userspace MMs"). Was there a
> conscious decision to break support for kernels less than 5.11, when
> close_range() was added. What is the policy on support of the host
> kernel? Since 5.4 is still supported as a longterm release. I think it
> would be nice to at least support 5.4. Is there any interest in
> removing this restriction?
>=20
> Also, this system is at glibc 2.31, which does not have execveat()
> support, which is required by that same commit above. Since execveat()
> has been supported since 3.19, this kernel should support it. Perhaps
> the issue can be resolved by defining a syscall wrapper in the UM
> headers if support is not found in glibc.

Yeah, we need the CLOSE_RANGE_CLOEXEC flag, which was added in 5.11.

On the one hand, there is no real alternative. This is a relatively hot
path (fork/exec), so I wouldn't want to replace the call with a loop.

On the other, this is "only" an extra safety measure. It is acceptable
for this to fail (the result is not even checked currently). As such,
the biggest issue seems to be that your libc does not yet have the
symbol.

Said differently, we could just replace the call with:

#ifndef CLOSE_RANGE_CLOEXEC
#define CLOSE_RANGE_CLOEXEC    (1U << 2)
#endif

  syscall(__NR_close_range, 0, ~0U, CLOSE_RANGE_CLOEXEC);


I am not sure whether we would want to do this in the upstream code.

Benjamin

