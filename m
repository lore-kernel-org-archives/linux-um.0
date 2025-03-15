Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426E2C35FF1
	for <linux-um@archiver.kernel.org>; Sat, 15 Mar 2025 01:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7kvJA5J2TZczMX5j3W0+0Uj/BEd1sOJcH3MzCy03gSc=; b=zj/bCKGynBnDOwbtHNEY3chNkm
	tK3tbW6XptgIguaYRR4MkA9QnS9QwGKyGbzw0g7aZOBP4G6PndCGqwwKmZ2O3Y1IxIjrEpU4XLb8r
	h3VCSKt7nNMqNc9gvgGcLgxrGFt+M8WGjg22Ge6dO5dzPRh3GwB3VfOOIzk1wOpsmOjsFmL9RIuSi
	e/M4BalheU1Qq8iSy90DcdmOA3uRG+AW54KaFZWNefqMRrEvMNqv98nnXjRRZa4KSXfzMO/8elU7J
	tsqSL88Xel2tACVadOEEyQbdKX/QtIEyfgCIUbBG3BpJvZlWJY+qcrOTM5w989DRK4+cThSYzK17q
	1qx+a9fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ttGL5-0000000FemR-123P;
	Sat, 15 Mar 2025 01:29:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ttGL3-0000000Fem3-27tw
	for linux-um@lists.infradead.org;
	Sat, 15 Mar 2025 01:29:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9477B5C5627;
	Sat, 15 Mar 2025 01:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD195C4CEE3;
	Sat, 15 Mar 2025 01:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742002160;
	bh=8a6cudezYN/0qR1pL7XJ08PJlQfplrgDXzVya/SnALQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RIrG5u4ftpB176s1kEmxAORX/BkabYCDhX5MqOyQLYgBDE/NcSyWbDJusUpkEUH7O
	 aD4buzVX0OxT5jm7zTuEMiPKG9UaZGZpEy05zyjr5ytRHEOmFN3BtFsFP7WC7RMt+d
	 ku0zJ9gNCxwarMhceDv4A1oPw8PPQy2URSbv9nS6FRhQdgjOsRyc+swIuehKzyMluz
	 xDD+fPwPQo7xOeYy1n/OLPZWWh9BJSSGTcApvCVe/kDIHUHHO5qlO9joPc1+QcLaH+
	 SLNoMCKec75dCA+tIY+sLRp4OrjNuoPCR2hF6p5VIZPKLwLTHjFYPCOSIuZGvlFoyG
	 XEIqcriCcjEnA==
Date: Fri, 14 Mar 2025 21:29:18 -0400
From: Sasha Levin <sashal@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	anton.ivanov@cambridgegreys.com, mst@redhat.com, jiri@resnulli.us,
	tglx@linutronix.de, viro@zeniv.linux.org.uk,
	krzysztof.kozlowski@linaro.org, herve.codina@bootlin.com,
	linux-um@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.6 14/17] um: virt-pci: don't use kmalloc()
Message-ID: <Z9TX7vadBvxcrbf9@lappy>
References: <20250218202743.3593296-1-sashal@kernel.org>
 <20250218202743.3593296-14-sashal@kernel.org>
 <c993aa3a8e86e429d2135974929283a33d0f34ca.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c993aa3a8e86e429d2135974929283a33d0f34ca.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_182921_585836_48731EE1 
X-CRM114-Status: UNSURE (   9.13  )
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

On Wed, Feb 19, 2025 at 08:42:01AM +0100, Johannes Berg wrote:
>On Tue, 2025-02-18 at 15:27 -0500, Sasha Levin wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> [ Upstream commit 5b166b782d327f4b66190cc43afd3be36f2b3b7a ]
>>
>> This code can be called deep in the IRQ handling, for
>> example, and then cannot normally use kmalloc(). Have
>> its own pre-allocated memory and use from there instead
>> so this doesn't occur. Only in the (very rare) case of
>> memcpy_toio() we'd still need to allocate memory.
>
>I don't believe this patch, "um: convert irq_lock to raw spinlock" and
>"um: virtio_uml: use raw spinlock", are relevant to anything older than
>6.12. I don't see how applying them would _hurt_, but I didn't have them
>before 6.12 and had no lockdep complaints about it; I believe some other
>internal IRQ rework caused the issues to pop up.
>
>Never mind that we (Intel WiFi stuff) are probably the only ones ever
>running this virtio_uml/virt-pci with lockdep :)

I'll drop it, thanks!

-- 
Thanks,
Sasha

