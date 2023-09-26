Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204B4E7E62E
	for <linux-um@archiver.kernel.org>; Tue, 26 Sep 2023 12:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ybYt6kIb0OoSo2jf5DgQ982S3ZhNTZwAOH7fyeCUr4w=; b=hKGO51K48SoPfP
	BKlYAh2JVQRJRINyuMEHpdK41dcedjtXFWjyIp3RiRCPFYzic0wGQ8OG0XJXgi8WEvSxBvboW8usM
	JiR3ABhfbyC2C2PIXN0nWeXzFqRoPMJw3zPrsRb5S0L9+lWgC2hBGu5w+5Q3vmTvce+pK1vIqYRAp
	gSYFVE+WLHdEQoFkBcQCS8eerQaDhCG+NlhOdCwhLByofYdOpiJGJq9P00c7p1bHDHYYOE6nShvEm
	r4AusE901tlMam+FmV45ZkO+TZ9fRk70Bq3iXp0TWOxJlNtMQsqn2qyzcruvenUq35iPmcHfsuQGg
	uVvLsOsQqH4sTyMPCnYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ql7L2-00GNyb-2U;
	Tue, 26 Sep 2023 12:38:52 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ql7Kz-00GNxw-1q
	for linux-um@lists.infradead.org;
	Tue, 26 Sep 2023 12:38:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VLKrZf01t2v0hTfjOd6Rfpr53wX9Mf9Tbjq0W3gcM3g=;
	t=1695731928; x=1696941528; b=E9HigRQIywUlqIcMDA6MdRv5OOM+obWtp8p9I9X6RXlTsVx
	sq3gNlu4yYDewkUzl3ztMnGNXxRyzSzIX+sOgZSFBImEKEBYxXwKcOIM6ZgLkX2hBmWtEEDz//1K4
	8PVo7+MCKbTR48Jxvep1/BG4tNcNXxE7+/ZzA1uA10lUWU/KDRBl08EgGFnj9bC05XTMHjKWQByxn
	rsHCfsQAXJllvy5tQ87kT/AI8ujhpIwmukSnEpPawAtkr0KfohGM1hqvX6kCEH5VmItpyKuYusA2p
	ziqW9AQGBczYOR+NXf2P3UIwP/J3Pz3M8SKKtLHUous+OgkWQtp1qYqk4vvM+krA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ql7Kw-005cI9-0l;
	Tue, 26 Sep 2023 14:38:46 +0200
Message-ID: <4d772184b2b39944de8444b0a6f437581297e1d4.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 0/3] um: clean up mm creation - another attempt
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Date: Tue, 26 Sep 2023 14:38:45 +0200
In-Reply-To: <2d041a80-0ba4-d48b-07b1-b1bc835b3e0d@cambridgegreys.com>
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
	 <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
	 <4f79b781db6d5892c86e103733c7c30cda78afdf.camel@sipsolutions.net>
	 <4b5764f0-d2c0-12ce-56bb-73c07ab59ebc@cambridgegreys.com>
	 <d6ac37b196ebc0443997a942f8efb16a69e424fc.camel@sipsolutions.net>
	 <18290c11-2d97-3aec-3fd7-b3dd0d33a88b@cambridgegreys.com>
	 <2d041a80-0ba4-d48b-07b1-b1bc835b3e0d@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_053849_608508_4C61CC66 
X-CRM114-Status: GOOD (  22.14  )
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

On Tue, 2023-09-26 at 13:16 +0100, Anton Ivanov wrote:
> 
> For the time being it is mostly negative :)

Oh well :)

> 1. The performance after the mm patch is down. By 30-40% on my standard bench.

For the record, you mean this three-patch series that we're discussing
in the thread of?


Btw, Benjamin realized that MADV_DONTFORK is broken in UML, precisely
_because_ we fork/copy the whole mm process and then try to fix it up.
But we can only fix up things that actually have VMAs, and of course
there are no VMAs with VM_DONTCOPY (set by MADV_DONTFORK) in the new mm
after fork.

To fix this, really we should either

1. Start from scratch, without copying, which my other patch [1] did.

   [1] https://lore.kernel.org/all/20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid/

   But of course that's more expensive because we now have to page-fault
   everything in the new process, and page faults are expensive.

2. Compare the new mm and the old mm, which requires putting it into
   arch_dup_mmap() like these patches here - where I'm not sure I
   understand at all why they cause a perf regression - and remove the
   VMAs that are marked VM_DONTCOPY in the old one.


To be honest I don't really like _either_ of these approaches, nor the
current "fork the process" approach that UML takes. It's very magic, and
very much works around how Linux works.

Remember that basically the mm process contents should match the page
tables in the VMAs; but this is decidedly not true where fork() is
involved, because while the VMAs are copied, most of the page tables are
_not_ copied. Thus, we have a situation where after fork we don't take
page faults in UML that we would take in a normal system (this part is
good for performance), and I believe also vice versa, which would then
perhaps explain the flush_tlb_page() in handle_page_fault(), because
honestly I don't otherwise have an explanation for it.


I think the better approach for correctness and integration into the
kernel would be to actually admit that UML is special because page
faults are so expensive, and

 * start with a fresh mm process every time
 * have vma_needs_copy() return true
 * completely fill the mappings according to only the new mm's VMAs
   in arch_dup_mmap() or perhaps later

I don't know how that'd behave wrt. performance, though it likely cannot
be better than with these patches, but at least it'd be more correct,
and more obviously correct too, for starters, because then the actual
mappings in the UML mm process would actually reflect the PTEs that
Linux knows about.


> 2. The preemption patches work fine on top (all 3 cases). The performance difference stays.

OK.

> 3. We do not have anything of value to add in term of cond_resched() to the drivers :(
> Most drivers are fairly simplistic with no safe points to add this.

Yeah, not surprised by this.

> 6. Do we still need force_flush_all() in the arch_dup_mmap()? This works with a non-forced tlb flush
> using flush_tlb_mm(mm);

Maybe not, does it make a difference though?

> 7. In all cases, UML is doing something silly.
> The CPU usage while doing find -type f -exec cat {} > /dev/null measured from outside in non-preemptive and
> PREEMPT_VOLUNTARY stays around 8-15%. The UML takes a sabbatical for the remaining 85 instead of actually
> doing work. PREEMPT is slightly better at 60, but still far from 100%. It just keeps going into idle and I
> cannot understand why.

Is it just waiting for IO?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
