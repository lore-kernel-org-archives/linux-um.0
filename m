Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iA9d2-0005uB-JO
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 09:18:34 +0000
Subject: Re: [RFC v2 2/2] um: implement time-travel=ext
References: <1568671815-I895f9019593bd579566f14e5af9346e3c9b56f28@changeid>
 <1568671815-I0c06fae89d77d5b272dfb4c7ea64641b597b5c7b@changeid>
 <7583ac26d787ddf211473166136836f3472bf31e.camel@sipsolutions.net>
 <1dd9e658-a6cd-39dd-09c7-d68ebcd7078c@cambridgegreys.com>
 <bfbb45a544415446e38fb89c08bb234047affa2b.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <84277c4a-c2a9-2077-38e9-75bd9ce05ffa@cambridgegreys.com>
Date: Tue, 17 Sep 2019 10:18:28 +0100
MIME-Version: 1.0
In-Reply-To: <bfbb45a544415446e38fb89c08bb234047affa2b.camel@sipsolutions.net>
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



On 17/09/2019 10:14, Johannes Berg wrote:
> On Tue, 2019-09-17 at 10:09 +0100, Anton Ivanov wrote:
> 
>> I hope you do not mind - will repeat my ask. Can we have a series off
>> let's say current 5.x with all patches ready for test/review.
> 
> Well, Richard applied almost everything. We also spoke about the "Fix
> LAST_IRQ usage" patch yesterday and he said he'd apply the one hunk of
> it that you didn't already fix.

Cool. I will wait for the PR then and start retesting vs DPDK/Bess.

> 
>> Some of your patches have 3-4 versions with a fixed version coming
>> nearly immediately thereafter and for some of them I am a bit lost which
>> versions should I test/review at present.
> 
> The only open patches now are on
> 
> https://patchwork.ozlabs.org/project/linux-um/list/
> 
> and I've just updated the state of my stuff there.

Ack. I will use what is there from now on. I was trying to keep on the 
mailing list and that did not quite work :)

> 
> johannes
> 
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

