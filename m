Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8313CCCD193
	for <linux-um@archiver.kernel.org>; Mon, 20 Oct 2025 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eVXqdZWOtZ7txBWnH50nnMS7XqFYpHtuEUVHW4IWcvc=; b=1P9NqHFyTyhOA3H4UB1LDUxL2w
	WFDXP688bj2K5NExBLcVpBqGSS59bWs+FTpz4/zlhS2oo7R6fy24mngP1+9CK9WXxq7+mf8/B23u0
	DWvFHLv8lBow36DB1/B4sEmjvrpX/gJI93rIurxmVg+Hf5RLPc1nKTmPFfLhqrwhokq1lOrfHTln3
	Kt1LodDikUugWLU9DQ2cSaB0sl00MiTzsHYhXJoXw8KUZgV12l6caHK0h13ME+AzNy7M8ZUUQnE+B
	n6RPK+MDmajcjmN55dYWXY54/NvcyQUMAPV0FgvVGpb/Fmaxzb3mFgQLL3wvYnvJM+O3IdG4EIxq/
	FyX2Zu8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAqm2-0000000Dwyq-3CGk;
	Mon, 20 Oct 2025 14:22:10 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAqlz-0000000Dwvu-1SNZ
	for linux-um@lists.infradead.org;
	Mon, 20 Oct 2025 14:22:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760970120;
	bh=eVXqdZWOtZ7txBWnH50nnMS7XqFYpHtuEUVHW4IWcvc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QaQdlt4XnQ8bxCpMVnwjRx90bajlP0wfryt4Gbw7RtcN+WcMPM1zMP1VeLsgpwjA3
	 zgy7qZNFc2U7x3kknp6brY8sa0gtQQ7haUGK4WV+m9q/1BSq7JZ/ucq1O6i4LRuM5Y
	 BB9um2wxslxBhnvVPm3c1K7gp9lSJMJH0RNh/Gpg=
Date: Mon, 20 Oct 2025 17:21:56 +0300 (GMT+03:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>,
	linux-kselftest@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Message-ID: <99359472-8b1e-4d51-adb8-5b16f1f90a9f@weissschuh.net>
In-Reply-To: <aNaNtI+mbyc4zgFy@rli9-mobl>
References: <aNaNtI+mbyc4zgFy@rli9-mobl>
Subject: Re: [PATCH v3 09/12] um: use nolibc for the --showconfig
 implementation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <99359472-8b1e-4d51-adb8-5b16f1f90a9f@weissschuh.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_072207_554356_2D472B68 
X-CRM114-Status: GOOD (  11.23  )
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

Hi Benjamin,

Sep 26, 2025 15:57:43 kernel test robot <lkp@intel.com>:

> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on uml/next]
> [also build test WARNING on uml/fixes shuah-kselftest/next shuah-kselftes=
t/fixes linus/master v6.17-rc7 next-20250925]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:=C2=A0=C2=A0=C2=A0 https://github.com/intel-lab-lkp/linux/commits/Ben=
jamin-Berg/tools-compiler-h-fix-__used-definition/20250924-222547
> base:=C2=A0=C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/uml/lin=
ux next
> patch link:=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/r/20250924142059.52=
7768-10-benjamin%40sipsolutions.net
> patch subject: [PATCH v3 09/12] um: use nolibc for the --showconfig imple=
mentation
> :::::: branch date: 2 days ago
> :::::: commit date: 2 days ago
> config: um-randconfig-r111-20250926 (https://download.01.org/0day-ci/arch=
ive/20250926/202509261452.g5peaXCc-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250926/202509261452.g5peaXCc-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/r/202509261452.g5peaXCc-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> =C2=A0=C2=A0 command-line: note: in included file (through tools/include/=
nolibc/nolibc.h, tools/include/nolibc/stddef.h, arch/um/include/shared/user=
.h, builtin):
>>> tools/include/nolibc/sys.h:109:29: sparse: sparse: Using plain integer =
as NULL pointer
> =C2=A0=C2=A0unistd.h:70:30: sparse: sparse: Using plain integer as NULL p=
ointer
> =C2=A0=C2=A0 tools/include/nolibc/unistd.h:70:33: sparse: sparse: Using p=
lain integer as NULL pointer

Do you intend to work on your UML with nolibc patches this cycle?
If not I would fix these sparse warnings in the nolibc tree and also apply =
your nolibc patches.


Thomas

