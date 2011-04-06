Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Wed, 6 Apr 2011 23:31:33 +0200
References: <20110407001837.12e6f01c@sf.home>
In-Reply-To: <20110407001837.12e6f01c@sf.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201104062331.34205.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] [RFC] um: x86: unbreak build by reintroducing this_cpu_cmpxchg16b_emu
To: Sergei Trofimovich <slyich@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Sergei,

Am Mittwoch 06 April 2011, 23:18:37 schrieb Sergei Trofimovich:
> I'm sure fix can be nices, but initial patch should express an idea.

Please send patches not as attachment.

I think this patch is only needed on x86_64.
Um builds fine on my main machine (i386).
It seems to fail on x86_64 when using  CONFIG_SLUB=y.

> The main offender is privileged 'cli'.
> 
> Thanks!

Thanks,
//richard

