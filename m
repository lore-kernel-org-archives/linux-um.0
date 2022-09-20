Return-Path: <openrisc-bounces@lists.librecores.org>
Date: Tue, 20 Sep 2022 11:49:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 25/44] printk: Remove trace_.*_rcuidle() usage
Message-ID: <YykqKm5j5q9DEKk7@google.com>
References: <20220919095939.761690562@infradead.org>
 <20220919101522.021681292@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919101522.021681292@infradead.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mips@vger.kernel.org, kasan-dev@googlegroups.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org, linux@armlinux.org.uk, linux-csky@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com, linux-imx@nxp.com, linux-snps-arc@lists.infradead.org, virtualization@lists.linux-foundation.org, pmladek@suse.com, john.ogness@linutronix.de, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org, rostedt@goodmis.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, loongarch@lists.linux.dev, linux-tegra@vger.kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-um.lists.infradead.org>

On (22/09/19 12:00), Peter Zijlstra wrote:
> The problem, per commit fc98c3c8c9dc ("printk: use rcuidle console
> tracepoint"), was printk usage from the cpuidle path where RCU was
> already disabled.
> 
> Per the patches earlier in this series, this is no longer the case.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Petr Mladek <pmladek@suse.com>

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>

