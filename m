Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1758189AbZC2QK5@vger.kernel.org>
Date: Mon, 30 Mar 2009 00:11:21 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 2/2] ptrace_vm: ptrace for syscall emulation virtual
	machines
Message-ID: <20090329161121.GD7671@hack>
References: <20090204080256.GC17452@cs.unibo.it> <20090310214456.GE5213@cs.unibo.it> <20090310220241.GC30475@elte.hu> <20090311134138.GD12753@cs.unibo.it> <20090316081508.GE3360@hack> <20090316121732.GC22978@cs.unibo.it> <20090318143939.GA3986@hack> <20090324232019.GG22695@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090324232019.GG22695@cs.unibo.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Mar 25, 2009 at 12:20:19AM +0100, Renzo Davoli wrote:
>Patch rebased on 2.6.29. I have fixed the code following Cong's suggestion.
>	renzo
>Although get_using_sysptvm is used as a boolean, I have left it int just 
>for the sake of simmetry with get_using_sysemu.
>It could be safely changed to boolean at any time.
>

Thanks.

My point is *not* changing it from 'int' to 'bool', I mean you
should change the interface, for example, change get_using_sysptvm()
to enable_sysptvm().

