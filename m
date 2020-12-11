Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knq2q-0006y8-Om
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 21:33:45 +0000
Subject: Re: [PATCH v4 6/7] um: swithch futex ops to cmpxchg
References: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
 <20201211174559.26010-7-anton.ivanov@cambridgegreys.com>
 <8bf26fa61b51080c1a861de1a95d292a6c93cf0a.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <7b453c0b-2509-6cef-cd2f-f0285bb251a9@cambridgegreys.com>
Date: Fri, 11 Dec 2020 21:33:41 +0000
MIME-Version: 1.0
In-Reply-To: <8bf26fa61b51080c1a861de1a95d292a6c93cf0a.camel@sipsolutions.net>
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
Cc: richard@nod.at

On 11/12/2020 20:12, Johannes Berg wrote:
> Typo in the subject :)
>
>> As a result of switching from emulated to true atomic cmpxchg
>> we can use cmpxchg in the corresponding um futex op.
> But this seems odd - maybe just reorder the patches so the futex code
> can directly have this squashed in?

You do not want to do that if you are still using the generic cmpxchg. 
That is quite cumbersome. If we reorder the cmpxchg before the futex, 
then it can be folded in.

I will do it in v5

A.

>
> johannes
>
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

