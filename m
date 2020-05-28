Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1je8GH-0001Qd-P2
 for linux-um@lists.infradead.org; Thu, 28 May 2020 02:27:15 +0000
Subject: Re: [PATCH 12/23] bpf: handle the compat string in
 bpf_trace_copy_string better
References: <20200521152301.2587579-1-hch@lst.de>
 <20200521152301.2587579-13-hch@lst.de>
 <20200527190432.e4af1fba00c13cb1421f5a37@linux-foundation.org>
From: Yonghong Song <yhs@fb.com>
Message-ID: <2b64fae6-394c-c1e5-8963-c256f4284065@fb.com>
Date: Wed, 27 May 2020 19:26:30 -0700
In-Reply-To: <20200527190432.e4af1fba00c13cb1421f5a37@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>, linux-parisc@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>



On 5/27/20 7:04 PM, Andrew Morton wrote:
> On Thu, 21 May 2020 17:22:50 +0200 Christoph Hellwig <hch@lst.de> wrote:
> 
>> User the proper helper for kernel or userspace addresses based on
>> TASK_SIZE instead of the dangerous strncpy_from_unsafe function.
>>
>> ...
>>
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -331,8 +331,11 @@ static void bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
>>   	switch (fmt_ptype) {
>>   	case 's':
>>   #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>> -		strncpy_from_unsafe(buf, unsafe_ptr, bufsz);
>> -		break;
>> +		if ((unsigned long)unsafe_ptr < TASK_SIZE) {
>> +			strncpy_from_user_nofault(buf, user_ptr, bufsz);
>> +			break;
>> +		}
>> +		fallthrough;
>>   #endif
>>   	case 'k':
>>   		strncpy_from_kernel_nofault(buf, unsafe_ptr, bufsz);
> 
> Another user of strncpy_from_unsafe() has popped up in linux-next's
> bpf.  I did the below, but didn't try very hard - it's probably wrong
> if CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=n?
> 
> Anyway, please take a look at all the bpf_trace.c changes in
> linux-next.
> 
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: bpf:bpf_seq_printf(): handle potentially unsafe format string better
> 
> User the proper helper for kernel or userspace addresses based on
> TASK_SIZE instead of the dangerous strncpy_from_unsafe function.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   kernel/trace/bpf_trace.c |   13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> --- a/kernel/trace/bpf_trace.c~xxx
> +++ a/kernel/trace/bpf_trace.c
> @@ -588,15 +588,22 @@ BPF_CALL_5(bpf_seq_printf, struct seq_fi
>   		}
>   
>   		if (fmt[i] == 's') {
> +			void *unsafe_ptr;
> +
>   			/* try our best to copy */
>   			if (memcpy_cnt >= MAX_SEQ_PRINTF_MAX_MEMCPY) {
>   				err = -E2BIG;
>   				goto out;
>   			}
>   
> -			err = strncpy_from_unsafe(bufs->buf[memcpy_cnt],
> -						  (void *) (long) args[fmt_cnt],
> -						  MAX_SEQ_PRINTF_STR_LEN);
> +			unsafe_ptr = (void *)(long)args[fmt_cnt];
> +			if ((unsigned long)unsafe_ptr < TASK_SIZE) {
> +				err = strncpy_from_user_nofault(
> +					bufs->buf[memcpy_cnt], unsafe_ptr,
> +					MAX_SEQ_PRINTF_STR_LEN);
> +			} else {
> +				err = -EFAULT;
> +			}

This probably not right.
The pointer stored at args[fmt_cnt] is a kernel pointer,
but it could be an invalid address and we do not want to fault.
Not sure whether it exists or not, we should use 
strncpy_from_kernel_nofault()?

>   			if (err < 0)
>   				bufs->buf[memcpy_cnt][0] = '\0';
>   			params[fmt_cnt] = (u64)(long)bufs->buf[memcpy_cnt];
> _
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

