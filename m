Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1269ECEB2C7
	for <linux-um@archiver.kernel.org>; Sat, 15 Nov 2025 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfm+MQXULvTpw1aaUw2GJFWd+i9+TwJ4lZKozAzdhws=; b=2lsnBokSY0e0yiJkqZU9LjNvNE
	+sj/ZjeIMtKa6VTWvu/RC8cxlHizdONTs9AojU00R8T7TCnVqrGxsf7JyRXIXB6cdMvmGaU+VcHE9
	zjgv9qeBWbS1d24sP18g5sIXY7cy179kZpmZLcU4/95lkbzm5YfbKUoMcnkxtMp+1cnXlW4d4sFEJ
	Iw7fN9mCVlkTtajJgTxeqkq3KSZRNPyBNMZ/wVcvlzL7wkMGH1OdUMYfAp5rlAHPVdW1riC/D6LKH
	dOHrOd/KompzCAN9fLX5YlVcHyJ8FpGkSEDAOyjuxi6SnKelruu3o0U1i7syb9pw/h0rAoKhNd12B
	NRui6lXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKCI4-0000000Dd3j-2Dr1;
	Sat, 15 Nov 2025 09:09:52 +0000
Received: from out-187.mta1.migadu.com ([95.215.58.187])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKCI1-0000000Dd2w-3gEA
	for linux-um@lists.infradead.org;
	Sat, 15 Nov 2025 09:09:51 +0000
Message-ID: <f7bd2dc1-e7a5-4e80-9cad-2acac8065876@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763197777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfm+MQXULvTpw1aaUw2GJFWd+i9+TwJ4lZKozAzdhws=;
	b=M/YUuAH3IyWhHYn5ZNYhvN1s6M7xHKp63PCRpmUrEKXu53qQ1HuLBjIKdBsHH7i0tHGrO2
	MjXPtZjS13xHfyK5QioHDDtwAUCXkyGqTgTAJkTaZnWGxD0YWfwq7kF4quaoj4fCBUjoDA
	i6LWMMM3rWw68vjk72a2dDN7mW73xXw=
Date: Sat, 15 Nov 2025 17:08:35 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] arc: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Vineet Gupta <vgupta@kernel.org>, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 dev.jain@arm.com, akpm@linux-foundation.org, david@redhat.com,
 ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <6a4192f5cef3049f123f08cb04ef5cd0179c3281.1763117269.git.zhengqi.arch@bytedance.com>
 <5199c367-aabb-43e7-951e-452657dcdddc@linux.dev>
 <4e120357-6fa3-436a-8474-b07b473381b6@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <4e120357-6fa3-436a-8474-b07b473381b6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251115_010950_068302_F4838E64 
X-CRM114-Status: UNSURE (   5.16  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 11/15/25 7:10 AM, Vineet Gupta wrote:
> On 11/14/25 03:20, Qi Zheng wrote:
>> Strangely, it seems that only ARC does not define CONFIG_64BIT?
>>
>> Does the ARC architecture support 64-bit? Did I miss something?
> 
> ARC is 32-bit only !

Got it! Will drop this patch in the next version.

Thanks!

> 
> -Vineet


