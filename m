Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97501C05027
	for <linux-um@archiver.kernel.org>; Fri, 20 Jan 2023 08:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BF+b8Rxq4zac2IpJTUlUHTRTlRVDI4ztZ9sxMxlwn3E=; b=D8l2kPZ74U5D1m
	+8nTYqQPBzBTeI3cKHpnH7MAfnPbPQt8m+rDtVRAT35zfrndAtlSyQ5tunS79ysD480/sr07ZYF0V
	ZTitXyRvKgBRHs1QZNGyny5q60b2MVptxBCpvE/EhWu5+F0R1U1I0WWH6Gt8OrIGrmxcDLZrx/hdA
	PaSaOB0mcnVb+GYMgljB/as8a1wK1VzPfS+Y7DKRMGVqRwWAZ40jvlks3UHa8+mxpRtv4d5j1q6ve
	vl6UZRz4VgAb96w9terbwSrEaqOFdhtWw6TZokd84E+BvzoOEYIkhm5ndPIfxoNjYv4OIywIQ3+ER
	UPz/ejVSzIFJrgmQpU2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pImfy-0091K5-N3; Fri, 20 Jan 2023 08:23:06 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pImfu-0091Ie-Si
	for linux-um@lists.infradead.org; Fri, 20 Jan 2023 08:23:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1IBDSfDrpMYQx8rkav9qJHt8V5y0Ox1ZCl4BB8a2/Bk=;
	t=1674202981; x=1675412581; b=DpplsQR98bvaYu49nQW+g5C3//OmaRJx6WNk/XrzNT8qk97
	wYAydGLMYzEU2ouC1MwKSXInHpDJQXKCCJsS9EPTrlh1skZzD6qAL7tujRZuhs0hd1mmtEevFrDTO
	ZTz8lJlsXB3F9xsUr6OXnc1tC2K7jQl1/SvAUsIUhaN85KcZbLFt+QFtU4bUrLMxN6IzsfJPvlqGq
	7OCjfZXzTuux+wo5BlVSKMlYnpzGSV+JlfsADX1SWUv4OdG4Joz/otAYARM0nC9mNq3EnzIBA+1gJ
	O83JKPkyZNo1AyGNDKWoMQZksxBsc8JAoQxhbRqPzP1NVPIhOuj31zBl7kAztLlg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pImfp-007Mhu-2I;
	Fri, 20 Jan 2023 09:22:57 +0100
Message-ID: <49d7ebeb4617e9a1e42ef1608da6a907201c6c38.camel@sipsolutions.net>
Subject: Re: [PATCH] um: virt-pci: implement pcibios_get_phb_of_node()
From: Johannes Berg <johannes@sipsolutions.net>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
Date: Fri, 20 Jan 2023 09:22:56 +0100
In-Reply-To: <20230120-uml-pci-of-v1-1-134fb66643d8@axis.com>
References: <20230120-uml-pci-of-v1-1-134fb66643d8@axis.com>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230120_002302_963497_B168D860 
X-CRM114-Status: GOOD (  12.71  )
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

On Fri, 2023-01-20 at 09:02 +0100, Vincent Whitchurch wrote:
> Implement pcibios_get_phb_of_node() as x86 does in order to allow PCI
> busses to be associated with devicetree nodes.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  arch/um/drivers/virt-pci.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> index 3ac220dafec4..6884e1be38e4 100644
> --- a/arch/um/drivers/virt-pci.c
> +++ b/arch/um/drivers/virt-pci.c
> @@ -533,6 +533,25 @@ static void um_pci_irq_vq_cb(struct virtqueue *vq)
>  	}
>  }
>  
> +/* Copied from arch/x86/kernel/devicetree.c */
> +struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)

Hah. I was going to ask how that works without any ifdef or anything,
but then I found the __weak version :-)

Acked-by: Johannes Berg <johannes@sipsolutions.net>


Or maybe I should finally put on my tentative ARCH=um maintainer hat and
start taking patches :)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
