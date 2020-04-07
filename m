Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLrDM-0004SQ-Bi
 for linux-um@lists.infradead.org; Tue, 07 Apr 2020 16:36:42 +0000
Subject: Re: Documentation for UML Vector network
References: <7c37a3f7310c0be2202ada464e31c2d4d424c502.camel@researchut.com>
 <32d50bed-cfdb-288a-181c-e186143c8169@kot-begemot.co.uk>
 <44b7a3a49731dfabe9cdfbeb281ad9470e71b625.camel@researchut.com>
 <c6774e9e-7811-cbbb-eea5-83e5045b59e9@kot-begemot.co.uk>
 <41e0199cf2ad126bca3047d18e14493ab903bbe6.camel@researchut.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <f64a6f99-8e20-9825-75eb-358054935807@kot-begemot.co.uk>
Date: Tue, 7 Apr 2020 17:36:31 +0100
MIME-Version: 1.0
In-Reply-To: <41e0199cf2ad126bca3047d18e14493ab903bbe6.camel@researchut.com>
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



On 14/02/2020 11:38, Ritesh Raj Sarraf wrote:
> Hi Anton,
> 
> On Wed, 2020-02-12 at 15:54 +0000, Anton Ivanov wrote:
>> In first instance I intend to update that. There is actually a .rd
>> markup version in progress for the next kernel versions.
>>
>> A wiki will be nice, because there is no way to fit all new UML
>> features like direct tunnel/overlay attachment, time travel, etc in
>> the documentation in the kernel tree.
> 
> A follow-up question.
> 
> The traditional UML networking modes supported slirp, which allowed for
> unprivileged networking access.
> 
> Is that something achievable with UML Vector network ?
> We have a use case where we want to be able be capable to use UML with
> network features. But do not have necessary privileges to set
> networking up on the host.

Apologies for the delay, I was started writing it in February, but had to drop it and work on something else for most of March.

The first 3 sections are at: https://github.com/kot-begemot-uk/uml-howto-v2

This includes vector driver documentation.

I will continue working through the old howto rearranging the sections as I go along and adding the new stuff.

Once it is all done and assembled, the end result should be a fully revised doc.

I am happy to handle proposed changes as pull requests.

Brgds,

> 
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

