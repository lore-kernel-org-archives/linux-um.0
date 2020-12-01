Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk8pf-00038a-Va
 for linux-um@lists.infradead.org; Tue, 01 Dec 2020 16:48:52 +0000
Subject: Re: [PATCH v6 4/5] um: support suspend to RAM
References: <20201130121550.173513-1-johannes@sipsolutions.net>
 <20201130131520.80e9b1810786.I3e8e33cbe3196d9325946af3a5655f7b6719382d@changeid>
 <ba5e0b62-df77-b96a-651e-48e56d3e7102@cambridgegreys.com>
 <1fc7e19ea1335ce0928c25032afd3c22b0812236.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <76b3846d-bbbd-1937-5ee7-f9737ede95b9@cambridgegreys.com>
Date: Tue, 1 Dec 2020 16:48:48 +0000
MIME-Version: 1.0
In-Reply-To: <1fc7e19ea1335ce0928c25032afd3c22b0812236.camel@sipsolutions.net>
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


On 01/12/2020 16:45, Johannes Berg wrote:
> On Tue, 2020-12-01 at 16:44 +0000, Anton Ivanov wrote:
>>> +	bool wakeup;
>> That is on top of the other patch series where there is an issue with patch 7.
>>
>> Are we going to park this one until we have sorted IRQ Handling Cleanups?
> I guess so, it won't apply without the other series, and I really don't
> want to respin without it, that'll just make a huge mess.

OK. I will try to have a look at 7 from the other series and the vector drivers to see exactly what makes it unhappy for the register/unregister

A.

>
>> 1-3 look good.
> :)
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

