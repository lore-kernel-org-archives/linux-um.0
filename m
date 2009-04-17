Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1758837AbZDQIRo@vger.kernel.org>
Date: Fri, 17 Apr 2009 16:18:23 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 0/2] ptrace_vm: ptrace for syscall emulation virtual
	machines
Message-ID: <20090417081823.GA31897@hack>
References: <20090204080236.GA17452@cs.unibo.it> <20090310214436.GC5213@cs.unibo.it> <20090316074520.GC3360@hack> <20090324234753.GH22695@cs.unibo.it> <20090329163228.GE7671@hack> <20090404101708.GG4203@cs.unibo.it> <20090407173646.GL12226@hack> <20090408121851.GE24173@cs.unibo.it> <20090413163603.GG2391@hack>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090413163603.GG2391@hack>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: Renzo Davoli <renzo@cs.unibo.it>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, mtk.manpages@gmail.com, Roland McGrath <roland@redhat.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Apr 14, 2009 at 12:36:03AM +0800, Américo Wang wrote:
>Anyway, I will test your patch tomorrow, and will send you more
>feedbacks soon.
>

Sorry for the delay.

I applied your 2 patches to linus-tree, compile and run, when I run
the same UML binary inside UML, I got:

Locating the bottom of the address space ... do_syscall_stub : ret =
-13, offset = 1052680, data = 0a98a008
do_syscall_stub: syscall 192 failed, return value = 0xfffffff3,
expected return value = 0x0
 syscall parameters: 0x0 0x1000 0x7 0x11 0x3 0x19c0
Failed to flush page for address 0x0
Killed

I don't have enough time to dig this, would like to have a look at it?

Thanks.

-- 
Live like a child, think like the god.
 
