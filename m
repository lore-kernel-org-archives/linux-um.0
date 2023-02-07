Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ED8C636D3
	for <linux-um@archiver.kernel.org>; Tue,  7 Feb 2023 22:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Eip9RzUIyaxjZMGE8IKz3S/ed+uFaDEOJgHpRWrKp6Q=; b=mHOiziA+Y5Btb7
	wejdXa0MB9T96OgIWZbrRBWGbuxgRN/3Y7vu0gygpAkGZTBqA8iq9jrKaQWZSz+yYOhno85SoUMvL
	BAurXCeoXpb69kScYxTe8f/RmHWHbXNdvFvuFthMF8MYttGjZU+OoFyw2sI6w3nAoXOOP8p2JHPsK
	fyVcuOZ/MWkFZtK9lfh9GeIpMhJjMaT/5b/WhGNJmDTh8KfPQolwScgsmo1U0AazamfYLDXp/n5iT
	aKeElHYvpJhlt7VvXKbinuTZUwZxpqTzamYdnfgBcL8H5+QXUk0kmbENkRX+vgqJA4cgngf00T/to
	H55kvCu0GwnKIg6J7Vdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPWWU-00DZfM-VV; Tue, 07 Feb 2023 22:33:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPWWS-00DZea-Ey
	for linux-um@lists.infradead.org; Tue, 07 Feb 2023 22:33:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9DAA4612CC;
	Tue,  7 Feb 2023 22:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70521C433D2;
	Tue,  7 Feb 2023 22:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675809183;
	bh=pRMdbCPpUDgsLpUiYoKb0mWWBWHKfkLHQvPGx+ldOq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vII49AhK7i9eNITaQdC/CphaA4sDWF6OZrjsJWgLxXzOAvL3gYgYPjM7A3BU4NdNQ
	 XQR8/Po1n8EPIz3ovQdeCyEbotF7NwVjtgm2SV7K1wNTwL3gR0aJJCiacZ38OGV4gw
	 THVXAD0CqDV2jBOWsD0IDXc4V/37oZBuoLwWeaONcRXCmcUBLr0ip+ZqqrXM3tG/YF
	 0A2mn/n9AK6nTTaQaYISAlhNYI6nzX6KRadAGM9C58UhleqiupKgcESH+grn83Tl5A
	 AbPvpQATe843oO0h150TxyUrKrFr5BZke9LOayEtBzHNL/DlcGZKR6+Ca1S1OL/e38
	 XbuY4NccTp0ag==
From: SeongJae Park <sj@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH] UML: define RUNTIME_DISCARD_EXIT
Date: Tue,  7 Feb 2023 22:33:00 +0000
Message-Id: <20230207223300.74593-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207164156.537378-1-masahiroy@kernel.org>
References: 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_143308_578372_F95A4165 
X-CRM114-Status: GOOD (  17.95  )
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

Hi Masahiro,

On Wed, 8 Feb 2023 01:41:56 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:

> With CONFIG_VIRTIO_UML=y, GNU ld < 2.36 fails to link UML vmlinux
> (w/wo CONFIG_LD_SCRIPT_STATIC).
> 
>   `.exit.text' referenced in section `.uml.exitcall.exit' of arch/um/drivers/virtio_uml.o: defined in discarded section `.exit.text' of arch/um/drivers/virtio_uml.o
>   collect2: error: ld returned 1 exit status
> 
> This fix is similar to the following commits:
> 
> - 4b9880dbf3bd ("powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT")
> - a494398bde27 ("s390: define RUNTIME_DISCARD_EXIT to fix link error
>   with GNU ld < 2.36")
> - c1c551bebf92 ("sh: define RUNTIME_DISCARD_EXIT")
> 
> Fixes: 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv")
> Reported-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: SeongJae Park <sj@kernel.org>


Thanks.
SJ

> ---
> 
>  arch/um/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/vmlinux.lds.S b/arch/um/kernel/vmlinux.lds.S
> index 16e49bfa2b42..53d719c04ba9 100644
> --- a/arch/um/kernel/vmlinux.lds.S
> +++ b/arch/um/kernel/vmlinux.lds.S
> @@ -1,4 +1,4 @@
> -
> +#define RUNTIME_DISCARD_EXIT
>  KERNEL_STACK_SIZE = 4096 * (1 << CONFIG_KERNEL_STACK_ORDER);
>  
>  #ifdef CONFIG_LD_SCRIPT_STATIC
> -- 
> 2.34.1
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
