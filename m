Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A865FF8868
	for <linux-um@archiver.kernel.org>; Mon, 27 Apr 2026 15:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:From:To:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gVvvrToxQqoJufgR7errHzdr6gRD4YiekKmFkYtyriA=; b=ZHBicLARV/3F8BHHGFJyJlSsrN
	DRZhu1TjfEb+mXPl88PjS6DPIbWnbvxvHKcC0qEJjgOlGLHv7+nyUlFJ07rT5ce+XjRN7m1W8mNHw
	DfFijT6hnH38cRVJUMLU/Lxr/EbO2Zmx7/CEHw8YgMnZ2Ylq7dlSg0YMs/fvMhCZ62eNzYiQVLorE
	DbazpIBxZeXVujAm6HT3V7JaqxhC4w1ryf5RkTcsrIXjeXhssTKtj4HrdCJSsA9GB7g2BwpzZVW4F
	6khOXX2x0QO39P+Z/bH082zOCusmrzIuy9SRVyHg5N33JnE6Y6NowyLEC7Cmi6pkhJHkKXCA2eemU
	yZzznuEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHNaj-0000000HAVI-0z49;
	Mon, 27 Apr 2026 15:09:45 +0000
Received: from mail-43167.protonmail.ch ([185.70.43.167])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHNag-0000000HAU9-42Uz
	for linux-um@lists.infradead.org;
	Mon, 27 Apr 2026 15:09:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1777302578; x=1777561778;
	bh=gVvvrToxQqoJufgR7errHzdr6gRD4YiekKmFkYtyriA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cRauntOPOyLyqd9A2Sd8xrSSFmnl1rnXJ5FFoXBvSMl0fjOt0vm6A6n1jMZl0o7Bp
	 TGLda3EoUpDWjhqeOQLtlr8W/k2yxor6ojYja2bSO8Ymtaq7EwATT2hSoSuQtkiYgk
	 PrJvaiRzlQHts+R+hHjmEbCVBNlkxOFhX/rTtRVsqVfKMAd/KYgQZ/BKJhMskm8hNc
	 qCjtszy1zk6Ov5ODkIITsgBB+MT/X73ERHmCV5Y4S/VUpX62h24dy8HK8pX4g87+II
	 jTqvPpbbgFCW5b9/Vi4RnUMhZRHDyOtFA6k0ohkZV0Pta3oEwCycKe0IoniDRfa1GP
	 Svd3iSczo0DDQ==
Date: Mon, 27 Apr 2026 15:09:32 +0000
To: "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
From: DaisyTheFoxxo <DaisyTheFoxxo@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [BUG] Missing strrchr definition in arch/um/drivers/
Message-ID: <GD6v0oPNvpWw7s3M_TdUNhVQgATrkPoUmI1CWAdTpUPLAC_G6e3-sROgIQe8nJ88-SCtTQh9iqxEiEYdA_8p-y4TXPimjSk_rtKUROIHCtA=@proton.me>
Feedback-ID: 137668501:user:proton
X-Pm-Message-ID: acccee6e87e616ba8c5261d8fb5cad9b524737e7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_080943_600025_A2B1EE3C 
X-CRM114-Status: UNSURE (   2.54  )
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

The following error occurs when building with a x86_64 defconfig

In file included from /usr/include/features.h:540,
                 from /usr/include/sys/types.h:25,
                 from ./arch/um/include/shared/user.h:24,
                 from <command-line>:
arch/um/drivers/cow_user.c: In function =E2=80=98absolutize=E2=80=99:
arch/um/drivers/cow_user.c:156:17: error: implicit declaration of function =
=E2=80=98strrchr=E2=80=99 [-Wimplicit-function-declaration]
  156 |         slash =3D strrchr(from, '/');
      |                 ^~~~~~~
arch/um/drivers/cow_user.c:17:1: note: =E2=80=98strrchr=E2=80=99 is defined=
 in header =E2=80=98<string.h>=E2=80=99; this is probably fixable by adding=
 =E2=80=98#include <string.h>=E2=80=99
   16 | #include "cow_sys.h"
  +++ |+#include <string.h>
   17 |
arch/um/drivers/cow_user.c:156:15: error: assignment to =E2=80=98char *=
=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a c=
ast [-Wint-conversion]
  156 |         slash =3D strrchr(from, '/');
      |               ^

