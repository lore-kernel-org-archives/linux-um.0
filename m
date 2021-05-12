Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [PATCH] um: add 2 missing libs to fix various build errors
References: <20210404182044.9918-1-rdunlap@infradead.org>
 <9f7eeb70-8ddc-fb04-a378-5f1e80d485e6@infradead.org>
 <74a0ba94-9a22-b7a4-3c1b-596ddbaa856e@cambridgegreys.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2a2ddf5b-3d08-1a13-94c8-ae2ca0e6444b@infradead.org>
Date: Tue, 11 May 2021 18:56:51 -0700
MIME-Version: 1.0
In-Reply-To: <74a0ba94-9a22-b7a4-3c1b-596ddbaa856e@cambridgegreys.com>
Content-Language: en-US
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, Brendan Jackman <jackmanb@google.com>, Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Johannes Berg <johannes@sipsolutions.net>, Johannes Berg <johannes.berg@intel.com>

On 4/9/21 10:28 PM, Anton Ivanov wrote:
> On 10/04/2021 05:13, Randy Dunlap wrote:
>> On 4/4/21 11:20 AM, Randy Dunlap wrote:


[snip]

>>
>> There are still some build errors in 2 object files:
>>
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM2'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM2'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x22): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x2f): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x3c): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x49): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x56): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x63): more undefined references to `X86_FEATURE_XMM' follow
>>
>> and
>>
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM2'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM2'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x22): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x2f): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x3c): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x49): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x56): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x63): undefined reference to `X86_FEATURE_XMM2'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x70): undefined reference to `X86_FEATURE_XMM2'
>>
>> I don't know what to do about these or what is causing them (other than
>> "alternatives").
> 
> I have a patch in the queue which should fix these - it "steals" the bug/feature definitions from the x86 tree.
> 
> A

Hi Anton,

Can you post (repost) the patch for these or point me to it
on a mailing list, please?


thanks.
-- 
~Randy


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

