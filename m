Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66AFC2BD09
	for <linux-um@archiver.kernel.org>; Mon,  1 Jul 2024 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3wS+qrvaAhLSvVTzV8yxDFdWOCdtsyH1a/2aYfgLHhM=; b=E9QfT6PD4OxEj+0J0SFVvmBZA7
	648SxrsBFo776tG6f0Ng0jCI600mXfbnjz2WhCFRx8wUN32xQu/0YfKqf6suytiPXkYxN0S5MP6Nn
	D1SOsEuiLQLyY819RHWmz4Nq3Ca0z2LKcgfN3ipjHVejQWNVnB88QE+SPEJjodsq22L9V7ItnTNtO
	/VE3jOgg911S0l2byT5AUDlB4z5SNhjVU96ni8720t5tflgMrXunJodLOix1pR8SDxRbNVxNgGgSN
	5BufgMSz/lLg7WZxAjtmWlOrvZ+tyvCNmk0zexKe215hpuzzrCFaSvwk6k0iZiw6aWM729aL5s4Rd
	y1k1SjcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOMRT-00000004ad2-0xzS;
	Mon, 01 Jul 2024 19:11:59 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOMRQ-00000004acA-0MsY
	for linux-um@lists.infradead.org;
	Mon, 01 Jul 2024 19:11:57 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sOMRN-005RPu-6x; Mon, 01 Jul 2024 19:11:53 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sOMRK-00HUPL-2A;
	Mon, 01 Jul 2024 20:11:52 +0100
Message-ID: <87e4cf72-bcb7-4072-b033-c99a02cc0834@cambridgegreys.com>
Date: Mon, 1 Jul 2024 20:11:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] um: Enable preemption in UML
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at
References: <20240403062754.124752-1-anton.ivanov@cambridgegreys.com>
 <6969757a8347ad5171a651fb668a28613b08176d.camel@sipsolutions.net>
 <4137d6ba7d380fed13f8edc1147211b4511e8bfb.camel@sipsolutions.net>
 <c6056c4a2d1cb549ae2c0b010de912e8ff38ec8f.camel@sipsolutions.net>
 <733d5ed2-d085-4422-9d46-4c14426f56c4@cambridgegreys.com>
 <f66a4586fdf321bf8778698d49b2629bdc0bb8c2.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <f66a4586fdf321bf8778698d49b2629bdc0bb8c2.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_121156_160791_68CBA21B 
X-CRM114-Status: UNSURE (   8.50  )
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

On 01/07/2024 20:09, Johannes Berg wrote:
> On Mon, 2024-07-01 at 19:55 +0100, Anton Ivanov wrote:
>> As Benjamin pointed out we no longer need this, so we can junk this
>> patch at this point. If there will be any need to save/restore FPU in
>> kernel context, I will revisit it.
> I think we still want/need the parts with the preempt_disable/enable,
> and Kconfig though?

Good point. I can do a cut down version.

>
> johannes
>
>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


