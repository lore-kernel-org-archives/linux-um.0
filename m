Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0B5C982EA
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AYhacAIOU9DfNtEKQcLBl4WUi74t7QonBaw7zJRbTMw=; b=i4GKgtBapJiNhr3aoD6zrVb2MD
	27ErsYF9AdCtCTh4XeVT3EHNAMG0y4nFTR2DXA1UBZmw7j6MpWW1k/fzXbZOc47miyH5m+Ii+Nl6l
	csRUMxF/x/lCgRhMY8Drzj0j+lImsiktxLVVRqfmJuXdLgWUExtJEviUvDQow9m7au2hLHfXrHekj
	b6oqVJ5xRMS5LouTgLhJ4KKY6DLRKVtVrtkBypsZdC+nnFnRHI9HrQinXZha36w/n98+9xmqIfxlf
	XAOroYncRC0RVFRpGITUSKcLEzNBtVU/DKKDEutOmA5q9VJcSZjwffWKsyZImKgw7bUZUzTm5RLT8
	NTYm7Zsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9LAo-000000084ex-0kSY;
	Wed, 23 Sep 2026 11:30:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9LAl-000000084d3-3tQT
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 11:30:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790162997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AYhacAIOU9DfNtEKQcLBl4WUi74t7QonBaw7zJRbTMw=;
	b=bIPJpYp8SAvjpZ0hLmxcgWBBZD4aKLNw4pyzFJp9H04E6JcBVDr8Ik0Gd8/7ua43hTSnBm
	LA8r6ianIPOgrDVM9CWa+jOYuHNfiLKVKgAgDgOt+V8YdaFOTJafSGFIO7Zw5ToKEexGA3
	SWZ8EpsuhfvGyCWS0WAOHYt6kD5YIOA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-gooFaoLZMMuKAK_dogOFiQ-1; Wed,
 23 Sep 2026 07:29:53 -0400
X-MC-Unique: gooFaoLZMMuKAK_dogOFiQ-1
X-Mimecast-MFC-AGG-ID: gooFaoLZMMuKAK_dogOFiQ_1790162988
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D61E1955F14;
	Wed, 23 Sep 2026 11:29:44 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 27F2A418;
	Wed, 23 Sep 2026 11:29:29 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 23 Sep 2026 13:29:44 +0200 (CEST)
Date: Wed, 23 Sep 2026 13:29:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, bpf@vger.kernel.org,
	paul@paul-moore.com, eparis@redhat.com, sgrubb@redhat.com,
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	guoren@kernel.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
	jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com, James.Bottomley@hansenpartnership.com,
	deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, davem@davemloft.net,
	andreas@gaisler.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	chris@zankel.net, jcmvbkbc@gmail.com, tglx@kernel.org,
	peterz@infradead.org, luto@kernel.org
Subject: Re: [PATCH v3 01/14] audit: log all six syscall arguments in the
 SYSCALL record
Message-ID: <arO4GNT_5wNEYsCO@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <855572d1b7461e7f258547be0f11c74029755110.1790088067.git.rrobaina@redhat.com>
MIME-Version: 1.0
In-Reply-To: <855572d1b7461e7f258547be0f11c74029755110.1790088067.git.rrobaina@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: LycgKiXZpY988h7Fk_TVCXc4AdAsQkLSn-KKo3DAhMA_1790162988
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_043000_053845_A44FCDF6 
X-CRM114-Status: GOOD (  12.89  )
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

On 09/22, Ricardo Robaina wrote:
>
> The SYSCALL record currently logs only four of the six syscall
> arguments (a0-a3). The remaining two are captured but silently
> discarded before reaching the audit context. This leads to the
> need for auxiliary records when audit-relevant data lands in the
> 5th or 6th argument of a syscall.
>
> Extend the SYSCALL record to log all six arguments, by adding
> arguments a4 and a5 (5th and 6th syscall arguments respectively)
> inline within the existing record. Also add the two new args to
> the audit rules switch case, so audit rules can filter on them.
>
> Rather than plumbing two more register arguments through every
> architecture's syscall entry path, retrieve the arguments from
> pt_regs via syscall_get_arguments(). To keep the series bisectable,
> add new helpers audit_syscall_entry_regs() and
> __audit_syscall_entry_regs() that take a pointer to pt_regs, rather
> than modifying the existing ones in place. Later patches convert
> each architecture over to the new helpers, and a final patch removes
> the legacy helpers and renames the new ones back to the original
> naming.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


