Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBgOW-00664O-A8
	for linux-um@lists.infradead.org; Wed, 13 Jul 2022 17:43:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C893961D0C
	for <linux-um@lists.infradead.org>; Wed, 13 Jul 2022 17:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24E6C34114
	for <linux-um@lists.infradead.org>; Wed, 13 Jul 2022 17:43:26 +0000 (UTC)
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2a01a846 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
	for <linux-um@lists.infradead.org>;
	Wed, 13 Jul 2022 17:43:25 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id y2so11532682ior.12
        for <linux-um@lists.infradead.org>; Wed, 13 Jul 2022 10:43:25 -0700 (PDT)
MIME-Version: 1.0
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 13 Jul 2022 19:43:13 +0200
Message-ID: <CAHmME9qg8QhGWX=vZFpVndhkEStL37kU4smH7myqm0OpXsLiqA@mail.gmail.com>
Subject: musl on uml - warning: relocation in read-only section `.ref.text'
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

In attempting to do a static build using a musl-based toolchain, I'm
seeing this linker error:

/home/zx2c4/Projects/wireguard-linux/tools/testing/selftests/wireguard/qemu/build/um/x86_64-linux-musl-cross/bin/../lib/gcc/x86_64-linux-
musl/11.2.1/../../../../x86_64-linux-musl/bin/ld: init/main.o:
warning: relocation in read-only section `.ref.text'
/home/zx2c4/Projects/wireguard-linux/tools/testing/selftests/wireguard/qemu/build/um/x86_64-linux-musl-cross/bin/../lib/gcc/x86_64-linux-
musl/11.2.1/../../../../x86_64-linux-musl/bin/ld: read-only segment
has dynamic relocations

Wondering if anybody else has seen this with musl.

Thanks,
Jason

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

