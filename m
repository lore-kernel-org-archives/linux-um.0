Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF87EC982EA
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xqQ+NYvyXWCfjlyvjvxmg1kCwOY0kqb1jeO3C2JsWsM=; b=CZBjdH2zg+NN6Vud88DOs0Tx+P
	z2wre6+U8pzjfjoKwUmDPmyhZc9p7itZ/zqSko5TQABnzKRXxyN++Fp/somwqQb0DR+1r0HLrogxn
	zJJSd57lT5+l0zeaIcvEF/SfPjkgq+4gFy2xM8bZNMH1JA+zvZB0SP+T08qxd/hp8E/86nBc7lusN
	fvJAb5q6U4bhNu9TiAuU1pTaQgquT5w3IxAxvU15pl6gv7FfsPt6EHNJ9Y5AdW8t1Ma5DCjni5rum
	m4hdE5UM0do2yLw7KDV0+/n+K4mZc6k925QzJBirjteihI3JLfOpD2aDycxvlKNLlXmMIDYFIEAwA
	LgCSreyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9LBS-000000084pX-1nfI;
	Wed, 23 Sep 2026 11:30:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9LBP-000000084ny-3DyE
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 11:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790163038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqQ+NYvyXWCfjlyvjvxmg1kCwOY0kqb1jeO3C2JsWsM=;
	b=ilWfCRuYtXMvgSkRooIx/ow7Zpr+D2CXd2ZCGUz2whCWl6Z+CCA+dbQCpAgc33P2HHFmTV
	WPOYSszPNxOgPG5+MOw0RKZadnu5TcQTiamDIl5MCAEFgQRssjkawiuXkLWwzClq97O2xu
	r+x3rubNQNBxf05lfCxxGk+HbSkHjps=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-hU8g012GMpKeOZhxZhxwBw-1; Wed,
 23 Sep 2026 07:30:34 -0400
X-MC-Unique: hU8g012GMpKeOZhxZhxwBw-1
X-Mimecast-MFC-AGG-ID: hU8g012GMpKeOZhxZhxwBw_1790163029
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1EA81955E8C;
	Wed, 23 Sep 2026 11:30:26 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9573118002B6;
	Wed, 23 Sep 2026 11:30:13 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 23 Sep 2026 13:30:26 +0200 (CEST)
Date: Wed, 23 Sep 2026 13:30:12 +0200
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
Subject: Re: [PATCH v3 14/14] audit: rename audit_syscall_entry_regs() to
 audit_syscall_entry()
Message-ID: <arO4RArEfB5HJqR-@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <0bb32d256099870f3f9ca2632cccf58538f882ed.1790088067.git.rrobaina@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0bb32d256099870f3f9ca2632cccf58538f882ed.1790088067.git.rrobaina@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: tvb8XPRQULYhLTQZvGpNXCt9wizeWBS_l9rKfXbw0Cs_1790163029
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_043039_879665_D28E0948 
X-CRM114-Status: GOOD (  10.63  )
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
> Now that every architecture has been converted to the pt_regs-based
> audit_syscall_entry_regs(), the legacy audit_syscall_entry() and
> __audit_syscall_entry() helpers that took the individual syscall
> argument registers (a0-a3) no longer have any callers.
>
> Remove those legacy helpers and rename audit_syscall_entry_regs() and
> __audit_syscall_entry_regs() back to audit_syscall_entry() and
> __audit_syscall_entry(), restoring the original naming.
>
> The _regs variants were introduced separately, and the architectures
> converted one per patch, specifically so this final rename is the only
> step that removes the old prototype. That keeps the series bisectable:
> every commit builds, and no caller is ever left referencing a helper
> that has been removed.
>
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


