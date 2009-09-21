Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1752826AbZIUQ0x@vger.kernel.org>
In-Reply-To: <20090921160532.GC3868@hack>
References: <Pine.LNX.4.64.0909192149250.27171@ask.diku.dk> <20090921160532.GC3868@hack>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CCABB2CC-E9F7-4153-8B60-85619DE71A13@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/5] arch/um: remove duplicate structure field initialization
Date: Mon, 21 Sep 2009 18:26:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>
Cc: Julia Lawall <julia@diku.dk>, jdike@addtoit.com, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

> "
> The initialization shall occur in initializer list order, each
> initializer provided for a particular subobject overriding any
> previously listed initializer for the same subobject [...]
> "
>
> I am wondering why gcc doesn't (can't?) complain about this?

Does -Woverride-init (included in -Wextra / -W) not work?  If so, please
file a bug report.

Thanks,


Segher

