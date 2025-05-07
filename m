Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBBEC3ABC0
	for <linux-um@archiver.kernel.org>; Wed,  7 May 2025 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KioJv91cVviuDVR7/0N2JA8Bc4fSDSe9gpDlIPRqQhA=; b=BJ2g9RmEQ9YvEFdAr/BIYX9/eX
	VfEKEDBipGkkjA2CSYnhqqEqceNk0ST8Pz8QlqYKje7whAfjrp82Tc77PiZmpnPuL2Q060FtTfmAZ
	oTdaOSoiieS+ZEIDJ9MxI+S21gbditIgSwIt6eHQilz1x5fCcJAtRW5QrhThkkhrsqp8+8YbEk5i/
	L1W0/heZA2PwtOwjrivx8Y64mJyGENxl2vaf4R35isL0g8dkJVbRRhey634XzfPRwdk6YK6teoU0L
	nbYd83Gs1Q49etCMpFydv75RgY73fdvGnQ4IzQZcp/ef9Hsb64OrQ17IBggPDCnHpYoMHMi5ueiwy
	rvc3m/MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCoWX-0000000GzaH-0m3t;
	Wed, 07 May 2025 23:50:01 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCoWV-0000000GzZa-0Xpi
	for linux-um@lists.infradead.org;
	Wed, 07 May 2025 23:50:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 192845C610A
	for <linux-um@lists.infradead.org>; Wed,  7 May 2025 23:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC07C4AF0B
	for <linux-um@lists.infradead.org>; Wed,  7 May 2025 23:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746661798;
	bh=PVmj7NJyGeK45hmVPi9ligxBtZ3ZO1Bg3hX7jXbGtO8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hBsiBKAUDAXzgSmpSbpGdkNylmRIgkbK4/Hj+Ve7zJtcUQvgigt/XtrN+K1LIiPmH
	 PDRV7f2CvAG+e8ptJw34NUUIbaVKSSUrJTNUsgjaph9lLic/h4jc0fgDpI8Kv+e7eW
	 5QdJAuAY9kHsbUFBp298uOBt8AyEbBaOvhcYNJCH7al+nyRn1wlHbLx5oHVowhChnO
	 kJ+zen5xT0RxKMYzarCbYa0N13MAlbtJ4Pj9Cta89X0cRv2UqxQO0NUA6zyLcfRONp
	 i/0oTHvVRmjej7YEM5WS8zbdSPWIR8lpxCQfB7NQ9NIRinzCoiX2C38T8vR9rmM934
	 RiRpCmQynwb5w==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54d6f93316dso457421e87.2
        for <linux-um@lists.infradead.org>; Wed, 07 May 2025 16:49:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcpVBv/iThQhqR3spxR0ZxayxNSb+f6MdtAdEKsw5scK4ZkV42zqn8DxDR4Ag2pcBHDc0U274ddQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxouAt9aO3osZxp0iu8vTGDeFHmEqHuT3M7EBaYwnFvQVrJYhoT
	2Y4Guaxl31c8cC6znTZvy9pdbupWJZroVsV4Dpc8gPYoL4Bfc9YHx2fbba05LDVraHc6eJNlSJh
	LgBWbDUlVWjMNRSPc16ucxlIDko4=
X-Google-Smtp-Source: AGHT+IFRdcpdVRskCoXAlzXvWCXXYRP4Q/wNsCbxpdTtK57XXn4nA18MqRrP5CC+45nMFjK7JUCyvRyniMzrCrngk3U=
X-Received: by 2002:ac2:4c50:0:b0:54e:81c9:6117 with SMTP id
 2adb3069b0e04-54fbfc40c95mr303374e87.46.1746661796733; Wed, 07 May 2025
 16:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250507074936.486648-1-masahiroy@kernel.org> <9ec50ce0-f60b-4d87-bc44-adaf2a1a97a1@linuxfoundation.org>
In-Reply-To: <9ec50ce0-f60b-4d87-bc44-adaf2a1a97a1@linuxfoundation.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 8 May 2025 08:49:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNARF=ANEEeENSwcWeayympi6Svci+ScWGpWQimyWm8xUzA@mail.gmail.com>
X-Gm-Features: ATxdqUEgEyaivNEkUxgddjCMDWte50zHAOMye87izKfRKe3dxwgVuXd7oBJ8YTk
Message-ID: <CAK7LNARF=ANEEeENSwcWeayympi6Svci+ScWGpWQimyWm8xUzA@mail.gmail.com>
Subject: Re: [PATCH] um: let 'make clean' properly clean underlying SUBARCH as well
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_164959_284980_61899429 
X-CRM114-Status: GOOD (  25.49  )
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

