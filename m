Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 17 May 2022 12:58:15 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 05/30] misc/pvpanic: Convert regular spinlock into
 trylock on panic path
Message-ID: <YoN/x2fpdDU4+nSB@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-6-gpiccoli@igalia.com>
 <YnpXGOXicwdy1E6n@alley>
 <0a20dd06-f459-638e-cb4d-8255ab1a1f23@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a20dd06-f459-638e-cb4d-8255ab1a1f23@igalia.com>
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
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Mihai Carabas <mihai.carabas@oracle.com>, Shile Zhang <shile.zhang@linux.alibaba.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>, zhenwei pi <pizhenwei@bytedance.com>

On Tue 2022-05-10 10:00:58, Guilherme G. Piccoli wrote:
> On 10/05/2022 09:14, Petr Mladek wrote:
> > [...]
> >> With that said, it's dangerous to use regular spinlocks in such path,
> >> as introduced by commit b3c0f8774668 ("misc/pvpanic: probe multiple instances").
> >> This patch fixes that by replacing regular spinlocks with the trylock
> >> safer approach.
> > 
> > It seems that the lock is used just to manipulating a list. A super
> > safe solution would be to use the rcu API: rcu_add_rcu() and
> > list_del_rcu() under rcu_read_lock(). The spin lock will not be
> > needed and the list will always be valid.
> > 
> > The advantage would be that it will always call members that
> > were successfully added earlier. That said, I am not familiar
> > with pvpanic and am not sure if it is worth it.
> > 
> >> It also fixes an old comment (about a long gone framebuffer code) and
> >> the notifier priority - we should execute hypervisor notifiers early,
> >> deferring this way the panic action to the hypervisor, as expected by
> >> the users that are setting up pvpanic.
> > 
> > This should be done in a separate patch. It changes the behavior.
> > Also there might be a discussion whether it really should be
> > the maximal priority.
> > 
> > Best Regards,
> > Petr
> 
> Thanks for the review Petr. Patch was already merged - my goal was to be
> concise, i.e., a patch per driver / module, so the patch kinda fixes
> whatever I think is wrong with the driver with regards panic handling.
> 
> Do you think it worth to remove this patch from Greg's branch just to
> split it in 2? Personally I think it's not worth, but opinions are welcome.

No problem. It is not worth the effort.


> About the RCU part, this one really could be a new patch, a good
> improvement patch - it makes sense to me, we can think about that after
> the fixes I guess.

Yup.

Best Regards,
Petr

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

