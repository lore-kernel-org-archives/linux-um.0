Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <15188cf2-a510-2725-0c6e-3c4b264714c5@igalia.com>
Date: Tue, 9 Aug 2022 16:03:51 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 06/13] um: Improve panic notifiers consistency and
 ordering
Content-Language: en-US
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-7-gpiccoli@igalia.com>
 <5bbc4296-4858-d01c-0c76-09d942377ddf@igalia.com>
 <54cd8c11428db4c419edf2267db00ca10da7a178.camel@sipsolutions.net>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <54cd8c11428db4c419edf2267db00ca10da7a178.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, kexec@lists.infradead.org, linux-um@lists.infradead.org
Cc: pmladek@suse.com, bhe@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>

On 09/08/2022 15:09, Johannes Berg wrote:
> [...]
>>> V2:
>>> - Kept the notifier header to avoid implicit usage - thanks
>>> Johannes for the suggestion!
>>>
>>>  arch/um/drivers/mconsole_kern.c | 7 +++----
>>>  arch/um/kernel/um_arch.c        | 8 ++++----
>>>  2 files changed, 7 insertions(+), 8 deletions(-)
>>> [...]
>>
>> Hi Johannes, do you feel this one is good now, after your last review?
>> Thanks in advance,
>>
> 
> Yeah, no objections, my previous comment was just a minor almost style
> issue anyway.
> 
> johannes

Perfect, thank you! Let me take the opportunity to ask you something I'm
asking all the maintainers involved here - do you prefer taking the
patch through your tree, or to get it landed with the whole series, at
once, from some maintainer?

Cheers!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

