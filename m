Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <58837e3d-0e2a-42ac-f198-9fe7be7aa823@igalia.com>
Date: Tue, 10 May 2022 11:10:40 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 08/30] powerpc/setup: Refactor/untangle panic notifiers
Content-Language: en-US
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-9-gpiccoli@igalia.com>
 <3c34d8e2-6f84-933f-a4ed-338cd300d6b0@linux.ibm.com>
 <f9c3de3c-1709-a1aa-2ece-c9fbfd5e6d6a@igalia.com>
 <87fslh8pe3.fsf@mpe.ellerman.id.au>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <87fslh8pe3.fsf@mpe.ellerman.id.au>
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
To: Michael Ellerman <mpe@ellerman.id.au>, Hari Bathini <hbathini@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, pmladek@suse.com, kexec@lists.infradead.org, bhe@redhat.com, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, akpm@linux-foundation.org

On 10/05/2022 10:53, Michael Ellerman wrote:
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
>> On 05/05/2022 15:55, Hari Bathini wrote:
>>> [...] 
>>> The change looks good. I have tested it on an LPAR (ppc64).
>>>
>>> Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
>>>
>>
>> Hi Michael. do you think it's possible to add this one to powerpc/next
>> (or something like that), or do you prefer a V2 with his tag?
> 
> Ah sorry, I assumed it was going in as part of the whole series. I guess
> I misread the cover letter.
> 
> So you want me to take this patch on its own via the powerpc tree?
> 
> cheers

Hi Michael, thanks for the prompt response!

You didn't misread, that was the plan heh
But some maintainers start to take patches and merge in their trees, and
in the end, it seems to make sense - almost half of this series are
fixes or clean-ups, that are not really necessary to get merged altogether.

So, if you can take this one, I'd appreciate - it'll make V2 a bit
smaller =)

Cheers,


Guilherme

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

