Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170DED10F51
	for <linux-um@archiver.kernel.org>; Wed, 26 Nov 2025 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MubSNeMbmYM/HeKESQYTWsGeLQj4IZdr09nxlU7W7oE=; b=rLPrbcj1w/KBgV5RURldskbCet
	z9BkG8JjQ7/KPOZUr4v8eK0U9BzvR7ALubymSRDemsPkVxmAwj7ZfFK3O90TRw3BKZ9hBuCM3qICu
	q3MAYq9qthJ0m2Ldwn2STEC93YFkobnzp+NBdpe0Z1jIffJkuCoYzOmcuLGQIgQKxh/zp7jveRpft
	emasZ+oRFtPW/pfImBoZr98cN9sYMpNH+qZ7TfJDfgubrZfpdVaesyeBy7cAU+zELsNAwBICPGtXG
	BePrnZ6tk/y74W7UTzvBbtzvRYOVxavrZr3mJD57p6NW/MNCYU+yqZ6CKepXx5Qg4RYPfAcLqZbNw
	EXxRxGMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOFvB-0000000F3px-29xS;
	Wed, 26 Nov 2025 13:51:01 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOFv8-0000000F3pX-0kcm
	for linux-um@lists.infradead.org;
	Wed, 26 Nov 2025 13:50:59 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-b8b33cdf470so191982a12.0
        for <linux-um@lists.infradead.org>; Wed, 26 Nov 2025 05:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764165057; x=1764769857; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MubSNeMbmYM/HeKESQYTWsGeLQj4IZdr09nxlU7W7oE=;
        b=H/BUa6x27k0IUydc5AZAMTcvJJtjHXQl2r3V7QbiwMnuuL+Hi/kuJFYTnvCUHRDgYo
         m8UE60l214AGJVifV2UqyVVkDtzZIYMcFHUzxrZAFowJHyBbsCLIO3Dn1eF1M1Rfzevd
         2Rvx/BWC2VsWgOM95ONgde0xFbRGMEbw/1WGi5msG5ey4J6lFrC+DZ4yvDP6bCR+hZ0H
         raXv0nfXkQlinmHB6XcfGyU05tqDVJXmvFYiNa7UY5GI9jpcQjcwDNz6UZOIeswT34FC
         qEKy0W18160t/pafMWxek8LpTtDuTjlhLU3bak3jBaWRMFy4ERsrrvf/4oMItWT6g2j8
         8NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764165057; x=1764769857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MubSNeMbmYM/HeKESQYTWsGeLQj4IZdr09nxlU7W7oE=;
        b=KXjz50FhxtP0v/gdSw9DJ6q/TZxvoE/oLZILEHI5G2rZ9+pUD/xOCgnNWpNw0iLwlL
         LEmXjCttnLH7jkvS0JmQsFk9b4QPfe+CyQBy/RCw9rRY7tlo0nJn4uHQB2gv3yONDC3t
         WROCQ1jdqQNbSmUQZUzVSEmLsv15RyxKp1MLvLJzLTBKLvObAHYo81+yC2/3sgWgoIR6
         6V5HczfKEddfbJO8ARL6tAThNyRjevRiBx/ivN+7dVt5Bc6Z+13UfJ/cvAv5nZBKCSvo
         EBm8Hr+4MmudFS5agYY38MHDOWTNji9PHCNxE17nfIJnGMfpPdtrrAtBbgoD7LnqlEa3
         D7/A==
X-Forwarded-Encrypted: i=1; AJvYcCVObX2joDflzT9bfdlJ0ITX4fDC9m9GBqeykffS4OLYH/MdOqbsga5DnjNwHiNpyFOCxhG0RyaLzw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0s2XOc2xRDa2tJ9tJ0aABYHHefitqaQc+FjYnNOHYInBY2uGj
	iaosLUTRzdBlIzQX8sFmrMwGoM1VK8Xa6JnedTz70fPuEKDtvExG28FOnf87o+CckWOmusLAVP4
	o0HAWoQXWKIwdMhZ416i2A5vZ5vTFJ2U=
