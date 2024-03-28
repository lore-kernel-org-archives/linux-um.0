Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D30C54E64
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kq+6MaTIIKAyQxEp2fwWEQaYzkGVVmjNy6tUfTvDL6Q=; b=jIiJ0v4RMuQFf1wweppUULX87L
	/hEcQM8dFMsyG4QPDNj6dLpqIpsPRu9Cs6ZoluUDKxcnWWVYGdmT52KV5I+PjvOZDlGxhlpffYx4p
	dDLx2tdcyG7dfVEHCw3qnGTp8iOnOFqP3Z3fv877xRJlRRnPinngkxL2h7f1idlYNnObluptHRkvQ
	9wMJcz8sS5hhE2BGyhC15IbtBhPkITJCYqP2xsYszpPJ46qxh8IaXXmXAtdZp8vDugDnaPgk2RLt1
	O+FsnPUsR87uyGctXpgIpqZBgPfvprPeFRHkN3nEInOqZXn8j2FS2QkS0y1i1/EPasYuvAuqiVyUL
	8zruZ6PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplpg-0000000DFwc-0wcV;
	Thu, 28 Mar 2024 09:14:00 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplpd-0000000DFvo-2ihw
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 09:13:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kq+6MaTIIKAyQxEp2fwWEQaYzkGVVmjNy6tUfTvDL6Q=;
	t=1711617237; x=1712826837; b=TQj+RgkvFAbTy2VIvcWKwR6GIk7aCzVZ00ZvdD+SX81rper
	XQIMRrbkhtmlZEWtzT2TeblufTZMuTAARnvZspjn4pAl0oAS5MJ8h9AxbWjYoA5HqBm2V7V15P5L+
	18ghtX5130Z9XOGBKG3Dqy76wumuflRk/rppaL66/7lOXttiTiuJONjpGFjTQjg6gW3Xxz+eCyhK6
	6SyZ2NQC+AMtl8nX5jjI9Q9VYAUielDZiq/svLGNsntCdiRSAk/7XYDabWFpG9lw5LJjd1hCLmLf4
	dOUGnPUJCqgESmw9zszEzjpS0NB/ApOrUufIl9r1p+FYRrAfvIZ8PsYYvxC94byQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rplpb-00000000opc-2Ic0;
	Thu, 28 Mar 2024 10:13:55 +0100
Message-ID: <c4121cbbf6673a8c97db1460a8d6847ccc49d4f3.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: Makefile: use bash from the environment
From: Johannes Berg <johannes@sipsolutions.net>
To: Yueh-Shun Li <shamrocklee@posteo.net>, Richard Weinberger
 <richard@nod.at>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 28 Mar 2024 10:13:54 +0100
In-Reply-To: <20240323174450.18376-1-shamrocklee@posteo.net>
References: <20240323174450.18376-1-shamrocklee@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_021357_705210_39F4B054 
X-CRM114-Status: GOOD (  10.31  )
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

On Sat, 2024-03-23 at 17:44 +0000, Yueh-Shun Li wrote:
> Set Makefile SHELL to bash instead of /bin/bash for better portability.
>=20
> Some systems do not install binaries to /bin, and therefore do not
> provide /bin/bash. This includes Linux distros which intentionally avoid
> implementing the Filesystem Hierarchy Standard (FHS), such as NixOS and
> Guix System.
>=20
> The recipies inside arch/um/Makefile don't require top-level Bash to
> build, and setting "SHELL" to "bash" makes Make pick the Bash executable
> from the environment, hence this patch.
>=20
> Changes since last roll:
> - Rebase onto a more recent commit on the master branch.
> - Remove a dangling in-text citation from the change log.
> - Reword the change log.

Not sure I'd have added the change log here (in this case at least), but
anyway:

Reviewed-by: Johannes Berg <johannes@sipsolutions.net

johannes

