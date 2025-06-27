Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95CCC7EE31
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 09:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y9vhrsp7QZvTqYOj7ek2BlquX7altZRuzwvy5tsKFHE=; b=C9o1+YXR1ucTkSP0ygkFl+odzJ
	+0vcJUsLdTzWcy8hVfZJhv6qrgbL66Z7XZYl0jt8fzEtg2NTBDMl8rh+qfQoJLTpuNnEBozAWQ8sM
	s2CZYALabiwn5JeoGipssg3/t2xNKd7lyyM4+qA4ON8LvdFArWiBT09PHL9k+OjinKSpHLqGWHg6E
	57VRzCgyW7X9ltSpB7bbDOYCaVzh7vC5uterj9rnIqyu5nX8xagXlnNkpajQTxsc5nE5VNpX9Ebps
	PhaaHb3/OcCmlAmPPGvpdGsJzN+cQsMbgRXaB/ZHbwl5rhh20pApFeBoaO+EIEOPj74ILDCTffSsy
	qa8iAc4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV5rC-0000000EBQb-1WoC;
	Fri, 27 Jun 2025 09:58:54 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV5lz-0000000EAlO-2jXF
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 09:53:32 +0000
Date: Fri, 27 Jun 2025 11:53:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751018010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y9vhrsp7QZvTqYOj7ek2BlquX7altZRuzwvy5tsKFHE=;
	b=k2iADpdvrNuJCjXW1lpo4dsA7Opqr7yQ5DO0tTz/zTCDj9UqBrAMwp1OR35WLItIHKLp4S
	nJH8hw5PiWQgpRqzuC5K6G7k8wEJ5GAhCrojtwwMbiAvMXqEiAhqKoW2TiXbyQb8OpYQE0
	73oh0jTNBks9kVXJtgYHY14TdNYiZx7vFefanmvJrDv/pTM/ayYIAZoZNxxlTTW6gI1+Qv
	epr6XQ7KEh1PYaDKCzWuE5HoZPWRV+tx3veil77Wgs4cnTcNMU6KRGeClvANwmHCCB2twH
	53v4yFRh7vlilzAK4cYTEXTL+MXhLGbUfRTkx4D02KGmUz/pg5FdXyQ8VsGtiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751018010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y9vhrsp7QZvTqYOj7ek2BlquX7altZRuzwvy5tsKFHE=;
	b=L9WITtaakBJQMLHa8mH/q+Ou4J2hqnEjRagwucfnjjTG16tO/c8US9UlAUe2TzfS/rvM0w
	kXbeqk3jtRNVI5BQ==
From: Nam Cao <namcao@linutronix.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] um: virt-pci: Switch to
 msi_create_parent_irq_domain()
Message-ID: <20250627095328.ce5O9YWf@linutronix.de>
References: <cover.1750947651.git.namcao@linutronix.de>
 <b911c2f15c031354850eee277a773832890c3c17.1750947651.git.namcao@linutronix.de>
 <45f44f0298259abf1862b965805307b7c01a279d.camel@sipsolutions.net>
 <20250627084943.nCYOI4Vp@linutronix.de>
 <94de787f4c3ad6fc3a44c50c2a5d5311861ddd6c.camel@sipsolutions.net>
 <20250627094901.bkxjYmHj@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627094901.bkxjYmHj@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_025331_828638_1BF90D77 
X-CRM114-Status: UNSURE (   8.66  )
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

On Fri, Jun 27, 2025 at 11:49:03AM +0200, Nam Cao wrote:
> My understanding of UM is limited, but I think I get it. We dereference a
> NULL pointer and get SIGSEGV. We go into that code path and lockdep yells.
> 
> With the NULL pointer deref removed, we won't go into that path, so it
> should be good.

By "that code path" I mean SIGSEGV handler.

Nam

