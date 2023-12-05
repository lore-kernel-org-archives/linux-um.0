Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078EBC4167B
	for <linux-um@archiver.kernel.org>; Tue,  5 Dec 2023 17:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7NBXt9xmAEkSUxu7YsZNQfOqx5RZWDv7vzb28/ySBQE=; b=KJvW9NjwhHyTMz/Djp9MsV5x8A
	ZAMHT2+zSXTOoeHFyoq3CxZS2rJ1ulniLWYhS/JhjPoj1D3PddreJ0/hsuyqZ7yQStCPG0Q31HHE/
	rvVmb45Hsce/dEr4vD9SeBsF6mwGpT+mgle5tt2gNT0VSvpIU9ZXSeg3YrIUUt5jBGgVga60c3sox
	BSIY4KusvhgEl34HPKpMCUT7gAHAhwt/s8M4+xGNVoFJvFdSbguHawfVmc3EdKb1O7CB/YTMdtzdC
	a3iQBza++Oa6DRzTBxQpLO10bQnFhP2yeB2n7Sb6ozVEdTcw7BaKEvfv+EkjGWF9LBdxjIc98CNge
	fNaAeDIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAZbb-00855I-2L;
	Tue, 05 Dec 2023 17:53:11 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAZbX-00854m-30
	for linux-um@lists.infradead.org;
	Tue, 05 Dec 2023 17:53:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DE963CE19F4;
	Tue,  5 Dec 2023 17:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99653C433C8;
	Tue,  5 Dec 2023 17:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701798785;
	bh=qND1Cy64uVoi7dcRD4f9PhuWzWNexF0SFLJhlxPZ91E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOHvhhhGxvy2Z/wb90CKjL692W3BqYaNIrPBlQ8ImdyJIOGtjD2j7xMkgGxaMhwXY
	 kuQgjFkYAtPqKyCh+i4sbbU9AG9ZdJez5q9PL41RjRm1ErlRBqIYPEu6k0e02lLhM+
	 aunfDl2k5E/MtUGpqtUdJ1blRg4NVZX8tdW5gqyY2FLk6MBHa/bQHiqK4ioRuGExQL
	 /Ce9YdeDBNPfVf6BNBOuVMw5uaTnSM2pZMmwaXZi59+56lmcGv28gkYmhoYoBqZsRB
	 3R7j/RRT3DyigF/LuAdEK4Nj7d+x5uL4nQSQ8uj1XzadQYLqbBZIhIYzLZSN5kWL0q
	 T1OMbB5r4kInw==
Date: Tue, 5 Dec 2023 10:53:02 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: ndesaulniers@google.com, trix@redhat.com, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] um: net: Fix return type of uml_net_start_xmit()
Message-ID: <20231205175302.GA536347@dev-arch.thelio-3990X>
References: <20231003-um-net-wifpts-v1-1-02888c634ee7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003-um-net-wifpts-v1-1-02888c634ee7@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_095308_426389_FD949A23 
X-CRM114-Status: GOOD (  23.40  )
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

Ping? I would like to turn this warning on for W=1 and the kbuild test
robot flagged this instance. If the UML folks don't want to carry it,
could I get an ack so that it could go with the warning enablement in
the kbuild tree?

https://lore.kernel.org/20231002-enable-wincompatible-function-pointer-types-strict-w-1-v1-1-808ab955d42d@kernel.org/

On Tue, Oct 03, 2023 at 11:35:53AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> warning in clang aims to catch these at compile time, which reveals:
> 
>   arch/um/drivers/net_kern.c:353:21: warning: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Wincompatible-function-pointer-types-strict]
>     353 |         .ndo_start_xmit         = uml_net_start_xmit,
>         |                                   ^~~~~~~~~~~~~~~~~~
>   1 warning generated.
> 
> ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
> 'netdev_tx_t', not 'int'. Adjust the return type of uml_net_start_xmit()
> to match the prototype's to resolve the warning. While UML does not
> currently implement support for kCFI, it could in the future, which
> means this warning becomes a fatal CFI failure at run time.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310031340.v1vPh207-lkp@intel.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/um/drivers/net_kern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
> index 3d7836c46507..cabcc501b448 100644
> --- a/arch/um/drivers/net_kern.c
> +++ b/arch/um/drivers/net_kern.c
> @@ -204,7 +204,7 @@ static int uml_net_close(struct net_device *dev)
>  	return 0;
>  }
>  
> -static int uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
> +static netdev_tx_t uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct uml_net_private *lp = netdev_priv(dev);
>  	unsigned long flags;
> 
> ---
> base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
> change-id: 20231003-um-net-wifpts-14a7429c7524
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>
> 

