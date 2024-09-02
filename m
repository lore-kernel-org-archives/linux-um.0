Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64E8CA0ED3
	for <linux-um@archiver.kernel.org>; Mon,  2 Sep 2024 20:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f9HqqG/S8gNFNXekuYP+0WbktJCC4EyB/r2MZNL9JoE=; b=vQ4Kjd/0dsqGkw46ghWJFe1hAE
	zgvV02VmBWpKLG+ZjOsOWlZfKGMKqwRbdll35hI2kWyc1XOscDqXgS+viS96LZsHYHIby6vUC1A8U
	0zsGmZzX8//B+5WazT/vVDTxNcvkSjTLVE98J12k8N2umTy99qQTG5ylONBRFdGhABsi3Ox9gcFgC
	zwU5tylsL/nYxGt/swcTObU9XTwgKs5hB785dCb4WMx6zmLKp6FWd6uRNS+4B8oQTLvBpE+Jqf9Vp
	9oiPqO++576l9/3+WCn+/A/eTPgF2K5mUT+3WPJ1ilPswHAJ6XtDoQhObCIm3s2dAW6fLaUUpbUcx
	KCQIr4cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slDzr-0000000FWpN-38Mm;
	Mon, 02 Sep 2024 20:49:59 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slDzo-0000000FWog-2AVl
	for linux-um@lists.infradead.org;
	Mon, 02 Sep 2024 20:49:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 32465A400C5;
	Mon,  2 Sep 2024 20:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69389C4CEC2;
	Mon,  2 Sep 2024 20:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725310195;
	bh=plMpypI6Wercf2AMqEeD8hJy/zS1sMK2nF2Og4ULyOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gHiMeoWa0lzT85g1imdgbajsEHzGCaCYUlk/ONYUe6Zp7GrwM6LszSffkEbLgdXRr
	 dHZltfJQaFh2HH5t9EAQ3UnL3Ixs52lRSxs09kbyRMkq2VD1ynpM5lHjNHH+VRSQRI
	 VYoQuFvj+E/HihP+bWCJ+ELFTH2RSC3ESwGcFY+o=
Date: Mon, 2 Sep 2024 13:49:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 torvalds@linux-foundation.org, christophe.leroy@csgroup.eu,
 jeffxu@google.com, Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, oliver.sang@intel.com, pedro.falcato@gmail.com,
 linux-um@lists.infradead.org, linux-s390@vger.kernel.org, Ravi Bangoria
 <ravi.bangoria@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
Message-Id: <20240902134953.e834bc2e57d36b1d3b1397e4@linux-foundation.org>
In-Reply-To: <yt9dy149vprr.fsf@linux.ibm.com>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
	<20240819185253.GA2333884@thelio-3990X>
	<yt9dy149vprr.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_134956_769489_C11A056C 
X-CRM114-Status: GOOD (  14.65  )
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

On Mon, 02 Sep 2024 21:06:48 +0200 Sven Schnelle <svens@linux.ibm.com> wrote:

> So uprobe_clear_state() in the beginning free's the memory area
> containing the vm_special_mapping data, but exit_mmap() uses this
> address later via vma->vm_private_data (which was set in _install_special_mapping().
> 
> The following change fixes this for me, but i'm not sure about any side
> effects:
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index df8e4575ff01..cfcabba36c93 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1340,11 +1340,11 @@ static inline void __mmput(struct mm_struct *mm)
>  {
>         VM_BUG_ON(atomic_read(&mm->mm_users));
>  
> -       uprobe_clear_state(mm);
>         exit_aio(mm);
>         ksm_exit(mm);
>         khugepaged_exit(mm); /* must run before exit_mmap */
>         exit_mmap(mm);
> +       uprobe_clear_state(mm);
>         mm_put_huge_zero_folio(mm);
>         set_mm_exe_file(mm, NULL);
>         if (!list_empty(&mm->mmlist)) {

uprobe_clear_state() is a pretty simple low-level thing.  Side-effects
seem unlikely?  

