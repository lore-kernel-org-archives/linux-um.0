Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CEDCFD2EC
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 08:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jbUKc6F/J3c7TwVoue/wpb5nObs9+8cJPZcz26Dn+Sw=; b=o/puUxlPkPogfZgdknp4xHW7X5
	xi3niM3L1NjMRqKrqBBcg4Dobe9VtXPrvk6FnV1eC0S+IXvN1Kp9zhosvDYmOQc3g+MqQakwG1Nm5
	TDgy71jgeP0f+y9boiPyl8f3KJ/fOrCy5yeTRw46DteoyFNXxivp18jAfvl5CUZcfk5+LBkXehp+f
	7l+8ZZELu0h8FByZ3z3PHGGa3fTHn4wpMsIEym4WeH9V/BFQnC0wfMrxSiyYd1wzRIHVcBeQ38/rP
	Vv4N7Pg4dRslI4w2X3yCzr8Fs1IEQa/uizij2dEy4C+sqj3f9vCqWeMJVVwVJeMxq50fd8v0l1oBi
	8vyBTFJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szBPP-0000000Fk8X-3XZ3;
	Fri, 11 Oct 2024 08:54:03 +0000
Received: from out0-207.mail.aliyun.com ([140.205.0.207])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szBP6-0000000Fk4A-42qP
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 08:53:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728636822; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jbUKc6F/J3c7TwVoue/wpb5nObs9+8cJPZcz26Dn+Sw=;
	b=M/iauj6+H2D0S1HWe2uq8GqsDabNL7UzpbV6waqxXW0E7i576cnwVEYsBe0qGh7Mt4tj1UUYxhhqjKw2BygFqEihznQIB305/0t35RgwSDnYPUpwHQ/uycmzxAhteUIZXJKb768sV6oJH7tgvcMhoaWqNLWzp6jVrlrUF+t+d5M=
Received: from 30.121.32.252(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZeQkkfa_1728636820 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 16:53:41 +0800
Message-ID: <fcaa6038-33dc-44a9-ab23-ac2309eeef4d@antgroup.com>
Date: Fri, 11 Oct 2024 16:53:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Abandon the _PAGE_NEWPROT bit
To: Benjamin Berg <benjamin@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241011053843.1623089-1-tiwei.btw@antgroup.com>
 <6abc79186ace90cd2abe202a4abe0eaf17eebb5f.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <6abc79186ace90cd2abe202a4abe0eaf17eebb5f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_015345_195405_8B29CAD1 
X-CRM114-Status: GOOD (  11.45  )
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

Hi,

On 2024/10/11 15:39, Benjamin Berg wrote:
> Hi,
> 
> On Fri, 2024-10-11 at 13:38 +0800, Tiwei Bie wrote:
>> When a PTE is updated in the page table, the _PAGE_NEWPAGE bit will
>> always be set. And the corresponding page will always be mapped or
>> unmapped depending on whether the PTE is present or not. The check
>> on the _PAGE_NEWPROT bit is not really reachable. Abandoning it will
>> allow us to simplify the code and remove the unreachable code.
> 
> Oh, nice cleanup!
> 
> And I like that mprotect is gone as I don't want it in SECCOMP mode :-)
> 
> Maybe we should rename _PAGE_NEWPAGE to something like _PAGE_NEEDSYNC?
> I think that might make it more clear how everything ties together.

Good idea! Will do.

> 
> Anyway, the change looks good to me.
> 
> Benjamin
> 
> Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>

Thanks! :)

Regards,
Tiwei

