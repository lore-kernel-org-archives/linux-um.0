Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJYIh-0006Zg-QA
 for linux-um@lists.infradead.org; Wed, 01 Apr 2020 08:00:41 +0000
Subject: Re: Patch to remove symbol conflicts in pcap transport
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
References: <SN6PR10MB30394F0158533B8AE1151F81E2C90@SN6PR10MB3039.namprd10.prod.outlook.com>
 <e7f5fc79-5ec2-d1f9-fa53-5d8fafdd8f13@kot-begemot.co.uk>
Message-ID: <d9eec0f9-1bd6-d164-8009-4474b4a377e3@kot-begemot.co.uk>
Date: Wed, 1 Apr 2020 09:00:36 +0100
MIME-Version: 1.0
In-Reply-To: <e7f5fc79-5ec2-d1f9-fa53-5d8fafdd8f13@kot-begemot.co.uk>
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
To: James McMechan <james_mcmechan@hotmail.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>



On 01/04/2020 08:58, Anton Ivanov wrote:
> On 01/04/2020 08:27, James McMechan wrote:
>> Hi,
>>
>> I had fixed up the pcap transport back in December,
>> Attached is the patch I was using (with a couple clean ups) I just prefixed likely collisions with /um_/
>> It has been working since 5.4.2 up thru 5.6.0 so far
>> I noticed that the standard transports are now marked (obsolete) in 5.6.0
>> Does this version of the new transport work correctly when statically linked? It nolonger errors out at startup.
> 
> Sorta. Neither pcap nor vector can be truly statically linked. PCAP library internally and vector explicitly
> invoke name resolution functions which will fail in static executables if you try to run on a system with
> different libc.
> 
> This cannot be fixed. Vector cannot be static and the same is valid for pcap.
> 
> Both will be prohibited from static linking in the future because the resulting executable is NOT static and
> there is absolutely nothing we can do about it. This is a core glibc issue which we can neither fix, nor work
> around.
> 
>> I have not found any documentation on how to configure the new experimental vector transport.
> 
> 1. In the works. I was snowed under OVS (in fact I still am) so the rewrite of the UML howto had to be parked.
> 
> 2. There is a patch in the queue which maps pcap, tap, daemon and socket onto vector using the old syntax leaving
> only the virtual ethernet and slirp on the old net subsystem.
> 
>> Since the classic transports are between 10-100 times faster than my network anyway I have not felt a need to upgrade.
>> More I was using UML to deal with some very old systems that were not easily upgraded. e.g. 2.6 kernels and I think even a 2.0.32?
>> The vector Kconfig help says it wants a >=3.0 kernel for example.
> 
> 3.0 and a reasonably recent glibc.
> 
> That is not an unreasonable requirement. 3.0 was released on 22 July 2011. That is 19 years.

Sorry, 9 years. I need more coffee :)

> 
> As an example the Arm guys cut-off at ~5 years. I have a whole desk drawer with Lemaker and other 5+ years old
> Arm SoC boards which are all going out of support now.
> 
>>
>> Enjoy,
>>
>> Jim McMechan
>>
>>
>> _______________________________________________
>> linux-um mailing list
>> linux-um@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-um
>>
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

