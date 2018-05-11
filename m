Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1621114.mSmC2JOP5I@blindfold>
References: <CAK7LNAQREY=32tX7m8dbJ6a_AhXLF_y-n5VLFBBcvXWaRvTmHg@mail.gmail.com>
 <1621114.mSmC2JOP5I@blindfold>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 11 May 2018 12:48:50 +0900
Message-ID: <CAK7LNAQXwKKM9Czkz0CnGm-OFqsM1AB7Run3dT9CdCTkCz=eiA@mail.gmail.com>
Subject: Re: [UML] Question about arch/x86/um/vdso/vdso-syms.lds
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>, Nicholas Piggin <npiggin@gmail.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Richard,


2018-05-09 15:36 GMT+09:00 Richard Weinberger <richard@nod.at>:
> Masahiro,
>
> Am Mittwoch, 9. Mai 2018, 05:36:18 CEST schrieb Masahiro Yamada:
>> Hi Richard,
>>
>>
>> Please let me ask a question about vdso-syms.lds
>> under arch/x86/um/vdso/.
>>
>> This file exists since:
>>
>> commit f1c2bb8b9964ed31de988910f8b1cfb586d30091
>> Author: Richard Weinberger <richard@nod.at>
>> Date:   Mon Jul 25 17:12:54 2011 -0700
>>
>>     um: implement a x86_64 vDSO
>>
>>
>> So, I think you are the right person
>> to reach out to.
>>
>>
>> Originally, vdso-syms.lds was linked to vmlinux,
>> but it is not since:
>>
>> commit 827880ec260ba048f95fe646b96a205c394fa0f0
>> Author: Nicholas Piggin <npiggin@gmail.com>
>> Date:   Fri Jun 9 15:24:16 2017 +1000
>>
>>     x86/um: thin archives build fix
>>
>>
>>
>> Something may be missing from my thought,
>> but I wonder what vdso-syms.lds is used for.
>
> Hmm, I think we can kill it. In 2011 I used the x86 vdso
> code as "template" this is how the file made it into UML.
> AFAICT it was forgotten after all the vdso related refactoring
> in um and x86.
>
> Thanks,
> //richard


OK, I have sent a patch to the UML ML.
Thanks.


-- 
Best Regards
Masahiro Yamada

