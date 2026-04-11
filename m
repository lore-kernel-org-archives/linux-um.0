Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E9AF3ED50
	for <linux-um@archiver.kernel.org>; Sat, 11 Apr 2026 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FhnmcJoJrZTwLxDzFf/dyJeKnPWqt6OoM4v/l8G1xgM=; b=N0ko0QWZDKu7K/2nHdpynRqgWK
	69Wpz2nFwEcqXmVPVtYTF2as6Wdf2Zmm6eOEx8mr30aaVVuz6utg2q7VIGO7rA818AvVuFw+tzWot
	uC3bbvr1m5cbxf6pKUPG5K81ZtdRauKHUA9dYXIARK1J6uCBXWVSWy9qi2fNo7x/Z5PeRkzuorMXA
	MfcEyWK5Wg01NlgrQfuDPswtxzNx+h3fiD+WUfvnvnpaemQ1HaK0TiapUfmsTHfSujT1aBqMqA2pF
	ODxEtCnwyrrvz5tsRqC/3lWM+Vhsz/i0p7i2Q6zlSBLatGVFJS8CmLOAFcJqVZSGPg87dNYWXNSAM
	WVOvnGrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBbPP-0000000DduI-04CH;
	Sat, 11 Apr 2026 16:42:11 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBbPM-0000000DdtV-0P4j
	for linux-um@lists.infradead.org;
	Sat, 11 Apr 2026 16:42:09 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wBbPD-00F3LG-Sr; Sat, 11 Apr 2026 16:41:59 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wBaIG-0000000EvdI-1ojD;
	Sat, 11 Apr 2026 17:41:58 +0100
Message-ID: <63ffe16b-af07-4ac4-a823-8665dc255fbe@cambridgegreys.com>
Date: Sat, 11 Apr 2026 17:41:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: Remove unnecessary NULL check in
 destroy_queue()
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at,
 johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, kernel test robot <lkp@intel.com>,
 Dan Carpenter <error27@gmail.com>
References: <20260411163705.948426-1-tiwei.btw@antgroup.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20260411163705.948426-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260411_094208_164992_F33AEE78 
X-CRM114-Status: GOOD (  13.01  )
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

On 11/04/2026 17:37, Tiwei Bie wrote:
> All callers of destroy_queue() already perform a NULL check, so
> a NULL qi will never be passed in. Inside destroy_queue(), we
> dereference qi immediately, and the subsequent NULL check on qi
> is unnecessary and confusing. Remove it to address the smatch
> warning.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202604110937.MLUL70Lx-lkp@intel.com/
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
>   arch/um/drivers/vector_kern.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 2cc90055499a..755d936e5b43 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -471,8 +471,6 @@ static void destroy_queue(struct vector_queue *qi)
>   	struct vector_private *vp = netdev_priv(qi->dev);
>   	struct mmsghdr *mmsg_vector;
>   
> -	if (qi == NULL)
> -		return;
>   	/* deallocate any skbuffs - we rely on any unused to be
>   	 * set to NULL.
>   	 */

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661


