Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30886D690EF
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 08:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XKEGFG8+w9WlJCUH/FgkbRKeopIg1n27vSxZREUm2aQ=; b=SbXejcSF3i4HstATe6wsNtUjf9
	AGqZ4otkq19X2wt4gCNjkQdoxUCP/6Wx3m+XGwrCPNIreUej7dGuKgWzNhDZx0R2zwo+KnLq6vbX4
	V1y4qkEOO59sOFSYzubWZP+WT7gBIIj8Rvlr654FshY8L+0vTlbQxeEFcUAaoKhg5nt2l0Sowh0YZ
	SXXINtkTaZqd3aBUJY7CBqsnuXNRCwelMT2nKcDHHYKhQKcrC6mWIbQQWCf6Fc2Y27fEmWQa+3eg0
	sim9loaT6Syx2kle6G6gtPkKbMt6kDaDrl+posux+alFAWAT5QceoaX80qjIZDAqyJb3pVXZxJNWY
	aPaxvJEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZxF-0000000F0vj-3pWZ;
	Thu, 28 Nov 2024 08:32:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwW-0000000F0pp-2kt5
	for linux-um@bombadil.infradead.org;
	Thu, 28 Nov 2024 08:32:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=XKEGFG8+w9WlJCUH/FgkbRKeopIg1n27vSxZREUm2aQ=; b=o30KFDe9S6UqzRv2dc3aQKvYYK
	CVSE/4FmciD5DQfCw8LLwxJ78wTOlP4vJJiMeRGf0pJx/QLqcDc74i+5zr6Mb9cCl0Pjtlzu+IXHh
	3Sz9I3E/SjKoFwhLNwJPZSdCWcPSlFb53VIEJwtZ8ecs+VVQx9gpwOXccaSDcRRbZduACDcBa2+qd
	8JUFj4EYeh+YfS4olGkqLnYsj3V7KcZu+UkWqVvKnMY7qpoXFd34uV2WhgSENJns/QW8B8iTWycjZ
	+jou7C2S6By/xiroK34oUWF4gK48gayF02NnvDy6KMT57YqlF/dxN9RnPTAKT8hxxJvIVQz4YrGnl
	c+wAFDpQ==;
Received: from out0-198.mail.aliyun.com ([140.205.0.198])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwQ-00000001Yhk-2Yok
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 08:32:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1732782708; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XKEGFG8+w9WlJCUH/FgkbRKeopIg1n27vSxZREUm2aQ=;
	b=f4HBPvKrXweOBqGHzhaUAt432xsdeN7IBLtoLsr04SY0rOaKQaoNvnhWnNL42Dp/3DmNTE/0YsypXFFr+gKO7ej1OFRwIXle26NsaUwz2ruXLi+jrxRFsywU1IQQo8aaX1zRnVbJHeq4CbnoaNMk87igeGRj0O/cUjbtsvFq0ZA=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.aP07WUS_1732782706 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 16:31:47 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/9] um: Mark parse_cache_line as __init
Date: Thu, 28 Nov 2024 16:31:30 +0800
Message-Id: <20241128083137.2219830-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
References: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_083203_019894_EC111024 
X-CRM114-Status: UNSURE (   6.29  )
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

It's only invoked during boot from get_host_cpu_features().

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/um_arch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index c5e91d3fb64e..852267542a06 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -272,7 +272,8 @@ static void __init parse_host_cpu_flags(char *line)
 			set_cpu_cap(&boot_cpu_data, i);
 	}
 }
-static void parse_cache_line(char *line)
+
+static void __init parse_cache_line(char *line)
 {
 	long res;
 	char *to_parse = strstr(line, ":");
-- 
2.34.1


