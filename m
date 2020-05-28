Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeAKo-0004di-7H
 for linux-um@lists.infradead.org; Thu, 28 May 2020 04:40:04 +0000
Date: Thu, 28 May 2020 06:39:57 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/23] bpf: handle the compat string in
 bpf_trace_copy_string better
Message-ID: <20200528043957.GA28494@lst.de>
References: <20200521152301.2587579-1-hch@lst.de>
 <20200521152301.2587579-13-hch@lst.de>
 <20200527190432.e4af1fba00c13cb1421f5a37@linux-foundation.org>
 <2b64fae6-394c-c1e5-8963-c256f4284065@fb.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2b64fae6-394c-c1e5-8963-c256f4284065@fb.com>
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
To: Yonghong Song <yhs@fb.com>
Cc: linux-parisc@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>

On Wed, May 27, 2020 at 07:26:30PM -0700, Yonghong Song wrote:
>> --- a/kernel/trace/bpf_trace.c~xxx
>> +++ a/kernel/trace/bpf_trace.c
>> @@ -588,15 +588,22 @@ BPF_CALL_5(bpf_seq_printf, struct seq_fi
>>   		}
>>     		if (fmt[i] == 's') {
>> +			void *unsafe_ptr;
>> +
>>   			/* try our best to copy */
>>   			if (memcpy_cnt >= MAX_SEQ_PRINTF_MAX_MEMCPY) {
>>   				err = -E2BIG;
>>   				goto out;
>>   			}
>>   -			err = strncpy_from_unsafe(bufs->buf[memcpy_cnt],
>> -						  (void *) (long) args[fmt_cnt],
>> -						  MAX_SEQ_PRINTF_STR_LEN);
>> +			unsafe_ptr = (void *)(long)args[fmt_cnt];
>> +			if ((unsigned long)unsafe_ptr < TASK_SIZE) {
>> +				err = strncpy_from_user_nofault(
>> +					bufs->buf[memcpy_cnt], unsafe_ptr,
>> +					MAX_SEQ_PRINTF_STR_LEN);
>> +			} else {
>> +				err = -EFAULT;
>> +			}
>
> This probably not right.
> The pointer stored at args[fmt_cnt] is a kernel pointer,
> but it could be an invalid address and we do not want to fault.
> Not sure whether it exists or not, we should use 
> strncpy_from_kernel_nofault()?

If you know it is a kernel pointer with this series it should be
strncpy_from_kernel_nofault.  But even before the series it should have
been strncpy_from_unsafe_strict.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

