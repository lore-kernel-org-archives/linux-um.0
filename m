Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BBBC7EE2E
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IZ0E3uTe6J6R0m/j8nnFa1b95ElxGXm9JwH2/e/K95M=; b=CW6eIeGJ/lZCY1H726/cM3le+B
	vIJIxFiPn4KSG/iTv0hJKe/j6eV/3/OXcu+U+5aOyzTRw6gB9LziMEcsXB39hpSMK2Nwv+/AubsUw
	l1RAPzMRLiCkHXDozYwfjsz9I/tJGSv6lyZfek1H1TuN/NNQloNjk7lLUiOfD/lSPmhCj3eNMVK6o
	UBTkC5h00k6kZ3p0yuDvsyOA7yBNlo0KVyrRruMnKWXbIK4Fv99MXc22q9n65kEqs4U6OC8ZjUEwt
	Pg6zhL77OIbQ4LdKgxtd0JfY1NuXWYTas+mYaLt+XFKEpHYR6tax3zb2ItBz90f5XGPz8+Vr2yzwj
	1p1wZOzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8dqk-003IeV-1B;
	Mon, 12 Jun 2023 09:28:34 +0000
Received: from michel.telenet-ops.be ([2a02:1800:110:4::f00:18])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8dqg-003Ibm-2d
	for linux-um@lists.infradead.org;
	Mon, 12 Jun 2023 09:28:32 +0000
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:8f41:e69:ef53:9db3])
	by michel.telenet-ops.be with bizsmtp
	id 89UQ2A00B41JBE4069UQnQ; Mon, 12 Jun 2023 11:28:24 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1q8dqa-008cV2-D4;
	Mon, 12 Jun 2023 11:28:24 +0200
Date: Mon, 12 Jun 2023 11:28:24 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: linux-um@lists.infradead.org, linux-spi@vger.kernel.org, 
    linux-mips@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.4-rc6
In-Reply-To: <20230612090911.1579029-1-geert@linux-m68k.org>
Message-ID: <9c7f3e17-c1-1a3a-7e87-9b1ea25d9d7@linux-m68k.org>
References: <CAHk-=wgmbjQu3bVSa5JJhEymeQhkr7N3cjg-CoNLVituUnfW8w@mail.gmail.com> <20230612090911.1579029-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-85567032-1686562104=:2054603"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_022831_017577_7844AC1F 
X-CRM114-Status: GOOD (  14.98  )
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-85567032-1686562104=:2054603
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 12 Jun 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.4-rc6[1] to v6.4-rc5[3], the summaries are:
>  - build errors: +5/-6

   + /kisskb/src/drivers/spi/spi-stm32-qspi.c: error: ‘op’ is used uninitialized [-Werror=uninitialized]:  => 523:27, 564:27

um-all{mod,yes}config

Seen before
(why did the type of quotes around 'op' in the compiler output change?)

   + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: field ‘call_clobbered’ has incomplete type ‘pt_solution’:  => 284:22
   + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: field ‘call_used’ has incomplete type ‘pt_solution’:  => 283:22
   + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: ‘gimple_call_addr_fndecl’ was not declared in this scope; did you mean ‘gimple_call_set_fndecl’?:  => 2790:10
   + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: ‘is_gimple_reg’ was not declared in this scope; did you mean ‘is_gimple_assign’?:  => 2556:18

mipsel-gcc5/mips-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/858fd168a95c5b9669aac8db6c14a9aeab446375/ (151 out of 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9561de3a55bed6bdd44a12820ba81ec416e705a7/ (151 out of 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
--8323329-85567032-1686562104=:2054603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--8323329-85567032-1686562104=:2054603--

