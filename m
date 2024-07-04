Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA03C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 06:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1CUmPwgpkcdPIvSRS1FXg032VtcprrPeQo1W0CJbMs0=; b=DU6KlMwNMiPC7CxXJVNEVSFoqD
	kubAEodpeBwh40WYMApZpxBfzB9+ly6KM1HG4PPWxspONHJfL/Za3r1l5DgMz4L1MMwW2lquqnkg7
	Zxadip9Hh5zb62ryUnbMMzURQhnmEQsWNUM6QvrJPbydawFg8Q+Tn5ZUC4MO4USzRGasCW3PP6OiK
	Xztto/lMl0PeqMlCmuGjYrSWDMqxsNae7UHX9G9CGhT08vIS5Bz4JHkyxNWgL0I7M/FqSpuw0Vxwm
	/ntnN/9oRWPS8kw5bbXgMa1RUejdXhGOd3s2O9h4adpHfaxuRuCh7NLVQ6TyqGnDlhBdMgiFYTYXl
	iFjiy82Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGPn-0000000COoW-3CHK;
	Thu, 04 Jul 2024 06:57:59 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGPj-0000000COnv-3J5L
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 06:57:57 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPGPf-005c6W-UN; Thu, 04 Jul 2024 06:57:52 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPGPc-0079I9-2C;
	Thu, 04 Jul 2024 07:57:51 +0100
Message-ID: <63793346-1f35-4789-8b41-0e280aa8c4fa@kot-begemot.co.uk>
Date: Thu, 4 Jul 2024 07:57:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: remove pcap driver from documentation
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20240703172013.c3232dc5cbe9.I7f9941095d45a39d0f1e83680a408b3c6d445242@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20240703172013.c3232dc5cbe9.I7f9941095d45a39d0f1e83680a408b3c6d445242@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_235755_861949_6463A1BB 
X-CRM114-Status: GOOD (  10.41  )
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



On 03/07/2024 16:20, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> We just removed the driver, but forgot the row in the
> documentation table mentioning it. Remove that.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index d1cfe415e4c4..27942446f406 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -223,8 +223,6 @@ remote UML and other VM instances.
>   +-----------+--------+------------------------------------+------------+
>   | socket    | legacy | none                               | ~ 450Mbit  |
>   +-----------+--------+------------------------------------+------------+
> -| pcap      | legacy | rx only                            | ~ 450Mbit  |
> -+-----------+--------+------------------------------------+------------+
>   | ethertap  | legacy | obsolete                           | ~ 500Mbit  |
>   +-----------+--------+------------------------------------+------------+
>   | vde       | legacy | obsolete                           | ~ 500Mbit  |

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

