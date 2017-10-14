Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1e3IZ8-0005Tf-UN for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 14 Oct 2017 09:17:06 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1e3IZ6-0000bA-SL
 for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 14 Oct 2017 09:17:06 +0000
Received: from tun5.smaug.kot-begemot.co.uk ([192.168.18.6]
 helo=smaug.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.84_2) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1e3IZ0-0006IH-0o for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 14 Oct 2017 09:16:58 +0000
Received: from wyvern.kot-begemot.co.uk ([192.168.3.72])
 by smaug.kot-begemot.co.uk with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1e3IYz-0002Np-P3
 for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 14 Oct 2017 10:16:57 +0100
References: <CACT4Y+Ye1Yw3SPCy80_JAqNGdqtSFTMVMc02-rbfJv1omT5Qhw@mail.gmail.com>
 <20171013220025.3619-1-thomas@m3y3r.de> <3011782.xhPzxOy8Zy@blindfold>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <29f2e0cd-b46c-6e5a-af09-496e0d330d61@kot-begemot.co.uk>
Date: Sat, 14 Oct 2017 10:16:57 +0100
MIME-Version: 1.0
In-Reply-To: <3011782.xhPzxOy8Zy@blindfold>
Subject: Re: [uml-devel] [PATCH] um: Fix kcov crash before kernel is started.
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

On 14/10/17 09:05, Richard Weinberger wrote:
> Am Samstag, 14. Oktober 2017, 00:00:25 CEST schrieb Thomas Meyer:
>> UMLs current_thread_info() unconditionally assumes that the top of the stack
>> contains the thread_info structure.
>> Prevent kcov from using invalid curent_thread_info() data by disable
>> instrumentation of early startup code.
>>
>> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
>> ---
>>  arch/um/kernel/skas/Makefile | 2 ++
>>  lib/Makefile                 | 4 ++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
>> index 0b76d8869c94..df3aedb974a2 100644
>> --- a/arch/um/kernel/skas/Makefile
>> +++ b/arch/um/kernel/skas/Makefile
>> @@ -3,6 +3,8 @@
>>  # Licensed under the GPL
>>  #
>>
>> +KCOV_INSTRUMENT                := n
> So, you disable kconv for the whole SKAS code?
> That's a bit broad. ;-\

It is a part of UML which most of us approach with a distinct feeling of
dread. At least I do.

It may be worth it to do that in first instance and then try to narrow
down sections which can have it later on :)

A.

>
>>  obj-y := clone.o mmu.o process.o syscall.o uaccess.o
>>
>>  # clone.o is in the stub, so it can't be built with profiling
>> diff --git a/lib/Makefile b/lib/Makefile
>> index dafa79613fb4..18319ad5daab 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -16,6 +16,10 @@ KCOV_INSTRUMENT_list_debug.o := n
>>  KCOV_INSTRUMENT_debugobjects.o := n
>>  KCOV_INSTRUMENT_dynamic_debug.o := n
>>
>> +ifdef CONFIG_UML
>> +KCOV_INSTRUMENT_cmdline.o := n
>> +endif
>> +
> huh? Why do we need an exception for UML here?
>
> Thanks,
> //richard
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

