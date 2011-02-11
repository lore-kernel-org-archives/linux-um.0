Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4D553455.6000409@panasas.com>
Date: Fri, 11 Feb 2011 15:06:29 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <4D52E4E1.7070705@panasas.com>	<4D540969.9090507@panasas.com> <AANLkTine1w2h29OPES1RHTs-otB_ohhMDMbbRoXFK+BB@mail.gmail.com>
In-Reply-To: <AANLkTine1w2h29OPES1RHTs-otB_ohhMDMbbRoXFK+BB@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: Regression with calibrate_xor_blocks, probably UML related
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, NeilBrown <neilb@suse.de>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 02/11/2011 02:38 PM, richard -rw- weinberger wrote:
> On Thu, Feb 10, 2011 at 4:51 PM, Boaz Harrosh <bharrosh@panasas.com> wrote:
>> On 02/09/2011 09:02 PM, Boaz Harrosh wrote:
>>> I have a new module that uses the async_tx.h lib.
>>>
>>> On an exact same module code based on 3.6.37 I see the:
>>>       xor: measuring software checksum speed
>>>          8regs     : 11312.000 MB/sec
>>>          8regs_prefetch:  9792.800 MB/sec
>>>          32regs    : 11220.400 MB/sec
>>>          32regs_prefetch:  9750.800 MB/sec
>>>       xor: using function: 8regs (11312.000 MB/sec)
>>>
>>> And all is well. But on code based on 2.6.38-rc4 I get hard stuck
>>> right after:
>>>       xor: measuring software checksum speed
>>>
>>
>> OK this is not dependent on Kernel version it is the same for both
>> .38-rc4 and .37. I was just lucky with .37 more.
>>

Thanks richard.

I'm afraid it is not a regression. Just that I got lucky more
with 2.6.37. But it happens with 2.6.37 just the same.

>> And the same things happen with raid456 module. I do
>> []$ modprobe raid456; modprobe --remove raid456
>> A few times it loads, printing the above checks, Then At one
>> time it freezes. Sometimes at first attempt sometimes at 4-7
>> attempts. I never went 10 times strait.
>>
>> When it freezes (hard) I can see in my host that the UML is
>> at 100% CPU.
>>
>> BTW: when I manage to pass the tests I get the above numbers
>> But when I load directly on the host I get:
>>
<>
>> Any way I'm trying to debug that xor.ko loading problem see what
>> comes up. Any help is welcome
> 
> Hmmm, can you bisect it?
> Can you post you config then I can also try my best...
> 

You mean that you can setup a UML and try it out for yourself?
All I did was:
[]$ make ARCH=um defconfig
Then turn on raid456 in "make ARCH=um xconfig"

when you load into the UML just, "modprobe raid456

Thanks
Boaz

>> Thanks
>> Boaz
>>
>>> the UML is completely frozen. When I kill the uml from the host
>>> I can sometimes get this trace.
