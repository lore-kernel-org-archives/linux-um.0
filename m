Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56B8E7717F
	for <linux-um@archiver.kernel.org>; Fri, 13 Dec 2024 20:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:
	MIME-Version:Message-ID:In-Reply-To:Date:References:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eDVY25onPaZtCJX+iVfKNsi9Z56goiXb90v/iUb9VGc=; b=0yTbc/CLhXLsicIlY13uEP3+z+
	ut0jKBaVoxMSXeXFp+3xqoB/nhUK3CBF9TihxTAGSZAVeQ4mEZ75aFFwPGFYUKA3xjhf3h5pOy8Dd
	CazwHSv17UnV8dTY6gFDVJbycQ6+qfvIr3kxMRvBFB9UR4h1ju1bThAGugJ/m5UJ7BCyY1FmpIqMA
	t0OmbkaX4SHh1GFdGa+xSeCdtX6+U+UoK2P4q5ABcbhdq+yNZrITGWYPLCoVzE2dnomyUK48IJppM
	+s8LSshHkLP1RHWuaXKAa1n6QgJFIlSHi861EOAqNMd5CdmYxDphBVymDtAsz1b+99ItJrpA+CMQE
	o2cEgixQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMBsI-00000004v0C-1x7p;
	Fri, 13 Dec 2024 20:02:58 +0000
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMBsG-00000004uvW-0o9B
	for linux-um@lists.infradead.org;
	Fri, 13 Dec 2024 20:02:57 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:56908)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tMBrx-001B4G-AP; Fri, 13 Dec 2024 13:02:37 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:35748 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tMBrw-002tmk-00; Fri, 13 Dec 2024 13:02:36 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org,  ricarkol@google.com,
  Liam.Howlett@oracle.com,  kees@kernel.org,  viro@zeniv.linux.org.uk,
  brauner@kernel.org,  jack@suse.cz,  linux-mm@kvack.org,
  linux-fsdevel@vger.kernel.org
References: <cover.1733998168.git.thehajime@gmail.com>
	<d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
	<87r06d0ymg.fsf@email.froward.int.ebiederm.org>
	<m2r06c59t9.wl-thehajime@gmail.com>
Date: Fri, 13 Dec 2024 14:01:58 -0600
In-Reply-To: <m2r06c59t9.wl-thehajime@gmail.com> (Hajime Tazaki's message of
	"Fri, 13 Dec 2024 16:19:46 +0900")
Message-ID: <87bjxf1he1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tMBrw-002tmk-00;;;mid=<87bjxf1he1.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19sW1PHOHAP9tXVu8GxcVgFKkZKUriqvqM=
Subject: Re: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, kees@kernel.org, Liam.Howlett@oracle.com, ricarkol@google.com, linux-um@lists.infradead.org, thehajime@gmail.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_120256_222593_FDC27475 
X-CRM114-Status: GOOD (  26.73  )
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

Hajime Tazaki <thehajime@gmail.com> writes:

> Hello Eric,
>
> thanks for the feedback.
>
> On Thu, 12 Dec 2024 23:22:47 +0900,
> Eric W. Biederman wrote:
>> 
>> Hajime Tazaki <thehajime@gmail.com> writes:
>> 
>> > As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
>> > loader, FDPIC ELF loader.  In this commit, we added necessary
>> > definitions in the arch, as UML has not been used so far.  It also
>> > updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.
>> 
>> Why does the no mmu case need an alternative elf loader?
>
> I was simply following the way how other nommu architectures (riscv,
> etc) did.
>
>> Last time I looked the regular binfmt_elf works just fine
>> without an mmu.  I looked again and at a quick skim the
>> regular elf loader still looks like it will work without
>> an MMU.
>
> I'm wondering how you looked at it and how you see that it works
> without MMU.

I got as far as seeing that vm_mmap should work.  As all of the
bits for mmap to work, are present in both mmu and nommu.

>> You would need ET_DYN binaries just so they will load and run
>> in a position independent way.  But even that seems a common
>> configuration even with a MMU these days.
>
> Yes, our perquisite for this nommu port is to use PIE binaries so,
> ET_DYN assumption works fine for the moment.
>
>> There are some funny things in elf_fdpic where it departs
>> from the ELF standard and is no fun to support unless it
>> is necessary.  So I am not excited to see more architectures
>> supporting ELF_FDPIC.
>
> I understand.
>
> I also wish to use the regular binfmt_elf, but it doesn't allow me to
> compile with !CONFIG_MMU right now.

Then I may simply be confused.  Where does the compile fail?
Is it somewhere in Kconfig?

I could be completely confused.  It has happened before.

I just react a little strongly to the assertion that elf_fdpic is
the only path when I don't see why that should be.

Especially for an architecture like user-mode-linux where I would expect
it to run the existing binaries for a port.

> I've played a little bit with touching binfmt_elf.c, but not finished
> yet with a trivial attempt.
>
> sorry, i'm not familiar with this part but wish to fix it for
> nommu+ET_EYN if possible with a right background information.

Eric


