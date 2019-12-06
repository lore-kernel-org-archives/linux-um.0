Return-Path: <anton.ivanov@cambridgegreys.com>
Subject: Re: 64 bit time regression in recvmmsg()
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
References: <3820d68b-1d97-8f41-d55d-237d1695458c@cambridgegreys.com>
 <CAMuHMdWuiGC4ay=f6M2H=-PLiffavnFSu8CPXE26euAi6aoY0w@mail.gmail.com>
 <CAK8P3a1mrFgRyh5Fgv-d8Szd2pq0T6Ac7wL3ogeYcf-Uyrg4ZQ@mail.gmail.com>
 <a5b9709d-b93b-46e1-ab18-a94ab921ccf7@cambridgegreys.com>
Message-ID: <9dc1be66-5c55-8b3d-875b-4e1206914e78@cambridgegreys.com>
Date: Fri, 6 Dec 2019 17:49:56 +0000
MIME-Version: 1.0
In-Reply-To: <a5b9709d-b93b-46e1-ab18-a94ab921ccf7@cambridgegreys.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>



On 29/11/2019 16:34, Anton Ivanov wrote:
> 
> 
> On 29/11/2019 15:17, Arnd Bergmann wrote:
>> On Fri, Nov 29, 2019 at 4:05 PM Geert Uytterhoeven 
>> <geert@linux-m68k.org> wrote:
>>> On Fri, Nov 29, 2019 at 3:34 PM Anton Ivanov
>>> <anton.ivanov@cambridgegreys.com> wrote:
>>>> Unfortunately, it looks like the recent year 2038 have broken
>>>> compatibility for one particular syscall interface we use - recvmmsg.
>>>>
>>>> The host now occasionally returns -22 (EINVAL) and the only way I see
>>>> for this to happen looking at the source is if when it gets something
>>>> bogus as a timeout.
>>>>
>>>> I think I have eliminated all other possible sources for this error.
>>>>
>>>> The picture can be observed when using a 64 bit host 5.2 kernel on a
>>>> Debian 64 bit buster userspace (glibc compiled vs 4.19 headers).
>>>>
>>>> The code as it is written at present retries and by sheer luck and
>>>> perseverance it manages to work, but this needs to be fixed.
>>
>> I only see a single call to recvmmsg() in arch/um, in 
>> uml_vector_recvmmsg(),
>> and this passes a NULL timeout pointer, is this the one that broke or
>> should I be looking at something else?
>>
>> Do I understand you right that the regression is on a pure 64-bit system?
> 
> Yes.
> 
> 64 bit host, Debian Buster with the stock 4.19 replaced by a 5.2.17 
> kernel upgrade, 5.2 and 5.3 64 bit UML also running Debian Buster inside.
> 
> It sporadically produces -EINVAL (-22) from the recvmmsg.
> 
> I went through the allocation and deallocation of the actual mmsg 
> several times to ensure it is not that.
> 
> IMHO it is the timespec conversion somewhere, but I cannot pinpoint the 
> actual cause.
> 
> The kernel command line is:
> 
> 
> /var/autofs/local/src/linux-work/linux/vmlinux mem=2048M umid=OPX \
> ubd0=/var/autofs/local/UML/OPX-3.0-Work.img  \
> vec0:transport=raw,ifname=pveth0,depth=128,gro=1,mac=92:9b:36:5e:38:69 \
> root=/dev/ubda ro con=null con0=null,fd:2 con1=fd:0,fd:1
> 
> pveth0 is one half of a veth pair created by doing
> 
> 
> ip link add lveth0 type veth peer name pveth0 && ifconfig pveth0 up
> 
> lveth0 is used for the host side.
> 
> Brgds,
> 
>>
>>       Arnd
>>
> 


Arnd,

I apologize, problem elsewhere. I have narrowed it down, it is a host 
regression at the end, not a recvmmsg/time one.

The EINVAL is occasionally returned from the guts of packet_rcv_vnet

https://elixir.bootlin.com/linux/latest/ident/packet_rcv_vnet

in af_packet. I am going to try to figure out exactly when it happens 
and why.

My sincere apologies,

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

