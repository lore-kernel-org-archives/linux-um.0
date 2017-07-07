Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170706073527.12006-1-richard@nod.at>
References: <20170706073527.12006-1-richard@nod.at>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 7 Jul 2017 11:34:26 +0200
Message-ID: <CAFLxGvz13cuyOA+VrnSRsqsySUMcow2TpVo_a1gYq=KFrAPDaw@mail.gmail.com>
Subject: Re: [PATCH] um: Correctly check for PTRACE_GETRESET/SETREGSET
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Florian Fainelli <f.fainelli@gmail.com>, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Jul 6, 2017 at 9:35 AM, Richard Weinberger <richard@nod.at> wrote:
> When checking for PTRACE_GETRESET/SETREGSET, make sure that
> the correct header file is included. We need linux/ptrace.h
> which contains all ptrace UAPI related defines.
> Otherwise #if defined(PTRACE_GETRESET) is always false.
>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Applied.

-- 
Thanks,
//richard

