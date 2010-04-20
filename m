Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 20 Apr 2010 12:52:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 2/5] uml: Drop private round_down definition
Message-ID: <20100420165225.GA31439@c-98-229-117-200.hsd1.ma.comcast.net>
References: <cover.1271713955.git.jan.kiszka@web.de> <74c7d668690f283cf3b8aed92004dc72e872f7ce.1271713955.git.jan.kiszka@web.de> <20100420083358.GD4356@cr0.nay.redhat.com> <alpine.LNX.2.00.1004201635050.7579@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1004201635050.7579@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Amerigo Wang <xiyou.wangcong@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Apr 20, 2010 at 04:35:52PM +0200, Jiri Kosina wrote:
> On Tue, 20 Apr 2010, Amerigo Wang wrote:
> > Shouldn't this signal.c #include <linux/kernel.h>?
> 
> Well, it gets included implicitly through uaccess.h -> sched.h -> 
> kernel.h.

You're depending on the internal details of uaccess.h and sched.h.  If
either of them changed, then this would cause unexpected compile
failures here.

Better to explicitly include kernel.h.

				Jeff

-- 
Work email - jdike at linux dot intel dot com
