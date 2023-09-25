Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203CFCE7A94
	for <linux-um@archiver.kernel.org>; Mon, 25 Sep 2023 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MwWWYuzJNWwL3yngmKALGIr4TKKiy6ELI+6V66CVhm8=; b=QUxHZ8sp9rJRMy
	27IMs+aEmZAZbJZoqeqYv6OPxp4IsvSo+sBFz2jPjL8A6otST4XI5HEUilt3OBUQAoI3mIiwZ9Y0H
	0rKQKDpaM2lmF/HDCqPH8ZB6BNVh9VKxx8vEovKiRN4uWPvuvdraKnSdjcm666vjyQYlKDtFVJC58
	ExUJToIk8MmbXeQZ6uIznVUPVYrEqG6nMsETTpD9IKRNYx69ZDdYZZMhcCIm2h/DkbYhVpCuFG6ge
	3wydirPVe8qg+HQW6EltbJLgsy/vnn84Bx49JyfLRWrkuxD5u8CdzhPDD1ocURvwtmJkPkOubSU9W
	eEGnrYJi6IHYuerDMoqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkliA-00ELXC-2f;
	Mon, 25 Sep 2023 13:33:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkli8-00ELVZ-3D
	for linux-um@lists.infradead.org;
	Mon, 25 Sep 2023 13:33:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QStXR2BXxCqgTO9BlskJ4WcscblJQQbAdcz1Ap5Zm04=;
	t=1695648794; x=1696858394; b=AOXppoAFPifRxGTU3NypufiXAbBTX/EDee1dSSmm0b2okod
	ro5UQUCcz2mZIWx1k+VDChhM0r3pFPGe92/CMzzJo/rmKGNLQmGknpUEfoUeOyLcona7ODJz+v70u
	b+KDWtfddRMiyZ3OYqhhge1juOxkEg4TZ6ghk+3Qm7/PjWcn9/xE49WcN92Y1L1JjVaVvOcPcY/I8
	ZFD42HETv6JEWSJZpW4IlufYB0pxi/w0FMK3eoBRN3W6LkwjoG+Kjr7iWrV9uSY+b06GLZiaS5eox
	5QEgWks7ULQBdAbpB7qMEnPDC1oG8pJawjIznF4WCd8oRIKS9Ej9as943VwfIIwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qkli4-003e7K-00;
	Mon, 25 Sep 2023 15:33:12 +0200
Message-ID: <4f79b781db6d5892c86e103733c7c30cda78afdf.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 0/3] um: clean up mm creation - another attempt
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Date: Mon, 25 Sep 2023 15:33:11 +0200
In-Reply-To: <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
	 <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_063317_036931_D955AE2D 
X-CRM114-Status: UNSURE (   7.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, 2023-09-25 at 14:29 +0100, Anton Ivanov wrote:
> I have rebased the preempt patch on top of these series.
> 
> PREEMPT works with some performance decrease.
> 
> VOLUNTARY deadlocks early in boot around the time it starts loading modules.
> 
> non-preemptible deadlocks very early in boot.
> 

Well I guess that means there's still some issue in here? Hmm.

Now I don't understand anything anymore, I guess.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
