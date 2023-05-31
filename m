Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAC6C7EE2E
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 04:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MoO5r0Qlr+Upd7ZO6BBk5mWheLSlAyZqrPMt2Mzdnqg=; b=VAgLMRiBzf7lLp
	src6qEQBtaJGB2jCjG8B1/umgPARP14uEZ5D8P9g98UcyiSfj7vEkG0BnY0GK0ft+EZv8UUkBhTQP
	2Wc0TGfWSMaTAYZg13tEQLc8ngnfx0c/jhJqqZ18aZl7eQBqq3MyTx1O+ckfsVsBoXitDImdix74N
	Ih6FAWof3oMW8kqbUT/WU2ApGnpK9k/VnN86CcUhv9ybxIO0gUnDxTCGBK5xFBasN32VM/JVIS3ET
	ldkTC04z5T0kjHfEako0hkXrf7xmSXQDYYp7AiNxV/wHQCukfUh3FKc3EZXCKyiQrrj+nAoKqcxA7
	K6LQ1gl4GrXHqimW4+Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4DeM-00G4Z6-1s;
	Wed, 31 May 2023 04:41:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4DeK-00G4YR-0e
	for linux-um@lists.infradead.org;
	Wed, 31 May 2023 04:41:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4484E61018;
	Wed, 31 May 2023 04:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7EBC433EF;
	Wed, 31 May 2023 04:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685508086;
	bh=X8DzOtFm5APJJSt0+uSAaCUWMDRz0NNoyEHRZnPXbLg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=sjFf/DrmDfOeiFUCGHnSSSEe7+oPXj6nFGtGpi+KZpxDPoRvcePXtlx3f2wo1Oj6q
	 jg9F/QJsRufCCiGIiPNSugaaBgGxQLUMUNnBCW33vuRySPsVugKnd9WULNGwLF18t2
	 lCRRv0iYflYSCyKT2uR71JNlTrRUrc7sIUxNiHum7CVprq0idDPmjeuuWafT9CzRvf
	 7wDU5aZzcR+gss5za+wvczpmOHLgYQvRGggIwgqIpMNBl89h/i36d9J2w63de/pwAh
	 YiIF+rJA5vtXEH80wyrWKIve83+JwHTGrkNvDK3bNZfNxddv9euIm1JlQBoBmNsb8d
	 9EOtKn3cHGlNg==
Date: Tue, 30 May 2023 21:41:25 -0700
From: Kees Cook <kees@kernel.org>
To: kernel test robot <lkp@intel.com>, Azeem Shaikh <azeemshaikh38@gmail.com>,
 Maxim Krasnyansky <maxk@qti.qualcomm.com>
CC: oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
User-Agent: K-9 Mail for Android
In-Reply-To: <202305311135.zGMT1gYR-lkp@intel.com>
References: <20230530164004.986750-1-azeemshaikh38@gmail.com> <202305311135.zGMT1gYR-lkp@intel.com>
Message-ID: <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_214128_321910_41EC9C93 
X-CRM114-Status: GOOD (  12.90  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On May 30, 2023 8:18:42 PM PDT, kernel test robot <lkp@intel.com> wrote:
>Hi Azeem,
>
>kernel test robot noticed the following build errors:
>
>[auto build test ERROR on uml/next]
>[also build test ERROR on uml/fixes wireless-next/main wireless/main linus/master v6.4-rc4 next-20230530]
>[If your patch is applied to the wrong git tree, kindly drop us a note.
>And when submitting patch, we suggest to use '--base' as documented in
>https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Azeem-Shaikh/uml-Replace-all-non-returning-strlcpy-with-strscpy/20230531-004115
>base:   git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
>patch link:    https://lore.kernel.org/r/20230530164004.986750-1-azeemshaikh38%40gmail.com
>patch subject: [PATCH] uml: Replace all non-returning strlcpy with strscpy
>config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230531/202305311135.zGMT1gYR-lkp@intel.com/config)
>compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>reproduce (this is a W=1 build):
>        # https://github.com/intel-lab-lkp/linux/commit/c51d7beb37cfbda321feb3811bbe0e381f804899
>        git remote add linux-review https://github.com/intel-lab-lkp/linux
>        git fetch --no-tags linux-review Azeem-Shaikh/uml-Replace-all-non-returning-strlcpy-with-strscpy/20230531-004115
>        git checkout c51d7beb37cfbda321feb3811bbe0e381f804899
>        # save the config file
>        mkdir build_dir && cp config build_dir/.config
>        make W=1 O=build_dir ARCH=um SUBARCH=i386 olddefconfig
>        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash
>
>If you fix the issue, kindly add following tag where applicable
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://lore.kernel.org/oe-kbuild-all/202305311135.zGMT1gYR-lkp@intel.com/
>
>All errors (new ones prefixed by >>):
>
>   arch/um/os-Linux/drivers/tuntap_user.c: In function 'tuntap_open':
>>> arch/um/os-Linux/drivers/tuntap_user.c:149:17: error: implicit declaration of function 'strscpy'; did you mean 'strncpy'? [-Werror=implicit-function-declaration]
>     149 |                 strscpy(ifr.ifr_name, pri->dev_name, sizeof(ifr.ifr_name));
>         |                 ^~~~~~~
>         |                 strncpy
>   cc1: some warnings being treated as errors

Ah, yeah, this is another "not actually in the kernel" cases. Let's ignore this strlcpy for now.

-Keed




-- 
Kees Cook

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
