Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25309C87FCE
	for <linux-um@archiver.kernel.org>; Mon, 28 Jul 2025 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UYNcGeys+8gkTrQ2K5DvrFz3i9bs95O5h5mTnWGNU7U=; b=FlRfoI8dEI84FW1EnQnXYHZfr3
	kTo6bmFDnq7Q2VDWJfLuMXx7X326enO2Nm+r1sTGaVGxdWPbd4f41rjizZTkayIJApuL864lm/883
	om5OsYCC1IxbP/bySixMC6nqmTXOWJ8IUkHNuGThIoaY/bBjGjSwVRc/btftdLfOcd23SVQa+k0J4
	yrV681j2SSxDPQC5CSFCgU8hIXXXNBFk+2J1mwhYTghkWTHEG7IR9tgt8feAQbnjro1bl8jFUmQjO
	enlyiGvvCE5TiN/xMVGhy5HA4MewB3dwatrtSbzCm2+mKEYFlgjL48n6S7ZqEPnaoqP8IaKYL15Sk
	Z7drClYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugRO2-0000000F4fN-2BnX;
	Mon, 28 Jul 2025 17:11:42 +0000
Received: from out-174.mta1.migadu.com ([95.215.58.174])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugQNc-0000000EvpN-0zjZ
	for linux-um@lists.infradead.org;
	Mon, 28 Jul 2025 16:07:13 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753718830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYNcGeys+8gkTrQ2K5DvrFz3i9bs95O5h5mTnWGNU7U=;
	b=WO1prYN4dOdDgEQd6r7MPRM9udUphzM5z92Ga2WKG7zCS8NpJDa/0KUmVb0hvMXyoydNOG
	1l5/k3M6BeddWOPSMWAOFi6mkGae3FCFESDIoc8gkals3rYSxPz8mLw5S64eKF0DkNSgqV
	kitp2FKGoQJQ5fS7qaojKzL5VRuJLh0=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH 9/9] um: Add initial SMP support
Date: Tue, 29 Jul 2025 00:06:51 +0800
Message-Id: <20250728160651.3268677-1-tiwei.bie@linux.dev>
In-Reply-To: <80979dce038d684495b77d6a90d19df7a4b94b9c.camel@sipsolutions.net>
References: <80979dce038d684495b77d6a90d19df7a4b94b9c.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_090712_416608_7AA04806 
X-CRM114-Status: UNSURE (   9.34  )
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

On Mon, 28 Jul 2025 15:55:28 +0200, Johannes Berg wrote:
> On Sun, 2025-07-27 at 14:29 +0800, Tiwei Bie wrote:
> > 
> > +static void IPI_handler(int cpu, struct uml_pt_regs *regs)
> > +{
> > +	struct pt_regs *old_regs = set_irq_regs((struct pt_regs *)regs);
> > +	unsigned char c;
> > +	int fd;
> > +
> > +	irq_enter();
> > +
> > +	if (current->mm)
> > +		os_alarm_process(current->mm->context.id.pid);
> > +
> > +	fd = uml_cpu_data[cpu].ipi_pipe[0];
> > +	while (os_read_file(fd, &c, 1) == 1) {
> 
> We were discussing the IPI stuff and started thinking maybe an RT signal
> with sigqueue() passing the value to the si_value in SA_SIGINFO data
> would be possible and have less overhead? That way there's nothing on
> the SIGIO path, and you don't need a read() for the type of IPI?

I like this idea. I will give it a try. Thanks!

Regards,
Tiwei

