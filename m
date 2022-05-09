Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <d9ec6f31-6125-0723-b7d7-5898abeb3289@arm.com>
Date: Mon, 9 May 2022 17:14:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 09/30] coresight: cpu-debug: Replace mutex with
 mutex_trylock on panic notifier
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-10-gpiccoli@igalia.com>
 <3cafe4fd-8a0b-2633-44a3-2995abd6c38c@arm.com>
 <65f24bc5-2211-0139-ee12-b2608e81ceb1@igalia.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <65f24bc5-2211-0139-ee12-b2608e81ceb1@igalia.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Leo Yan <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mike Leach <mike.leach@linaro.org>

Hi

On 09/05/2022 14:09, Guilherme G. Piccoli wrote:
> On 28/04/2022 05:11, Suzuki K Poulose wrote:
>> Hi Guilherme,
>>
>> On 27/04/2022 23:49, Guilherme G. Piccoli wrote:
>>> The panic notifier infrastructure executes registered callbacks when
>>> a panic event happens - such callbacks are executed in atomic context,
>>> with interrupts and preemption disabled in the running CPU and all other
>>> CPUs disabled. That said, mutexes in such context are not a good idea.
>>>
>>> This patch replaces a regular mutex with a mutex_trylock safer approach;
>>> given the nature of the mutex used in the driver, it should be pretty
>>> uncommon being unable to acquire such mutex in the panic path, hence
>>> no functional change should be observed (and if it is, that would be
>>> likely a deadlock with the regular mutex).
>>>
>>> Fixes: 2227b7c74634 ("coresight: add support for CPU debug module")
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>>
>> How would you like to proceed with queuing this ? I am happy
>> either way. In case you plan to push this as part of this
>> series (I don't see any potential conflicts) :
>>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Hi Suzuki, some other maintainers are taking the patches to their next
> branches for example. I'm working on V2, and I guess in the end would be
> nice to reduce the size of the series a bit.
> 
> So, do you think you could pick this one for your coresight/next branch
> (or even for rc cycle, your call - this is really a fix)?
> This way, I won't re-submit this one in V2, since it's gonna be merged
> already in your branch.

I have queued this to coresight/next.

Thanks
Suzuki

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

