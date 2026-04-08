Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98799FD5F97
	for <linux-um@archiver.kernel.org>; Wed,  8 Apr 2026 08:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JmpApk2FiR7o+PlJJ3uiofPQloqZIdHEM81aoWW5UxI=; b=xBLAcUxSx+lhX5Q5IbaArfiWW9
	lynXpwB64x+cYmm1GaJmqaRlDkbAt3zPDMviiWJ5Vu9TFk4yfMv4sExa2tmzHTXjTym7hT7E04/3j
	BtNMR/aRbTrZp6ufvRhau4h9mjcv87y2RtCO/Ks9gpo0mopIC6yf8jaVRcIthmHAzg2UhsOTOOgOi
	X5RJBMl81ta2J+/3xlqyZsdyXO4/fIjj+YpSON+q77lbqzshJjaN0uL7+M7rLeXcCF+n4ywkPl8Lp
	2dlyl4RPqa+vRNFpNLh+qCfJUDR6YsIfo8HNODP/A83Jr/qZ7n6WKYNfbIcf1pekmC0RXNkwWKjs5
	d5/6NtKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAOKE-00000008WTe-2apu;
	Wed, 08 Apr 2026 08:31:50 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAOKB-00000008WTI-2o8i
	for linux-um@lists.infradead.org;
	Wed, 08 Apr 2026 08:31:49 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wANq5-00EpGh-9C; Wed, 08 Apr 2026 08:00:42 +0000
Received: from [192.168.21.56]
	by jain.kot-begemot.co.uk with esmtp (Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wAMkm-0000000CGGZ-3ISF;
	Wed, 08 Apr 2026 09:00:40 +0100
Message-ID: <39683457-2145-4586-ba0b-e874839ec24f@cambridgegreys.com>
Date: Wed, 8 Apr 2026 09:00:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: reject out-of-range port channel numbers
To: Johannes Berg <johannes@sipsolutions.net>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>, richard@nod.at
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260401160315.88534-1-pengpeng@iscas.ac.cn>
 <d022d5597e1d5ca3ecddb192e39d4a14a16d4c5a.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <d022d5597e1d5ca3ecddb192e39d4a14a16d4c5a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_013147_732744_F72018F5 
X-CRM114-Status: GOOD (  15.01  )
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


On 08/04/2026 08:39, Johannes Berg wrote:
> On Thu, 2026-04-02 at 00:03 +0800, Pengpeng Hou wrote:
>> port_init() parses the port channel number into an int, formats it into
>> a small fixed string buffer, and later passes it to htons() for bind().
>> Out-of-range values can therefore overflow the local device-name buffer
>> and still get silently truncated at the socket layer.
> So ... you have a whole bunch of these fixes, but do we really assume
> that the kernel command-line is somehow attacker controlled for ARCH=um?
>
> Maybe I'm not imagining the right things, but I have a hard time seeing
> anyone run a service of any sort where the command line gets to be user-
> controlled, and yet the kernel needs to be secure against that user; in
> a normal ARCH=um scenario the command line is written by the user as
> something like
>
> 	linux foo=bar mem=256M ...
>
> and then can happily attach gdb to the process and muck with it any way
> they want anyway?
>
> I'd probably say the code shouldn't have been this way at the start, but
> I'm also not convinced it's even really worth fixing for anything but
> the "look my LLM found _something_" creds...

+1

>
> johannes
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


