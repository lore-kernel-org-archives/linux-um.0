Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910B5C369D1
	for <linux-um@archiver.kernel.org>; Mon, 28 Apr 2025 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HB6UU5yogU94k7DhWu7jwtheEUAsHOd7Ikdt+ACpxrA=; b=IM9zneNIj6YxdevW+EmprXlsor
	JhVu/6luNIZwnh34XtwqIC/XjLZ1keLEAyxiMCtWWxzBJggahjptM/mQTyB+XxDtVV+VIf6nVQ3gW
	0kvpX05q4Ck2gqcqP1b8EEN8CWzEUz411xGllYwkenITpnk6B5I7nnylxb36jdLEDESiu7ao56BsY
	LB7V5EhllqvKUPiAoum6VEre2j4N/YSZAhwvPCXe2aw4RZLOXz6GVoG9jU2ao+2k4d//pVuKbWrua
	xwPqErwJurEgH7EniOMLXRM1JwvWCk6FCXWG+ZMUk8GBGqR6LvuAs8zCtf1WB3fonQZQ/5+IPagUC
	yk/5bLcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Bv8-000000049Um-3VjL;
	Mon, 28 Apr 2025 00:00:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Bv6-000000049Uc-27Tr
	for linux-um@lists.infradead.org;
	Mon, 28 Apr 2025 00:00:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8DAC661135;
	Sun, 27 Apr 2025 23:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC53C4CEE3;
	Mon, 28 Apr 2025 00:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745798422;
	bh=IU7HSUz+UthbAhhEiD8ZYvTSvQYphVH7wCBb1yhsLQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=toQxu9oOpoZ2jxuhyxYqhFAv/OeiU6bydfBfy5nkt93/5a/lXDWuLb0ZavnBmXNhh
	 jgFLlKoazsLK/L1H68iK8iuXOfVeMI2S3tMLp73haqwPfxYWxT4gLYLvCeQF9CmXwA
	 Qt4jUOxqZIhG8gM4DJZ8jmxnvgvNo5hRslkrmhBoEv6fp/2jWdukpaQxncgqkaxkl6
	 vT2bYqcMqM2ChPCPQuNYypyNYcejXTtiNMmlgTMy96cmCuiO3ZhAUi/sl2J/kj1AIs
	 YIEDDMWelNMWfu/gXWSz07QTBBfWGRfZN/ArNH3XjenU3n+DvMQkSm+B1wSkcEkKa9
	 5etLPvEUCiWTQ==
Date: Sun, 27 Apr 2025 20:00:21 -0400
From: Sasha Levin <sashal@kernel.org>
To: Tiwei Bie <tiwei.btw@antgroup.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	benjamin.berg@intel.com, linux-um@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.13 23/28] um: Rewrite the sigio workaround
 based on epoll and tgkill
Message-ID: <aA7FFcn6gjIC8jCe@lappy>
References: <20250407181224.3180941-1-sashal@kernel.org>
 <20250407181224.3180941-23-sashal@kernel.org>
 <621e867f-5427-4062-8783-e474e3dcdb3f@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <621e867f-5427-4062-8783-e474e3dcdb3f@antgroup.com>
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

On Tue, Apr 08, 2025 at 12:38:12PM +0800, Tiwei Bie wrote:
>On 2025/4/8 02:12, Sasha Levin wrote:
>> From: Tiwei Bie <tiwei.btw@antgroup.com>
>>
>> [ Upstream commit 33c9da5dfb18c2ff5a88d01aca2cf253cd0ac3bc ]
>>
>> The existing sigio workaround implementation removes FDs from the
>> poll when events are triggered, requiring users to re-add them via
>> add_sigio_fd() after processing. This introduces a potential race
>> condition between FD removal in write_sigio_thread() and next_poll
>> update in __add_sigio_fd(), and is inefficient due to frequent FD
>> removal and re-addition. Rewrite the implementation based on epoll
>> and tgkill for improved efficiency and reliability.
>>
>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>> Link: https://patch.msgid.link/20250315161910.4082396-2-tiwei.btw@antgroup.com
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  arch/um/drivers/random.c       |   2 +-
>>  arch/um/drivers/rtc_user.c     |   2 +-
>>  arch/um/include/shared/os.h    |   2 +-
>>  arch/um/include/shared/sigio.h |   1 -
>>  arch/um/kernel/sigio.c         |  26 ---
>>  arch/um/os-Linux/sigio.c       | 330 +++++----------------------------
>>  6 files changed, 47 insertions(+), 316 deletions(-)
>
>Please drop this patch. Thanks! Details can be found here:
>
>https://lore.kernel.org/linux-um/ffa0b6af-523d-4e3e-9952-92f5b04b82b3@antgroup.com/

Dropped, thanks.

-- 
Thanks,
Sasha

