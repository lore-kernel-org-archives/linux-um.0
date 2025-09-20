Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85329CAC5A0
	for <linux-um@archiver.kernel.org>; Sat, 20 Sep 2025 09:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R8dIGGEbQ4Q0r8Zo2e/LChxljiPvbRcBQuQeTR9qt8Y=; b=Kmj3gEPCbrREEIcTUg9pCZfPdw
	D5N+y7IHglNBsLW4clqWeBUywoCg3+W5uyVbPVPQrUys/LZZyxanq9jWtpPoDL91BfC8I6+Usv/+k
	MOIRD8BF6tKsDhyP4Rr4LlKyCgh6R18UNZp4eyt65Ai1N/JoQBo8Y5pQqEGOZrqIzIaKCfz/mX5Zs
	7y9yzhCqDeGzw1Tt9bX/uJJN7LqqQA92LPBzc5cXqgiJ1SgOs4wO82CJHDp56RcK1BXAxhCdpyDWa
	0K4DQqfkZQCxdyotfPt8vFVYOmdWf2Chm0GanYUPDoiRep29jlpuZNa8cqyr/759BJd4z6R/8RS/B
	/DmcJXlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uztcx-000000055e5-4C6x;
	Sat, 20 Sep 2025 09:11:32 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uztcv-000000055da-41GS
	for linux-um@lists.infradead.org;
	Sat, 20 Sep 2025 09:11:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758359487;
	bh=3WAm0SLhLHMv/JU4T0KOsCjhyX6J08SpFwvph0fLhPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+6HYi+333nAYDy59V1pVKyXAMzfnN16PVy/gW8lCKsqXAZEfVBCY6QJ0qZ6ecczk
	 0KIGcdAF2lh7M9aiv+/vL9/eq8EGmeV2Dv8noSU9p8YHnvaCKrKNjns6L/olvXl7ET
	 3ah8nnNoonfLSRBpcLeEDe/mM1ITdzUJ+yXzfpzA=
Date: Sat, 20 Sep 2025 11:11:24 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 09/11] tools/nolibc: add uio.h with readv and writev
Message-ID: <ac0968cb-c019-425d-928d-b163120a002d@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-10-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919153420.727385-10-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_021130_153517_FA0DBFAE 
X-CRM114-Status: UNSURE (   8.77  )
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

On 2025-09-19 17:34:18+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> This is generally useful and struct iovec is also needed for other
> purposes such as ptrace.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/include/nolibc/Makefile                |  1 +
>  tools/include/nolibc/nolibc.h                |  1 +
>  tools/include/nolibc/sys/uio.h               | 49 ++++++++++++++++++++
>  tools/testing/selftests/nolibc/nolibc-test.c |  9 ++++
>  4 files changed, 60 insertions(+)
>  create mode 100644 tools/include/nolibc/sys/uio.h

(...)

