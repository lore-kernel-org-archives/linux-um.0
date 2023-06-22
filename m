Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C79EB64DA
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 19:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ALktUxx5WvyIYfEjBTkqPAqFxgi5YNhy8hlH0pripq8=; b=4hHlB4ivV0aDeK
	cW1DTxxOvQ0UGd+sYk26+2tYSpVg+JeBcEWpd8A4xSkzGzk3VDqt3jpIjXWQ2qenxR3EsjpTxpxkr
	nCl9R9hPhWKVJ9mu8Wi5AZW5ni82JVAwq+Y1ee9Z7oVSyuNCbmK21v5DZXUy3XuHTY5/Tb8oInzvV
	ZBKoCxD92JK2OGJ1h95FVP7Z+Kyp8QzKsK2nT71l8QOEQlerfbqZ1czJvvIVNw9xIOTcUo0Sxau8Y
	MkjaLywUukp15TWNSpPNQJqyiNEzctwhnvPTmstyH5gcIyF8eIXDaHj9LpUddvu4Xij0/8wiwsd4N
	8udNeVQMV3Aptih1vyFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCQBf-001a7B-0W;
	Thu, 22 Jun 2023 19:41:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCQBc-001a5x-2B
	for linux-um@lists.infradead.org;
	Thu, 22 Jun 2023 19:41:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=205KmJElDtZJNK+w5BqAEkYlHUkOavV+4/Dl5Cuw28s=;
	t=1687462902; x=1688672502; b=eFqrCOagHBTaRrS4PU9pa1LEX3gWlnJGPUAWQj3u6Vwv0Vn
	xq6CuYBcHhgEAniwSSH2TWwcNAQPua7suA/OhOchkqJzUxBh6n9KBXFcsIxBb3AzWZprw2Ulh3jDW
	4wAUwMVzuthRJ0S4YyDcMWeJaKqrrKyKt50Aid5HMX7G2B/ll55HCmWVZyV5NiGzsVe3TAfwUf6UN
	7/ZvRbmhN1idKS3qe0SxpE2e941ErzrgL7Y9Q0PScMoWLIqKsxE3oK0lZWQUnVfJFxaVo4p/rgyKi
	tGfzOW+dv9ho7yHPeJe42m1HZ0FWwL0y5BhJVDI+NitrDOnOLM5MJ3lbawiG9Jxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qCQBP-00EstW-23;
	Thu, 22 Jun 2023 21:41:31 +0200
Message-ID: <dc5704a5d452f7432313170ed900975b2b72354f.camel@sipsolutions.net>
Subject: Re: UML for arm64
From: Johannes Berg <johannes@sipsolutions.net>
To: Rob Herring <robh@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, Benjamin Berg <benjamin@sipsolutions.net>
Date: Thu, 22 Jun 2023 21:41:30 +0200
In-Reply-To: <20230622192247.GA2278576-robh@kernel.org>
References: <20230622192247.GA2278576-robh@kernel.org>
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_124144_733094_6C5151BC 
X-CRM114-Status: UNSURE (   8.16  )
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

On Thu, 2023-06-22 at 13:22 -0600, Rob Herring wrote:
> Hi all,
> 
> I'm interested in getting UML working on Arm. Is anyone aware of any 
> efforts to do this already?

Not me ... But yeah, agree that it seems likely to require some
refactoring, even if _some_ degree of attempts were made to keep arch-
specific things there ...

There might be a ton of arch-specific things in the ptrace code too, so
perhaps it'd be easier to start with the seccomp-based model:

https://patchwork.ozlabs.org/project/linux-um/list/?series=329466

But that's not really done yet either.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
