Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543A3C3ABBE
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 22:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CK1elPKWXClSLPdRPqW5P03MZNYsbIZRsBDl9jKU4I=; b=JqFV3SHtwH7TmpOwRnj+Ig3VZX
	nU42iXCyyG5w+yBrHrOQhSr65Upne78UIfS4BAyf6TU1P4OeiujWczRaxUd6s1Y4r61S2OJogTlHK
	tHzkbt+Zp86sx75IJkYdeNWIAP1LZrI6XoqasUA+HyW5jl1WnDoW6gDjLOgDPzmCq4VK8yHJcLAMS
	HWGvZ/1VDtKBvybwzn4N9j+hWVgxx2MfD7os7Gzkxm9mzBokxGlVCMXosWH9RW2/vc41KGpp9epDb
	qTMrTNtekBcWQceQN30FZmkS6zpF+Rj8t398QUM5ScvG9CFVKxlPubmzoinQa1NNjQgna46Sa49Cd
	9Ko38x6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD9Vv-00000001tIr-1ClY;
	Thu, 08 May 2025 22:14:47 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD9Vs-00000001tIP-1z2b
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 22:14:46 +0000
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-864a22fcdf2so51780539f.0
        for <linux-um@lists.infradead.org>; Thu, 08 May 2025 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746742483; x=1747347283; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CK1elPKWXClSLPdRPqW5P03MZNYsbIZRsBDl9jKU4I=;
        b=ZCrVAWZuCE9n4eQLs7yVC7kygl0WqO0YNPrs4EFRoWmOkl7VhFAN+grxUx9DCIJocw
         AC17XXgCMZDPDqWC1KvN+xxWzKfncir5HHsBNqqYqqKPyV9s19gJGOEMEJMO/whU1AHy
         TeYiv9nCdwtZE25BP/hVWa47dmpP1iOhbYWo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746742483; x=1747347283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CK1elPKWXClSLPdRPqW5P03MZNYsbIZRsBDl9jKU4I=;
        b=JENeswV8Ez1xXQHrunCpHBIfBLAbrYzr1sRpo13CxI/JKxb5ImvwCEaOnEO/runl9n
         yaUHkOI6cYAwS1Z/JkrtutjQ92BArHwejslb6CedKNWc8x5oVeXu2BZkGHyogSwG9JnE
         qUMn79mDW0G4bYITvYx9A/lLuT4uJNFEiCp085Y+4E7eFsqXMCMnYraK7s2G/0ZIFMbx
         f2uEzlpwaWwDmslXzx8vgrqit1VJQIfi2Mv9FhD+Jsk2sFl/TPFnNtRA9x4euT1mQdkD
         iVopXvuUSSlKPDr+Ei+1Ymz4+rs2np16fE6i5Lh/MW1JjOTEX5Gs2P14EySYedfHzQTe
         /EJA==
X-Forwarded-Encrypted: i=1; AJvYcCVD7kaCbysBdJO9P23pzzqcHfbI5mg7xp+9CUcJWW4uaf+JUeaQSaL2UWrppZ4jHavQrXlp7h1D6Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwnKLcPgJ4XGCOYMPVzJRLLg5eZK+rRwla8aB3CLmwIONbC/bxV
	qBQTQq8k5S3Bpw/fd1HGbWJjhEDlfQcwoMEY/prE2uZRuqo+UT5Oillw5eUfbS0=
X-Gm-Gg: ASbGncsl5PCGVIMKpUwe8Jzo3BeZkijuLtAb+NrjgarpoMrx9WM8nN6WrrImuq7oGUZ
	5Tc8kOQK14L+Jsr4vANKVB3/GI2ujCktJ4azqlQNs5aMyyRhySeZO0dn1tJaGL8cipo6YPnwl4Q
	GVaRdsCZ2E++US6VH3OC61FAq1VmuBmf129maR/F7KJ88i8dqT7j2bgxb+0wZiw3rNVlnByPb/7
	v5w8O1uWNf7FH5QAta3x4NiJvqKxyUKZVHjWmzpbOWSprIHyB6vAECiTidzFwudYmai/Ibdwzvb
	rQcYU7Sje3ndz9j2ZtWWLjlVJlBr+/72CR3U1TO1vRirNgjmFsU=
