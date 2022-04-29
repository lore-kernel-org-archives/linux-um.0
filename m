Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 29 Apr 2022 20:46:36 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 13/30] s390/consoles: Improve panic notifiers reliability
Message-ID: <YmwyjMtT7QTZiHaa@osiris>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-14-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220427224924.592546-14-gpiccoli@igalia.com>
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
Cc: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On Wed, Apr 27, 2022 at 07:49:07PM -0300, Guilherme G. Piccoli wrote:
> Currently many console drivers for s390 rely on panic/reboot notifiers
> to invoke callbacks on these events. The panic() function disables local
> IRQs, secondary CPUs and preemption, so callbacks invoked on panic are
> effectively running in atomic context.
> 
> Happens that most of these console callbacks from s390 doesn't take the
> proper care with regards to atomic context, like taking spinlocks that
> might be taken in other function/CPU and hence will cause a lockup
> situation.
> 
> The goal for this patch is to improve the notifiers reliability, acting
> on 4 console drivers, as detailed below:
> 
> (1) con3215: changed a regular spinlock to the trylock alternative.
> 
> (2) con3270: also changed a regular spinlock to its trylock counterpart,
> but here we also have another problem: raw3270_activate_view() takes a
> different spinlock. So, we worked a helper to validate if this other lock
> is safe to acquire, and if so, raw3270_activate_view() should be safe.
> 
> Notice though that there is a functional change here: it's now possible
> to continue the notifier code [reaching con3270_wait_write() and
> con3270_rebuild_update()] without executing raw3270_activate_view().
> 
> (3) sclp: a global lock is used heavily in the functions called from
> the notifier, so we added a check here - if the lock is taken already,
> we just bail-out, preventing the lockup.
> 
> (4) sclp_vt220: same as (3), a lock validation was added to prevent the
> potential lockup problem.
> 
> Besides (1)-(4), we also removed useless void functions, adding the
> code called from the notifier inside its own body, and changed the
> priority of such notifiers to execute late, since they are "heavyweight"
> for the panic environment, so we aim to reduce risks here.
> Changed return values to NOTIFY_DONE as well, the standard one.
> 
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> As a design choice, the option used here to verify a given spinlock is taken
> was the function "spin_is_locked()" - but we noticed that it is not often used.
> An alternative would to take the lock with a spin_trylock() and if it succeeds,
> just release the spinlock and continue the code. But that seemed weird...
> 
> Also, we'd like to ask a good validation of case (2) potential functionality
> change from the s390 console experts - far from expert here, and in our naive
> code observation, that seems fine, but that analysis might be missing some
> corner case.
> 
> Thanks in advance!
> 
>  drivers/s390/char/con3215.c    | 36 +++++++++++++++--------------
>  drivers/s390/char/con3270.c    | 34 +++++++++++++++------------
>  drivers/s390/char/raw3270.c    | 18 +++++++++++++++
>  drivers/s390/char/raw3270.h    |  1 +
>  drivers/s390/char/sclp_con.c   | 28 +++++++++++++----------
>  drivers/s390/char/sclp_vt220.c | 42 +++++++++++++++++++---------------
>  6 files changed, 96 insertions(+), 63 deletions(-)

Code looks good, and everything still seems to work. I applied this
internally for the time being, and if it passes testing, I'll schedule
it for the next merge window.

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

