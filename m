Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8628CEBF97
	for <linux-um@archiver.kernel.org>; Tue, 18 Nov 2025 06:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SW5mao1oAS7ZPY74h8nKRtOXO2UiK6ZWi1GkM3JuTbw=; b=OXBUdsIAEMKDcewiu1BLg9sETw
	6VfL2k4LW3ZB601t2v/45HLY3wi+YkEUXDU32AzHeojJ5xUxrmfMJZH0ejPxi54/xHsE6aKJjt/yF
	wSEvw3b0cMxnX7VW4T2t4Whe1yJh/IdKcc9pXMNkS5rBDR4dslSj2fnE8K5OMm8wjVBZAGc5rc//+
	b3XFao08BHpsZAzj46Hs/VbOhTV/g82teXwrrJ0xLFUPJnQ/bnYy6NV0inVqAk51+ULCajt7+3ueC
	6nZzDfti4tI4Ooc0iEwHDVq/CuWOLIzPIfsCJsDDYIyhO9OHe2U0GG91IYmeXMGIqGwl7H7e4zoZ8
	kMjSILxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLEuK-0000000HTJS-2Cwf;
	Tue, 18 Nov 2025 06:09:40 +0000
Received: from out-186.mta0.migadu.com ([2001:41d0:1004:224b::ba])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLEuH-0000000HTHc-23k3
	for linux-um@lists.infradead.org;
	Tue, 18 Nov 2025 06:09:39 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763446161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SW5mao1oAS7ZPY74h8nKRtOXO2UiK6ZWi1GkM3JuTbw=;
	b=pr0b6BONl9J93DUlw7yB7zfaY09DhaSjRb+dBBSJFGUyX9/gRWNCNeMlhtq5Ss5cHPMELc
	1wEPqMeW2L8kV/nRr3wgFglki12JTnRQKJASIy44BS1d0CqNZGNOfasqWBrkeUxHUnzt6j
	6w+QSE5TJVrVMJniYxiPsDkw5753Ekc=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: development@efficientek.com
Cc: linux-um@lists.infradead.org,
	tiwei.bie@linux.dev
Subject: Re: No more non-root networking modes?
Date: Tue, 18 Nov 2025 14:08:55 +0800
Message-Id: <20251118060855.3714863-1-tiwei.bie@linux.dev>
In-Reply-To: <20251117203131.479a1cfd@crass-HP-ZBook-15-G2>
References: <20251117203131.479a1cfd@crass-HP-ZBook-15-G2>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_220937_669093_EF1E4EBB 
X-CRM114-Status: UNSURE (   8.89  )
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

On Mon, 17 Nov 2025 20:31:31 -0600, Glenn Washburn wrote:
> Hi all,
> 
> I'm just now noticing that earlier this year obsolete networking
> transports were removed (commit 65eaac591b75). This included SLiRP,
> which was to my knowledge the only transport that supported network
> access as an unprivileged user (no privileged access needed to setup
> the transport either). Am I wrong about that? If not, I'm curious as to
> why functionality that could not be achieved by other means was
> dropped? And if there are any work arounds? I can understand why other
> transports that need privileged access to setup, but were inferior to
> other existing transports would be removed. I write this as someone who
> is currently using the SLiRP transport.

vec also supports networking without privileged access:

https://www.kernel.org/doc/html/v6.17/virt/uml/user_mode_linux_howto_v2.html#vde-vector-transport
https://lore.kernel.org/all/bfa07f4d-16a3-476b-9314-b8052ec198b1@antgroup.com/

Regards,
Tiwei

