Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1cGTX1-0002Hw-ER
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Dec 2016 16:32:51 +0000
Received: from mail-oi0-f68.google.com ([209.85.218.68])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cGTWy-0005Qw-9H
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Dec 2016 16:32:51 +0000
Received: by mail-oi0-f68.google.com with SMTP id v84so11584243oie.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 12 Dec 2016 08:32:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1480789253.13532.5.camel@researchut.com>
References: <1480789253.13532.5.camel@researchut.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 12 Dec 2016 17:32:42 +0100
Message-ID: <CAFLxGvymHmbX=FpXFXWK4o6dzDrKA7TAMS84ABTuNGhNhFUEXg@mail.gmail.com>
Subject: Re: [uml-devel] Build failure on new gcc-6 on Debian Sid
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: rrs@researchut.com
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Hi!

On Sat, Dec 3, 2016 at 7:20 PM, Ritesh Raj Sarraf <rrs@researchut.com> wrote:
> Hi,
>
> On Debian Sid (Unstable), with Linux version 4.8.11, I was hopeful that uml
> would build proper with gcc-6. But I still am getting the below mentioned build
> failure.
>
> The 4.8.11 kernel has the fixes for the core kernel. I'm not sure if any extra
> changes are needed for UM again.
>
> The current workaround that we use in Debian to build latest UML bits from the
> kernel source, is to use the gcc-5 compiler.
>
> The Debian bug report is accessible at:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=837579
>
> Thanks,
> Ritesh
>
>
> The fix that went in the stable release is:
> http://git.kernel.org/cgit/linux/kernel/git/stable/stable-queue.git/commit/?id=a
> fad7e0e67ef545a4d92507a236f0666c33d3ad4
>
>   CC [M]  lib/cordic.o
>   CC [M]  lib/asn1_decoder.o
>   GEN     lib/oid_registry_data.c
> perl: warning: Setting locale failed.
> perl: warning: Please check that your locale settings:
>         LANGUAGE = "en_IN:en",
>         LC_ALL = (unset),
>         LC_TIME = "en_IN.utf8",
>         LC_MONETARY = "en_IN.utf8",
>         LC_COLLATE = "C",
>         LC_MEASUREMENT = "en_IN.utf8",
>         LC_NUMERIC = "C",
>         LC_PAPER = "en_IN.utf8",
>         LANG = "C"
>     are supported and installed on your system.
> perl: warning: Falling back to the standard locale ("C").
>   CC [M]  lib/oid_registry.o
>   LD      virt/lib/built-in.o
>   LD      virt/built-in.o
>   LINK    vmlinux
>   LD      vmlinux.o
>   MODPOST vmlinux.o
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
> /usr/bin/ld: arch/um/drivers/built-in.o: relocation R_X86_64_32 against
> `.rodata.str1.1' can not be used when making a shared object; recompile with
> -fPIC
> /usr/bin/ld: final link failed: Nonrepresentable section on output
> collect2: error: ld returned 1 exit status
> Makefile:955: recipe for target 'vmlinux' failed
> make[1]: *** [vmlinux] Error 1
> make[1]: Leaving directory '/build/user-mode-linux-4.8-1um/linux-source-4.8'
> debian/rules:76: recipe for target 'build-stamp' failed
> make: *** [build-stamp] Error 2
>

Isn't this a toolchain bug?
Can you please try this fix?
https://sourceware.org/bugzilla/show_bug.cgi?id=20800


-- 
Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

