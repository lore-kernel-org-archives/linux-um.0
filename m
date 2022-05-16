Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <c6a55df0-11f5-21ae-8a61-b37141d2436b@igalia.com>
Date: Mon, 16 May 2022 11:28:10 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 20/30] panic: Add the panic informational notifier list
Content-Language: en-US
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-21-gpiccoli@igalia.com> <YoJbeuTNBXOIypSH@alley>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YoJbeuTNBXOIypSH@alley>
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
To: Petr Mladek <pmladek@suse.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Hari Bathini <hbathini@linux.ibm.com>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Hunter <jonathanh@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Leo Yan <leo.yan@linaro.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Mike Leach <mike.leach@linaro.org>, Mikko Perttunen <mperttunen@nvidia.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>

On 16/05/2022 11:11, Petr Mladek wrote:
> [...]
> 
> All notifiers moved in this patch seems to fit well the "info"
> notifier list. The patch looks good from this POV.
> 
> I still have to review the rest of the patches to see if it
> is complete.
> 
> Best Regards,
> Petr

Thanks a bunch for the review =)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