X-Google-Smtp-Source: AGHT+IH5MQwed+065d9LOVuxEKO6ubkA9Ob6pEePe9HD+g9AN4JF3g2On82Lij+nTEGd4vyd0n7qaQ==
X-Received: by 2002:a05:6602:1401:b0:867:c17:a6ff with SMTP id ca18e2360f4ac-86764496f6fmr113977539f.8.1746742483142;
        Thu, 08 May 2025 15:14:43 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-867636e0efdsm15990639f.29.2025.05.08.15.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 15:14:42 -0700 (PDT)
Message-ID: <a4558815-f400-41c9-973d-90680ceb3ede@linuxfoundation.org>
Date: Thu, 8 May 2025 16:14:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: let 'make clean' properly clean underlying SUBARCH as
 well
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org,
 David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250507074936.486648-1-masahiroy@kernel.org>
 <9ec50ce0-f60b-4d87-bc44-adaf2a1a97a1@linuxfoundation.org>
 <CAK7LNARF=ANEEeENSwcWeayympi6Svci+ScWGpWQimyWm8xUzA@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAK7LNARF=ANEEeENSwcWeayympi6Svci+ScWGpWQimyWm8xUzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_151444_744059_EFA9D6DF 
X-CRM114-Status: GOOD (  16.68  )
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

On 5/7/25 17:49, Masahiro Yamada wrote:
> On Thu, May 8, 2025 at 6:38 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 5/7/25 01:49, Masahiro Yamada wrote:
>>> Building the kernel with O= is affected by stale in-tree build artifacts.
>>>
>>> So, if the source tree is not clean, Kbuild displays the following:
>>>
>>>     $ make ARCH=um O=build defconfig
>>>     make[1]: Entering directory '/.../linux/build'
>>>     ***
>>>     *** The source tree is not clean, please run 'make ARCH=um mrproper'
>>>     *** in /.../linux
>>>     ***
>>>     make[2]: *** [/.../linux/Makefile:673: outputmakefile] Error 1
>>>     make[1]: *** [/.../linux/Makefile:248: __sub-make] Error 2
>>>     make[1]: Leaving directory '/.../linux/build'
>>>     make: *** [Makefile:248: __sub-make] Error 2
>>>
>>> Usually, running 'make mrproper' is sufficient for cleaning the source
>>> tree for out-of-tree builds.
>>>
>>> However, building UML generates build artifacts not only in arch/um/,
>>> but also in the SUBARCH directory (i.e., arch/x86/). If in-tree stale
>>> files remain under arch/x86/, Kbuild will reuse them instead of creating
>>> new ones under the specified build directory.
>>>
>>> This commit makes 'make ARCH=um clean' recurse into the SUBARCH directory.
>>>
>>> Reported-by: Shuah Khan <skhan@linuxfoundation.org>
>>> Closes: https://lore.kernel.org/lkml/20250502172459.14175-1-skhan@linuxfoundation.org/
>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>
>> It doesn't solve the problem. I still see arch/x86/realmode/rm/pasyms.h
>> after running make ARCH=um mrproper
> 
> 
> Why not?
> 
> This patch allows 'make ARCH=um mrproper'
> to clean up both arch/um and arch/x86/.
> 
> It is really simple to test the behavior.
> 
> 
> [Without this patch]
> 
> masahiro@zoe:~/workspace/linux-kbuild(master)$ touch
> arch/x86/realmode/rm/pasyms.h
> masahiro@zoe:~/workspace/linux-kbuild(master)$ make ARCH=um mrproper
> masahiro@zoe:~/workspace/linux-kbuild(master)$ ls arch/x86/realmode/rm/pasyms.h
> arch/x86/realmode/rm/pasyms.h
> 
> [With this patch]
> 
> masahiro@zoe:~/workspace/linux-kbuild(kbuild)$ touch
> arch/x86/realmode/rm/pasyms.h
> masahiro@zoe:~/workspace/linux-kbuild(kbuild)$ make ARCH=um mrproper
>    CLEAN   arch/x86/realmode/rm
> masahiro@zoe:~/workspace/linux-kbuild(kbuild)$ ls arch/x86/realmode/rm/pasyms.h
> ls: cannot access 'arch/x86/realmode/rm/pasyms.h': No such file or directory
> 

I ran another controlled test starting from a totally clean repo
and the building - looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


