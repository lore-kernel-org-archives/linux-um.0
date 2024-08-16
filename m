Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5F2C3DA4A
	for <linux-um@archiver.kernel.org>; Fri, 16 Aug 2024 07:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LExdO87mry8HyL7SOp36JtNIHE4EzuqTMVIvTdhoH/s=; b=G72hbP/gu+Vwc/1sIpVBb1KYl8
	JkN06DDFP0T+Ss+d/8LoiD+hWRA6h6eXpFF546QWSvv5Ex/E7qKBVjiyptk6GnKsefAMGdEyByfPL
	N3+3vRB2Jz1VFWsipAjdxDbQ2G+6/XX2N/QEupGtCSIkWGDkEPE8AtJibqdtYn6zgL9sy86/0NUyp
	QvtuxP86wDYNhu471HF08IvIH9xWumdSUX4FzE29yf1uUxem4N0i2+U/xCY9ag7QeEYbLFyrAPqgZ
	bhDNb/twbZEliDOhCxj8nAkUedJWke+Pdl/E5INjAHpk00yLiBADFamJCRiltK1ZyJtLRHXAjIl6p
	6F/QGC0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1serqt-0000000CCRG-0lXV;
	Fri, 16 Aug 2024 07:58:27 +0000
Received: from out0-200.mail.aliyun.com ([140.205.0.200])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1serqo-0000000CCOz-3INV
	for linux-um@lists.infradead.org;
	Fri, 16 Aug 2024 07:58:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723795099; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LExdO87mry8HyL7SOp36JtNIHE4EzuqTMVIvTdhoH/s=;
	b=1FkPMHXFeKGntzCGMm5M8C3dQf1dp/Xo7ueXcW/qpA90TE+L+rzkjo47s3zLApaw0ht2PDr9N8YZg+qH4jN7UhfJMPsDOy2TbUhg+/8dd4WneGTaO7QP+MCCfBNpyxqwtcu+jYW0PnQYFh6cHtmiemwZPPbOzN2Tlu/PTBXqOh8=
Received: from 30.236.48.76(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ytc8sKJ_1723795088)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 15:58:16 +0800
Message-ID: <8caaf7d5-a0a0-4888-b467-d8fc84830f8a@antgroup.com>
Date: Fri, 16 Aug 2024 15:58:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] um: Remove unused mm_fd field from mm_id
To: Benjamin Berg <benjamin@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240816015447.320394-1-tiwei.btw@antgroup.com>
 <20240816015447.320394-5-tiwei.btw@antgroup.com>
 <3be8448cfb2aeb39e0e73856a701101dc8a0f04f.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <3be8448cfb2aeb39e0e73856a701101dc8a0f04f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_005823_334527_7AE9FB9A 
X-CRM114-Status: UNSURE (   9.49  )
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

Hi Benjamin,

On 2024/8/16 13:59, Benjamin Berg wrote:
> Hi Tiwei,
> 
> On Fri, 2024-08-16 at 09:54 +0800, Tiwei Bie wrote:
>> It's no longer used since the removal of the SKAS3/4 support.
>>
>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>> ---
>>  arch/um/include/shared/skas/mm_id.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/um/include/shared/skas/mm_id.h
>> b/arch/um/include/shared/skas/mm_id.h
>> index 1e76ba40feba..b3571a8afec9 100644
>> --- a/arch/um/include/shared/skas/mm_id.h
>> +++ b/arch/um/include/shared/skas/mm_id.h
>> @@ -8,7 +8,6 @@
>>  
>>  struct mm_id {
>>  	union {
>> -		int mm_fd;
>>  		int pid;
>>  	} u;
>>  	unsigned long stack;
> 
> Maybe we should also remove the union here while at it? It is pretty
> pointless after all.

That makes sense. Will do. Thanks!

Regards,
Tiwei

> 
> Benjamin


