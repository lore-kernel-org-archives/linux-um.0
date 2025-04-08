Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76D3C3600C
	for <linux-um@archiver.kernel.org>; Tue,  8 Apr 2025 04:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bwkiWIhCqcHRhh2byO+xlA819heH6mmGnapUcjYd90c=; b=rbPxCc0aDAZ3X+xFREpX7OUL+t
	sIJS2gYS37as8eTIiMSbE4EGrlk8Ml/lb2oPrGC9kAikV4p2dyp8NNiVqUOM4T26q0MfAAb4m92pz
	SJ92KAjMPZNRdde8QwKrMSpWtubXJBFNrtSqJZZPmqVV3WoCj9rJ1DVBJFHd9+jpV9qkNKs8ypImT
	wPw57EfTriGK1YQh+2Sz6pz5oJhf8Px0YXXykHkVXdG7C4+q163weEcRYun/1sJ2pbAZ3NlDkYZYg
	ohfIuIp5Ok3pcg8ZWBODu4FL24pJ+9xn6ZlmtkOWYjN+llJ8heP0SjgcdWYNC/oiNfMIVQcf1vV48
	MrCpWcSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20hI-00000002hcz-0ACa;
	Tue, 08 Apr 2025 04:36:28 +0000
Received: from out0-215.mail.aliyun.com ([140.205.0.215])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20hE-00000002hcb-3Xw3
	for linux-um@lists.infradead.org;
	Tue, 08 Apr 2025 04:36:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1744086982; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bwkiWIhCqcHRhh2byO+xlA819heH6mmGnapUcjYd90c=;
	b=swESqnMzlMGyj1Mwdnd5wt+MEgfkDUBj7Bc4EDMeVVrP1mYqLDWX3D5e5nMcV2zVFtpgJYp6ZnT/DYQrdOLhjpvdnAe7Xa1QPqMsrgCgmBXyvKEv8oirFFLDcQgWjW7ykItl3C/E1AHo5eR7U++1+lfcpv/kCXiUKC8zNyAs3YY=
Received: from 30.174.97.68(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cGaosiy_1744086978 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 12:36:18 +0800
Message-ID: <ab2a3e64-b8ef-4e27-9d73-3b08b4364528@antgroup.com>
Date: Tue, 08 Apr 2025 12:36:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.14 26/31] um: Rewrite the sigio workaround based
 on epoll and tgkill
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 benjamin.berg@intel.com, linux-um@lists.infradead.org
References: <20250407181054.3177479-1-sashal@kernel.org>
 <20250407181054.3177479-26-sashal@kernel.org>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20250407181054.3177479-26-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_213625_076667_7AC9B94D 
X-CRM114-Status: UNSURE (   7.53  )
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

On 2025/4/8 02:10, Sasha Levin wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
> 
> [ Upstream commit 33c9da5dfb18c2ff5a88d01aca2cf253cd0ac3bc ]
> 
> The existing sigio workaround implementation removes FDs from the
> poll when events are triggered, requiring users to re-add them via
> add_sigio_fd() after processing. This introduces a potential race
> condition between FD removal in write_sigio_thread() and next_poll
> update in __add_sigio_fd(), and is inefficient due to frequent FD
> removal and re-addition. Rewrite the implementation based on epoll
> and tgkill for improved efficiency and reliability.
> 
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> Link: https://patch.msgid.link/20250315161910.4082396-2-tiwei.btw@antgroup.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/um/drivers/random.c       |   2 +-
>  arch/um/drivers/rtc_user.c     |   2 +-
>  arch/um/include/shared/os.h    |   2 +-
>  arch/um/include/shared/sigio.h |   1 -
>  arch/um/kernel/sigio.c         |  26 ---
>  arch/um/os-Linux/sigio.c       | 330 +++++----------------------------
>  6 files changed, 47 insertions(+), 316 deletions(-)

Please drop this patch. Thanks! Details can be found here: 

https://lore.kernel.org/linux-um/ffa0b6af-523d-4e3e-9952-92f5b04b82b3@antgroup.com/

Regards,
Tiwei

