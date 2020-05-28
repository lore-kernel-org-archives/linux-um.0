Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeM05-0001sK-IT
 for linux-um@lists.infradead.org; Thu, 28 May 2020 17:07:27 +0000
Subject: Re: [PATCH 12/23] bpf: handle the compat string in
 bpf_trace_copy_string better
References: <20200521152301.2587579-1-hch@lst.de>
 <20200521152301.2587579-13-hch@lst.de>
 <20200527190432.e4af1fba00c13cb1421f5a37@linux-foundation.org>
 <2b64fae6-394c-c1e5-8963-c256f4284065@fb.com> <20200528043957.GA28494@lst.de>
From: Yonghong Song <yhs@fb.com>
Message-ID: <a1aa26f4-8c0a-5f8a-8460-6d61f167702d@fb.com>
Date: Thu, 28 May 2020 10:06:17 -0700
In-Reply-To: <20200528043957.GA28494@lst.de>
Content-Language: en-US
MIME-Version: 1.0
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
To: Christoph Hellwig <hch@lst.de>
Cc: linux-parisc@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org



On 5/27/20 9:39 PM, Christoph Hellwig wrote:
> On Wed, May 27, 2020 at 07:26:30PM -0700, Yonghong Song wrote:
>>> --- a/kernel/trace/bpf_trace.c~xxx
>>> +++ a/kernel/trace/bpf_trace.c
>>> @@ -588,15 +588,22 @@ BPF_CALL_5(bpf_seq_printf, struct seq_fi
>>>    		}
>>>      		if (fmt[i] == 's') {
>>> +			void *unsafe_ptr;
>>> +
>>>    			/* try our best to copy */
>>>    			if (memcpy_cnt >= MAX_SEQ_PRINTF_MAX_MEMCPY) {
>>>    				err = -E2BIG;
>>>    				goto out;
>>>    			}
>>>    -			err = strncpy_from_unsafe(bufs->buf[memcpy_cnt],
>>> -						  (void *) (long) args[fmt_cnt],
>>> -						  MAX_SEQ_PRINTF_STR_LEN);
>>> +			unsafe_ptr = (void *)(long)args[fmt_cnt];
>>> +			if ((unsigned long)unsafe_ptr < TASK_SIZE) {
>>> +				err = strncpy_from_user_nofault(
>>> +					bufs->buf[memcpy_cnt], unsafe_ptr,
>>> +					MAX_SEQ_PRINTF_STR_LEN);
>>> +			} else {
>>> +				err = -EFAULT;
>>> +			}
>>
>> This probably not right.
>> The pointer stored at args[fmt_cnt] is a kernel pointer,
>> but it could be an invalid address and we do not want to fault.
>> Not sure whether it exists or not, we should use
>> strncpy_from_kernel_nofault()?
> 
> If you know it is a kernel pointer with this series it should be
> strncpy_from_kernel_nofault.  But even before the series it should have
> been strncpy_from_unsafe_strict.

The use of strncpy_from_unsafe() mimics old bpf_trace_printk() 
implementation which just changed to _strict version:
https://lkml.org/lkml/2020/5/18/1309

Agreed that we should change to strncpy_from_unsafe_strict().
I can submit a patch for this.

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

