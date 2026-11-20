Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673BA606A320
	for <linux-um@archiver.kernel.org>; Fri, 20 Nov 2026 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aBC81qC0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=A5p512q1vWE8Uy9SPysuh8aKMj7lGxs0o4LND/TLe8s=; b=aBC81qC04q/npJ
	GgPz9pVKFbTD4wf97tjlK1C84XwZGK6kjiOTuf9RtGWMLb81ajbupMsCDpHkQRhUD38tcdo4M9c2f
	rzFt6YP+9Q+EgCzBfzlQRLq9DMfb6LOzKJULzK82MJZBvcAdzo/9qLeykYZfyER57wKmNtrnC/mEl
	6QDYT0yfj7dT/1TJQEhBMNa5L84O3zl2LNSytP0Nqw4n02F5EhPUPQyeXOTav73lZ2FgFpz4dWfut
	C87ooN129JmpsElyKpqa0ar+RMflLXsKZ8lvHQvkkundRNdqafMfv2lw6VzkozzKFeAiA9NVkYmUH
	ruEFppNn35ObREcXEihA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJJI-0000000EGse-2Xyf;
	Fri, 20 Nov 2026 07:45:28 +0000
Received: from ns3.kot-begemot.co.uk ([31.70.137.218])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJJF-0000000EGr5-00PQ
	for linux-um@lists.infradead.org;
	Fri, 20 Nov 2026 07:45:27 +0000
Received: from [192.168.19.6] (helo=jain.kot-begemot.co.uk)
	by ns3.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xUJ1z-00000002Hv4-3XfP;
	Fri, 20 Nov 2026 07:27:36 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xUIo7-0000000E1eN-2ICf;
	Fri, 20 Nov 2026 07:27:33 +0000
Message-ID: <aa262899-6b0c-47b8-b099-a8aa83a2a881@cambridgegreys.com>
Date: Fri, 20 Nov 2026 07:27:32 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: Don't clean up NAPI that was never set up
To: shyckless@gmail.com, johannes@sipsolutions.net, richard@nod.at
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
References: <20261119-uml-vector-napi-v1-1-b3751cf4fa60@gmail.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20261119-uml-vector-napi-v1-1-b3751cf4fa60@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_234525_047202_3CC06D86 
X-CRM114-Status: GOOD (  25.08  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/11/2026 22:39, Suyuan Wang via B4 Relay wrote:
> From: Suyuan Wang <stevewong@hust.edu.cn>
> 
> vector_net_open() calls vector_net_close() on any failure once
> vp->fds is set, and vector_net_close() then runs napi_disable() and
> netif_napi_del() unconditionally. But the NAPI context is only added
> and enabled after build_transport_data() and the header buffer
> allocations, so a failure in any of those disables a NAPI context that
> was never added. napi_disable() locks n->dev, which is still NULL:
> 
>    ip link set vec0 up   (vec0:transport=gre,...,rx_key=1, no tx_key)
>    Kernel panic - not syncing: Kernel mode fault at addr 0x910
>     napi_disable+0x4e/0x9e
>     vector_net_close+0x2b9/0x87d
>     vector_net_open+0x105d/0x106f
>     __dev_open+0x244/0x334
> 
> Record in vp->napi_enabled whether vector_net_open() got as far as
> enabling NAPI, and only disable and delete it in vector_net_close()
> when it did. NAPI is still enabled only after the queues and buffers
> that vector_poll() uses are set up.
> 
> Found with a static analysis tool and checked by hand.
> 
> Fixes: b35507a4cfb2 ("um: Migrate vector drivers to NAPI")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
> ---
> Tested with UML (seccomp=on) on top of the um fixes branch: with a GRE
> vector device missing tx_key, "ip link set vec0 up" panics without the
> patch and fails cleanly with -EINVAL with it, also when repeated. A raw
> vector device on the host's lo still goes up and down twice as before.
> ---
>   arch/um/drivers/vector_kern.c | 9 +++++++--
>   arch/um/drivers/vector_kern.h | 1 +
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 8008278ccee7..021f14780b45 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1137,8 +1137,12 @@ static int vector_net_close(struct net_device *dev)
>   		um_free_irq(vp->tx_irq, dev);
>   		vp->tx_irq = 0;
>   	}
> -	napi_disable(&vp->napi);
> -	netif_napi_del(&vp->napi);
> +	/* vector_net_open() may fail before setting up NAPI */
> +	if (vp->napi_enabled) {
> +		napi_disable(&vp->napi);
> +		netif_napi_del(&vp->napi);
> +		vp->napi_enabled = false;
> +	}
>   	if (vp->fds->rx_fd > 0) {
>   		if (vp->bpf)
>   			uml_vector_detach_bpf(vp->fds->rx_fd, vp->bpf);
> @@ -1260,6 +1264,7 @@ static int vector_net_open(struct net_device *dev)
>   		netif_napi_add_weight(vp->dev, &vp->napi, vector_poll, NAPI_POLL_WEIGHT);
>   
>   	napi_enable(&vp->napi);
> +	vp->napi_enabled = true;
>   
>   	/* READ IRQ */
>   	err = um_request_irq(
> diff --git a/arch/um/drivers/vector_kern.h b/arch/um/drivers/vector_kern.h
> index 5f0ceb80779d..e1b697266fa7 100644
> --- a/arch/um/drivers/vector_kern.h
> +++ b/arch/um/drivers/vector_kern.h
> @@ -118,6 +118,7 @@ struct vector_private {
>   
>   	bool rexmit_scheduled;
>   	bool opened;
> +	bool napi_enabled;
>   	bool in_write_poll;
>   	bool in_error;
>   
> 
> 
> 
> 
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661

