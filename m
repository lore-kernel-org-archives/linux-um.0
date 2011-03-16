Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20110315172208.82934b13.randy.dunlap@oracle.com>
References: <20110315194543.a5d56c0c.sfr@canb.auug.org.au>
	<20110315172208.82934b13.randy.dunlap@oracle.com>
Date: Wed, 16 Mar 2011 11:38:03 +0800
Message-ID: <AANLkTi=yDHaeosLpyuCjTJ8hZA8Q4bzHCmKK0J1Giunz@mail.gmail.com>
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH -next] uml: fix tty interface warnings
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, gregkh@suse.de, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Mar 16, 2011 at 8:22 AM, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> Fix tty interface warnings in arch/um:
>
> arch/um/drivers/stdio_console.c:122: warning: initialization from incompatible pointer type
> arch/um/drivers/ssl.c:139: warning: initialization from incompatible pointer type
>

Acked-by: WANG Cong <xiyou.wangcong@gmail.com>

Thanks.
