Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 3 Dec 2020 15:54:42 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH AUTOSEL 5.9 27/39] sched/idle: Fix arch_cpu_idle() vs
 tracing
Message-ID: <20201203145442.GC9994@osiris>
References: <20201203132834.930999-1-sashal@kernel.org>
 <20201203132834.930999-27-sashal@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201203132834.930999-27-sashal@kernel.org>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Sasha Levin <sashal@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-csky@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 03, 2020 at 08:28:21AM -0500, Sasha Levin wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> [ Upstream commit 58c644ba512cfbc2e39b758dd979edd1d6d00e27 ]
> 
> We call arch_cpu_idle() with RCU disabled, but then use
> local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
> 
> Switch all arch_cpu_idle() implementations to use
> raw_local_irq_{en,dis}able() and carefully manage the
> lockdep,rcu,tracing state like we do in entry.
> 
> (XXX: we really should change arch_cpu_idle() to not return with
> interrupts enabled)
> 
> Reported-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Link: https://lkml.kernel.org/r/20201120114925.594122626@infradead.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This patch broke s390 irq state tracing. A patch to fix this is
scheduled to be merged upstream today (hopefully).
Therefore I think this patch should not yet go into 5.9 stable.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

