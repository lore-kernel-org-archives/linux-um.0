Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] um: use %lx format specifiers for unsigned longs
References: <1453576679-10888-1-git-send-email-colin.king@canonical.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56A9338B.6010202@nod.at>
Date: Wed, 27 Jan 2016 22:15:55 +0100
MIME-Version: 1.0
In-Reply-To: <1453576679-10888-1-git-send-email-colin.king@canonical.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 23.01.2016 um 20:17 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> static analysis from cppcheck detected %x being used for
> unsigned longs:
> 
> [arch/x86/um/os-Linux/task_size.c:112]: (warning) %x in format
>   string (no. 1) requires 'unsigned int' but the argument type
>   is 'unsigned long'.
> 
> Use %lx instead of %x
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, Thanks!
//richard

