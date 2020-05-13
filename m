Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from www62.your-server.de ([213.133.104.62])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYzzV-0005DD-Ip
 for linux-um@lists.infradead.org; Wed, 13 May 2020 22:36:43 +0000
Subject: Re: [PATCH 11/18] maccess: remove strncpy_from_unsafe
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-12-hch@lst.de>
 <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
 <20200513192804.GA30751@lst.de>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
Date: Thu, 14 May 2020 00:36:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200513192804.GA30751@lst.de>
Content-Language: en-US
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
To: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org

On 5/13/20 9:28 PM, Christoph Hellwig wrote:
> On Wed, May 13, 2020 at 12:11:27PM -0700, Linus Torvalds wrote:
>> On Wed, May 13, 2020 at 9:01 AM Christoph Hellwig <hch@lst.de> wrote:
>>>
>>> +static void bpf_strncpy(char *buf, long unsafe_addr)
>>> +{
>>> +       buf[0] = 0;
>>> +       if (strncpy_from_kernel_nofault(buf, (void *)unsafe_addr,
>>> +                       BPF_STRNCPY_LEN))
>>> +               strncpy_from_user_nofault(buf, (void __user *)unsafe_addr,
>>> +                               BPF_STRNCPY_LEN);
>>> +}
>>
>> This seems buggy when I look at it.
>>
>> It seems to think that strncpy_from_kernel_nofault() returns an error code.
>>
>> Not so, unless I missed where you changed the rules.
> 
> I didn't change the rules, so yes, this is wrong.
> 
>> Also, I do wonder if we shouldn't gate this on TASK_SIZE, and do the
>> user trial first. On architectures where this thing is valid in the
>> first place (ie kernel and user addresses are separate), the test for
>> address size would allow us to avoid a pointless fault due to an
>> invalid kernel access to user space.
>>
>> So I think this function should look something like
>>
>>    static void bpf_strncpy(char *buf, long unsafe_addr)
>>    {
>>            /* Try user address */
>>            if (unsafe_addr < TASK_SIZE) {
>>                    void __user *ptr = (void __user *)unsafe_addr;
>>                    if (strncpy_from_user_nofault(buf, ptr, BPF_STRNCPY_LEN) >= 0)
>>                            return;
>>            }
>>
>>            /* .. fall back on trying kernel access */
>>            buf[0] = 0;
>>            strncpy_from_kernel_nofault(buf, (void *)unsafe_addr,
>> BPF_STRNCPY_LEN);
>>    }
>>
>> or similar. No?
> 
> So on say s390 TASK_SIZE_USUALLy is (-PAGE_SIZE), which means we'd alway
> try the user copy first, which seems odd.
> 
> I'd really like to here from the bpf folks what the expected use case
> is here, and if the typical argument is kernel or user memory.

It's used for both. Given this is enabled on pretty much all program types, my
assumption would be that usage is still more often on kernel memory than user one.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

