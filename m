Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 30 Aug 2011 13:04:59 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110830120459.GT2203@ZenIV.linux.org.uk>
References: <1314702244-3948-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1314702244-3948-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: fix strrchr problems
To: Richard Weinberger <richard@nod.at>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@ftp.linux.org.uk>, jdike@addtoit.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Aug 30, 2011 at 01:04:04PM +0200, Richard Weinberger wrote:
> From: Al Viro <viro@ftp.linux.org.uk>
> 
> [richard@nod.at:
> Fixes:
> /usr/lib/gcc/x86_64-linux-gnu/4.4.5/../../../../lib/libc.a(strrchr.o): In function `rindex':
> (.text+0x0): multiple definition of `strrchr'
> 
> If both STATIC_LINK and UML_NET_VDE are set to "y" libc's strstr
							    ^^^^^^
							    strrchr...
> may clash with the kernel implementation.
