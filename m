Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1pzO-0004gz-Kf
 for linux-um@lists.infradead.org; Wed, 12 Feb 2020 11:15:32 +0000
Subject: Re: Documentation for UML Vector network
References: <7c37a3f7310c0be2202ada464e31c2d4d424c502.camel@researchut.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <32d50bed-cfdb-288a-181c-e186143c8169@kot-begemot.co.uk>
Date: Wed, 12 Feb 2020 11:15:23 +0000
MIME-Version: 1.0
In-Reply-To: <7c37a3f7310c0be2202ada464e31c2d4d424c502.camel@researchut.com>
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



On 12/02/2020 10:38, Ritesh Raj Sarraf wrote:
> Hi,
> 
> I see in the latest changes for Linux in Linus's tree, that the
> previous networking modes have been marked obsolete.
> 
> Is there any official documentation on how to use the new Vector
> network in UML ? Or does it stand transparent to the users ?
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 
1. A patch to make it transparent replacement for whatever is possible from the old transports is in the queue

2. I was going to spend most of next week to rewrite the bits and pieces from my website on how to use it and incorporate them into the official docs and submit them as a patch to Documentation.

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

