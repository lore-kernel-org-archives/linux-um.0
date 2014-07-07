Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 7 Jul 2014 15:05:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20140707150523.cc671116bf366e8db73209c5@linux-foundation.org>
In-Reply-To: <20140705112238.16142.42735.stgit@zurg>
References: <20140705112238.16142.42735.stgit@zurg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] checkstack: use $UTS_MACHINE as target architecture
To: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, 05 Jul 2014 15:22:38 +0400 Konstantin Khlebnikov <koct9i@gmail.com> wrote:

> This fixes command # make checkstack for i386/x86_64.
> Looks like $UTS_MACHINE is exactly what scripts/checkstack.pl needs.
> 
> By default $UTS_MACHINE is equal to $ARCH, but some arch/${ARCH}/Makefile
> overrides it. This patch updates it also in arch/x86/Makefile.um
> 
> broken in ffee0de ("x86: Default to ARCH=x86 to avoid overriding CONFIG_64BIT")

The changelog doesn't describe the bug which is being fixed.  It should
do so please.  If there are any compiler/make error messages then those
should be included.

