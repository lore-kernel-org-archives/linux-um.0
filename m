Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D921C369A2
	for <linux-um@archiver.kernel.org>; Mon,  7 Apr 2025 14:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vqPo4BJw+Ec/ACl21W0maFoVCJxW/RDcMRbTDnWNsJI=; b=AjFbeaJegJ079ZYa92D7zznV4S
	K3laPn8rLnkGeCzNZszd7H3BcUrvCMJk/KMNscbNqggjgZwnSAXdsPFvLvfbaIHwOLyuOTeHECcK2
	f4/MmCNmNx9mc0I+HAzTfGIPRLH4IUeHf/BB3vE70G/nm/DkYjmYJNRV0TqMv0oT1ls/gCwhxIcKG
	qQVcHSYKF/W+Km+FgtEu+TS74bBnmRJh830xM4Lt6Y4r9V6OPR6U2iryWTMzoePNubaBMaV7/EOKL
	THqixO11yNVgRIic6S3kiAApbfKidh7y6QFrqNuYEiw+Uo+C8Bxy1FhH9fJMPppminMiYpwOBRvv+
	SYuiHfuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1n4e-00000000eHX-1SvS;
	Mon, 07 Apr 2025 14:03:40 +0000
Received: from bali.collaboradmins.com ([2a01:4f8:201:9162::2])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1n4b-00000000eG2-0yP1
	for linux-um@lists.infradead.org;
	Mon, 07 Apr 2025 14:03:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744034614;
	bh=LwpFHqtTF6aiM+1soPf8ma0ZkEP2mzQ1iN1O5ga09M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbK+zNlmEYMyXgy9EE+nYDPMS6CNvfQvS4m8Ns622tsZ+iUYZZUmQVKBc+XlC+Ex0
	 LaVUBaVnuHyN4MmHQRM5lw75L9OtxOhDCkjuYODTe+qjTI/m5+AMTxT0Gka7jc0QE8
	 IifRhyjZZYK5QvnI+mMIhrnYhTnAo9KP5sABY5mQ6fcU6WPvsT9xj3IKWxPUaa7KsX
	 WNf9C7FVgUYYMwv/V1hMAOJBiisS+blTU874Zclxv4aFp9RB6gJyAyCkEp32WSgf2b
	 YGO6OexvWQ9aiFyaesw8sjta8FGk9hz0lRUCH2EruQhXMFQ6T/BIolXXN9TstLXeHQ
	 P+ItjRt/WHB3Q==
Received: from notapiano (unknown [70.107.117.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D60C917E02BE;
	Mon,  7 Apr 2025 16:03:28 +0200 (CEST)
Date: Mon, 7 Apr 2025 10:03:26 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: James.Bottomley@hansenpartnership.com, akpm@linux-foundation.org,
	anton.ivanov@cambridgegreys.com, corbet@lwn.net,
	davem@davemloft.net, dmaengine@vger.kernel.org, ebiggers@kernel.org,
	edumazet@google.com, horms@kernel.org, jaegeuk@kernel.org,
	jarkko@kernel.org, jic23@kernel.org, johannes@sipsolutions.net,
	kernel@collabora.com, keyrings@vger.kernel.org, kuba@kernel.org,
	lars@metafoo.de, linux-doc@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mm@kvack.org,
	linux-sound@vger.kernel.org, linux-um@lists.infradead.org,
	maxime.chevallier@bootlin.com, mchehab@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, perex@perex.cz,
	richard@nod.at, tiwai@suse.com, tytso@mit.edu, vkoul@kernel.org,
	workflows@vger.kernel.org, zohar@linux.ibm.com
Subject: Re: [PATCH] docs: Remove literal markup from Documentation/ paths
Message-ID: <9bc7b77b-73a7-4d6d-9187-ac452f8cad23@notapiano>
References: <20250404-doc-paths-unliteral-v1-1-74718785444e@collabora.com>
 <811c4103-08b1-4288-9a15-bd9795bc59f4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <811c4103-08b1-4288-9a15-bd9795bc59f4@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_070337_424656_4B098E8F 
X-CRM114-Status: GOOD (  17.91  )
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

On Sat, Apr 05, 2025 at 10:17:16AM +0900, Akira Yokosawa wrote:
> Hi,
> 
> Nícolas F. R. A. Prado wrote:
> > Given that the automarkup Sphinx plugin cross-references
> > "Documentation/*.rst" strings in the text to the corresponding
> > documents, surrounding those strings with the literal markup (``) not
> > only adds unnecessary markup in the source files, but actually prevents
> > the automatic cross-referencing to happen (as it doesn't happen in
> > literal blocks).
> > 
> > Remove all the occurrences of the literal markup in
> > "Documentation/*.rst" paths, except when the actual source file is being
> > referred. Also change the surrounding text when needed so it reads well
> > both in the source and the web page (eg. 'see file Doc...' -> 'see
> > Doc...').
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
[..]
> >  
> >  2) All new ``Kconfig`` options have help text.
> >  
> > @@ -47,7 +48,7 @@ Provide documentation
> >  2) All new ``/proc`` entries are documented under ``Documentation/``
> >  
> >  3) All new kernel boot parameters are documented in
> > -   ``Documentation/admin-guide/kernel-parameters.rst``.
> > +   Documentation/admin-guide/kernel-parameters.rst.
> 
> Hmm, this item is asking "Have you documented the new params in that
> particular file?", so I don't think this change should be made.

Right, that makes sense. I'll drop this and the below change for v2.

Thanks,
Nícolas

> 
> >  
> >  4) All new module parameters are documented with ``MODULE_PARM_DESC()``
> >  
> > @@ -58,7 +59,7 @@ Provide documentation
> >     linux-api@vger.kernel.org.
> >  
> >  6) If any ioctl's are added by the patch, then also update
> > -   ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
> > +   Documentation/userspace-api/ioctl/ioctl-number.rst.
> 
> Ditto.
> 
>         Thanks, Akira
> 
> >  
> >  Check your code with tools
> >  ==========================
> 

