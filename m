Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgPk8-0001h2-PT
 for linux-um@lists.infradead.org; Sat, 21 Nov 2020 10:03:47 +0000
Subject: Re: [PATCH 4/4] um: allow PM with suspend-to-idle
References: <20201120212921.880781-1-johannes@sipsolutions.net>
 <20201120222625.7a475c89cdd4.Id4fe7fb6f0405eb24f3db3ae7a6276293f0ce6f7@changeid>
 <9731397936ba99253548843d9e487ce0df44bdce.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <ddd00c01-55a0-00ea-60cc-3a710207befd@kot-begemot.co.uk>
Date: Sat, 21 Nov 2020 09:34:48 +0000
MIME-Version: 1.0
In-Reply-To: <9731397936ba99253548843d9e487ce0df44bdce.camel@sipsolutions.net>
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

On 20/11/2020 21:33, Johannes Berg wrote:
> On Fri, 2020-11-20 at 22:29 +0100, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> In order to be able to experiment with suspend in UML,
>> add the minimal work to be able to suspend (s2idle) an
>> instance of UML, and be able to wake it back up from
>> that state with the USR1 signal sent to the main UML
>> process.
> 
> So what I said about rtcwake ... maybe that's an argument for removing
> the USR1 handling? I wasn't really too sure about it.
> 
> But on the other hand, typically real systems will have at least *some*
> kind of wakeup source that you can manually use and that's always
> enabled, perhaps the power button for example; the SIGUSR1 handling was
> meant to simulate such a thing.

This usually translates to the IRQ controller being powered on even if 
the rest of the machine is off and some lines being able to function 
even in power down state.

Not that difficult actually. Going to sleep should just turn off all 
relevant IRQs including de-registering fds. If you are not 
de-registering the fds, the fact that it is turned off in the controller 
will be of no use - it will be re-triggered.

Waking up should restore the state.

Once that is in place, you can emulate the full PM sleep/wake up cycle.

Emulating suspend to disk is more interesting. I actually looked at it 
many years ago and that looked nearly impossible to implement.

> 
> (Today, if you send SIGUSR1 to the main 'linux' process, it just dies,
> but I hope nobody relies on that ...?)
> 
> johannes
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

