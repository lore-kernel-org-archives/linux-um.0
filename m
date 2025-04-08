Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0AFC3600C
	for <linux-um@archiver.kernel.org>; Tue,  8 Apr 2025 04:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O8emNOLgchaMA6FNToPtETTCX+MdTAGIvuUPFGMciYA=; b=RhcHXTTXC4ux+qJCgKN+LVA5de
	yYBaEjQj3Y9hvEycXbCJdr2Ht50mZvJjpBJT8mivAFpGDF0P/7OLrWw6hCaOTR2+mx1eOwWE8tP1R
	QPyoXixSRG7w3w9rIO7ThVpf5pBxwozYBHoB+293Ym+oozrK3O7S4slvmCVwFFUXr0iI0qDLXw/wI
	GLiN4ygTMj10SrZt3w1Ro4Pm/T1vLXGYjmNoB3I6/b8ePaGTH8RQmgk74yQsELeFWFHNCAk8qfNXZ
	nAC+csPnHah6yZyPaUl5jXNi/tIrdVNLBeCGoj46oz70gaU7ujUr2RyETt2bjIWu9TTm5PP8mi55+
	psRKGC7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20ic-00000002hfj-1i26;
	Tue, 08 Apr 2025 04:37:50 +0000
Received: from out0-204.mail.aliyun.com ([140.205.0.204])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20iZ-00000002hfM-08wL
	for linux-um@lists.infradead.org;
	Tue, 08 Apr 2025 04:37:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1744087064; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O8emNOLgchaMA6FNToPtETTCX+MdTAGIvuUPFGMciYA=;
	b=kkauwTmZy9RPwWac+JchKU5C3oVLBA7xIkbosg9ULbV954Fz8LRdEtXoTK6QS2JaSRFp9h9135BpBl0B9bqQ0XEnaJDqaT65bcbaX2ho2GexQsZfnkujC9GMwmW2gpmhOPxre4cTNx7bCHsQzDVqPzxQqXEUr7b/0jDOmPepBQE=
Received: from 30.174.97.68(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cGaotJt_1744087060 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 12:37:41 +0800
Message-ID: <d9125f9e-4ec2-40aa-b186-798f53bcd2c6@antgroup.com>
Date: Tue, 08 Apr 2025 12:37:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.13 22/28] um: Switch to the pthread-based helper
 in sigio workaround
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 linux-um@lists.infradead.org
References: <20250407181224.3180941-1-sashal@kernel.org>
 <20250407181224.3180941-22-sashal@kernel.org>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20250407181224.3180941-22-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_213747_289554_34D19A9A 
X-CRM114-Status: UNSURE (   6.82  )
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

On 2025/4/8 02:12, Sasha Levin wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
> 
> [ Upstream commit d295beeed2552a987796d627ba7d0985b1e2d72f ]
> 
> The write_sigio thread and UML kernel thread share the same errno,
> which can lead to conflicts when both call syscalls concurrently.
> Switch to the pthread-based helper to address this issue.
> 
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> Link: https://patch.msgid.link/20250319135523.97050-4-tiwei.btw@antgroup.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/um/os-Linux/sigio.c | 44 +++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)

Please drop this patch. Thanks! Details can be found here: 

https://lore.kernel.org/linux-um/ffa0b6af-523d-4e3e-9952-92f5b04b82b3@antgroup.com/

Regards,
Tiwei

