Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C89C3ABBF
	for <linux-um@archiver.kernel.org>; Wed,  7 May 2025 21:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZifjbgrrxCfL++2FfK3suLq/IdOp0kek7L8OM2I2Lcs=; b=111yNTMhVtDQHnVp1rHPtLn/h2
	kcCaiE+YeS3PrI46fyLFc2Wx+xHmNXyaylW6OWU7uOjd0dA4vHB0ZcEa02sxPDFr9O/D5k/5ztiWa
	CklRW8wPIiL1eqkSx0+RTcboSzCO4B6VoAcLNkH6zhCHoGO1B7WjsdNaajjTcJHjDo27KWL8Mcppq
	jWTTq0K1OO9pjXiopVcYPzB9N5uEMbOSLPu9nQHtSeWDuJ8d6Xb6cr1l1GPwpb0IikLJiGZnNBd1u
	Axur9asS3gRAWdlOgNALWiaD7HkCNMjPWH0AAq6YxA1ElnaVDWJr6Aid0bshHvGfvJUUuWtjweb30
	v3XiZxfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCmTX-0000000GoLt-0jwq;
	Wed, 07 May 2025 21:38:47 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCmTU-0000000GoKq-0fs5
	for linux-um@lists.infradead.org;
	Wed, 07 May 2025 21:38:45 +0000
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3d81768268dso1753015ab.3
        for <linux-um@lists.infradead.org>; Wed, 07 May 2025 14:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746653923; x=1747258723; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZifjbgrrxCfL++2FfK3suLq/IdOp0kek7L8OM2I2Lcs=;
        b=GKPd412xqF0nA7sqj8f5+amD/Irlx1rDjO///MOWh3IiDPlgO2foxdGwj0E10uZwf7
         Ps/copJIWvyV531iPuY7DmLASOwpCyET1KTo+XJqOLMUcAa5JhTxpR9Gg+p+CKQSvKy0
         rGMGJJu+uYaxVtgdboThwIPLMhx0nwVblhME0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746653923; x=1747258723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZifjbgrrxCfL++2FfK3suLq/IdOp0kek7L8OM2I2Lcs=;
        b=t/zOV7nwGnMU6e76KV2seOKAFvpZoQe1KpHd0PQ1tE5eGnT+xNIkUeU5o9a71FZAMS
         47lsBcBrvzGFmki/V41VaBUQ4jBm1nrhycQw/flsBeitPBHHC4NkXMarbyPjeeboOT4F
         ListPee9UGH0ZA34ZA5/OkaJpy18+ep9UBsW8ddxHBATj0yR/8b3N/Rb2Ndh3045pTc8
         W37Gw1j0jwNmXZ234Ooq7klqm/ed7QGaTG3981WaBWoyeI+f3rDg92hg0bJrPp/Tl3pM
         RnvxldTc9YeIHDnf9tx5fd4Saih9t0Pp+t4hqwC83GqTs+bXZHTHJDDcGjZ41YsSYEeG
         Tm1A==
X-Forwarded-Encrypted: i=1; AJvYcCUg+TfHaaJl6t778SC/4WBmEfeaf+bvl+qgIyY7TYKieYAPHSW5EK1vTWpbPKh7v9FIGgppV4cEng==@lists.infradead.org
X-Gm-Message-State: AOJu0YxO6TsLdhfnrcEW+eULFbgzMpXKZzao5tEjaBCRi89CRTcuiSRT
	IFTOAZTUPK+Y6slE7XAMJBEjQEJhkun8S9+zkDrGJwvPNckUUGAVq8zeJdYNLe4=
X-Gm-Gg: ASbGncs2pTW1sdK+Ub1f6gP/vWK8cbGIR+r+yaJAIIzEXIjd1TU3KmBD9VyZIloHWcZ
	ynx06WBKnRYIYN5IeHb6Z/s2dnSQh2F4Fec8m9aZuXiLS/r7V8sNj09ZExzlO0udd7psW4LlawF
	kxei/WbibnP4J4k3lK8XbOt7f8PjMvvAA3mbtzWzbPjUCz/xxdMwwHPAMUoro04J/ThE6CbevDp
	/wZFLfiEeXbSsGIROl+cfJHn+GzVb81D8PwTI+QOvZ7IN6eWBhucGOkHPRocw/wuOJbq5zICS26
	abL5vciB+x2SgzZJZX6Qw46jgOiX/FNzwoQwRKW9NqnMWjGD2hE=