On Thu, May 8, 2025 at 6:38=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> On 5/7/25 01:49, Masahiro Yamada wrote:
> > Building the kernel with O=3D is affected by stale in-tree build artifa=
cts.
> >
> > So, if the source tree is not clean, Kbuild displays the following:
> >
> >    $ make ARCH=3Dum O=3Dbuild defconfig
> >    make[1]: Entering directory '/.../linux/build'
> >    ***
> >    *** The source tree is not clean, please run 'make ARCH=3Dum mrprope=
r'
> >    *** in /.../linux
> >    ***
> >    make[2]: *** [/.../linux/Makefile:673: outputmakefile] Error 1
> >    make[1]: *** [/.../linux/Makefile:248: __sub-make] Error 2
> >    make[1]: Leaving directory '/.../linux/build'
> >    make: *** [Makefile:248: __sub-make] Error 2
> >
> > Usually, running 'make mrproper' is sufficient for cleaning the source
> > tree for out-of-tree builds.
> >
> > However, building UML generates build artifacts not only in arch/um/,
> > but also in the SUBARCH directory (i.e., arch/x86/). If in-tree stale
> > files remain under arch/x86/, Kbuild will reuse them instead of creatin=
g
> > new ones under the specified build directory.
> >
> > This commit makes 'make ARCH=3Dum clean' recurse into the SUBARCH direc=
tory.
> >
> > Reported-by: Shuah Khan <skhan@linuxfoundation.org>
> > Closes: https://lore.kernel.org/lkml/20250502172459.14175-1-skhan@linux=
foundation.org/
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> It doesn't solve the problem. I still see arch/x86/realmode/rm/pasyms.h
> after running make ARCH=3Dum mrproper


Why not?

This patch allows 'make ARCH=3Dum mrproper'
to clean up both arch/um and arch/x86/.

It is really simple to test the behavior.


[Without this patch]

masahiro@zoe:~/workspace/linux-kbuild(master)$ touch
arch/x86/realmode/rm/pasyms.h
masahiro@zoe:~/workspace/linux-kbuild(master)$ make ARCH=3Dum mrproper
masahiro@zoe:~/workspace/linux-kbuild(master)$ ls arch/x86/realmode/rm/pasy=
ms.h
arch/x86/realmode/rm/pasyms.h

[With this patch]

masahiro@zoe:~/workspace/linux-kbuild(kbuild)$ touch
arch/x86/realmode/rm/pasyms.h
masahiro@zoe:~/workspace/linux-kbuild(kbuild)$ make ARCH=3Dum mrproper
  CLEAN   arch/x86/realmode/rm
masahiro@zoe:~/workspace/linux-kbuild(kbuild)$ ls arch/x86/realmode/rm/pasy=
ms.h
ls: cannot access 'arch/x86/realmode/rm/pasyms.h': No such file or director=
y





> A subsequent kunit run on x86_64 fails. make ARCH=3Dx86_64 mrproper
> will remove the headers for x86_64 properly. The patch I proposed
> prompts user run mrproper on the arch in compile.h - It works now
> for the case where compile.h doesn't exist. I can send that out
> unless you have other ideas on how to fix this.

No.

If you still see a problem, please explain the bad scenario,
please explain without kunit.









> My workflow:
>
> - Build kernel on x86_64 with CONFIG_AMD_MEM_ENCRYPT enabled
>
> - Check for arch/x86/realmode/rm/pasyms.h
>    ls arch/x86/realmode/rm/pasyms.h
>       arch/x86/realmode/rm/pasyms.h
>
> - make ARCH=3Dum O=3D/linux/build
>
>    This patch cleans the source tree, but doesn't remove
>    arch/x86/realmode/rm/pasyms.h
>
> - ls arch/x86/realmode/rm/pasyms.h
>       arch/x86/realmode/rm/pasyms.h
>
> - ./tools/testing/kunit/kunit.py run --alltests --arch x86_64
> [15:26:35] Configuring KUnit Kernel ...
> Regenerating .config ...
> Populating config with:
> $ make ARCH=3Dx86_64 O=3D.kunit olddefconfig
> [15:26:37] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=3Dx86_64 O=3D.kunit olddefconfig
> Building with:
> $ make all compile_commands.json scripts_gdb ARCH=3Dx86_64 O=3D.kunit --j=
obs=3D16
> ERROR:root:ld:arch/x86/realmode/rm/realmode.lds:236: undefined symbol `se=
v_es_trampoline_start' referenced in expression
> make[6]: *** [../arch/x86/realmode/rm/Makefile:49: arch/x86/realmode/rm/r=
ealmode.elf] Error 1
> make[5]: *** [../arch/x86/realmode/Makefile:22: arch/x86/realmode/rm/real=
mode.bin] Error 2
> make[4]: *** [../scripts/Makefile.build:461: arch/x86/realmode] Error 2
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [../scripts/Makefile.build:461: arch/x86] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [/linux/linux_kselftest/Makefile:2009: .] Error 2
> make[1]: *** [/linux/linux_kselftest/Makefile:248: __sub-make] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>
> thanks,
> -- Shuah



--
Best Regards

Masahiro Yamada

