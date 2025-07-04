Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BC2C8303D
	for <linux-um@archiver.kernel.org>; Fri,  4 Jul 2025 17:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HuyqKYbzEZNceU+dad2NMm+FjjBbcgqjoJOnGR5GLpA=; b=qsJ19/ESRGgKW7ULHpgZdaUGCO
	H8V9QKx05HUJXxF/2KSAMi+mJfZTDoxT3EQD6dFNCpEnpzl3W6HAdmh36EuRRMlG0Uib+JkteFVCx
	4iRLvSTvQFRpIE1jPdrLfLccViwqUBQZIXlU3SxJznhADJV0sOjm+JAo23Sqh0pzcV+gkrK79EzU3
	FO62VvoYwjYdB7NnrutsQ4mJIh3sl7CdnXkrt+pTkPaC8AWepAq3MATJUYFwtO/o2/hwtiQTtKKDP
	8nvo/qd4opLVnQWlH8dBQlXm/WUFwaMkCPiyMNd7m8gI7Ldy0aYjSFooJNcISdaoUUZZBC3ek253/
	ovN+S7XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXjm8-0000000F2xk-2OcD;
	Fri, 04 Jul 2025 17:00:36 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXjYl-0000000F0lk-3sMu
	for linux-um@lists.infradead.org;
	Fri, 04 Jul 2025 16:46:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57B9F26AC;
	Fri,  4 Jul 2025 09:46:31 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A7F53F63F;
	Fri,  4 Jul 2025 09:46:42 -0700 (PDT)
Date: Fri, 4 Jul 2025 17:46:32 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH 21/23] um: ptrace: Use USER_REGSET_NOTE_TYPE() to specify
 regset note names
Message-ID: <aGgFQxrBfwF5QbP4@e133380.arm.com>
References: <20250701135616.29630-1-Dave.Martin@arm.com>
 <20250701135616.29630-22-Dave.Martin@arm.com>
 <98d145e6dd8e216a3f7e146ad4e401724c3d669b.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d145e6dd8e216a3f7e146ad4e401724c3d669b.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_094648_009437_58A6C56D 
X-CRM114-Status: GOOD (  12.06  )
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

On Fri, Jul 04, 2025 at 01:58:57PM +0200, Johannes Berg wrote:
> On Tue, 2025-07-01 at 14:56 +0100, Dave Martin wrote:
> > Instead of having the core code guess the note name for each regset,
> > use USER_REGSET_NOTE_TYPE() to pick the correct name from elf.h.
> > 
> 
> Seems to work according to the test in the cover letter. Since it's part
> of a larger series and this patch doesn't build by itself, I'll assume
> you want to take them all together through some other tree, so:
> 
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Tested-by: Johannes Berg <johannes@sipsolutions.net>
> 
> johannes

Thanks!

Cheers
---Dave

