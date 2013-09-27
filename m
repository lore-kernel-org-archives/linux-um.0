Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <52451AA7.3080204@nod.at>
Date: Fri, 27 Sep 2013 07:41:59 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1380255287-5818-1-git-send-email-artagnon@gmail.com> <1380255287-5818-3-git-send-email-artagnon@gmail.com>
In-Reply-To: <1380255287-5818-3-git-send-email-artagnon@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 2/2] um/vdso: add .gitignore for a couple of targets
To: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Michal Marek <mmarek@suse.cz>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 27.09.2013 06:14, schrieb Ramkumar Ramachandra:
> Cc: Richard Weinberger <richard@nod.at>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  arch/x86/um/vdso/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 arch/x86/um/vdso/.gitignore
> 
> diff --git a/arch/x86/um/vdso/.gitignore b/arch/x86/um/vdso/.gitignore
> new file mode 100644
> index 0000000..9cac6d0
> --- /dev/null
> +++ b/arch/x86/um/vdso/.gitignore
> @@ -0,0 +1,2 @@
> +vdso-syms.lds
> +vdso.lds
> 

Queued for 3.13-rc1.

Thanks,
//richard
