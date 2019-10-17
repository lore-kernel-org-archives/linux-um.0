Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iL5u2-0006J2-Ph
 for linux-um@lists.infradead.org; Thu, 17 Oct 2019 13:33:20 +0000
Subject: Re: uml segfault during I/O
References: <a1307b17bd3f51d84d9195760492d1ef284b6382.camel@researchut.com>
 <1ccf27d8-6b6a-7d08-acef-93077f07511b@cambridgegreys.com>
 <5dc5e0694d2fcf2f8bb083e3861fd1b39c768b8c.camel@researchut.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <cf1294b2-e1cc-961c-e8e1-d070fe0ea94d@cambridgegreys.com>
Date: Thu, 17 Oct 2019 14:33:13 +0100
MIME-Version: 1.0
In-Reply-To: <5dc5e0694d2fcf2f8bb083e3861fd1b39c768b8c.camel@researchut.com>
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
To: rrs@researchut.com, linux-um@lists.infradead.org



On 17/10/2019 14:30, Ritesh Raj Sarraf wrote:
> On Thu, 2019-10-17 at 14:02 +0100, Anton Ivanov wrote:
>> Looking into that. I have not run into anything like that, but I have
>> not used any of the legacy networking for 5 odd years now.
>>
> 
> Do you think this is related to networking ? I ask because there was no
> network activity going on.

no, it's disk somewhere. I managed to reproduce it with 5.2 stock on 
Debian 5.2 host.

> 
> apt is just an example. The packages were all already downloaded and
> there was no network activity. Rather, there was block I/O.

I am looking into that.

> 
> One thing I noticed, which may or may not be useful to this report. I
> was booting the uml guest and immediately logging into it and running
> the block I/O. And the segfault would occur.
> 
> If I, instead, booted the uml vm and let it remain idle for a minute or
> so and then did the I/O, it worked fine. So I am not sure if there is
> any lazy initialization happening in the background which gets
> corrupted during immediate hot boot I/O.

Interesting...

> 
> On the other hand, if you think there can be any number of commands to
> run locally that could generate more information, please assist me so.

As I said - I managed to reproduce it, I am looking at it. In first 
instance I am trying with a couple of version up/down to see if this is 
5.2 specific.

> 
> Thanks,
> Ritesh
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