X-Gm-Gg: ASbGncv/EyQ0MzuKxKcT/N87Z6HeUSKaBMVFJQ9ovFh0bgugl5IbaDRs4ewjz89tV5t
	j2oxnHutNq+gtw42//26gXPLzJOR5hvVOmhvSle8+mZg07zwAQDZtG1tmMlC+4hj0EvplvUeMpV
	zb5fNVCBsdQZvVvAGwHbywlORJthtuOfJyCehdGv65LoeXRMfnewTKqsPpk5DRXQgLoERBMn7lf
	XTqGDjKRtzVxGHQrdtBZgimYfJL7JW7tzx96hUAeSCm8NJT7Y45RntUYkuJpcbkJzKYAZ3W8eaO
	BdOP+43uc971BxQret5C9Re1/vIPt0bAOeVF0fGeXVBUKTbfvepDNE5VfteH7etbTaGuymkpX6q
	34JStq1VqIbq1xw==
X-Google-Smtp-Source: AGHT+IHyjyBhvKxSJvpXE0N3bS4+qnIUQ/hrP8nt2xNCh1iG/p92wXmacntCXSyEtcLWpcePqvDURhRBURjbbMcC7kM=
X-Received: by 2002:a05:7300:7b01:b0:2a4:3593:2c08 with SMTP id
 5a478bee46e88-2a7249fec39mr7725470eec.1.1764165056986; Wed, 26 Nov 2025
 05:50:56 -0800 (PST)
MIME-Version: 1.0
References: <202511210858.uwVivgvn-lkp@intel.com> <84b74435-5aad-4c15-aea5-db87b4a6bf11@kernel.org>
In-Reply-To: <84b74435-5aad-4c15-aea5-db87b4a6bf11@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Nov 2025 14:50:44 +0100
X-Gm-Features: AWmQ_bktxfIw2Y2gRIytid6imUptHKKwkrT99X3ar_u-JsKJ1SBOQUCIAfvL4CA
Message-ID: <CANiq72mCd7FVO0Btsvct5Dy67TkBJd=QJgnPvLMn9d43Vy0YnA@mail.gmail.com>
Subject: Re: [linux-next:master 4806/10599] error[E0560]: struct
 `bindings::kernel_param_ops` has no field named `get`
To: Daniel Gomez <da.gomez@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Andreas Hindborg <a.hindborg@kernel.org>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Benno Lossin <lossin@kernel.org>, 
	linux-modules@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_055058_273725_5B6826BD 
X-CRM114-Status: GOOD (  10.24  )
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

On Wed, Nov 26, 2025 at 2:41=E2=80=AFPM Daniel Gomez <da.gomez@kernel.org> =
wrote:
>
> On 21/11/2025 01.24, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git master
> > head:   88cbd8ac379cf5ce68b7efcfd4d1484a6871ee0b
> > commit: 0b08fc292842a13aa496413b48c1efb83573b8c6 [4806/10599] rust: int=
roduce module_param module
> > config: um-randconfig-001-20251121 (https://download.01.org/0day-ci/arc=
hive/20251121/202511210858.uwVivgvn-lkp@intel.com/config)
> > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project=
 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
> > rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20251121/202511210858.uwVivgvn-lkp@intel.com/reproduce)
>
> We can't reproduce this.
>
> If anyone cares, please let us know how to reproduce it.
>
> Tested on Debian testing x86_64 host.
>
> rustc --version
> rustc 1.91.1 (ed61e7d7e 2025-11-07
>
> /home/dagomez/0day/llvm-22.0.0-e19fa930ca838715028c00c234874d1db4f93154-2=
0250918-184558-x86_64/bin/clang-22 --version
> ClangBuiltLinux clang version 22.0.0git (https://github.com/llvm/llvm-pro=
ject.git e19fa930ca838715028c00c234874d1db4f93154)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /home/dagomez/0day/llvm-22.0.0-e19fa930ca838715028c00c23487=
4d1db4f93154-20250918-184558-x86_64/bin
>
>   561  wget https://download.01.org/0day-ci/archive/20251121/202511210858=
.uwVivgvn-lkp@intel.com/config
>   563  git clone https://github.com/intel/lkp-tests.git ~/lkp-tests
>   565  mkdir -p build_dir && cp config build_dir/.config
>
>   571  COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang-22 ~/lkp-tests=
/kbuild/make.cross W=3D1 O=3Dbuild_dir ARCH=3Dum olddefconfig
>   572  COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang-22 ~/lkp-tests=
/kbuild/make.cross W=3D1 O=3Dbuild_dir ARCH=3Dum prepare
>   573  COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang-22 ~/lkp-tests=
/kbuild/make.cross W=3D1 O=3Dbuild_dir ARCH=3Dum -j$(nproc)
>
> I'm just getting these warnings:
>
> ...

Cc'ing UML so that they are in the loop.

Cheers,
Miguel

