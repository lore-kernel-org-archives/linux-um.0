Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1uLv-0002bJ-TT
 for linux-um@lists.infradead.org; Wed, 12 Feb 2020 15:55:05 +0000
Subject: Re: Documentation for UML Vector network
References: <7c37a3f7310c0be2202ada464e31c2d4d424c502.camel@researchut.com>
 <32d50bed-cfdb-288a-181c-e186143c8169@kot-begemot.co.uk>
 <44b7a3a49731dfabe9cdfbeb281ad9470e71b625.camel@researchut.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <c6774e9e-7811-cbbb-eea5-83e5045b59e9@kot-begemot.co.uk>
Date: Wed, 12 Feb 2020 15:54:56 +0000
MIME-Version: 1.0
In-Reply-To: <44b7a3a49731dfabe9cdfbeb281ad9470e71b625.camel@researchut.com>
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



On 12/02/2020 15:40, Ritesh Raj Sarraf wrote:
> Hi Anton,
> 
> On Wed, 2020-02-12 at 11:15 +0000, Anton Ivanov wrote:
>> 1. A patch to make it transparent replacement for whatever is
>> possible from the old transports is in the queue
>>
>> 2. I was going to spend most of next week to rewrite the bits and
>> pieces from my website on how to use it and incorporate them into the
>> official docs and submit them as a patch to Documentation.
> 
> I did skim through your website looking for pointers in that direction.
> 
> Given that UML@SourceForge is very outdated, I suggest a different
> location. I also recollect Richard was considering moving to a wiki on
> a much reliable and maintained location, like uml.wiki.kernel.org. But
> I think that hasn't happened.
> 
> In my opinion, one good candidate where UML documentation could be
> maintained is:
> Documentation/virt/uml/UserModeLinux-HOWTO.txt

In first instance I intend to update that. There is actually a .rd markup version in progress for the next kernel versions.

A wiki will be nice, because there is no way to fit all new UML features like direct tunnel/overlay attachment, time travel, etc in the documentation in the kernel tree.

Brgds,

> 
> 
> That document is a dump of the UML@SourceForge website content. Having
> it in the kernel tree may have a better maintenance life.
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

