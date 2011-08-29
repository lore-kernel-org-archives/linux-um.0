Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 29 Aug 2011 23:11:10 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110829221110.GO2203@ZenIV.linux.org.uk>
References: <1314634419-24766-1-git-send-email-richard@nod.at>
 <1314634419-24766-9-git-send-email-richard@nod.at>
 <20110829142705.5be82d7c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110829142705.5be82d7c.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 8/9] um: fix strrchr problems
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@ftp.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Aug 29, 2011 at 02:27:05PM -0700, Andrew Morton wrote:

> z:/usr/src/linux-3.1-rc4> grep -r kernel_strrchr .       
> z:/usr/src/linux-3.1-rc4> 
> 
> ok, I give up.  How does this work?

You are grepping for the wrong thing ;-)  It works the same way defines
next to it do - both the kernel and libc define functions with the
same name (doing the same thing) and we get problems when linking.

See the comment right before it:

# -Dvmap=kernel_vmap prevents anything from referencing the libpcap.o symbol so
# named - it's a common symbol in libpcap, so we get a binary which crashes.
#
# Same things for in6addr_loopback and mktime - found in libc. For these two we
# only get link-time error, luckily.
#
# These apply to USER_CFLAGS to.

