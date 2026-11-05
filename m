Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5524E606A31B
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rPK6ezAd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ocShDwJv7t3aH5l1tCpXXdZxnTMgWjYCvpze57Wu7Uo=; b=rPK6ezAd7cdQAY
	Nc0sObiZp9gfxa+Wmg24/jhw0znea2qGkUiWbJcMmeCwAUBiRMWmhjf0gJ32O+JynY7HBVE+qhbnk
	L0oBUfLa3/d8cdj3TlBqzbHx3NZaSGFf3FdGgNRhetIyLFHjrMne41G1sOaxvN7kS+T0JSOH2mRmT
	HzMQdzq7wVy8MHzyddCq3PXZDK543LwJKq2OtjJVGwoQe2843y7591wk4SliAYYghQb8VOakNWi/c
	g89j58/Xic1AQ8DN8/5/PyJibHLJKpMDbXxcDVUZR8YcF1poEtBYRFoBHxiKrZk3qka1K05x7QM9Q
	ff9qE2b7DfRmrd1u2tjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOvRI-00000008bkx-0R1N;
	Thu, 05 Nov 2026 11:15:28 +0000
Received: from ns3.kot-begemot.co.uk ([31.70.137.218])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOvRE-00000008bk3-2WaB
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 11:15:27 +0000
Received: from [192.168.19.6] (helo=jain.kot-begemot.co.uk)
	by ns3.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xOuvl-0000000173y-1bb2;
	Thu, 05 Nov 2026 10:42:53 +0000
Received: from terribleterror1.kot-begemot.co.uk ([192.168.12.4])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xOupF-000000000uy-3H6H;
	Thu, 05 Nov 2026 10:42:52 +0000
Message-ID: <e18ba080-20e9-43f2-9e0e-982031e54571@cambridgegreys.com>
Date: Thu, 5 Nov 2026 10:42:49 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: Possible underflow and races fixes
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at, mst@redhat.com
References: <20261021130648.3373281-1-anton.ivanov@cambridgegreys.com>
 <635ef2ffdf7c77a35a3c32e5c569b8e46efb9ac0.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <635ef2ffdf7c77a35a3c32e5c569b8e46efb9ac0.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_031525_196173_DB8F000D 
X-CRM114-Status: GOOD (  11.77  )
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 03/11/2026 09:41, Johannes Berg wrote:
> On Wed, 2026-10-21 at 14:05 +0100, anton.ivanov@cambridgegreys.com
> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> Michael S. Tsirkin while working on net virtio checksum hardening
>> discovered a number of issues in the uml vector driver. This patch
>> addresses these issues.
>>
>> 1. Use of header_size, not rx_header_size in some of the runt/underflow
>> checks. IPV6 raw socket API for protocols like GRE or L2TPV2 is asymmetric -
>> the header format and size in recv and send differ. All rx checks must use
>> the rx specific size.
>>
>> 2. Vector reuses rx and tx queue locks for stats. These queues are not
>> always allocated as some transports do not use them and they can be
>> disabled on the kernel command line. Resetting or accessing ethtool stats
>> in this case could lead to a null pointer dereference.
>>
>> 3. virtio_net_header processing was not up to date with all the GSO
>> additions and changes and was skipping necessary processing.
>>
>> 4. Missing barrier in vector_send().
>>
>> 5. Incorrect timer destruction in net_close()
> 
> This doesn't apply, could you resend it?

Sure, I will try to get around to it before the end of this week.

> 
> Thanks,
> johannes
> 
> 


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661


