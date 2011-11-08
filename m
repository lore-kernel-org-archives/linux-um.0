Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ian Campbell <Ian.Campbell@citrix.com>
In-Reply-To: <4EB8CBB0.8010201@nagafix.co.uk>
References: <4EB8CBB0.8010201@nagafix.co.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 8 Nov 2011 08:32:44 +0000
Message-ID: <1320741164.16747.63.camel@dagon.hellion.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: 2.6.32.47 breaks UML build (both i386 and amd64)
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, 2011-11-08 at 13:26 +0700, Antoine Martin wrote:
> (...)
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `sysdev_resume':
> /linux-2.6.32.47-amd64/drivers/base/sys.c:478: undefined reference to
> `irq_pm_syscore_resume'
> collect2: ld returned 1 exit status
>   KSYM    .tmp_kallsyms1.S
> nm: '.tmp_vmlinux1': No such file
> No valid symbol.
> make: *** [.tmp_kallsyms1.S] Error 1

Thanks, I posted a fix already in
<1320736973.16747.55.camel@dagon.hellion.org.uk>

Ian.