X-Google-Smtp-Source: AGHT+IE1/slQnUZ/gp64LlLf1Xdhk9pgLlMroXdZw8hWl+UeJwbGOY4V7bGf7pYzD3fEdXviFh0QcA==
X-Received: by 2002:a05:6e02:198e:b0:3d5:deaf:b443 with SMTP id e9e14a558f8ab-3da738ed6ddmr60341025ab.3.1746653922622;
        Wed, 07 May 2025 14:38:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa8dea4sm2887534173.110.2025.05.07.14.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 14:38:42 -0700 (PDT)
Message-ID: <9ec50ce0-f60b-4d87-bc44-adaf2a1a97a1@linuxfoundation.org>
Date: Wed, 7 May 2025 15:38:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: let 'make clean' properly clean underlying SUBARCH as
 well
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org,
 Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>
References: <20250507074936.486648-1-masahiroy@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250507074936.486648-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_143844_268709_3216F1FA 
X-CRM114-Status: GOOD (  17.20  )
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

On 5/7/25 01:49, Masahiro Yamada wrote:
> Building the kernel with O= is affected by stale in-tree build artifacts.
> 
> So, if the source tree is not clean, Kbuild displays the following:
> 
>    $ make ARCH=um O=build defconfig
>    make[1]: Entering directory '/.../linux/build'
>    ***
>    *** The source tree is not clean, please run 'make ARCH=um mrproper'
>    *** in /.../linux
>    ***
>    make[2]: *** [/.../linux/Makefile:673: outputmakefile] Error 1
>    make[1]: *** [/.../linux/Makefile:248: __sub-make] Error 2
>    make[1]: Leaving directory '/.../linux/build'
>    make: *** [Makefile:248: __sub-make] Error 2
> 
> Usually, running 'make mrproper' is sufficient for cleaning the source
> tree for out-of-tree builds.
> 
> However, building UML generates build artifacts not only in arch/um/,
> but also in the SUBARCH directory (i.e., arch/x86/). If in-tree stale
> files remain under arch/x86/, Kbuild will reuse them instead of creating
> new ones under the specified build directory.
> 
> This commit makes 'make ARCH=um clean' recurse into the SUBARCH directory.
> 
> Reported-by: Shuah Khan <skhan@linuxfoundation.org>
> Closes: https://lore.kernel.org/lkml/20250502172459.14175-1-skhan@linuxfoundation.org/
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

It doesn't solve the problem. I still see arch/x86/realmode/rm/pasyms.h
after running make ARCH=um mrproper

A subsequent kunit run on x86_64 fails. make ARCH=x86_64 mrproper
will remove the headers for x86_64 properly. The patch I proposed
prompts user run mrproper on the arch in compile.h - It works now
for the case where compile.h doesn't exist. I can send that out
unless you have other ideas on how to fix this.

My workflow:

- Build kernel on x86_64 with CONFIG_AMD_MEM_ENCRYPT enabled

- Check for arch/x86/realmode/rm/pasyms.h
   ls arch/x86/realmode/rm/pasyms.h
      arch/x86/realmode/rm/pasyms.h

- make ARCH=um O=/linux/build
   
   This patch cleans the source tree, but doesn't remove
   arch/x86/realmode/rm/pasyms.h

- ls arch/x86/realmode/rm/pasyms.h
      arch/x86/realmode/rm/pasyms.h

- ./tools/testing/kunit/kunit.py run --alltests --arch x86_64
[15:26:35] Configuring KUnit Kernel ...
Regenerating .config ...
Populating config with:
$ make ARCH=x86_64 O=.kunit olddefconfig
[15:26:37] Building KUnit Kernel ...
Populating config with:
$ make ARCH=x86_64 O=.kunit olddefconfig
Building with:
$ make all compile_commands.json scripts_gdb ARCH=x86_64 O=.kunit --jobs=16
ERROR:root:ld:arch/x86/realmode/rm/realmode.lds:236: undefined symbol `sev_es_trampoline_start' referenced in expression
make[6]: *** [../arch/x86/realmode/rm/Makefile:49: arch/x86/realmode/rm/realmode.elf] Error 1
make[5]: *** [../arch/x86/realmode/Makefile:22: arch/x86/realmode/rm/realmode.bin] Error 2
make[4]: *** [../scripts/Makefile.build:461: arch/x86/realmode] Error 2
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [../scripts/Makefile.build:461: arch/x86] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [/linux/linux_kselftest/Makefile:2009: .] Error 2
make[1]: *** [/linux/linux_kselftest/Makefile:248: __sub-make] Error 2
make: *** [Makefile:248: __sub-make] Error 2

thanks,
-- Shuah

