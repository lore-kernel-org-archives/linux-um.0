Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iALRf-0005YS-Vu
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 21:55:37 +0000
Subject: Re: CONFIG_COMPAT for UM?
References: <60f73376da11640d5b335512f052a583fd784fd8.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <76d688c3-3d8b-fb59-3ad4-ef8dd9c023be@kot-begemot.co.uk>
Date: Tue, 17 Sep 2019 22:54:08 +0100
MIME-Version: 1.0
In-Reply-To: <60f73376da11640d5b335512f052a583fd784fd8.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org



On 17/09/2019 21:47, Johannes Berg wrote:
> Hi,
> 
> It seems to me that it ought to be possible - at least if the host
> kernel has 32/64 compatibility, to extend the same to the UML kernel?
> 
> Has anyone ever given this a thought?
> 
> I just realized that our test suite is based on 32-bit binaries ... :-)
> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

I have run 32 on 64 with no issues. In fact, I had to build a product 
prototype using that a while back because the target userspace load did 
not have 64 bit support. Even vector IO works despite the differences 
between 32 bit and 64 bit syscalls for that.

I am not sure we need to do anything here. What in particular do you 
have in mind?

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

