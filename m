Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1288280550-26997-1-git-send-email-richard@nod.at>
References: <1288280550-26997-1-git-send-email-richard@nod.at>
Date: Thu, 4 Nov 2010 22:32:18 +0000
Message-ID: <AANLkTikp3-n_X9Au9+teixoMs3JEmj0XMShB-hacSZXj@mail.gmail.com>
Subject: Re: [PATCH] um: fix ptrace build error
From: Will Newton <will.newton@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, namhyung@gmail.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Oct 28, 2010 at 4:42 PM, Richard Weinberger <richard@nod.at> wrote:
> Both 0a3d763 and 9b05a69 broke the um build.
> This patch fixes the issues.
>
> 0a3d763 introduced the undeclared variable "datavp".
> The patch seems completely untested. :-(
>
> 9b05a69 changed arch_ptrace()'s signature but did not
> update um/include/asm/ptrace-generic.h.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Tested-by: Will Newton <will.newton@gmail.com>
