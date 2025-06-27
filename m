Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D442AC77B7F
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMAKGN3DCjxCnMwPzKP2GWHT0WEI2uJUsaP5kWI4Hj4=; b=sjfuxqAS1iKPI0/gN0271sSASK
	9MuYas4dLJi4WLdm/k4WgDTuythdo2+YuCJdWoW0RPIaRnHxs+vTWfCY/418yPX+zamLamJQNPlZy
	JvB+tpbgDK9FV8RArxbcPKV5Nb68StT2tuPhAI+xylrBfUuiXYbqv+ra64AaF73kDSHRtsIUJd1V6
	HQ5TC8xUfnSKgJbIiM1dlE5MOrVQQj1kelADBER0Tefghgor6QyeCCVTN5BgYy3nLiZog4ohQczly
	kx975OPJjXnIihReVhLcGTyugoeVepWEGY+qvh6Fo/YXgWGOFKq/XXRDaXCpzDx8+gM8McFEWbhtF
	lejkcA5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV5kN-0000000EAdi-0ecz;
	Fri, 27 Jun 2025 09:51:51 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV5hi-0000000EA9h-0GTv
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 09:49:07 +0000
Date: Fri, 27 Jun 2025 11:49:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751017743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMAKGN3DCjxCnMwPzKP2GWHT0WEI2uJUsaP5kWI4Hj4=;
	b=IRa8OV+iToo0MMIWZDoH+ZhERGufvGcISFA7hfSf8TSf0emx6tEh3PsfRIaynIWaUZnLWd
	C9EHU9s+nFaPVbXVwjtLW/HAIz9bj+jotEcEpd715+5IwXrXFY2RbOg1qeDofBkrYGwAhg
	bnRRJcrtDQ2rgp1n2jGHEsuRmZ911iGHRcbF4Y+YyFwz9/7Op89cf/cAFhcGBNupZLr7tn
	FW6y7j4KtoDrQHMl4hWZTHSLkCippUGHCA0G3VgojFjRFtw6+hmHPkVNSgcrijxygryjPq
	f5upp46kmJiUdCW7Nu495P6LLzOCCfPU+85DgQ7dinofVtrjF0x1pZ8YkxwtYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751017743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMAKGN3DCjxCnMwPzKP2GWHT0WEI2uJUsaP5kWI4Hj4=;
	b=3/t7LYlSAqK5KoR23AtUxCxXiu36e/JFCJDyoeLH7qokzy7+OrBbAPkL52IvkdAt+ljLg1
	N5F5HTKU+kpyA/Dg==
From: Nam Cao <namcao@linutronix.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] um: virt-pci: Switch to
 msi_create_parent_irq_domain()
Message-ID: <20250627094901.bkxjYmHj@linutronix.de>
References: <cover.1750947651.git.namcao@linutronix.de>
 <b911c2f15c031354850eee277a773832890c3c17.1750947651.git.namcao@linutronix.de>
 <45f44f0298259abf1862b965805307b7c01a279d.camel@sipsolutions.net>
 <20250627084943.nCYOI4Vp@linutronix.de>
 <94de787f4c3ad6fc3a44c50c2a5d5311861ddd6c.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94de787f4c3ad6fc3a44c50c2a5d5311861ddd6c.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_024906_238973_A22CA144 
X-CRM114-Status: GOOD (  18.18  )
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

On Fri, Jun 27, 2025 at 11:23:58AM +0200, Johannes Berg wrote:
> On Fri, 2025-06-27 at 10:49 +0200, Nam Cao wrote:
> > 
> > Thanks for testing! The later kernel crash should be fixed with:
> > 
> > diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> > index e51a9357934da..557d93aea00a1 100644
> > --- a/arch/um/drivers/virt-pci.c
> > +++ b/arch/um/drivers/virt-pci.c
> > @@ -407,7 +407,6 @@ static const struct irq_domain_ops um_pci_inner_domain_ops = {
> >  
> >  #define UM_PCI_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
> >  				   MSI_FLAG_USE_DEF_CHIP_OPS		| \
> > -				   MSI_FLAG_PCI_MSI_MASK_PARENT		| \
> >  				   MSI_FLAG_NO_AFFINITY)
> 
> Can confirm that.
> 
> > I have no immediate idea about the lockdep warn, I don't see how the
> > MSI_FLAG_PCI_MSI_MASK_PARENT flag can be related to that. Probably there's
> > another problem, let me stare at it..

My understanding of UM is limited, but I think I get it. We dereference a
NULL pointer and get SIGSEGV. We go into that code path and lockdep yells.

With the NULL pointer deref removed, we won't go into that path, so it
should be good.

> Seems to go away as well, perhaps it's due to taking some wrong path
> with the flag just prior to the crash?
> 
> IOW, works for me with the above change with no crash and no lockdep
> warning either.

I will send v2.

Nam

