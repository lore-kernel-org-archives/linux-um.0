Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <1f464f3d-6668-9e05-bcb7-1b419b5373e1@igalia.com>
Date: Sun, 18 Sep 2022 11:00:36 -0300
MIME-Version: 1.0
Subject: Re: [PATCH V3 04/11] um: Improve panic notifiers consistency and
 ordering
Content-Language: en-US
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-5-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220819221731.480795-5-gpiccoli@igalia.com>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: kexec@lists.infradead.org, bhe@redhat.com, pmladek@suse.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, xuqiang36@huawei.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>

On 19/08/2022 19:17, Guilherme G. Piccoli wrote:
> Currently the panic notifiers from user mode linux don't follow
> the convention for most of the other notifiers present in the
> kernel (indentation, priority setting, numeric return).
> More important, the priorities could be improved, since it's a
> special case (userspace), hence we could run the notifiers earlier;
> user mode linux shouldn't care much with other panic notifiers but
> the ordering among the mconsole and arch notifier is important,
> given that the arch one effectively triggers a core dump.
> 
> Fix that by running the mconsole notifier as the first panic
> notifier, followed by the architecture one (that coredumps).
> 
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Richard Weinberger <richard@nod.at>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> V3:
> - No changes.
> [...]

Hi Johannes, sorry for the ping. Do you think you could pick this one?
Or if you prefer, I can resend it alone (not in the series) - let me
know your preference.

Thanks,


Guilherme

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

