Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYCwL-00FQVE-UG
 for linux-um@lists.infradead.org; Wed, 06 Oct 2021 19:50:59 +0000
Subject: Re: Is exec still very slow compared to other aspects of UML?
References: <20211006144048.6a42a958@crass-HP-ZBook-15-G2>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <b7ec9258-27c8-45e5-1c36-713eb5d5c682@kot-begemot.co.uk>
Date: Wed, 6 Oct 2021 20:50:53 +0100
MIME-Version: 1.0
In-Reply-To: <20211006144048.6a42a958@crass-HP-ZBook-15-G2>
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
To: development@efficientek.com, linux-um@lists.infradead.org

On 06/10/2021 20:40, Glenn Washburn wrote:
> Hi all,
> 
> After reading this blog post[1], which I think is at least several years
> old, I'm left wondering how much of an issue is the exec speed. Or
> alternatively, could I see a significant speed up by reducing the
> number of exec calls. Any one have opinions on this?
> 
> Glenn
> 
> [1] https://www.kot-begemot.co.uk/node/15
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

Yes it is.

It causes a full tlb flush and that is really slow. We have fixed most 
other areas, but this one seems to be fundamentally unfixable.

Most of the material on the blog has been migrated to the kernel doc. 
The kernel doc is the authoritative source now.


Brgds,

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

